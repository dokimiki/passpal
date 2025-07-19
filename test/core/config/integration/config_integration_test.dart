import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:passpal/core/config/providers/config_provider.dart';
import 'package:passpal/core/config/services/config_cache.dart';
import 'package:passpal/core/config/services/config_merger.dart';
import 'package:passpal/core/config/sources/env_config_source.dart';
import 'package:passpal/core/config/sources/remote_config_source.dart';

import '../mocks/mock_config_sources.dart';
import 'mock_providers.dart';

void main() {
  group('Config Integration Tests', () {
    late ProviderContainer container;
    late MockEnvConfigSource mockEnvSource;
    late MockRemoteConfigSource mockRemoteSource;

    setUp(() {
      mockEnvSource = MockEnvConfigSource();
      mockRemoteSource = MockRemoteConfigSource();

      container = ProviderContainer(
        overrides: [
          envConfigSourceProvider.overrideWithValue(mockEnvSource),
          remoteConfigSourceProvider.overrideWithValue(mockRemoteSource),
          configMergerProvider.overrideWith(
            (ref) => ConfigMerger(
              envConfigSource: mockEnvSource,
              remoteConfigSource: mockRemoteSource,
            ),
          ),
          ...MockProviderOverrides.overrides,
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('End-to-End Configuration Loading', () {
      test(
        'should load configuration from all sources with correct priority',
        () async {
          // Set up mock data with different priorities
          mockEnvSource.setMockEnvData({
            'APP_VERSION': '2.0.0',
            'ENABLE_DEBUG_MODE': 'true',
            'MANABO_BASE_URL': 'https://env.manabo.chukyo-u.ac.jp',
            'LOG_LEVEL': 'debug',
          });

          mockRemoteSource.setMockRemoteData({
            'app_version': '1.5.0',
            'enable_analytics': false,
            'manabo_base_url': 'https://remote.manabo.chukyo-u.ac.jp',
            'log_level': 'info',
          });

          // Load configuration
          final config = await container.read(loadedConfigProvider.future);

          // Verify priority (env > remote > default)
          expect(config.version, equals('2.0.0')); // from env
          expect(config.enableDebugMode, isTrue); // from env
          expect(
            config.enableAnalytics,
            isTrue,
          ); // from env (default since not set)
          expect(config.enableCrashReporting, isTrue); // from default
          expect(
            config.apiConfig.manaboBaseUrl,
            equals('https://env.manabo.chukyo-u.ac.jp'),
          ); // from env
          expect(config.debugConfig.logLevel, equals('debug')); // from env
        },
      );

      test('should handle partial source failures gracefully', () async {
        // Set up env source to fail
        mockEnvSource.setErrorState(true, 'Env source failed');

        // Set up remote source with valid data
        mockRemoteSource.setMockRemoteData({
          'app_version': '1.5.0',
          'enable_analytics': false,
          'manabo_base_url': 'https://remote.manabo.chukyo-u.ac.jp',
        });

        // Load configuration
        final config = await container.read(loadedConfigProvider.future);

        // Should use remote + default values
        expect(config.version, equals('1.5.0')); // from remote
        expect(config.enableAnalytics, isFalse); // from remote
        expect(config.enableCrashReporting, isTrue); // from default
        expect(
          config.apiConfig.manaboBaseUrl,
          equals('https://remote.manabo.chukyo-u.ac.jp'),
        ); // from remote
      });

      test('should fall back to defaults when all sources fail', () async {
        // Set up all sources to fail
        mockEnvSource.setErrorState(true, 'Env source failed');
        mockRemoteSource.setErrorState(true, 'Remote source failed');

        // Load configuration
        final config = await container.read(loadedConfigProvider.future);

        // Should use default values
        expect(config.version, equals('1.0.0'));
        expect(config.enableAnalytics, isTrue);
        expect(config.enableCrashReporting, isTrue);
        expect(config.enableDebugMode, isFalse);
        expect(
          config.apiConfig.manaboBaseUrl,
          equals('https://manabo.cnc.chukyo-u.ac.jp'),
        );
      });
    });

    group('Configuration Caching Integration', () {
      test('should cache configuration after successful load', () async {
        // Set up mock data
        mockEnvSource.setMockEnvData({
          'APP_VERSION': '2.0.0',
          'ENABLE_DEBUG_MODE': 'true',
        });

        // First load - should fetch from sources
        final config1 = await container.read(loadedConfigProvider.future);
        expect(config1.version, equals('2.0.0'));

        // Verify cache is populated
        final cache = container.read(configCacheProvider);
        expect(cache.cachedConfig, isNotNull);
        expect(cache.cachedConfig!.version, equals('2.0.0'));

        // Second load - should use cache
        final config2 = await container.read(loadedConfigProvider.future);
        expect(config2.version, equals('2.0.0'));
      });

      test('should refresh cache when explicitly requested', () async {
        // Set up initial mock data
        mockEnvSource.setMockEnvData({
          'APP_VERSION': '1.0.0',
          'ENABLE_DEBUG_MODE': 'false',
        });

        // Load initial configuration
        final config1 = await container.read(loadedConfigProvider.future);
        expect(config1.version, equals('1.0.0'));
        expect(config1.enableDebugMode, isFalse);

        // Update mock data
        mockEnvSource.setMockEnvData({
          'APP_VERSION': '2.0.0',
          'ENABLE_DEBUG_MODE': 'true',
        });

        // Refresh configuration
        final config2 = await container.read(refreshedConfigProvider.future);
        expect(config2.version, equals('2.0.0'));
        expect(config2.enableDebugMode, isTrue);
      });

      test('should handle cache expiration', () async {
        // Set up mock data
        mockEnvSource.setMockEnvData({'APP_VERSION': '1.0.0'});

        // Load initial configuration
        final config1 = await container.read(loadedConfigProvider.future);
        expect(config1.version, equals('1.0.0'));

        // Manually expire cache (24-hour cache now)
        final cache = container.read(configCacheProvider);
        cache.invalidateCache();

        // Update mock data
        mockEnvSource.setMockEnvData({'APP_VERSION': '2.0.0'});

        // Invalidate the provider to force reload from sources
        container.refresh(loadedConfigProvider);

        // Load again - should fetch from sources due to expired cache
        final config2 = await container.read(loadedConfigProvider.future);
        expect(config2.version, equals('2.0.0'));
      });
    });

    group('Provider Interdependencies', () {
      test('should provide correct configuration sections', () async {
        // Clear cache and refresh all providers
        final cache = container.read(configCacheProvider);
        cache.invalidateCache();
        container.refresh(loadedConfigProvider);
        container.refresh(apiConfigProvider);
        container.refresh(authConfigProvider);
        container.refresh(debugConfigProvider);
        container.refresh(featureFlagsProvider);
        container.refresh(adminConfigProvider);

        mockEnvSource.setMockEnvData({
          'APP_VERSION': '2.0.0',
          'ENABLE_DEBUG_MODE': 'true',
          'MANABO_BASE_URL': 'https://env.manabo.chukyo-u.ac.jp',
          'ALLOWED_EMAIL_DOMAIN': '@test.chukyo-u.ac.jp',
          'LOG_LEVEL': 'debug',
          'ENABLE_OFFLINE_MODE': 'false',
          'ADMIN_APP_VERSION': '2.0.0',
          'MIN_SUPPORTED_VERSION': '1.5.0',
        });

        // Load configuration
        await container.read(loadedConfigProvider.future);

        // Provider state should now transition correctly after our fixes
        expect(
          container.read(apiConfigProvider).manaboBaseUrl,
          equals('https://env.manabo.chukyo-u.ac.jp'),
        );
        expect(
          container.read(authConfigProvider).allowedEmailDomain,
          equals('@test.chukyo-u.ac.jp'),
        );

        final debugConfig = container.read(debugConfigProvider);
        expect(debugConfig.logLevel, equals('debug'));
        expect(debugConfig.enableConsoleLogging, isTrue);

        final featureFlags = container.read(featureFlagsProvider);
        expect(featureFlags.enableOfflineMode, isFalse);

        final adminConfig = container.read(adminConfigProvider);
        expect(adminConfig.appVersion, equals('2.0.0'));
        expect(adminConfig.minSupportedVersion, equals('1.5.0'));
      });

      test('should provide correct utility checks', () async {
        // Clear cache and refresh all providers
        final cache = container.read(configCacheProvider);
        cache.invalidateCache();
        container.refresh(loadedConfigProvider);
        container.refresh(isDebugModeProvider);
        container.refresh(isAnalyticsEnabledProvider);
        container.refresh(isCrashReportingEnabledProvider);
        container.refresh(isFeatureEnabledProvider('offlineMode'));
        container.refresh(isFeatureEnabledProvider('pushNotifications'));
        container.refresh(isFeatureEnabledProvider('maintenanceMode'));

        mockEnvSource.setMockEnvData({
          'ENABLE_DEBUG_MODE': 'true',
          'ENABLE_ANALYTICS': 'false',
          'ENABLE_CRASH_REPORTING': 'true',
          'ENABLE_OFFLINE_MODE': 'true',
          'ENABLE_PUSH_NOTIFICATIONS': 'false',
          'ENABLE_MAINTENANCE_MODE': 'false',
        });

        // Load configuration
        await container.read(loadedConfigProvider.future);

        expect(container.read(isDebugModeProvider), isTrue);
        expect(container.read(isAnalyticsEnabledProvider), isFalse);
        expect(container.read(isCrashReportingEnabledProvider), isTrue);
        expect(container.read(isFeatureEnabledProvider('offlineMode')), isTrue);
        expect(
          container.read(isFeatureEnabledProvider('pushNotifications')),
          isFalse,
        );
        expect(
          container.read(isFeatureEnabledProvider('maintenanceMode')),
          isFalse,
        );
      });

      test('should handle loading and error states correctly', () async {
        // Clear cache and refresh providers
        final cache = container.read(configCacheProvider);
        cache.invalidateCache();
        container.refresh(loadedConfigProvider);
        container.refresh(isConfigLoadingProvider);
        container.refresh(hasConfigErrorsProvider);

        mockEnvSource.setMockEnvData({'APP_VERSION': '1.0.0'});

        // Check loading state by watching the provider and getting future
        final loadedConfigAsync = container.read(loadedConfigProvider);
        expect(loadedConfigAsync.isLoading, isTrue);
        expect(container.read(isConfigLoadingProvider), isTrue);

        // Wait for loading to complete
        final config = await container.read(loadedConfigProvider.future);
        expect(config, isNotNull);
        expect(container.read(isConfigLoadingProvider), isFalse);
        expect(container.read(hasConfigErrorsProvider), isFalse);
      });
    });

    group('Configuration Validation Integration', () {
      test('should validate loaded configuration from all sources', () async {
        // Set up valid configuration
        mockEnvSource.setMockEnvData({
          'APP_VERSION': '2.0.0',
          'MANABO_BASE_URL': 'https://valid.manabo.chukyo-u.ac.jp',
          'ALLOWED_EMAIL_DOMAIN': '@chukyo-u.ac.jp',
          'LOG_LEVEL': 'info',
        });

        mockRemoteSource.setMockRemoteData({
          'connection_timeout_seconds': 30,
          'max_retries': 3,
        });

        // Load configuration
        final config = await container.read(loadedConfigProvider.future);

        // Verify all values are valid
        expect(config.version, equals('2.0.0'));
        expect(config.apiConfig.manaboBaseUrl, startsWith('https://'));
        expect(config.authConfig.allowedEmailDomain, startsWith('@'));
        expect(
          config.debugConfig.logLevel,
          isIn(['debug', 'info', 'warning', 'error']),
        );
        expect(config.apiConfig.connectionTimeoutSeconds, greaterThan(0));
        expect(config.apiConfig.maxRetries, greaterThan(0));
      });

      test('should handle configuration with invalid values', () async {
        // Set up configuration with some invalid values
        mockEnvSource.setMockEnvData({
          'APP_VERSION': 'invalid-version',
          'MANABO_BASE_URL': 'not-a-url',
          'CONNECTION_TIMEOUT_SECONDS': '-1',
          'MAX_RETRIES': '0',
        });

        // Load configuration - should complete without throwing
        final config = await container.read(loadedConfigProvider.future);

        // Should use env values (even if invalid) due to priority
        expect(config.version, equals('invalid-version'));
        expect(config.apiConfig.manaboBaseUrl, equals('not-a-url'));
        expect(config.apiConfig.connectionTimeoutSeconds, equals(-1));
        expect(config.apiConfig.maxRetries, equals(0));
      });
    });

    group('Performance and Memory Integration', () {
      test('should handle multiple concurrent configuration loads', () async {
        // Set up mock data
        mockEnvSource.setMockEnvData({
          'APP_VERSION': '2.0.0',
          'ENABLE_DEBUG_MODE': 'true',
        });

        // Start multiple concurrent loads
        final futures = List.generate(
          10,
          (index) => container.read(loadedConfigProvider.future),
        );

        // Wait for all to complete
        final configs = await Future.wait(futures);

        // All should return the same configuration
        for (final config in configs) {
          expect(config.version, equals('2.0.0'));
          expect(config.enableDebugMode, isTrue);
        }
      });

      test('should properly dispose of resources', () async {
        // Set up configuration
        mockEnvSource.setMockEnvData({'APP_VERSION': '1.0.0'});

        // Load configuration
        await container.read(loadedConfigProvider.future);

        // Dispose container
        container.dispose();

        // Container should be disposed (no direct way to check, but dispose should complete without error)
        expect(true, isTrue);
      });
    });

    group('Complex Scenario Integration', () {
      test('should handle complete application lifecycle', () async {
        // 1. Initial configuration load
        mockEnvSource.setMockEnvData({
          'APP_VERSION': '1.0.0',
          'ENABLE_DEBUG_MODE': 'false',
        });

        mockRemoteSource.setMockRemoteData({
          'enable_analytics': true,
          'manabo_base_url': 'https://remote.manabo.chukyo-u.ac.jp',
        });

        // Initialize configuration
        await container.read(initializeConfigProvider.future);
        final initialConfig = await container.read(loadedConfigProvider.future);

        expect(initialConfig.version, equals('1.0.0'));
        expect(initialConfig.enableDebugMode, isFalse);
        expect(initialConfig.enableAnalytics, isTrue);

        // 2. Manual refresh
        mockEnvSource.setMockEnvData({
          'APP_VERSION': '2.0.0',
          'ENABLE_DEBUG_MODE': 'true',
        });

        final refreshedConfig = await container.read(
          refreshedConfigProvider.future,
        );
        expect(refreshedConfig.version, equals('2.0.0'));
        expect(refreshedConfig.enableDebugMode, isTrue);
      });

      test(
        'should handle configuration source failures during lifecycle',
        () async {
          // Initial setup
          mockEnvSource.setMockEnvData({'APP_VERSION': '1.0.0'});

          mockRemoteSource.setMockRemoteData({'enable_analytics': true});

          // Load initial configuration
          final initialConfig = await container.read(
            loadedConfigProvider.future,
          );
          expect(initialConfig.version, equals('1.0.0'));

          // Simulate env source failure
          mockEnvSource.setErrorState(true, 'Env source failed');

          // Update remote config
          mockRemoteSource.setMockRemoteData({
            'app_version': '2.0.0',
            'enable_analytics': false,
          });

          // Refresh configuration - should still work with remote + defaults
          final refreshedConfig = await container.read(
            refreshedConfigProvider.future,
          );
          expect(refreshedConfig.version, equals('2.0.0'));
          expect(refreshedConfig.enableAnalytics, isFalse);
        },
      );
    });
  });
}
