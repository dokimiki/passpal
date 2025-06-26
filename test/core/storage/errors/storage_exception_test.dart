import 'package:test/test.dart';
import 'package:passpal/core/storage/errors/storage_exception.dart';

void main() {
  group('StorageException', () {
    test('deserialize exception should have correct properties', () {
      const exception = DeserializeException(
        key: 'cache.assignments',
        message: 'Invalid JSON format',
        cause: 'FormatException: Unexpected character',
      );

      expect(exception.key, equals('cache.assignments'));
      expect(exception.message, equals('Invalid JSON format'));
      expect(exception.cause, equals('FormatException: Unexpected character'));
      expect(exception, isA<StorageException>());
    });

    test('secureIo exception should have correct properties', () {
      const exception = SecureIoException(
        operation: 'read',
        message: 'Failed to read from secure storage',
        cause: 'PlatformException',
      );

      expect(exception.operation, equals('read'));
      expect(exception.message, equals('Failed to read from secure storage'));
      expect(exception.cause, equals('PlatformException'));
      expect(exception, isA<StorageException>());
    });

    test('kvIo exception should have correct properties', () {
      const exception = KvIoException(
        operation: 'write',
        message: 'Failed to write to SharedPreferences',
      );

      expect(exception.operation, equals('write'));
      expect(exception.message, equals('Failed to write to SharedPreferences'));
      expect(exception.cause, isNull);
      expect(exception, isA<StorageException>());
    });

    test('exceptions should have correct toString', () {
      const deserializeException = DeserializeException(
        key: 'test',
        message: 'test message',
      );
      const secureIoException = SecureIoException(
        operation: 'read',
        message: 'test message',
      );
      const kvIoException = KvIoException(
        operation: 'write',
        message: 'test message',
      );

      expect(deserializeException.toString(), 
        equals('DeserializeException(key: test): test message'));
      expect(secureIoException.toString(), 
        equals('SecureIoException(operation: read): test message'));
      expect(kvIoException.toString(), 
        equals('KvIoException(operation: write): test message'));
    });

    test('exceptions should be different types', () {
      const exception1 = DeserializeException(
        key: 'test',
        message: 'test',
      );
      const exception2 = SecureIoException(
        operation: 'test',
        message: 'test',
      );

      expect(exception1.runtimeType, isNot(equals(exception2.runtimeType)));
    });
  });
}
