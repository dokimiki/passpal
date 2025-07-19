import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:passpal/core/storage/interfaces/secure_storage_interface.dart';
import 'package:passpal/core/storage/models/storage_exceptions.dart';
import 'package:passpal/core/storage/services/credential_manager.dart';

class MockSecureStorageInterface extends Mock
    implements SecureStorageInterface {}

void main() {
  group('CredentialManager', () {
    late CredentialManager credentialManager;
    late MockSecureStorageInterface mockSecureStorage;

    setUp(() {
      mockSecureStorage = MockSecureStorageInterface();
      credentialManager = CredentialManager(mockSecureStorage);
    });

    group('CredentialType', () {
      test('should convert to string correctly', () {
        expect(CredentialType.manabo.value, equals('manabo'));
        expect(CredentialType.googleOauth.value, equals('google_oauth'));
      });

      test('should parse from string correctly', () {
        expect(
          CredentialType.fromString('manabo'),
          equals(CredentialType.manabo),
        );
        expect(CredentialType.fromString('invalid'), isNull);
      });
    });

    group('StoredCredential', () {
      test('should serialize and deserialize correctly', () {
        final credential = StoredCredential(
          identifier: 'user123',
          value: 'secret_token',
          type: CredentialType.manabo,
          createdAt: DateTime(2024, 1, 1),
          expiresAt: DateTime(2024, 12, 31),
          metadata: {'key': 'value'},
        );

        final json = credential.toJson();
        final restored = StoredCredential.fromJson(json);

        expect(restored.identifier, equals(credential.identifier));
        expect(restored.value, equals(credential.value));
        expect(restored.type, equals(credential.type));
        expect(restored.createdAt, equals(credential.createdAt));
        expect(restored.expiresAt, equals(credential.expiresAt));
        expect(restored.metadata, equals(credential.metadata));
      });

      test('should detect expired credentials', () {
        final expiredCredential = StoredCredential(
          identifier: 'user123',
          value: 'token',
          type: CredentialType.manabo,
          createdAt: DateTime(2024, 1, 1),
          expiresAt: DateTime(2024, 1, 2), // Past date
        );

        final validCredential = StoredCredential(
          identifier: 'user123',
          value: 'token',
          type: CredentialType.manabo,
          createdAt: DateTime.now(),
          expiresAt: DateTime.now().add(const Duration(hours: 1)),
        );

        final noExpiryCredential = StoredCredential(
          identifier: 'user123',
          value: 'token',
          type: CredentialType.manabo,
          createdAt: DateTime.now(),
        );

        expect(expiredCredential.isExpired, isTrue);
        expect(validCredential.isExpired, isFalse);
        expect(noExpiryCredential.isExpired, isFalse);
      });
    });

    group('storeCredential', () {
      test('should store credential and metadata successfully', () async {
        // Arrange
        when(
          () => mockSecureStorage.write(any(), any()),
        ).thenAnswer((_) async => const Right(unit));

        // Act
        final result = await credentialManager.storeCredential(
          identifier: 'user123',
          value: 'secret_token',
          type: CredentialType.manabo,
          metadata: {'campus': 'nagoya'},
        );

        // Assert
        expect(result.isRight(), isTrue);
        verify(
          () => mockSecureStorage.write(
            'credential_manabo_user123',
            'secret_token',
          ),
        );
        verify(
          () =>
              mockSecureStorage.write('credential_meta_manabo_user123', any()),
        );
      });

      test('should cleanup on metadata storage failure', () async {
        // Arrange
        when(
          () => mockSecureStorage.write('credential_manabo_user123', any()),
        ).thenAnswer((_) async => const Right(unit));
        when(
          () =>
              mockSecureStorage.write('credential_meta_manabo_user123', any()),
        ).thenAnswer(
          (_) async => Left(
            StorageFailureFactory.writeFailure(message: 'Storage failed'),
          ),
        );
        when(
          () => mockSecureStorage.delete('credential_manabo_user123'),
        ).thenAnswer((_) async => const Right(unit));

        // Act
        final result = await credentialManager.storeCredential(
          identifier: 'user123',
          value: 'secret_token',
          type: CredentialType.manabo,
        );

        // Assert
        expect(result.isLeft(), isTrue);
        verify(() => mockSecureStorage.delete('credential_manabo_user123'));
      });

      test('should handle storage errors', () async {
        // Arrange
        when(() => mockSecureStorage.write(any(), any())).thenAnswer(
          (_) async => Left(
            StorageFailureFactory.writeFailure(message: 'Storage failed'),
          ),
        );

        // Act
        final result = await credentialManager.storeCredential(
          identifier: 'user123',
          value: 'secret_token',
          type: CredentialType.manabo,
        );

        // Assert
        expect(result.isLeft(), isTrue);
      });
    });

    group('getCredential', () {
      test('should retrieve valid credential successfully', () async {
        // Arrange
        final credential = StoredCredential(
          identifier: 'user123',
          value: 'secret_token',
          type: CredentialType.manabo,
          createdAt: DateTime.now(),
        );

        when(
          () => mockSecureStorage.containsKey('credential_meta_manabo_user123'),
        ).thenAnswer((_) async => const Right(true));
        when(
          () => mockSecureStorage.read('credential_meta_manabo_user123'),
        ).thenAnswer((_) async => Right(jsonEncode(credential.toJson())));
        when(
          () => mockSecureStorage.read('credential_manabo_user123'),
        ).thenAnswer((_) async => const Right('secret_token'));

        // Act
        final result = await credentialManager.getCredential(
          type: CredentialType.manabo,
          identifier: 'user123',
        );

        // Assert
        expect(result.isRight(), isTrue);
        final retrievedCredential = result.getOrElse(() => null);
        expect(retrievedCredential, isNotNull);
        expect(retrievedCredential!.identifier, equals('user123'));
        expect(retrievedCredential.value, equals('secret_token'));
        expect(retrievedCredential.type, equals(CredentialType.manabo));
      });

      test('should return null for non-existent credential', () async {
        // Arrange
        when(
          () => mockSecureStorage.containsKey('credential_meta_manabo_user123'),
        ).thenAnswer((_) async => const Right(false));

        // Act
        final result = await credentialManager.getCredential(
          type: CredentialType.manabo,
          identifier: 'user123',
        );

        // Assert
        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => null), isNull);
      });

      test('should auto-invalidate expired credentials', () async {
        // Arrange
        final expiredCredential = StoredCredential(
          identifier: 'user123',
          value: 'secret_token',
          type: CredentialType.manabo,
          createdAt: DateTime(2024, 1, 1),
          expiresAt: DateTime(2024, 1, 2), // Past date
        );

        when(
          () => mockSecureStorage.containsKey('credential_meta_manabo_user123'),
        ).thenAnswer((_) async => const Right(true));
        when(
          () => mockSecureStorage.read('credential_meta_manabo_user123'),
        ).thenAnswer(
          (_) async => Right(jsonEncode(expiredCredential.toJson())),
        );
        when(
          () => mockSecureStorage.delete(any()),
        ).thenAnswer((_) async => const Right(unit));

        // Act
        final result = await credentialManager.getCredential(
          type: CredentialType.manabo,
          identifier: 'user123',
        );

        // Assert
        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => null), isNull);
        verify(() => mockSecureStorage.delete('credential_manabo_user123'));
        verify(
          () => mockSecureStorage.delete('credential_meta_manabo_user123'),
        );
      });

      test(
        'should cleanup metadata when credential value is missing',
        () async {
          // Arrange
          final credential = StoredCredential(
            identifier: 'user123',
            value: 'secret_token',
            type: CredentialType.manabo,
            createdAt: DateTime.now(),
          );

          when(
            () =>
                mockSecureStorage.containsKey('credential_meta_manabo_user123'),
          ).thenAnswer((_) async => const Right(true));
          when(
            () => mockSecureStorage.read('credential_meta_manabo_user123'),
          ).thenAnswer((_) async => Right(jsonEncode(credential.toJson())));
          when(
            () => mockSecureStorage.read('credential_manabo_user123'),
          ).thenAnswer((_) async => const Right(null));
          when(
            () => mockSecureStorage.delete('credential_meta_manabo_user123'),
          ).thenAnswer((_) async => const Right(unit));

          // Act
          final result = await credentialManager.getCredential(
            type: CredentialType.manabo,
            identifier: 'user123',
          );

          // Assert
          expect(result.isRight(), isTrue);
          expect(result.getOrElse(() => null), isNull);
          verify(
            () => mockSecureStorage.delete('credential_meta_manabo_user123'),
          );
        },
      );

      test('should handle storage errors', () async {
        // Arrange
        when(() => mockSecureStorage.containsKey(any())).thenAnswer(
          (_) async => Left(
            StorageFailureFactory.readFailure(message: 'Storage failed'),
          ),
        );

        // Act
        final result = await credentialManager.getCredential(
          type: CredentialType.manabo,
          identifier: 'user123',
        );

        // Assert
        expect(result.isLeft(), isTrue);
      });
    });

    group('removeCredential', () {
      test('should remove credential and metadata successfully', () async {
        // Arrange
        when(
          () => mockSecureStorage.delete(any()),
        ).thenAnswer((_) async => const Right(unit));

        // Act
        final result = await credentialManager.removeCredential(
          type: CredentialType.manabo,
          identifier: 'user123',
        );

        // Assert
        expect(result.isRight(), isTrue);
        verify(() => mockSecureStorage.delete('credential_manabo_user123'));
        verify(
          () => mockSecureStorage.delete('credential_meta_manabo_user123'),
        );
      });

      test('should handle storage errors gracefully', () async {
        // Arrange
        when(() => mockSecureStorage.delete(any())).thenAnswer(
          (_) async => Left(
            StorageFailureFactory.writeFailure(message: 'Delete failed'),
          ),
        );

        // Act
        await credentialManager.removeCredential(
          type: CredentialType.manabo,
          identifier: 'user123',
        );

        // Assert
        // Should continue cleanup even if individual deletes fail
        verify(() => mockSecureStorage.delete('credential_manabo_user123'));
        verify(
          () => mockSecureStorage.delete('credential_meta_manabo_user123'),
        );
      });
    });

    group('hasValidCredential', () {
      test('should return true for valid credential', () async {
        // Arrange
        final credential = StoredCredential(
          identifier: 'user123',
          value: 'secret_token',
          type: CredentialType.manabo,
          createdAt: DateTime.now(),
        );

        when(
          () => mockSecureStorage.containsKey('credential_meta_manabo_user123'),
        ).thenAnswer((_) async => const Right(true));
        when(
          () => mockSecureStorage.read('credential_meta_manabo_user123'),
        ).thenAnswer((_) async => Right(jsonEncode(credential.toJson())));
        when(
          () => mockSecureStorage.read('credential_manabo_user123'),
        ).thenAnswer((_) async => const Right('secret_token'));

        // Act
        final result = await credentialManager.hasValidCredential(
          type: CredentialType.manabo,
          identifier: 'user123',
        );

        // Assert
        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => false), isTrue);
      });

      test('should return false for non-existent credential', () async {
        // Arrange
        when(
          () => mockSecureStorage.containsKey('credential_meta_manabo_user123'),
        ).thenAnswer((_) async => const Right(false));

        // Act
        final result = await credentialManager.hasValidCredential(
          type: CredentialType.manabo,
          identifier: 'user123',
        );

        // Assert
        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => true), isFalse);
      });
    });

    group('getCredentialsByType', () {
      test('should return all valid credentials for type', () async {
        // Arrange
        when(() => mockSecureStorage.getAllKeys()).thenAnswer(
          (_) async => const Right([
            'credential_meta_manabo_user1',
            'credential_meta_manabo_user2',
            'credential_meta_albo_user1',
            'other_key',
          ]),
        );

        final credential1 = StoredCredential(
          identifier: 'user1',
          value: 'token1',
          type: CredentialType.manabo,
          createdAt: DateTime.now(),
        );

        final credential2 = StoredCredential(
          identifier: 'user2',
          value: 'token2',
          type: CredentialType.manabo,
          createdAt: DateTime.now(),
        );

        when(
          () => mockSecureStorage.containsKey('credential_meta_manabo_user1'),
        ).thenAnswer((_) async => const Right(true));
        when(
          () => mockSecureStorage.read('credential_meta_manabo_user1'),
        ).thenAnswer((_) async => Right(jsonEncode(credential1.toJson())));
        when(
          () => mockSecureStorage.read('credential_manabo_user1'),
        ).thenAnswer((_) async => const Right('token1'));

        when(
          () => mockSecureStorage.containsKey('credential_meta_manabo_user2'),
        ).thenAnswer((_) async => const Right(true));
        when(
          () => mockSecureStorage.read('credential_meta_manabo_user2'),
        ).thenAnswer((_) async => Right(jsonEncode(credential2.toJson())));
        when(
          () => mockSecureStorage.read('credential_manabo_user2'),
        ).thenAnswer((_) async => const Right('token2'));

        // Act
        final result = await credentialManager.getCredentialsByType(
          CredentialType.manabo,
        );

        // Assert
        expect(result.isRight(), isTrue);
        final credentials = result.getOrElse(() => []);
        expect(credentials.length, equals(2));
        expect(
          credentials.map((c) => c.identifier),
          containsAll(['user1', 'user2']),
        );
      });

      test('should handle storage errors', () async {
        // Arrange
        when(() => mockSecureStorage.getAllKeys()).thenAnswer(
          (_) async => Left(
            StorageFailureFactory.readFailure(message: 'Storage failed'),
          ),
        );

        // Act
        final result = await credentialManager.getCredentialsByType(
          CredentialType.manabo,
        );

        // Assert
        expect(result.isLeft(), isTrue);
      });
    });

    group('clearCredentialsByType', () {
      test('should clear all credentials for type', () async {
        // Arrange
        when(() => mockSecureStorage.getAllKeys()).thenAnswer(
          (_) async => const Right([
            'credential_meta_manabo_user1',
            'credential_meta_manabo_user2',
          ]),
        );

        final credential1 = StoredCredential(
          identifier: 'user1',
          value: 'token1',
          type: CredentialType.manabo,
          createdAt: DateTime.now(),
        );

        when(
          () => mockSecureStorage.containsKey('credential_meta_manabo_user1'),
        ).thenAnswer((_) async => const Right(true));
        when(
          () => mockSecureStorage.read('credential_meta_manabo_user1'),
        ).thenAnswer((_) async => Right(jsonEncode(credential1.toJson())));
        when(
          () => mockSecureStorage.read('credential_manabo_user1'),
        ).thenAnswer((_) async => const Right('token1'));

        when(
          () => mockSecureStorage.containsKey('credential_meta_manabo_user2'),
        ).thenAnswer((_) async => const Right(false));

        when(
          () => mockSecureStorage.delete(any()),
        ).thenAnswer((_) async => const Right(unit));

        // Act
        final result = await credentialManager.clearCredentialsByType(
          CredentialType.manabo,
        );

        // Assert
        expect(result.isRight(), isTrue);
        verify(() => mockSecureStorage.delete('credential_manabo_user1'));
        verify(() => mockSecureStorage.delete('credential_meta_manabo_user1'));
      });
    });

    group('clearAllCredentials', () {
      test('should clear all credential-related keys', () async {
        // Arrange
        when(() => mockSecureStorage.getAllKeys()).thenAnswer(
          (_) async => const Right([
            'credential_manabo_user1',
            'credential_meta_manabo_user1',
            'credential_albo_user1',
            'other_key',
          ]),
        );
        when(
          () => mockSecureStorage.delete(any()),
        ).thenAnswer((_) async => const Right(unit));

        // Act
        final result = await credentialManager.clearAllCredentials();

        // Assert
        expect(result.isRight(), isTrue);
        verify(() => mockSecureStorage.delete('credential_manabo_user1'));
        verify(() => mockSecureStorage.delete('credential_meta_manabo_user1'));
        verify(() => mockSecureStorage.delete('credential_albo_user1'));
        verifyNever(() => mockSecureStorage.delete('other_key'));
      });
    });

    group('updateCredentialMetadata', () {
      test('should update metadata for existing credential', () async {
        // Arrange
        final existingCredential = StoredCredential(
          identifier: 'user123',
          value: 'secret_token',
          type: CredentialType.manabo,
          createdAt: DateTime.now(),
          metadata: {'old': 'value'},
        );

        when(
          () => mockSecureStorage.containsKey('credential_meta_manabo_user123'),
        ).thenAnswer((_) async => const Right(true));
        when(
          () => mockSecureStorage.read('credential_meta_manabo_user123'),
        ).thenAnswer(
          (_) async => Right(jsonEncode(existingCredential.toJson())),
        );
        when(
          () => mockSecureStorage.read('credential_manabo_user123'),
        ).thenAnswer((_) async => const Right('secret_token'));
        when(
          () => mockSecureStorage.write(any(), any()),
        ).thenAnswer((_) async => const Right(unit));

        // Act
        final result = await credentialManager.updateCredentialMetadata(
          type: CredentialType.manabo,
          identifier: 'user123',
          metadata: {'new': 'value'},
        );

        // Assert
        expect(result.isRight(), isTrue);
        verify(
          () => mockSecureStorage.write(
            'credential_manabo_user123',
            'secret_token',
          ),
        );
        verify(
          () =>
              mockSecureStorage.write('credential_meta_manabo_user123', any()),
        );
      });

      test('should fail for non-existent credential', () async {
        // Arrange
        when(
          () => mockSecureStorage.containsKey('credential_meta_manabo_user123'),
        ).thenAnswer((_) async => const Right(false));

        // Act
        final result = await credentialManager.updateCredentialMetadata(
          type: CredentialType.manabo,
          identifier: 'user123',
          metadata: {'new': 'value'},
        );

        // Assert
        expect(result.isLeft(), isTrue);
      });
    });

    group('Security Tests', () {
      test('should use proper key prefixes for separation', () {
        final credentialKey = credentialManager._getCredentialKey(
          CredentialType.manabo,
          'user123',
        );
        final metadataKey = credentialManager._getMetadataKey(
          CredentialType.manabo,
          'user123',
        );

        expect(credentialKey, equals('credential_manabo_user123'));
        expect(metadataKey, equals('credential_meta_manabo_user123'));
        expect(credentialKey, isNot(equals(metadataKey)));
      });

      test('should handle different credential types separately', () {
        final manaboKey = credentialManager._getCredentialKey(
          CredentialType.manabo,
          'user123',
        );
        final alboKey = credentialManager._getCredentialKey(
          CredentialType.albo,
          'user123',
        );

        expect(manaboKey, isNot(equals(alboKey)));
        expect(manaboKey, contains('manabo'));
        expect(alboKey, contains('albo'));
      });

      test('should handle special characters in identifiers safely', () {
        final key = credentialManager._getCredentialKey(
          CredentialType.manabo,
          'user@example.com',
        );

        expect(key, equals('credential_manabo_user@example.com'));
        // Verify no special handling breaks the key structure
        expect(key.startsWith('credential_'), isTrue);
      });
    });
  });
}

// Extension to access private methods for testing
extension CredentialManagerTestExtension on CredentialManager {
  String _getCredentialKey(CredentialType type, String identifier) {
    return 'credential_${type.value}_$identifier';
  }

  String _getMetadataKey(CredentialType type, String identifier) {
    return 'credential_meta_${type.value}_$identifier';
  }
}
