import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:passpal/core/storage/models/credentials.dart';
import 'package:passpal/core/storage/secure/flutter_secure_storage_credential_storage.dart';
import 'package:passpal/core/storage/errors/storage_exception.dart';

import 'flutter_secure_storage_credential_storage_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterSecureStorage>()])
void main() {
  group('FlutterSecureStorageCredentialStorage', () {
    late MockFlutterSecureStorage mockStorage;
    late FlutterSecureStorageCredentialStorage credentialStorage;

    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      credentialStorage = FlutterSecureStorageCredentialStorage(
        storage: mockStorage,
      );
    });

    group('save', () {
      test('should save credentials as JSON string', () async {
        const credentials = Credentials(
          username: 'test@example.com',
          password: 'password123',
          sessionCookie: 'session123',
        );

        await credentialStorage.save(credentials);

        verify(mockStorage.write(
          key: 'passpal_credentials',
          value: anyNamed('value'),
        )).called(1);
      });

      test('should throw SecureIoException when storage write fails', () async {
        const credentials = Credentials(
          username: 'test@example.com',
          password: 'password123',
        );

        when(mockStorage.write(
          key: anyNamed('key'), 
          value: anyNamed('value'),
        )).thenThrow(Exception('Storage error'));

        await expectLater(
          () => credentialStorage.save(credentials),
          throwsA(isA<SecureIoException>()
              .having((e) => e.operation, 'operation', 'save')
              .having((e) => e.message, 'message', 
                contains('Failed to save credentials'))),
        );
      });
    });

    group('read', () {
      test('should return null when no credentials stored', () async {
        when(mockStorage.read(key: anyNamed('key')))
            .thenAnswer((_) async => null);

        final result = await credentialStorage.read();

        expect(result, isNull);
      });

      test('should return credentials when valid JSON stored', () async {
        const jsonString = '{"username":"test@example.com","password":"password123","sessionCookie":"session123","expiresAt":null}';
        when(mockStorage.read(key: anyNamed('key')))
            .thenAnswer((_) async => jsonString);

        final result = await credentialStorage.read();

        expect(result, isNotNull);
        expect(result!.username, equals('test@example.com'));
        expect(result.password, equals('password123'));
        expect(result.sessionCookie, equals('session123'));
      });

      test('should throw SecureIoException when storage read fails', () async {
        when(mockStorage.read(key: anyNamed('key')))
            .thenThrow(Exception('Storage error'));

        await expectLater(
          () => credentialStorage.read(),
          throwsA(isA<SecureIoException>()
              .having((e) => e.operation, 'operation', 'read')
              .having((e) => e.message, 'message', 
                contains('Failed to read credentials'))),
        );
      });

      test('should throw SecureIoException when invalid JSON stored', () async {
        when(mockStorage.read(key: anyNamed('key')))
            .thenAnswer((_) async => 'invalid json');

        await expectLater(
          () => credentialStorage.read(),
          throwsA(isA<SecureIoException>()),
        );
      });
    });

    group('purge', () {
      test('should delete credentials from storage', () async {
        await credentialStorage.purge();

        verify(mockStorage.delete(key: 'passpal_credentials')).called(1);
      });

      test('should throw SecureIoException when storage delete fails', () async {
        when(mockStorage.delete(key: anyNamed('key')))
            .thenThrow(Exception('Storage error'));

        await expectLater(
          () => credentialStorage.purge(),
          throwsA(isA<SecureIoException>()
              .having((e) => e.operation, 'operation', 'purge')
              .having((e) => e.message, 'message', 
                contains('Failed to purge credentials'))),
        );
      });
    });
  });
}
