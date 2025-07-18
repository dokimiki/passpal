import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:passpal/core/config/models/admin_config.dart';
import 'package:passpal/core/config/models/api_config.dart';
import 'package:passpal/core/config/models/app_config.dart';
import 'package:passpal/core/config/models/auth_config.dart';
import 'package:passpal/core/config/models/debug_config.dart';
import 'package:passpal/core/config/models/feature_flags.dart';
import 'package:passpal/core/config/providers/config_provider.dart';
import 'package:passpal/core/config/services/config_cache.dart';
import 'package:passpal/core/config/services/config_merger.dart';
import 'package:passpal/core/config/services/config_update_monitor.dart';
import 'package:passpal/core/config/sources/env_config_source.dart';
import 'package:passpal/core/config/sources/remote_config_source.dart';
import 'mock_config_sources.dart';

part 'mock_config_providers.g.dart';

/// Mock test configuration provider
@riverpod
AppConfig testAppConfig(Ref ref) {
  return getTestConfig();
}

/// Mock loaded configuration provider for testing
@riverpod
Future<AppConfig> testLoadedConfig(Ref ref) async {
  // Simulate loading delay
  await Future.delayed(const Duration(milliseconds: 100));
  return getTestConfig();
}

/// Mock configuration provider that always returns loading state
@riverpod
Future<AppConfig> testLoadingConfig(Ref ref) async {
  // Never complete to simulate loading state
  await Future.delayed(const Duration(seconds: 10));
  return getTestConfig();
}

/// Mock configuration provider that always throws an error
@riverpod
Future<AppConfig> testErrorConfig(Ref ref) async {
  throw Exception('Test configuration error');
}

/// Mock configuration provider with custom config
@riverpod
AppConfig testCustomConfig(Ref ref, AppConfig config) {
  return config;
}

/// Mock configuration initialization provider
@riverpod
Future<void> testInitializeConfig(Ref ref) async {
  // Simulate initialization
  await Future.delayed(const Duration(milliseconds: 50));
}

/// Mock configuration refresh provider
@riverpod
Future<AppConfig> testRefreshedConfig(Ref ref) async {
  // Simulate refresh delay
  await Future.delayed(const Duration(milliseconds: 200));
  return getTestConfig(version: '1.0.1'); // Return updated config
}

/// Mock API config provider
@riverpod
ApiConfig testApiConfig(Ref ref) {
  return getTestApiConfig();
}

/// Mock Auth config provider
@riverpod
AuthConfig testAuthConfig(Ref ref) {
  return getTestAuthConfig();
}

/// Mock Debug config provider
@riverpod
DebugConfig testDebugConfig(Ref ref) {
  return getTestDebugConfig();
}

/// Mock Feature flags provider
@riverpod
FeatureFlags testFeatureFlags(Ref ref) {
  return getTestFeatureFlags();
}

/// Mock Admin config provider
@riverpod
AdminConfig testAdminConfig(Ref ref) {
  return getTestAdminConfig();
}

/// Mock config merger provider
@riverpod
ConfigMerger testConfigMerger(Ref ref) {
  return ConfigMerger(
    envConfigSource: ref.watch(mockEnvConfigSourceProvider),
    remoteConfigSource: ref.watch(mockRemoteConfigSourceProvider),
  );
}

/// Mock config cache provider
@riverpod
ConfigCache testConfigCache(Ref ref) {
  return ConfigCache();
}

/// Mock config update monitor provider
@riverpod
ConfigUpdateMonitor testConfigUpdateMonitor(Ref ref) {
  return ConfigUpdateMonitor(
    remoteConfigSource: ref.watch(mockRemoteConfigSourceProvider),
    ref: ref,
  );
}

/// Mock env config source provider
@riverpod
EnvConfigSource testEnvConfigSource(Ref ref) {
  return ref.watch(mockEnvConfigSourceProvider);
}

/// Mock remote config source provider
@riverpod
RemoteConfigSource testRemoteConfigSource(Ref ref) {
  return ref.watch(mockRemoteConfigSourceProvider);
}

/// Test configuration factory methods
AppConfig getTestConfig({
  String? version,
  bool? enableAnalytics,
  bool? enableCrashReporting,
  bool? enableDebugMode,
  ApiConfig? apiConfig,
  AuthConfig? authConfig,
  DebugConfig? debugConfig,
  FeatureFlags? featureFlags,
  AdminConfig? adminConfig,
}) {
  return AppConfig(
    version: version ?? '1.0.0',
    enableAnalytics: enableAnalytics ?? true,
    enableCrashReporting: enableCrashReporting ?? true,
    enableDebugMode: enableDebugMode ?? false,
    apiConfig: apiConfig ?? getTestApiConfig(),
    authConfig: authConfig ?? getTestAuthConfig(),
    debugConfig: debugConfig ?? getTestDebugConfig(),
    featureFlags: featureFlags ?? getTestFeatureFlags(),
    adminConfig: adminConfig ?? getTestAdminConfig(),
  );
}

ApiConfig getTestApiConfig({
  String? manaboBaseUrl,
  String? alboBaseUrl,
  String? cubicsBaseUrl,
  String? ssoUrl,
  String? palApiBaseUrl,
  int? connectionTimeoutSeconds,
  int? receiveTimeoutSeconds,
  int? maxRetries,
}) {
  return ApiConfig(
    manaboBaseUrl: manaboBaseUrl ?? 'https://test.manabo.chukyo-u.ac.jp',
    alboBaseUrl: alboBaseUrl ?? 'https://test.albo.chukyo-u.ac.jp',
    cubicsBaseUrl: cubicsBaseUrl ?? 'https://test.cubics.chukyo-u.ac.jp',
    ssoUrl: ssoUrl ?? 'https://test.sso.chukyo-u.ac.jp',
    palApiBaseUrl: palApiBaseUrl ?? 'https://test.api.chukyo-passpal.app/v1',
    connectionTimeoutSeconds: connectionTimeoutSeconds ?? 10,
    receiveTimeoutSeconds: receiveTimeoutSeconds ?? 20,
    maxRetries: maxRetries ?? 2,
  );
}

AuthConfig getTestAuthConfig({String? allowedEmailDomain}) {
  return AuthConfig(
    allowedEmailDomain:
        allowedEmailDomain ?? '@test.chukyo-u.ac.jp', // cspell:disable-line
  );
}

DebugConfig getTestDebugConfig({
  String? logLevel,
  bool? enableConsoleLogging,
  bool? enableFileLogging,
  bool? enableNetworkLogging,
  bool? enableCrashlytics,
}) {
  return DebugConfig(
    logLevel: logLevel ?? 'debug',
    enableConsoleLogging: enableConsoleLogging ?? true,
    enableFileLogging: enableFileLogging ?? true,
    enableNetworkLogging: enableNetworkLogging ?? true,
    enableCrashlytics: enableCrashlytics ?? false,
  );
}

FeatureFlags getTestFeatureFlags({
  bool? enableOfflineMode,
  bool? enablePushNotifications,
  bool? enableMaintenanceMode,
}) {
  return FeatureFlags(
    enableOfflineMode: enableOfflineMode ?? true,
    enablePushNotifications: enablePushNotifications ?? true,
    enableMaintenanceMode: enableMaintenanceMode ?? false,
  );
}

AdminConfig getTestAdminConfig({
  String? appVersion,
  String? minSupportedVersion,
  bool? isMaintenanceMode,
  String? maintenanceMessage,
}) {
  return AdminConfig(
    appVersion: appVersion ?? '1.0.0',
    minSupportedVersion: minSupportedVersion ?? '1.0.0',
    isMaintenanceMode: isMaintenanceMode ?? false,
    maintenanceMessage: maintenanceMessage ?? 'Test maintenance message',
  );
}

/// Provider container override utilities for testing
class TestConfigProviderOverrides {
  /// Create overrides for basic configuration testing
  static List<Override> basic() {
    return [
      appConfigProvider.overrideWith((ref) => getTestConfig()),
      loadedConfigProvider.overrideWith((ref) async => getTestConfig()),
      apiConfigProvider.overrideWith((ref) => getTestApiConfig()),
      authConfigProvider.overrideWith((ref) => getTestAuthConfig()),
      debugConfigProvider.overrideWith((ref) => getTestDebugConfig()),
      featureFlagsProvider.overrideWith((ref) => getTestFeatureFlags()),
      adminConfigProvider.overrideWith((ref) => getTestAdminConfig()),
    ];
  }

  /// Create overrides for loading state testing
  static List<Override> loading() {
    return [
      loadedConfigProvider.overrideWith((ref) async {
        await Future.delayed(const Duration(seconds: 10));
        return getTestConfig();
      }),
      ...basic(),
    ];
  }

  /// Create overrides for error state testing
  static List<Override> error() {
    return [
      loadedConfigProvider.overrideWith((ref) async {
        throw Exception('Test configuration error');
      }),
      // Include basic overrides except loadedConfigProvider
      appConfigProvider.overrideWith((ref) => getTestConfig()),
      apiConfigProvider.overrideWith((ref) => getTestApiConfig()),
      authConfigProvider.overrideWith((ref) => getTestAuthConfig()),
      debugConfigProvider.overrideWith((ref) => getTestDebugConfig()),
      featureFlagsProvider.overrideWith((ref) => getTestFeatureFlags()),
      adminConfigProvider.overrideWith((ref) => getTestAdminConfig()),
    ];
  }

  /// Create overrides with custom configuration
  static List<Override> custom(AppConfig config) {
    return [
      appConfigProvider.overrideWith((ref) => config),
      loadedConfigProvider.overrideWith((ref) async => config),
      apiConfigProvider.overrideWith((ref) => config.apiConfig),
      authConfigProvider.overrideWith((ref) => config.authConfig),
      debugConfigProvider.overrideWith((ref) => config.debugConfig),
      featureFlagsProvider.overrideWith((ref) => config.featureFlags),
      adminConfigProvider.overrideWith((ref) => config.adminConfig),
    ];
  }

  /// Create overrides for service testing
  static List<Override> services() {
    return [
      configMergerProvider.overrideWith(
        (ref) => ConfigMerger(
          envConfigSource: ref.watch(mockEnvConfigSourceProvider),
          remoteConfigSource: ref.watch(mockRemoteConfigSourceProvider),
        ),
      ),
      configCacheProvider.overrideWith((ref) => ConfigCache()),
      envConfigSourceProvider.overrideWith(
        (ref) => ref.watch(mockEnvConfigSourceProvider),
      ),
      remoteConfigSourceProvider.overrideWith(
        (ref) => ref.watch(mockRemoteConfigSourceProvider),
      ),
    ];
  }

  /// Create overrides for full integration testing
  static List<Override> integration() {
    return [...basic(), ...services()];
  }
}

/// Test configuration scenarios for different testing needs
class TestConfigScenarios {
  /// Development environment configuration
  static AppConfig development() {
    return getTestConfig(
      enableDebugMode: true,
      debugConfig: getTestDebugConfig(
        logLevel: 'debug',
        enableConsoleLogging: true,
        enableFileLogging: true,
        enableCrashlytics: false,
      ),
      featureFlags: getTestFeatureFlags(
        enableOfflineMode: true,
        enablePushNotifications: false,
      ),
    );
  }

  /// Production environment configuration
  static AppConfig production() {
    return getTestConfig(
      enableDebugMode: false,
      debugConfig: getTestDebugConfig(
        logLevel: 'warn',
        enableConsoleLogging: false,
        enableFileLogging: false,
        enableCrashlytics: true,
      ),
      featureFlags: getTestFeatureFlags(
        enableOfflineMode: true,
        enablePushNotifications: true,
      ),
    );
  }

  /// Maintenance mode configuration
  static AppConfig maintenance() {
    return getTestConfig(
      featureFlags: getTestFeatureFlags(enableMaintenanceMode: true),
      adminConfig: getTestAdminConfig(
        isMaintenanceMode: true,
        maintenanceMessage: 'System under maintenance',
      ),
    );
  }

  /// Offline mode configuration
  static AppConfig offline() {
    return getTestConfig(
      featureFlags: getTestFeatureFlags(
        enableOfflineMode: true,
        enablePushNotifications: false,
      ),
    );
  }

  /// Minimal configuration for testing
  static AppConfig minimal() {
    return getTestConfig(
      enableAnalytics: false,
      enableCrashReporting: false,
      enableDebugMode: false,
      featureFlags: getTestFeatureFlags(
        enableOfflineMode: false,
        enablePushNotifications: false,
        enableMaintenanceMode: false,
      ),
    );
  }
}
