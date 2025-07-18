import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../error/models/app_exception.dart';
import '../models/admin_config.dart';
import '../models/app_config.dart';
import '../models/api_config.dart';
import '../models/auth_config.dart';
import '../models/debug_config.dart';
import '../models/feature_flags.dart';
import '../sources/env_config_source.dart';
import '../sources/remote_config_source.dart';

part 'config_merger.g.dart';

/// Configuration merger service that merges configurations from multiple sources
///
/// Priority order (highest to lowest):
/// 1. Environment variables (.env files)
/// 2. Firebase Remote Config
/// 3. Default values
class ConfigMerger {
  final EnvConfigSource _envConfigSource;
  final RemoteConfigSource _remoteConfigSource;

  ConfigMerger({
    required EnvConfigSource envConfigSource,
    required RemoteConfigSource remoteConfigSource,
  }) : _envConfigSource = envConfigSource,
       _remoteConfigSource = remoteConfigSource;

  /// Merge configurations from all sources based on priority
  ///
  /// Returns a merged [AppConfig] where values from higher priority sources
  /// override those from lower priority sources.
  Future<AppConfig> mergeConfigs() async {
    try {
      // Start with default configuration
      AppConfig defaultConfig = _getDefaultConfig();

      // Apply remote config (if available)
      AppConfig? remoteConfig;
      try {
        await _remoteConfigSource.initialize();
        remoteConfig = await _remoteConfigSource.loadConfig();
      } catch (e) {
        // Remote config failures are non-fatal, continue with defaults
        remoteConfig = null;
      }

      // Apply env config (highest priority)
      AppConfig? envConfig;
      try {
        envConfig = await _envConfigSource.loadConfig();
      } catch (e) {
        // Environment config failures are non-fatal, continue with other sources
        envConfig = null;
      }

      // Merge configurations in priority order
      return _mergeAppConfigs(
        defaultConfig: defaultConfig,
        remoteConfig: remoteConfig,
        envConfig: envConfig,
      );
    } catch (e, stackTrace) {
      throw AppException.config(
        message: 'Failed to merge configurations: ${e.toString()}',
        errorCode: 'CONFIG_MERGE_ERROR',
        timestamp: DateTime.now(),
        stackTrace: stackTrace,
      );
    }
  }

  /// Get default configuration values
  AppConfig _getDefaultConfig() {
    return AppConfig(
      version: '1.0.0',
      enableAnalytics: true,
      enableCrashReporting: true,
      enableDebugMode: false,
      apiConfig: ApiConfig(
        manaboBaseUrl: 'https://manabo.cnc.chukyo-u.ac.jp',
        alboBaseUrl: 'https://cubics-pt-out.mng.chukyo-u.ac.jp',
        cubicsBaseUrl: 'https://cubics-as-out.mng.chukyo-u.ac.jp',
        ssoUrl: 'https://shib.chukyo-u.ac.jp',
        palApiBaseUrl: 'https://api.chukyo-passpal.app/v1',
        connectionTimeoutSeconds: 30,
        receiveTimeoutSeconds: 60,
        maxRetries: 3,
      ),
      authConfig: AuthConfig(allowedEmailDomain: '@m.chukyo-u.ac.jp'),
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
  }

  /// Merge multiple AppConfig instances based on priority
  AppConfig _mergeAppConfigs({
    required AppConfig defaultConfig,
    AppConfig? remoteConfig,
    AppConfig? envConfig,
  }) {
    // Start with default, then apply remote, then env (highest priority)
    AppConfig merged = defaultConfig;

    // Apply remote config if available
    if (remoteConfig != null) {
      merged = merged.copyWith(
        version: remoteConfig.version,
        enableAnalytics: remoteConfig.enableAnalytics,
        enableCrashReporting: remoteConfig.enableCrashReporting,
        enableDebugMode: remoteConfig.enableDebugMode,
        apiConfig: _mergeApiConfigs(merged.apiConfig, remoteConfig.apiConfig),
        authConfig: _mergeAuthConfigs(
          merged.authConfig,
          remoteConfig.authConfig,
        ),
        debugConfig: _mergeDebugConfigs(
          merged.debugConfig,
          remoteConfig.debugConfig,
        ),
        featureFlags: _mergeFeatureFlags(
          merged.featureFlags,
          remoteConfig.featureFlags,
        ),
        adminConfig: _mergeAdminConfigs(
          merged.adminConfig,
          remoteConfig.adminConfig,
        ),
      );
    }

    // Apply env config if available (highest priority)
    if (envConfig != null) {
      merged = merged.copyWith(
        version: envConfig.version,
        enableAnalytics: envConfig.enableAnalytics,
        enableCrashReporting: envConfig.enableCrashReporting,
        enableDebugMode: envConfig.enableDebugMode,
        apiConfig: _mergeApiConfigs(merged.apiConfig, envConfig.apiConfig),
        authConfig: _mergeAuthConfigs(merged.authConfig, envConfig.authConfig),
        debugConfig: _mergeDebugConfigs(
          merged.debugConfig,
          envConfig.debugConfig,
        ),
        featureFlags: _mergeFeatureFlags(
          merged.featureFlags,
          envConfig.featureFlags,
        ),
        adminConfig: _mergeAdminConfigs(
          merged.adminConfig,
          envConfig.adminConfig,
        ),
      );
    }

    return merged;
  }

  /// Merge API configurations
  ApiConfig _mergeApiConfigs(ApiConfig base, ApiConfig override) {
    return base.copyWith(
      manaboBaseUrl: override.manaboBaseUrl,
      alboBaseUrl: override.alboBaseUrl,
      cubicsBaseUrl: override.cubicsBaseUrl,
      ssoUrl: override.ssoUrl,
      palApiBaseUrl: override.palApiBaseUrl,
      connectionTimeoutSeconds: override.connectionTimeoutSeconds,
      receiveTimeoutSeconds: override.receiveTimeoutSeconds,
      maxRetries: override.maxRetries,
    );
  }

  /// Merge authentication configurations
  AuthConfig _mergeAuthConfigs(AuthConfig base, AuthConfig override) {
    return base.copyWith(allowedEmailDomain: override.allowedEmailDomain);
  }

  /// Merge debug configurations
  DebugConfig _mergeDebugConfigs(DebugConfig base, DebugConfig override) {
    return base.copyWith(
      logLevel: override.logLevel,
      enableConsoleLogging: override.enableConsoleLogging,
      enableFileLogging: override.enableFileLogging,
      enableNetworkLogging: override.enableNetworkLogging,
      enableCrashlytics: override.enableCrashlytics,
    );
  }

  /// Merge feature flags
  FeatureFlags _mergeFeatureFlags(FeatureFlags base, FeatureFlags override) {
    return base.copyWith(
      enableOfflineMode: override.enableOfflineMode,
      enablePushNotifications: override.enablePushNotifications,
      enableMaintenanceMode: override.enableMaintenanceMode,
    );
  }

  /// Merge admin configurations
  AdminConfig _mergeAdminConfigs(AdminConfig base, AdminConfig override) {
    return base.copyWith(
      appVersion: override.appVersion,
      minSupportedVersion: override.minSupportedVersion,
      isMaintenanceMode: override.isMaintenanceMode,
      maintenanceMessage: override.maintenanceMessage,
    );
  }
}

/// Riverpod provider for ConfigMerger
@riverpod
ConfigMerger configMerger(Ref ref) {
  return ConfigMerger(
    envConfigSource: ref.watch(envConfigSourceProvider),
    remoteConfigSource: ref.watch(remoteConfigSourceProvider),
  );
}
