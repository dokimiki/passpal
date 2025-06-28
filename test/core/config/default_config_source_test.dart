import 'package:test/test.dart';
import 'package:passpal/core/config/sources/default_config_source.dart';

void main() {
  late DefaultConfigSource source;

  setUp(() {
    source = const DefaultConfigSource();
  });

  group('DefaultConfigSource', () {
    test('should initialize without errors', () async {
      await expectLater(source.initialize(), completes);
    });

    test('should return correct source name', () {
      expect(source.sourceName, equals('Default'));
    });

    test('should return default string values', () async {
      final baseUrl = await source.getString('PAL_API_BASE_URL');
      expect(baseUrl, equals('https://api.chukyo-passpal.app/v1'));
    });

    test('should return default bool values', () async {
      final newParser = await source.getBool('FEATURE_NEW_ASSIGNMENT_PARSER');
      expect(newParser, isFalse);

      final biometric = await source.getBool('FEATURE_BIOMETRIC_AUTH');
      expect(biometric, isFalse);

      final offline = await source.getBool('FEATURE_OFFLINE_MODE');
      expect(offline, isFalse);

      final experimental = await source.getBool('FEATURE_EXPERIMENTAL');
      expect(experimental, isFalse);
    });

    test('should return default debug values', () async {
      final showLogs = await source.getBool('DEBUG_SHOW_LOGS');
      expect(showLogs, isFalse);

      final mockData = await source.getBool('DEBUG_MOCK_DATA');
      expect(mockData, isFalse);

      final networkLogging = await source.getBool('DEBUG_NETWORK_LOGGING');
      expect(networkLogging, isFalse);

      final performance = await source.getBool('DEBUG_PERFORMANCE_MONITORING');
      expect(performance, isFalse);
    });

    test('should return null for unknown keys', () async {
      final unknown = await source.getString('UNKNOWN_KEY');
      expect(unknown, isNull);
    });

    test('should provide change stream', () {
      expect(source.onConfigChanged, isA<Stream<String>>());
    });

    test('should dispose without errors', () async {
      await expectLater(source.dispose(), completes);
    });
  });
}
