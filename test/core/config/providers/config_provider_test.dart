import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:passpal/core/config/providers/config_provider.dart';
import 'package:passpal/core/config/services/config_cache.dart';
import 'package:passpal/core/config/services/config_merger.dart';
import 'package:passpal/core/error/providers.dart';
import 'package:passpal/core/config/models/app_config.dart';
import 'package:passpal/core/config/models/api_config.dart';
import 'package:passpal/core/config/models/auth_config.dart';
import 'package:passpal/core/config/models/debug_config.dart';
import 'package:passpal/core/config/models/feature_flags.dart';
import 'package:passpal/core/config/models/admin_config.dart';

// Generate mocks
@GenerateNiceMocks([
  MockSpec<ConfigMerger>(),
  MockSpec<ConfigCache>(),
  MockSpec<CrashlyticsService>(),
  MockSpec<ErrorReporter>(),
])
import 'config_provider_test.mocks.dart';

void main() {
  group('ConfigProvider', () {
    late ProviderContainer container;
    late MockConfigMerger mockMerger;
    late MockConfigCache mockCache;
    late MockCrashlyticsService mockCrashlytics;
    late MockErrorReporter mockErrorReporter;

    setUp(() {
      mockMerger = MockConfigMerger();
      mockCache = MockConfigCache();
      mockCrashlytics = MockCrashlyticsService();
      mockErrorReporter = MockErrorReporter();

      container = ProviderContainer(
        overrides: [
          configMergerProvider.overrideWithValue(mockMerger),
          configCacheProvider.overrideWithValue(mockCache),
          crashlyticsServiceProvider.overrideWithValue(mockCrashlytics),
          errorReporterProvider.overrideWithValue(mockErrorReporter),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('appConfig', () {
      test('should return default configuration', () {
        final config = container.read(appConfigProvider);

        expect(config.version, equals('1.0.0'));
        expect(config.enableAnalytics, isTrue);
        expect(config.enableCrashReporting, isTrue);
        expect(config.enableDebugMode, isFalse);
        expect(
          config.apiConfig.manaboBaseUrl,
          equals('https://manabo.cnc.chukyo-u.ac.jp'),
        );
        expect(
          config.authConfig.allowedEmailDomain,
          equals('@m.chukyo-u.ac.jp'),
        );
      });
    });

    group('loadedConfig', () {
      test('should return cached config when available', () async {
        final testConfig = AppConfig(
          version: '2.0.0',
          enableAnalytics: false,
          enableCrashReporting: false,
          enableDebugMode: true,
          apiConfig: const ApiConfig(
            manaboBaseUrl: 'https://test.example.com',
            alboBaseUrl: 'https://test.example.com',
            cubicsBaseUrl: 'https://test.example.com',
            ssoUrl: 'https://test.example.com',
            palApiBaseUrl: 'https://test.example.com',
            connectionTimeoutSeconds: 10,
            receiveTimeoutSeconds: 20,
            maxRetries: 1,
          ),
          authConfig: const AuthConfig(allowedEmailDomain: '@test.com'),
          debugConfig: const DebugConfig(
            logLevel: 'debug',
            enableConsoleLogging: true,
            enableFileLogging: true,
            enableNetworkLogging: true,
            enableCrashlytics: true,
          ),
          featureFlags: const FeatureFlags(
            enableOfflineMode: false,
            enablePushNotifications: false,
            enableMaintenanceMode: true,
          ),
          adminConfig: const AdminConfig(
            appVersion: '2.0.0',
            minSupportedVersion: '2.0.0',
            isMaintenanceMode: true,
            maintenanceMessage: 'Test maintenance',
          ),
        );

        when(mockCache.cachedConfig).thenReturn(testConfig);

        final config = await container.read(loadedConfigProvider.future);

        expect(config.version, equals('2.0.0'));
        expect(config.enableAnalytics, isFalse);
        expect(config.enableDebugMode, isTrue);
        verify(mockCache.cachedConfig).called(1);
      });

      test('should load from merger when cache is empty', () async {
        final testConfig = AppConfig(
          version: '3.0.0',
          enableAnalytics: true,
          enableCrashReporting: true,
          enableDebugMode: false,
          apiConfig: const ApiConfig(
            manaboBaseUrl: 'https://remote.example.com',
            alboBaseUrl: 'https://remote.example.com',
            cubicsBaseUrl: 'https://remote.example.com',
            ssoUrl: 'https://remote.example.com',
            palApiBaseUrl: 'https://remote.example.com',
            connectionTimeoutSeconds: 30,
            receiveTimeoutSeconds: 60,
            maxRetries: 3,
          ),
          authConfig: const AuthConfig(allowedEmailDomain: '@remote.com'),
          debugConfig: const DebugConfig(
            logLevel: 'info',
            enableConsoleLogging: false,
            enableFileLogging: false,
            enableNetworkLogging: true,
            enableCrashlytics: true,
          ),
          featureFlags: const FeatureFlags(
            enableOfflineMode: true,
            enablePushNotifications: true,
            enableMaintenanceMode: false,
          ),
          adminConfig: const AdminConfig(
            appVersion: '3.0.0',
            minSupportedVersion: '3.0.0',
            isMaintenanceMode: false,
            maintenanceMessage: '',
          ),
        );

        when(mockCache.cachedConfig).thenReturn(null);
        when(mockMerger.mergeConfigs()).thenAnswer((_) async => testConfig);

        final config = await container.read(loadedConfigProvider.future);

        expect(config.version, equals('3.0.0'));
        expect(
          config.apiConfig.manaboBaseUrl,
          equals('https://remote.example.com'),
        );
        verify(mockCache.cachedConfig).called(1);
        verify(mockMerger.mergeConfigs()).called(1);
        verify(mockCache.cacheConfig(testConfig)).called(1);
      });

      test('should return default config when merger fails', () async {
        when(mockCache.cachedConfig).thenReturn(null);
        when(mockMerger.mergeConfigs()).thenThrow(Exception('Network error'));

        final config = await container.read(loadedConfigProvider.future);

        expect(config.version, equals('1.0.0'));
        expect(
          config.apiConfig.manaboBaseUrl,
          equals('https://manabo.cnc.chukyo-u.ac.jp'),
        );
        verify(mockCache.cachedConfig).called(1);
        verify(mockMerger.mergeConfigs()).called(1);
        verify(mockErrorReporter.reportError(any)).called(1);
      });
    });

    group('specific config providers', () {
      test('should provide API config', () {
        final apiConfig = container.read(apiConfigProvider);
        expect(
          apiConfig.manaboBaseUrl,
          equals('https://manabo.cnc.chukyo-u.ac.jp'),
        );
        expect(apiConfig.connectionTimeoutSeconds, equals(30));
      });

      test('should provide auth config', () {
        final authConfig = container.read(authConfigProvider);
        expect(authConfig.allowedEmailDomain, equals('@m.chukyo-u.ac.jp'));
      });

      test('should provide debug config', () {
        final debugConfig = container.read(debugConfigProvider);
        expect(debugConfig.logLevel, equals('info'));
        expect(debugConfig.enableNetworkLogging, isTrue);
      });

      test('should provide feature flags', () {
        final flags = container.read(featureFlagsProvider);
        expect(flags.enableOfflineMode, isTrue);
        expect(flags.enablePushNotifications, isTrue);
        expect(flags.enableMaintenanceMode, isFalse);
      });

      test('should provide admin config', () {
        final adminConfig = container.read(adminConfigProvider);
        expect(adminConfig.appVersion, equals('1.0.0'));
        expect(adminConfig.isMaintenanceMode, isFalse);
      });
    });

    group('feature flag helpers', () {
      test('should check feature flags correctly', () {
        expect(container.read(isFeatureEnabledProvider('offlineMode')), isTrue);
        expect(
          container.read(isFeatureEnabledProvider('pushNotifications')),
          isTrue,
        );
        expect(
          container.read(isFeatureEnabledProvider('maintenanceMode')),
          isFalse,
        );
        expect(
          container.read(isFeatureEnabledProvider('unknownFeature')),
          isFalse,
        );
      });
    });

    group('configuration flags', () {
      test('should check debug mode', () {
        expect(container.read(isDebugModeProvider), isFalse);
      });

      test('should check analytics enabled', () {
        expect(container.read(isAnalyticsEnabledProvider), isTrue);
      });

      test('should check crash reporting enabled', () {
        expect(container.read(isCrashReportingEnabledProvider), isTrue);
      });
    });
  });
}
