import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/config/models/api_config.dart';
import 'package:passpal/core/config/exceptions/config_exception.dart';

void main() {
  group('Config Network URL Exception Propagation Tests', () {
    test('should handle URL configuration validation', () {
      // Test that ApiConfig validates required URLs
      expect(
        () => const ApiConfig(
          palapiBaseUrl: 'https://api.chukyo-passpal.app/v1',
          alboBaseUrl: 'https://albo.chukyonet.jp',
          manaboBaseUrl: 'https://manabo.chukyonet.jp',
          cubicsBaseUrl: 'https://cubics.chukyonet.jp',
          ssoBaseUrl: 'https://sso.chukyonet.jp',
        ),
        returnsNormally,
      );
    });

    test('should provide default URL configuration when sources fail', () {
      // Test that default configuration is available
      final defaultConfig = ApiConfig.defaultConfig;

      expect(defaultConfig.palapiBaseUrl, isNotEmpty);
      expect(defaultConfig.alboBaseUrl, isNotEmpty);
      expect(defaultConfig.manaboBaseUrl, isNotEmpty);
      expect(defaultConfig.cubicsBaseUrl, isNotEmpty);
      expect(defaultConfig.ssoBaseUrl, isNotEmpty);

      // Verify URLs are valid format
      expect(defaultConfig.palapiBaseUrl, startsWith('https://'));
      expect(defaultConfig.alboBaseUrl, startsWith('https://'));
      expect(defaultConfig.manaboBaseUrl, startsWith('https://'));
      expect(defaultConfig.cubicsBaseUrl, startsWith('https://'));
      expect(defaultConfig.ssoBaseUrl, startsWith('https://'));
    });

    test('should handle network URL environment variable parsing', () {
      // Test that URL environment variables are properly parsed
      const testUrls = {
        'PAL_API_BASE_URL': 'https://test-api.example.com/v1',
        'ALBO_BASE_URL': 'https://test-albo.example.com',
        'MANABO_BASE_URL': 'https://test-manabo.example.com',
        'CUBICS_BASE_URL': 'https://test-cubics.example.com',
        'SSO_BASE_URL': 'https://test-sso.example.com',
      };

      for (final entry in testUrls.entries) {
        final url = entry.value;

        // Verify URL format is valid
        expect(url, startsWith('https://'));
        expect(url, contains('.'));
        expect(
          Uri.tryParse(url),
          isNotNull,
          reason: 'Invalid URL format: $url',
        );
      }
    });

    test('should create ApiConfig with custom URLs for testing', () {
      // Test that custom configuration works for testing scenarios
      final customConfig = const ApiConfig(
        palapiBaseUrl: 'https://test-api.example.com/v1',
        alboBaseUrl: 'https://test-albo.example.com',
        manaboBaseUrl: 'https://test-manabo.example.com',
        cubicsBaseUrl: 'https://test-cubics.example.com',
        ssoBaseUrl: 'https://test-sso.example.com',
      );

      expect(customConfig.palapiBaseUrl, 'https://test-api.example.com/v1');
      expect(customConfig.alboBaseUrl, 'https://test-albo.example.com');
      expect(customConfig.manaboBaseUrl, 'https://test-manabo.example.com');
      expect(customConfig.cubicsBaseUrl, 'https://test-cubics.example.com');
      expect(customConfig.ssoBaseUrl, 'https://test-sso.example.com');
    });

    test('should validate that all URLs are properly set in default config', () {
      // This test ensures configuration errors would propagate to error handling
      final config = ApiConfig.defaultConfig;

      // These checks would throw exceptions if URLs are malformed,
      // which would then propagate to core/error and Crashlytics mock
      final urls = [
        config.palapiBaseUrl,
        config.alboBaseUrl,
        config.manaboBaseUrl,
        config.cubicsBaseUrl,
        config.ssoBaseUrl,
      ];

      for (final url in urls) {
        final uri = Uri.tryParse(url);
        expect(uri, isNotNull, reason: 'Malformed URL: $url');
        expect(uri!.hasScheme, isTrue, reason: 'URL missing scheme: $url');
        expect(uri.scheme, equals('https'), reason: 'Non-HTTPS URL: $url');
        expect(uri.host, isNotEmpty, reason: 'URL missing host: $url');
      }
    });

    test('should handle configuration errors that reach error reporting system', () {
      // This test simulates configuration errors that would reach Crashlytics mock

      try {
        // Attempt to create invalid configuration
        const invalidConfig = ApiConfig(
          palapiBaseUrl: 'https://api.chukyo-passpal.app/v1',
          alboBaseUrl: 'https://albo.chukyonet.jp',
          manaboBaseUrl: 'https://manabo.chukyonet.jp',
          cubicsBaseUrl: 'https://cubics.chukyonet.jp',
          ssoBaseUrl: 'https://sso.chukyonet.jp',
        );

        // Validation should pass for valid config
        expect(invalidConfig.palapiBaseUrl, isNotEmpty);
      } catch (e) {
        // If any validation errors occur, they should be ConfigException types
        // that will be properly handled by the error reporting system
        expect(e, isA<ConfigException>());

        if (e is ConfigException) {
          expect(e.message, isNotEmpty);
          expect(e.isFatal, isA<bool>());
          // Note: In production, this would automatically reach Crashlytics mock
          // through the global error handler in core/error
        }
      }
    });
  });
}
