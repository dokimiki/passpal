import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../error/providers.dart';
import '../models/admin_config.dart';
import '../models/api_config.dart';
import '../models/app_config.dart';
import '../models/auth_config.dart';
import '../models/debug_config.dart';
import '../models/feature_flags.dart';
import '../services/config_cache.dart';
import '../services/config_merger.dart';

part 'config_provider.g.dart';

/// Configuration provider state
enum ConfigProviderState {
  /// Initial state, not loaded yet
  initial,

  /// Loading configuration
  loading,

  /// Configuration loaded successfully
  loaded,

  /// Error occurred during loading
  error,
}

/// Main configuration provider that manages app configuration
///
/// This provider handles:
/// - Configuration initialization and loading
/// - Memory caching with automatic expiration
/// - Error handling and recovery
/// - Configuration update monitoring
/// - Reactive configuration state management
@riverpod
AppConfig appConfig(Ref ref) {
  // Return default configuration initially
  return _getDefaultConfig();
}

/// Load configuration from all sources
///
/// This method:
/// 1. Checks cache first for valid configuration
/// 2. If cache is invalid, loads from merged sources
/// 3. Updates cache with new configuration
/// 4. Handles errors gracefully
@riverpod
Future<AppConfig> loadedConfig(Ref ref) async {
  final cache = ref.read(configCacheProvider);
  final merger = ref.read(configMergerProvider);
  final logger = ref.read(scopedLoggerProvider('ConfigProvider'));

  logger.info('Loading configuration');

  // Check cache first
  final cachedConfig = cache.cachedConfig;
  if (cachedConfig != null) {
    logger.info('Using cached configuration');
    return cachedConfig;
  }

  logger.info('Cache invalid, loading from sources');

  try {
    // Load from merged sources
    final config = await merger.mergeConfigs();

    // Update cache
    cache.cacheConfig(config);

    logger.info('Configuration loaded successfully');
    return config;
  } catch (error, stackTrace) {
    final errorReporter = ref.read(errorReporterProvider);

    logger.error(
      'Failed to load configuration: ${error.toString()}',
      stackTrace: stackTrace,
    );

    // Report error but don't throw - return defaults
    await errorReporter.reportError(
      AppError.now(
        message: 'Configuration loading failed: ${error.toString()}',
        errorCode: 'CONFIG_LOAD_ERROR',
        stackTrace: stackTrace,
        isRecoverable: true,
        retryDelay: const Duration(minutes: 1),
        context: {'error': error.toString()},
      ),
    );

    logger.warning('Using default configuration due to load failure');
    return _getDefaultConfig();
  }
}

/// Refresh configuration by clearing cache and reloading
@riverpod
Future<AppConfig> refreshedConfig(Ref ref) async {
  final cache = ref.read(configCacheProvider);
  final logger = ref.read(scopedLoggerProvider('ConfigProvider'));

  logger.info('Refreshing configuration');

  // Clear cache
  cache.invalidateCache();

  // Reload configuration
  return await ref.refresh(loadedConfigProvider.future);
}

/// Get default configuration
AppConfig _getDefaultConfig() {
  return AppConfig(
    version: '1.0.0',
    enableAnalytics: true,
    enableCrashReporting: true,
    enableDebugMode: false,
    apiConfig: const ApiConfig(
      manaboBaseUrl: 'https://manabo.cnc.chukyo-u.ac.jp',
      alboBaseUrl: 'https://cubics-pt-out.mng.chukyo-u.ac.jp',
      cubicsBaseUrl: 'https://cubics-as-out.mng.chukyo-u.ac.jp',
      ssoUrl: 'https://shib.chukyo-u.ac.jp',
      palApiBaseUrl: 'https://api.chukyo-passpal.app/v1',
      connectionTimeoutSeconds: 30,
      receiveTimeoutSeconds: 60,
      maxRetries: 3,
    ),
    authConfig: const AuthConfig(allowedEmailDomain: '@m.chukyo-u.ac.jp'),
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
      appVersion: '1.0.0',
      minSupportedVersion: '1.0.0',
      isMaintenanceMode: false,
      maintenanceMessage: '',
    ),
  );
}

/// Provider for configuration initialization
///
/// This provider handles the initialization of the configuration system
/// and should be called during app startup
@riverpod
Future<void> initializeConfig(Ref ref) async {
  final logger = ref.read(scopedLoggerProvider('ConfigInit'));

  logger.info('Initializing configuration system');

  try {
    // Load initial configuration
    await ref.read(loadedConfigProvider.future);

    // Set up cache update monitoring
    final cache = ref.read(configCacheProvider);
    cache.cacheUpdateStream.listen((config) {
      if (config != null) {
        logger.debug('Configuration cache updated');
      } else {
        logger.debug('Configuration cache invalidated');
      }
    });

    logger.info('Configuration system initialized successfully');
  } catch (error, stackTrace) {
    logger.error(
      'Failed to initialize configuration system: ${error.toString()}',
      stackTrace: stackTrace,
    );

    // Report error but don't throw - app can continue with defaults
    final errorReporter = ref.read(errorReporterProvider);
    await errorReporter.reportError(
      AppError.now(
        message:
            'Configuration system initialization failed: ${error.toString()}',
        errorCode: 'CONFIG_INIT_ERROR',
        stackTrace: stackTrace,
        isRecoverable: true,
        retryDelay: const Duration(minutes: 1),
        context: {'error': error.toString()},
      ),
    );
  }
}

/// Provider for checking if configuration is loading
@riverpod
bool isConfigLoading(Ref ref) {
  final loadedConfig = ref.watch(loadedConfigProvider);
  return loadedConfig.isLoading;
}

/// Provider for checking if configuration has errors
@riverpod
bool hasConfigErrors(Ref ref) {
  final loadedConfig = ref.watch(loadedConfigProvider);
  return loadedConfig.hasError;
}

/// Provider for getting specific configuration sections
@riverpod
ApiConfig apiConfig(Ref ref) {
  final config = ref.watch(appConfigProvider);
  return config.apiConfig;
}

@riverpod
AuthConfig authConfig(Ref ref) {
  final config = ref.watch(appConfigProvider);
  return config.authConfig;
}

@riverpod
DebugConfig debugConfig(Ref ref) {
  final config = ref.watch(appConfigProvider);
  return config.debugConfig;
}

@riverpod
FeatureFlags featureFlags(Ref ref) {
  final config = ref.watch(appConfigProvider);
  return config.featureFlags;
}

@riverpod
AdminConfig adminConfig(Ref ref) {
  final config = ref.watch(appConfigProvider);
  return config.adminConfig;
}

/// Provider for configuration version
@riverpod
String configVersion(Ref ref) {
  final config = ref.watch(appConfigProvider);
  return config.version;
}

/// Provider for feature flag checks
@riverpod
bool isFeatureEnabled(Ref ref, String feature) {
  final flags = ref.watch(featureFlagsProvider);

  switch (feature) {
    case 'offlineMode':
      return flags.enableOfflineMode;
    case 'pushNotifications':
      return flags.enablePushNotifications;
    case 'maintenanceMode':
      return flags.enableMaintenanceMode;
    default:
      return false;
  }
}

/// Provider for debug mode check
@riverpod
bool isDebugMode(Ref ref) {
  final config = ref.watch(appConfigProvider);
  return config.enableDebugMode;
}

/// Provider for analytics check
@riverpod
bool isAnalyticsEnabled(Ref ref) {
  final config = ref.watch(appConfigProvider);
  return config.enableAnalytics;
}

/// Provider for crash reporting check
@riverpod
bool isCrashReportingEnabled(Ref ref) {
  final config = ref.watch(appConfigProvider);
  return config.enableCrashReporting;
}
