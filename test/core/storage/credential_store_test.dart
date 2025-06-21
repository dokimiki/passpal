import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:passpal/core/storage/credential_store.dart';

import 'credential_store_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  group('CredentialStore', () {
    late MockFlutterSecureStorage mockStorage;
    late CredentialStore credentialStore;

    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      credentialStore = CredentialStore(mockStorage);
    });

    group('write', () {
      test('calls secureStorage.write with correct parameters', () async {
        // Arrange
        const key = 'auth_id';
        const value = 'user123';
        when(
          mockStorage.write(key: anyNamed('key'), value: anyNamed('value')),
        ).thenAnswer((_) async => null);

        // Act
        await credentialStore.write(key, value);

        // Assert
        verify(mockStorage.write(key: key, value: value)).called(1);
      });

      test('rethrows exception when secureStorage.write fails', () async {
        // Arrange
        const key = 'auth_id';
        const value = 'user123';
        final exception = Exception('Storage write failed');
        when(
          mockStorage.write(key: anyNamed('key'), value: anyNamed('value')),
        ).thenThrow(exception);

        // Act & Assert
        expect(
          () async => await credentialStore.write(key, value),
          throwsA(exception),
        );
      });
    });

    group('read', () {
      test(
        'calls secureStorage.read with correct key and returns value',
        () async {
          // Arrange
          const key = 'auth_id';
          const expectedValue = 'user123';
          when(
            mockStorage.read(key: anyNamed('key')),
          ).thenAnswer((_) async => expectedValue);

          // Act
          final result = await credentialStore.read(key);

          // Assert
          verify(mockStorage.read(key: key)).called(1);
          expect(result, equals(expectedValue));
        },
      );

      test('returns null when key does not exist', () async {
        // Arrange
        const key = 'nonexistent_key';
        when(
          mockStorage.read(key: anyNamed('key')),
        ).thenAnswer((_) async => null);

        // Act
        final result = await credentialStore.read(key);

        // Assert
        verify(mockStorage.read(key: key)).called(1);
        expect(result, isNull);
      });

      test('rethrows exception when secureStorage.read fails', () async {
        // Arrange
        const key = 'auth_id';
        final exception = Exception('Storage read failed');
        when(mockStorage.read(key: anyNamed('key'))).thenThrow(exception);

        // Act & Assert
        expect(() async => await credentialStore.read(key), throwsA(exception));
      });
    });

    group('delete', () {
      test('calls secureStorage.delete with specific key', () async {
        // Arrange
        const key = 'auth_id';
        when(
          mockStorage.delete(key: anyNamed('key')),
        ).thenAnswer((_) async => null);

        // Act
        await credentialStore.delete(key: key);

        // Assert
        verify(mockStorage.delete(key: key)).called(1);
        verifyNever(mockStorage.deleteAll());
      });
      test('calls secureStorage.deleteAll when all=true', () async {
        // Arrange
        when(mockStorage.deleteAll()).thenAnswer((_) async => null);

        // Act
        await credentialStore.delete(all: true);

        // Assert
        verify(mockStorage.deleteAll()).called(1);
      });
      test(
        'calls secureStorage.deleteAll when all=true even with key provided',
        () async {
          // Arrange
          const key = 'auth_id';
          when(mockStorage.deleteAll()).thenAnswer((_) async => null);

          // Act
          await credentialStore.delete(key: key, all: true);

          // Assert
          verify(mockStorage.deleteAll()).called(1);
          verifyNever(mockStorage.delete(key: anyNamed('key')));
        },
      );

      test('throws ArgumentError when key is null and all is false', () async {
        // Act & Assert
        expect(
          () async => await credentialStore.delete(),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('rethrows exception when secureStorage.delete fails', () async {
        // Arrange
        const key = 'auth_id';
        final exception = Exception('Storage delete failed');
        when(mockStorage.delete(key: anyNamed('key'))).thenThrow(exception);

        // Act & Assert
        expect(
          () async => await credentialStore.delete(key: key),
          throwsA(exception),
        );
      });

      test('rethrows exception when secureStorage.deleteAll fails', () async {
        // Arrange
        final exception = Exception('Storage deleteAll failed');
        when(mockStorage.deleteAll()).thenThrow(exception);

        // Act & Assert
        expect(
          () async => await credentialStore.delete(all: true),
          throwsA(exception),
        );
      });
    });
  });
}
