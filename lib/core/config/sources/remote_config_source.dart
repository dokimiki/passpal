import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../error/models/app_exception.dart';
import '../../error/models/failure.dart';
import '../exceptions/config_error_types.dart';
import '../models/admin_config.dart';
import '../models/app_config.dart';
import '../models/api_config.dart';
import '../models/auth_config.dart';
import '../models/debug_config.dart';
import '../models/feature_flags.dart';

part 'remote_config_source.g.dart';

/// Firebase Remote Config configuration source
class RemoteConfigSource {
  static const Duration _defaultFetchTimeout = Duration(seconds: 10);
  static const Duration _defaultMinimumFetchInterval = Duration(hours: 1);

  final FirebaseRemoteConfig _remoteConfig;
  DateTime? _lastFetchTime;
  Map<String, dynamic>? _cachedConfig;

  RemoteConfigSource({FirebaseRemoteConfig? remoteConfig})
    : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  /// Initialize Remote Config with default values and settings
  Future<void> initialize() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: _defaultFetchTimeout,
          minimumFetchInterval: _defaultMinimumFetchInterval,
        ),
      );

      await _remoteConfig.setDefaults(_getDefaultValues());
    } catch (e, stackTrace) {
      throw AppException.config(
        message: ConfigErrorMessages.withDetail(
          ConfigErrorMessages.configInitializationFailed,
          e.toString(),
        ),
        errorCode: ConfigErrorCodes.configInitializationFailed,
        timestamp: DateTime.now(),
        stackTrace: stackTrace,
      );
    }
  }

  /// Fetch and activate remote configuration
  Future<AppConfig> loadConfig({
    Duration? fetchTimeout,
    bool forceRefresh = false,
  }) async {
    try {
      // Check if we need to fetch new config
      if (forceRefresh || _shouldFetchNewConfig()) {
        await _fetchAndActivateConfig(fetchTimeout);
      }

      return _parseAppConfig();
    } on TimeoutException catch (e, stackTrace) {
      throw Failure.configSource(
        message: ConfigErrorMessages.withDetail(
          ConfigErrorMessages.remoteConfigTimeout,
          e.message ?? 'Request timeout',
        ),
        errorCode: ConfigErrorCodes.remoteConfigTimeout,
        timestamp: DateTime.now(),
        stackTrace: stackTrace,
        retryDelay: ConfigRetryDelays.remoteConfigFetch,
      );
    } on FirebaseException catch (e, stackTrace) {
      throw Failure.configSource(
        message: ConfigErrorMessages.withDetail(
          ConfigErrorMessages.remoteConfigFetchFailed,
          e.message ?? 'Firebase error',
        ),
        errorCode: ConfigErrorCodes.remoteConfigFetchFailed,
        timestamp: DateTime.now(),
        stackTrace: stackTrace,
        retryDelay: ConfigRetryDelays.remoteConfigFetch,
      );
    } on FormatException catch (e, stackTrace) {
      throw Failure.configParse(
        message: ConfigErrorMessages.withDetail(
          ConfigErrorMessages.remoteConfigParseError,
          e.message,
        ),
        errorCode: ConfigErrorCodes.remoteConfigParseError,
        timestamp: DateTime.now(),
        stackTrace: stackTrace,
        retryDelay: ConfigRetryDelays.configParse,
      );
    } catch (e, stackTrace) {
      throw AppException.config(
        message: ConfigErrorMessages.withDetail(
          ConfigErrorMessages.configSourceUnavailable,
          e.toString(),
        ),
        errorCode: ConfigErrorCodes.configSourceUnavailable,
        timestamp: DateTime.now(),
        stackTrace: stackTrace,
      );
    }
  }

  /// Check if remote configuration is available
  Future<bool> hasConfig() async {
    try {
      await initialize();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get configuration value for a specific key
  T? getValue<T>(String key) {
    try {
      final value = _remoteConfig.getValue(key);

      if (T == String) {
        return value.asString() as T?;
      } else if (T == int) {
        return value.asInt() as T?;
      } else if (T == double) {
        return value.asDouble() as T?;
      } else if (T == bool) {
        return value.asBool() as T?;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Get JSON configuration for a specific key
  Map<String, dynamic>? getJsonValue(String key) {
    try {
      final jsonString = _remoteConfig.getString(key);
      if (jsonString.isEmpty) return null;

      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Stream of configuration updates
  Stream<RemoteConfigUpdate> get onConfigUpdated {
    return _remoteConfig.onConfigUpdated;
  }

  /// Check if we should fetch new configuration
  bool _shouldFetchNewConfig() {
    if (_lastFetchTime == null) return true;

    final now = DateTime.now();
    final timeSinceLastFetch = now.difference(_lastFetchTime!);

    return timeSinceLastFetch >= _defaultMinimumFetchInterval;
  }

  /// Fetch and activate remote configuration
  Future<void> _fetchAndActivateConfig(Duration? fetchTimeout) async {
    // Configure timeout if provided
    if (fetchTimeout != null) {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: fetchTimeout,
          minimumFetchInterval: _defaultMinimumFetchInterval,
        ),
      );
    }

    // Fetch with timeout
    await _remoteConfig.fetchAndActivate().timeout(
      fetchTimeout ?? _defaultFetchTimeout,
      onTimeout: () {
        throw TimeoutException(
          'Remote config fetch timeout',
          fetchTimeout ?? _defaultFetchTimeout,
        );
      },
    );

    _lastFetchTime = DateTime.now();
    _cachedConfig = null; // Clear cache to force reparse
  }

  /// Parse remote configuration into AppConfig
  AppConfig _parseAppConfig() {
    if (_cachedConfig != null) {
      return _parseFromCache();
    }

    try {
      final config = AppConfig(
        apiConfig: _parseApiConfig(),
        authConfig: _parseAuthConfig(),
        debugConfig: _parseDebugConfig(),
        featureFlags: _parseFeatureFlags(),
        adminConfig: _parseAdminConfig(),
      );

      // Cache the parsed config
      _cachedConfig = config.toJson();

      return config;
    } catch (e, stackTrace) {
      throw Failure.configParse(
        message: ConfigErrorMessages.withDetail(
          ConfigErrorMessages.remoteConfigParseError,
          e.toString(),
        ),
        errorCode: ConfigErrorCodes.remoteConfigParseError,
        timestamp: DateTime.now(),
        stackTrace: stackTrace,
        retryDelay: ConfigRetryDelays.configParse,
      );
    }
  }

  /// Parse configuration from cache
  AppConfig _parseFromCache() {
    try {
      return AppConfig.fromJson(_cachedConfig!);
    } catch (e, stackTrace) {
      // Clear invalid cache and reparse
      _cachedConfig = null;
      throw Failure.configParse(
        message: ConfigErrorMessages.withDetail(
          ConfigErrorMessages.remoteConfigParseError,
          'Cache parsing failed: $e',
        ),
        errorCode: ConfigErrorCodes.remoteConfigParseError,
        timestamp: DateTime.now(),
        stackTrace: stackTrace,
        retryDelay: ConfigRetryDelays.configParse,
      );
    }
  }

  /// Parse API configuration from remote config
  ApiConfig _parseApiConfig() {
    final apiJson = getJsonValue('api_config');
    if (apiJson != null) {
      try {
        return ApiConfig.fromJson(apiJson);
      } catch (e) {
        // Fallback to individual values
      }
    }

    return ApiConfig(
      manaboBaseUrl:
          getValue<String>('manabo_base_url') ??
          ApiConfigDefaults.manaboBaseUrl,
      alboBaseUrl:
          getValue<String>('albo_base_url') ?? ApiConfigDefaults.alboBaseUrl,
      cubicsBaseUrl:
          getValue<String>('cubics_base_url') ??
          ApiConfigDefaults.cubicsBaseUrl,
      ssoUrl: getValue<String>('sso_url') ?? ApiConfigDefaults.ssoUrl,
      palApiBaseUrl:
          getValue<String>('pal_api_base_url') ??
          ApiConfigDefaults.palApiBaseUrl,
      connectionTimeoutSeconds:
          getValue<int>('connection_timeout_seconds') ??
          ApiConfigDefaults.connectionTimeoutSeconds,
      receiveTimeoutSeconds:
          getValue<int>('receive_timeout_seconds') ??
          ApiConfigDefaults.receiveTimeoutSeconds,
      maxRetries: getValue<int>('max_retries') ?? ApiConfigDefaults.maxRetries,
    );
  }

  /// Parse authentication configuration from remote config
  AuthConfig _parseAuthConfig() {
    final authJson = getJsonValue('auth_config');
    if (authJson != null) {
      try {
        return AuthConfig.fromJson(authJson);
      } catch (e) {
        // Fallback to individual values
      }
    }

    return AuthConfig(
      allowedEmailDomain:
          getValue<String>('allowed_email_domain') ??
          AuthConfigDefaults.allowedEmailDomain,
    );
  }

  /// Parse debug configuration from remote config
  DebugConfig _parseDebugConfig() {
    final debugJson = getJsonValue('debug_config');
    if (debugJson != null) {
      try {
        return DebugConfig.fromJson(debugJson);
      } catch (e) {
        // Fallback to individual values
      }
    }

    return DebugConfig(
      logLevel: getValue<String>('log_level') ?? DebugConfigDefaults.logLevel,
      enableConsoleLogging:
          getValue<bool>('enable_console_logging') ??
          DebugConfigDefaults.enableConsoleLogging,
      enableFileLogging:
          getValue<bool>('enable_file_logging') ??
          DebugConfigDefaults.enableFileLogging,
      enableNetworkLogging:
          getValue<bool>('enable_network_logging') ??
          DebugConfigDefaults.enableNetworkLogging,
      enableCrashlytics:
          getValue<bool>('enable_crashlytics') ??
          DebugConfigDefaults.enableCrashlytics,
    );
  }

  /// Parse feature flags from remote config
  FeatureFlags _parseFeatureFlags() {
    final flagsJson = getJsonValue('feature_flags');
    if (flagsJson != null) {
      try {
        return FeatureFlags.fromJson(flagsJson);
      } catch (e) {
        // Fallback to individual values
      }
    }

    return FeatureFlags(
      enableOfflineMode:
          getValue<bool>('feature_offline_mode') ??
          FeatureFlagsDefaults.enableOfflineMode,
      enablePushNotifications:
          getValue<bool>('feature_push_notifications') ??
          FeatureFlagsDefaults.enablePushNotifications,
      enableMaintenanceMode:
          getValue<bool>('feature_maintenance_mode') ??
          FeatureFlagsDefaults.enableMaintenanceMode,
    );
  }

  /// Parse admin configuration from remote config
  AdminConfig _parseAdminConfig() {
    final adminJson = getJsonValue('admin_config');
    if (adminJson != null) {
      try {
        return AdminConfig.fromJson(adminJson);
      } catch (e) {
        // Fallback to individual values
      }
    }

    return AdminConfig(
      appVersion:
          getValue<String>('app_version') ?? AdminConfigDefaults.appVersion,
      minSupportedVersion:
          getValue<String>('min_supported_version') ??
          AdminConfigDefaults.minSupportedVersion,
      isMaintenanceMode:
          getValue<bool>('is_maintenance_mode') ??
          AdminConfigDefaults.isMaintenanceMode,
      maintenanceMessage:
          getValue<String>('maintenance_message') ??
          AdminConfigDefaults.maintenanceMessage,
    );
  }

  /// Get default values for Remote Config
  Map<String, dynamic> _getDefaultValues() {
    return {
      // API Configuration defaults
      'manabo_base_url': ApiConfigDefaults.manaboBaseUrl,
      'albo_base_url': ApiConfigDefaults.alboBaseUrl,
      'cubics_base_url': ApiConfigDefaults.cubicsBaseUrl,
      'sso_url': ApiConfigDefaults.ssoUrl,
      'pal_api_base_url': ApiConfigDefaults.palApiBaseUrl,
      'connection_timeout_seconds': ApiConfigDefaults.connectionTimeoutSeconds,
      'receive_timeout_seconds': ApiConfigDefaults.receiveTimeoutSeconds,
      'max_retries': ApiConfigDefaults.maxRetries,

      // Auth Configuration defaults
      'allowed_email_domain': AuthConfigDefaults.allowedEmailDomain,

      // Debug Configuration defaults
      'log_level': DebugConfigDefaults.logLevel,
      'enable_console_logging': DebugConfigDefaults.enableConsoleLogging,
      'enable_file_logging': DebugConfigDefaults.enableFileLogging,
      'enable_network_logging': DebugConfigDefaults.enableNetworkLogging,
      'enable_crashlytics': DebugConfigDefaults.enableCrashlytics,

      // Feature Flags defaults
      'feature_offline_mode': FeatureFlagsDefaults.enableOfflineMode,
      'feature_push_notifications':
          FeatureFlagsDefaults.enablePushNotifications,
      'feature_maintenance_mode': FeatureFlagsDefaults.enableMaintenanceMode,

      // Admin Configuration defaults
      'app_version': AdminConfigDefaults.appVersion,
      'min_supported_version': AdminConfigDefaults.minSupportedVersion,
      'is_maintenance_mode': AdminConfigDefaults.isMaintenanceMode,
      'maintenance_message': AdminConfigDefaults.maintenanceMessage,

      // JSON configurations (empty by default)
      'api_config': '{}',
      'auth_config': '{}',
      'debug_config': '{}',
      'feature_flags': '{}',
      'admin_config': '{}',
    };
  }

  /// Get last fetch time
  DateTime? get lastFetchTime => _lastFetchTime;

  /// Get the remote config instance
  FirebaseRemoteConfig get instance => _remoteConfig;

  /// Clear cached configuration
  void clearCache() {
    _cachedConfig = null;
  }
}

/// Riverpod provider for RemoteConfigSource with keepAlive
@Riverpod(keepAlive: true)
RemoteConfigSource remoteConfigSource(Ref ref) {
  return RemoteConfigSource();
}

/// Riverpod provider for loading remote configuration
@riverpod
Future<AppConfig> remoteConfig(Ref ref) async {
  final source = ref.watch(remoteConfigSourceProvider);
  await source.initialize();
  return await source.loadConfig();
}

/// Riverpod provider for remote configuration with custom timeout
@riverpod
Future<AppConfig> remoteConfigWithTimeout(Ref ref, Duration timeout) async {
  final source = ref.watch(remoteConfigSourceProvider);
  await source.initialize();
  return await source.loadConfig(fetchTimeout: timeout);
}

/// Riverpod provider for monitoring remote config updates
@riverpod
Stream<RemoteConfigUpdate> remoteConfigUpdates(Ref ref) {
  final source = ref.watch(remoteConfigSourceProvider);
  return source.onConfigUpdated;
}
