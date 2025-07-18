import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:passpal/core/config/providers/config_provider.dart';
import 'package:passpal/core/config/services/config_cache.dart';
import 'package:passpal/core/config/services/config_merger.dart';
import 'package:passpal/core/config/sources/env_config_source.dart';
import 'package:passpal/core/config/sources/remote_config_source.dart';
import 'mock_config_providers.dart';

void main() {
  group('Mock Config Providers', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    group('Test Config Providers', () {
      test('testAppConfig should return default test configuration', () {
        // Act
        final config = container.read(testAppConfigProvider);

        // Assert
        expect(config.version, '1.0.0');
        expect(config.enableAnalytics, true);
        expect(config.enableDebugMode, false);
        expect(
          config.apiConfig.manaboBaseUrl,
          'https://test.manabo.chukyo-u.ac.jp',
        );
        expect(config.authConfig.allowedEmailDomain, '@test.chukyo-u.ac.jp');
        expect(config.debugConfig.logLevel, 'debug');
        expect(config.featureFlags.enableOfflineMode, true);
        expect(config.adminConfig.appVersion, '1.0.0');
      });

      test(
        'testLoadedConfig should return configuration after delay',
        () async {
          // Act
          final config = await container.read(testLoadedConfigProvider.future);

          // Assert
          expect(config.version, '1.0.0');
          expect(config.enableAnalytics, true);
        },
      );

      test('testLoadingConfig should simulate loading state', () async {
        // Arrange
        final provider = container.read(testLoadingConfigProvider);

        // Act & Assert
        expect(provider.isLoading, true);
        expect(provider.hasError, false);
        expect(provider.hasValue, false);
      });

      test('testErrorConfig should throw exception', () async {
        // Act & Assert
        expect(
          () => container.read(testErrorConfigProvider.future),
          throwsA(isA<Exception>()),
        );
      });

      test('testCustomConfig should return custom configuration', () {
        // Arrange
        final customConfig = getTestConfig(
          version: '2.0.0',
          enableDebugMode: true,
        );

        // Act
        final config = container.read(testCustomConfigProvider(customConfig));

        // Assert
        expect(config.version, '2.0.0');
        expect(config.enableDebugMode, true);
      });
    });

    group('Test Config Section Providers', () {
      test('testApiConfig should return test API configuration', () {
        // Act
        final apiConfig = container.read(testApiConfigProvider);

        // Assert
        expect(apiConfig.manaboBaseUrl, 'https://test.manabo.chukyo-u.ac.jp');
        expect(apiConfig.connectionTimeoutSeconds, 10);
        expect(apiConfig.maxRetries, 2);
      });

      test('testAuthConfig should return test Auth configuration', () {
        // Act
        final authConfig = container.read(testAuthConfigProvider);

        // Assert
        expect(authConfig.allowedEmailDomain, '@test.chukyo-u.ac.jp');
      });

      test('testDebugConfig should return test Debug configuration', () {
        // Act
        final debugConfig = container.read(testDebugConfigProvider);

        // Assert
        expect(debugConfig.logLevel, 'debug');
        expect(debugConfig.enableConsoleLogging, true);
        expect(debugConfig.enableFileLogging, true);
        expect(debugConfig.enableCrashlytics, false);
      });

      test('testFeatureFlags should return test Feature flags', () {
        // Act
        final featureFlags = container.read(testFeatureFlagsProvider);

        // Assert
        expect(featureFlags.enableOfflineMode, true);
        expect(featureFlags.enablePushNotifications, true);
        expect(featureFlags.enableMaintenanceMode, false);
      });

      test('testAdminConfig should return test Admin configuration', () {
        // Act
        final adminConfig = container.read(testAdminConfigProvider);

        // Assert
        expect(adminConfig.appVersion, '1.0.0');
        expect(adminConfig.minSupportedVersion, '1.0.0');
        expect(adminConfig.isMaintenanceMode, false);
        expect(adminConfig.maintenanceMessage, 'Test maintenance message');
      });
    });

    group('Test Config Factory Methods', () {
      test('getTestConfig should return default test configuration', () {
        // Act
        final config = getTestConfig();

        // Assert
        expect(config.version, '1.0.0');
        expect(config.enableAnalytics, true);
        expect(config.enableDebugMode, false);
      });

      test('getTestConfig should support custom parameters', () {
        // Act
        final config = getTestConfig(
          version: '2.0.0',
          enableDebugMode: true,
          enableAnalytics: false,
        );

        // Assert
        expect(config.version, '2.0.0');
        expect(config.enableDebugMode, true);
        expect(config.enableAnalytics, false);
      });

      test('getTestApiConfig should return test API configuration', () {
        // Act
        final apiConfig = getTestApiConfig();

        // Assert
        expect(apiConfig.manaboBaseUrl, 'https://test.manabo.chukyo-u.ac.jp');
        expect(apiConfig.connectionTimeoutSeconds, 10);
      });

      test('getTestApiConfig should support custom parameters', () {
        // Act
        final apiConfig = getTestApiConfig(
          manaboBaseUrl: 'https://custom.manabo.chukyo-u.ac.jp',
          connectionTimeoutSeconds: 60,
        );

        // Assert
        expect(apiConfig.manaboBaseUrl, 'https://custom.manabo.chukyo-u.ac.jp');
        expect(apiConfig.connectionTimeoutSeconds, 60);
      });
    });
  });

  group('TestConfigProviderOverrides', () {
    group('basic()', () {
      test('should override basic configuration providers', () {
        // Arrange
        final container = ProviderContainer(
          overrides: TestConfigProviderOverrides.basic(),
        );

        // Act
        final appConfig = container.read(appConfigProvider);
        final apiConfig = container.read(apiConfigProvider);
        final authConfig = container.read(authConfigProvider);

        // Assert
        expect(appConfig.version, '1.0.0');
        expect(apiConfig.manaboBaseUrl, 'https://test.manabo.chukyo-u.ac.jp');
        expect(authConfig.allowedEmailDomain, '@test.chukyo-u.ac.jp');

        // Cleanup
        container.dispose();
      });
    });

    group('loading()', () {
      test('should override loaded config with loading state', () {
        // Arrange
        final container = ProviderContainer(
          overrides: TestConfigProviderOverrides.loading(),
        );

        // Act
        final loadedConfig = container.read(loadedConfigProvider);

        // Assert
        expect(loadedConfig.isLoading, true);
        expect(loadedConfig.hasError, false);
        expect(loadedConfig.hasValue, false);

        // Cleanup
        container.dispose();
      });
    });

    group('error()', () {
      test('should override loaded config with error state', () async {
        // Arrange
        final container = ProviderContainer(
          overrides: TestConfigProviderOverrides.error(),
        );

        // Act & Assert - Test the Future directly
        await expectLater(
          container.read(loadedConfigProvider.future),
          throwsA(isA<Exception>()),
        );

        // Alternative: Test the AsyncValue state
        final loadedConfig = container.read(loadedConfigProvider);
        expect(loadedConfig.hasError, true);
        expect(loadedConfig.isLoading, false);
        expect(loadedConfig.hasValue, false);

        // Cleanup
        container.dispose();
      });
    });

    group('custom()', () {
      test('should override with custom configuration', () {
        // Arrange
        final customConfig = getTestConfig(
          version: '3.0.0',
          enableDebugMode: true,
        );
        final container = ProviderContainer(
          overrides: TestConfigProviderOverrides.custom(customConfig),
        );

        // Act
        final appConfig = container.read(appConfigProvider);
        final apiConfig = container.read(apiConfigProvider);

        // Assert
        expect(appConfig.version, '3.0.0');
        expect(appConfig.enableDebugMode, true);
        expect(apiConfig.manaboBaseUrl, customConfig.apiConfig.manaboBaseUrl);

        // Cleanup
        container.dispose();
      });
    });

    group('services()', () {
      test('should override service providers', () {
        // Arrange
        final container = ProviderContainer(
          overrides: TestConfigProviderOverrides.services(),
        );

        // Act
        final configMerger = container.read(configMergerProvider);
        final configCache = container.read(configCacheProvider);
        final envConfigSource = container.read(envConfigSourceProvider);
        final remoteConfigSource = container.read(remoteConfigSourceProvider);

        // Assert
        expect(configMerger, isNotNull);
        expect(configCache, isNotNull);
        expect(envConfigSource, isNotNull);
        expect(remoteConfigSource, isNotNull);

        // Cleanup
        container.dispose();
      });
    });

    group('integration()', () {
      test('should override all providers for integration testing', () {
        // Arrange
        final container = ProviderContainer(
          overrides: TestConfigProviderOverrides.integration(),
        );

        // Act
        final appConfig = container.read(appConfigProvider);
        final configMerger = container.read(configMergerProvider);
        final configCache = container.read(configCacheProvider);

        // Assert
        expect(appConfig, isNotNull);
        expect(configMerger, isNotNull);
        expect(configCache, isNotNull);

        // Cleanup
        container.dispose();
      });
    });
  });

  group('TestConfigScenarios', () {
    test('development() should return development configuration', () {
      // Act
      final config = TestConfigScenarios.development();

      // Assert
      expect(config.enableDebugMode, true);
      expect(config.debugConfig.logLevel, 'debug');
      expect(config.debugConfig.enableConsoleLogging, true);
      expect(config.debugConfig.enableCrashlytics, false);
      expect(config.featureFlags.enablePushNotifications, false);
    });

    test('production() should return production configuration', () {
      // Act
      final config = TestConfigScenarios.production();

      // Assert
      expect(config.enableDebugMode, false);
      expect(config.debugConfig.logLevel, 'warn');
      expect(config.debugConfig.enableConsoleLogging, false);
      expect(config.debugConfig.enableCrashlytics, true);
      expect(config.featureFlags.enablePushNotifications, true);
    });

    test('maintenance() should return maintenance configuration', () {
      // Act
      final config = TestConfigScenarios.maintenance();

      // Assert
      expect(config.featureFlags.enableMaintenanceMode, true);
      expect(config.adminConfig.isMaintenanceMode, true);
      expect(config.adminConfig.maintenanceMessage, 'System under maintenance');
    });

    test('offline() should return offline configuration', () {
      // Act
      final config = TestConfigScenarios.offline();

      // Assert
      expect(config.featureFlags.enableOfflineMode, true);
      expect(config.featureFlags.enablePushNotifications, false);
    });

    test('minimal() should return minimal configuration', () {
      // Act
      final config = TestConfigScenarios.minimal();

      // Assert
      expect(config.enableAnalytics, false);
      expect(config.enableCrashReporting, false);
      expect(config.enableDebugMode, false);
      expect(config.featureFlags.enableOfflineMode, false);
      expect(config.featureFlags.enablePushNotifications, false);
      expect(config.featureFlags.enableMaintenanceMode, false);
    });
  });
}
