import 'package:test/test.dart';
import 'package:passpal/core/storage/errors/storage_exception.dart';

void main() {
  group('Storage Exception Propagation', () {
    test('StorageExceptions should implement Exception interface', () {
      final exceptions = [
        const DeserializeException(
          key: 'cache.assignments',
          message: 'Invalid JSON format',
          cause: 'FormatException: Unexpected character',
        ),
        const SecureIoException(
          operation: 'read',
          message: 'Failed to read from secure storage',
          cause: 'PlatformException',
        ),
        const KvIoException(
          operation: 'putJson',
          message: 'Failed to save JSON data',
          cause: 'SharedPreferences error',
        ),
      ];

      for (final exception in exceptions) {
        expect(exception, isA<Exception>());
        expect(exception, isA<StorageException>());
      }
    });

    test('StorageExceptions should have proper error messages', () {
      const deserializeException = DeserializeException(
        key: 'cache.assignments',
        message: 'Invalid JSON format',
      );
      
      const secureIoException = SecureIoException(
        operation: 'read',
        message: 'Failed to read from secure storage',
      );
      
      const kvIoException = KvIoException(
        operation: 'putJson',
        message: 'Failed to save JSON data',
      );

      expect(deserializeException.toString(), 
        contains('DeserializeException(key: cache.assignments): Invalid JSON format'));
      expect(secureIoException.toString(), 
        contains('SecureIoException(operation: read): Failed to read from secure storage'));
      expect(kvIoException.toString(), 
        contains('KvIoException(operation: putJson): Failed to save JSON data'));
    });

    test('StorageExceptions should be thrown and caught properly', () {
      expect(() {
        throw const DeserializeException(
          key: 'test',
          message: 'test error',
        );
      }, throwsA(isA<DeserializeException>()));

      expect(() {
        throw const SecureIoException(
          operation: 'test',
          message: 'test error',
        );
      }, throwsA(isA<SecureIoException>()));

      expect(() {
        throw const KvIoException(
          operation: 'test',
          message: 'test error',
        );
      }, throwsA(isA<KvIoException>()));
    });

    test('StorageExceptions can be caught as StorageException', () {
      final exceptions = [
        const DeserializeException(key: 'test', message: 'test'),
        const SecureIoException(operation: 'test', message: 'test'),
        const KvIoException(operation: 'test', message: 'test'),
      ];

      for (final exception in exceptions) {
        expect(() => throw exception, throwsA(isA<StorageException>()));
      }
    });
  });
}
