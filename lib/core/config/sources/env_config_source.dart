import 'dart:async';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../error/models/app_exception.dart';
import '../models/admin_config.dart';
import '../models/app_config.dart';
import '../models/api_config.dart';
import '../models/auth_config.dart';
import '../models/debug_config.dart';
import '../models/feature_flags.dart';

part 'env_config_source.g.dart';

/// Environment file configuration source using flutter_dotenv
class EnvConfigSource {
  static const String _defaultEnvFile = '.env';
  static const String _productionEnvFile = '.env.production';
  static const String _developmentEnvFile = '.env.development';

  final DotEnv _dotEnv;
  String? _currentEnvFile;

  EnvConfigSource({DotEnv? dotEnv}) : _dotEnv = dotEnv ?? DotEnv();

  /// Load environment configuration from appropriate .env file
  ///
  /// Loads in priority order:
  /// 1. .env.production (if in release mode)
  /// 2. .env.development (if in debug mode)
  /// 3. .env (default fallback)
  Future<AppConfig> loadConfig() async {
    try {
      await _loadEnvFile();
      return _parseAppConfig();
    } on FileSystemException catch (e) {
      throw AppException.config(
        message: 'Environment file not found: ${e.path}',
        errorCode: 'CONFIG_FILE_NOT_FOUND',
        timestamp: DateTime.now(),
        stackTrace: StackTrace.current,
      );
    } on FormatException catch (e) {
      throw AppException.config(
        message: 'Invalid environment file format: ${e.message}',
        errorCode: 'CONFIG_PARSE_ERROR',
        timestamp: DateTime.now(),
        stackTrace: StackTrace.current,
      );
    } catch (e) {
      throw AppException.config(
        message: 'Failed to load environment configuration: $e',
        errorCode: 'CONFIG_SOURCE_ERROR',
        timestamp: DateTime.now(),
        stackTrace: StackTrace.current,
      );
    }
  }

  /// Check if environment file exists
  Future<bool> hasConfig() async {
    final envFiles = [_getEnvFileForEnvironment(), _defaultEnvFile];

    for (final envFile in envFiles) {
      if (await _fileExists(envFile)) {
        return true;
      }
    }

    return false;
  }

  /// Get environment-specific configuration file name
  String _getEnvFileForEnvironment() {
    const isProduction = bool.fromEnvironment('dart.vm.product');
    return isProduction ? _productionEnvFile : _developmentEnvFile;
  }

  /// Load appropriate environment file
  Future<void> _loadEnvFile() async {
    final envFiles = [_getEnvFileForEnvironment(), _defaultEnvFile];

    for (final envFile in envFiles) {
      if (await _fileExists(envFile)) {
        await _dotEnv.load(fileName: envFile);
        _currentEnvFile = envFile;
        return;
      }
    }

    throw FileSystemException(
      'No environment file found',
      'Checked files: ${envFiles.join(', ')}',
    );
  }

  /// Check if file exists
  Future<bool> _fileExists(String fileName) async {
    try {
      final file = File(fileName);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  /// Parse environment variables into AppConfig
  AppConfig _parseAppConfig() {
    return AppConfig(
      apiConfig: _parseApiConfig(),
      authConfig: _parseAuthConfig(),
      debugConfig: _parseDebugConfig(),
      featureFlags: _parseFeatureFlags(),
      adminConfig: _parseAdminConfig(),
    );
  }

  /// Parse API configuration from environment variables
  ApiConfig _parseApiConfig() {
    return ApiConfig(
      manaboBaseUrl:
          _getString('MANABO_BASE_URL') ?? ApiConfigDefaults.manaboBaseUrl,
      alboBaseUrl: _getString('ALBO_BASE_URL') ?? ApiConfigDefaults.alboBaseUrl,
      cubicsBaseUrl:
          _getString('CUBICS_BASE_URL') ?? ApiConfigDefaults.cubicsBaseUrl,
      ssoUrl: _getString('SSO_URL') ?? ApiConfigDefaults.ssoUrl,
      palApiBaseUrl:
          _getString('PAL_API_BASE_URL') ?? ApiConfigDefaults.palApiBaseUrl,
      connectionTimeoutSeconds:
          _getInt('CONNECTION_TIMEOUT_SECONDS') ??
          ApiConfigDefaults.connectionTimeoutSeconds,
      receiveTimeoutSeconds:
          _getInt('RECEIVE_TIMEOUT_SECONDS') ??
          ApiConfigDefaults.receiveTimeoutSeconds,
      maxRetries: _getInt('MAX_RETRIES') ?? ApiConfigDefaults.maxRetries,
    );
  }

  /// Parse authentication configuration from environment variables
  AuthConfig _parseAuthConfig() {
    return AuthConfig(
      allowedEmailDomain:
          _getString('ALLOWED_EMAIL_DOMAIN') ??
          AuthConfigDefaults.allowedEmailDomain,
    );
  }

  /// Parse debug configuration from environment variables
  DebugConfig _parseDebugConfig() {
    return DebugConfig(
      logLevel: _getString('LOG_LEVEL') ?? DebugConfigDefaults.logLevel,
      enableConsoleLogging:
          _getBool('ENABLE_CONSOLE_LOGGING') ??
          DebugConfigDefaults.enableConsoleLogging,
      enableFileLogging:
          _getBool('ENABLE_FILE_LOGGING') ??
          DebugConfigDefaults.enableFileLogging,
      enableNetworkLogging:
          _getBool('ENABLE_NETWORK_LOGGING') ??
          DebugConfigDefaults.enableNetworkLogging,
      enableCrashlytics:
          _getBool('ENABLE_CRASHLYTICS') ??
          DebugConfigDefaults.enableCrashlytics,
    );
  }

  /// Parse feature flags from environment variables
  FeatureFlags _parseFeatureFlags() {
    return FeatureFlags(
      enableOfflineMode:
          _getBool('FEATURE_OFFLINE_MODE') ??
          FeatureFlagsDefaults.enableOfflineMode,
      enablePushNotifications:
          _getBool('FEATURE_PUSH_NOTIFICATIONS') ??
          FeatureFlagsDefaults.enablePushNotifications,
      enableMaintenanceMode:
          _getBool('FEATURE_MAINTENANCE_MODE') ??
          FeatureFlagsDefaults.enableMaintenanceMode,
    );
  }

  /// Parse admin configuration from environment variables
  AdminConfig _parseAdminConfig() {
    return AdminConfig(
      appVersion: _getString('APP_VERSION') ?? AdminConfigDefaults.appVersion,
      minSupportedVersion:
          _getString('MIN_SUPPORTED_VERSION') ??
          AdminConfigDefaults.minSupportedVersion,
      isMaintenanceMode:
          _getBool('IS_MAINTENANCE_MODE') ??
          AdminConfigDefaults.isMaintenanceMode,
      maintenanceMessage:
          _getString('MAINTENANCE_MESSAGE') ??
          AdminConfigDefaults.maintenanceMessage,
    );
  }

  /// Get optional string value from environment
  String? _getString(String key) {
    final value = _dotEnv.env[key];
    return (value == null || value.isEmpty) ? null : value;
  }

  /// Get optional integer value from environment
  int? _getInt(String key) {
    final value = _getString(key);
    if (value == null) return null;

    try {
      return int.parse(value);
    } catch (e) {
      throw AppException.config(
        message: 'Invalid integer value for $key: $value',
        errorCode: 'CONFIG_INVALID_INTEGER',
        timestamp: DateTime.now(),
        stackTrace: StackTrace.current,
      );
    }
  }

  /// Get optional boolean value from environment
  bool? _getBool(String key) {
    final value = _getString(key);
    if (value == null) return null;
    return _parseBool(value);
  }

  /// Parse boolean value from string
  bool? _parseBool(String value) {
    final normalized = value.toLowerCase().trim();
    switch (normalized) {
      case 'true':
      case '1':
      case 'yes':
      case 'on':
        return true;
      case 'false':
      case '0':
      case 'no':
      case 'off':
        return false;
      default:
        throw AppException.config(
          message: 'Invalid boolean value: $value',
          errorCode: 'CONFIG_INVALID_BOOLEAN',
          timestamp: DateTime.now(),
          stackTrace: StackTrace.current,
        );
    }
  }

  /// Get the currently loaded environment file path
  String? get currentEnvFile => _currentEnvFile;

  /// Get all loaded environment variables
  Map<String, String> get allEnvVars => Map.unmodifiable(_dotEnv.env);
}

/// Riverpod provider for EnvConfigSource with keepAlive
@Riverpod(keepAlive: true)
EnvConfigSource envConfigSource(Ref ref) {
  return EnvConfigSource();
}

/// Riverpod provider for loading environment configuration
@riverpod
Future<AppConfig> envConfig(Ref ref) async {
  final source = ref.watch(envConfigSourceProvider);
  return await source.loadConfig();
}
