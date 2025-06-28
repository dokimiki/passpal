import 'package:test/test.dart';
import 'package:passpal/core/config/exceptions/config_exception.dart';

void main() {
  group('ConfigException', () {
    test('should create ConfigParseException with correct properties', () {
      const exception = ConfigParseException(
        message: 'Invalid value',
        key: 'test_key',
        value: 'invalid_value',
      );

      expect(exception.message, equals('Invalid value'));
      expect(exception.key, equals('test_key'));
      expect(exception.value, equals('invalid_value'));
      expect(exception.isFatal, isFalse);
    });

    test('should create ConfigSourceException with correct properties', () {
      const exception = ConfigSourceException(
        message: 'Source error',
        source: 'TestSource',
      );

      expect(exception.message, equals('Source error'));
      expect(exception.source, equals('TestSource'));
      expect(exception.isFatal, isFalse);
    });

    test('should create RequiredConfigMissingException as fatal', () {
      const exception = RequiredConfigMissingException(key: 'required_key');

      expect(exception.key, equals('required_key'));
      expect(exception.isFatal, isTrue);
      expect(exception.message, contains('required_key'));
    });

    test('should format toString correctly', () {
      const parseException = ConfigParseException(
        message: 'Invalid value',
        key: 'test_key',
        value: 'invalid_value',
      );

      const sourceException = ConfigSourceException(
        message: 'Source error',
        source: 'TestSource',
      );

      const missingException = RequiredConfigMissingException(
        key: 'required_key',
      );

      expect(parseException.toString(), contains('ConfigParseException'));
      expect(parseException.toString(), contains('test_key'));
      expect(parseException.toString(), contains('invalid_value'));

      expect(sourceException.toString(), contains('ConfigSourceException'));
      expect(sourceException.toString(), contains('TestSource'));

      expect(
        missingException.toString(),
        contains('RequiredConfigMissingException'),
      );
      expect(missingException.toString(), contains('required_key'));
    });
  });
}
