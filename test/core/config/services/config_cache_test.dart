import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/config/models/admin_config.dart';
import 'package:passpal/core/config/models/api_config.dart';
import 'package:passpal/core/config/models/app_config.dart';
import 'package:passpal/core/config/models/auth_config.dart';
import 'package:passpal/core/config/models/debug_config.dart';
import 'package:passpal/core/config/models/feature_flags.dart';
import 'package:passpal/core/config/services/config_cache.dart';

void main() {
  group('ConfigCache', () {
    late ConfigCache cache;
    late AppConfig testConfig;

    setUp(() {
      cache = ConfigCache();
      testConfig = const AppConfig(
        version: '1.0.0',
        enableAnalytics: true,
        enableCrashReporting: true,
        enableDebugMode: false,
        apiConfig: ApiConfig(
          manaboBaseUrl: 'https://manabo.example.com',
          alboBaseUrl: 'https://albo.example.com',
          cubicsBaseUrl: 'https://cubics.example.com',
          ssoUrl: 'https://sso.example.com',
          palApiBaseUrl: 'https://api.example.com',
          connectionTimeoutSeconds: 30,
          receiveTimeoutSeconds: 60,
          maxRetries: 3,
        ),
        authConfig: AuthConfig(allowedEmailDomain: '@example.com'),
        debugConfig: DebugConfig(
          logLevel: 'info',
          enableConsoleLogging: false,
          enableFileLogging: false,
          enableNetworkLogging: true,
          enableCrashlytics: true,
        ),
        featureFlags: FeatureFlags(
          enableOfflineMode: true,
          enablePushNotifications: true,
          enableMaintenanceMode: false,
        ),
        adminConfig: AdminConfig(
          appVersion: '1.0.0',
          minSupportedVersion: '1.0.0',
          isMaintenanceMode: false,
          maintenanceMessage: '',
        ),
      );
    });

    tearDown(() {
      cache.dispose();
    });

    test('should return null when cache is empty', () {
      expect(cache.cachedConfig, isNull);
      expect(cache.isCacheValid, isFalse);
      expect(cache.timeUntilExpiration, isNull);
    });

    test('should cache configuration successfully', () {
      cache.cacheConfig(testConfig);

      expect(cache.cachedConfig, equals(testConfig));
      expect(cache.isCacheValid, isTrue);
      expect(cache.timeUntilExpiration, isNotNull);
    });

    test('should return cached config when valid', () {
      cache.cacheConfig(testConfig);

      final cached = cache.cachedConfig;
      expect(cached, equals(testConfig));
      expect(cached?.version, equals('1.0.0'));
    });

    test('should invalidate cache after expiration', () async {
      // Cache with 24-hour expiration now
      cache.cacheConfig(testConfig);

      // Manually set cache time to past expiration (25 hours ago)
      cache.setCacheTime(DateTime.now().subtract(const Duration(hours: 25)));

      expect(cache.cachedConfig, isNull);
      expect(cache.isCacheValid, isFalse);
    });

    test('should manually invalidate cache', () {
      cache.cacheConfig(testConfig);
      expect(cache.cachedConfig, equals(testConfig));

      cache.invalidateCache();

      expect(cache.cachedConfig, isNull);
      expect(cache.isCacheValid, isFalse);
      expect(cache.timeUntilExpiration, isNull);
    });

    test('should calculate time until expiration correctly', () {
      cache.cacheConfig(testConfig);

      final timeUntilExpiration = cache.timeUntilExpiration;
      expect(timeUntilExpiration, isNotNull);
      expect(timeUntilExpiration!.inHours, lessThanOrEqualTo(24));
      expect(timeUntilExpiration.inHours, greaterThanOrEqualTo(23));
    });

    test('should emit cache updates through stream', () async {
      final updates = <AppConfig?>[];
      final subscription = cache.cacheUpdateStream.listen(updates.add);

      cache.cacheConfig(testConfig);
      await Future.delayed(const Duration(milliseconds: 10));

      cache.invalidateCache();
      await Future.delayed(const Duration(milliseconds: 10));

      expect(updates.length, equals(2));
      expect(updates[0], equals(testConfig));
      expect(updates[1], isNull);

      await subscription.cancel();
    });

    test('should handle multiple config updates', () {
      cache.cacheConfig(testConfig);
      final firstCached = cache.cachedConfig;

      final updatedConfig = testConfig.copyWith(version: '1.1.0');
      cache.cacheConfig(updatedConfig);
      final secondCached = cache.cachedConfig;

      expect(firstCached?.version, equals('1.0.0'));
      expect(secondCached?.version, equals('1.1.0'));
    });

    test('should properly dispose resources', () {
      cache.cacheConfig(testConfig);

      expect(() => cache.dispose(), returnsNormally);

      // After dispose, stream should be closed
      expect(cache.cacheUpdateStream.isBroadcast, isTrue);
    });
  });
}
