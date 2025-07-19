import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:passpal/core/config/models/admin_config.dart';
import 'package:passpal/core/config/models/app_config.dart';
import 'package:passpal/core/config/models/api_config.dart';
import 'package:passpal/core/config/models/auth_config.dart';
import 'package:passpal/core/config/models/debug_config.dart';
import 'package:passpal/core/config/models/feature_flags.dart';
import 'package:passpal/core/config/sources/env_config_source.dart';
import 'package:passpal/core/config/sources/remote_config_source.dart';

part 'mock_config_sources.g.dart';

/// Mock environment configuration source for testing
class MockEnvConfigSource extends EnvConfigSource {
  final Map<String, String> _mockEnvData;
  bool _shouldThrowError;
  String? _errorMessage;

  MockEnvConfigSource({
    Map<String, String>? mockEnvData,
    bool shouldThrowError = false,
    String? errorMessage,
  }) : _mockEnvData = mockEnvData ?? <String, String>{},
       _shouldThrowError = shouldThrowError,
       _errorMessage = errorMessage,
       super(dotEnv: MockDotEnv());

  @override
  Future<AppConfig> loadConfig() async {
    if (_shouldThrowError) {
      throw Exception(_errorMessage ?? 'Mock env config error');
    }

    // Simulate loading delay
    await Future.delayed(const Duration(milliseconds: 50));

    return _parseConfigFromEnv();
  }

  /// Set mock environment data
  void setMockEnvData(Map<String, String> data) {
    _mockEnvData.clear();
    _mockEnvData.addAll(data);
  }

  /// Set error state
  void setErrorState(bool shouldThrow, [String? errorMessage]) {
    _shouldThrowError = shouldThrow;
    _errorMessage = errorMessage;
  }

  /// Parse configuration from mock environment data
  AppConfig _parseConfigFromEnv() {
    return AppConfig(
      version: _mockEnvData['APP_VERSION'] ?? '1.0.0',
      enableAnalytics: _parseBool(_mockEnvData['ENABLE_ANALYTICS']) ?? true,
      enableCrashReporting:
          _parseBool(_mockEnvData['ENABLE_CRASH_REPORTING']) ?? true,
      enableDebugMode: _parseBool(_mockEnvData['ENABLE_DEBUG_MODE']) ?? false,
      apiConfig: ApiConfig(
        manaboBaseUrl:
            _mockEnvData['MANABO_BASE_URL'] ??
            'https://test.manabo.chukyo-u.ac.jp',
        alboBaseUrl:
            _mockEnvData['ALBO_BASE_URL'] ?? 'https://test.albo.chukyo-u.ac.jp',
        cubicsBaseUrl:
            _mockEnvData['CUBICS_BASE_URL'] ??
            'https://test.cubics.chukyo-u.ac.jp',
        ssoUrl: _mockEnvData['SSO_URL'] ?? 'https://test.sso.chukyo-u.ac.jp',
        palApiBaseUrl:
            _mockEnvData['PAL_API_BASE_URL'] ??
            'https://test.api.chukyo-passpal.app/v1',
        connectionTimeoutSeconds:
            _parseInt(_mockEnvData['CONNECTION_TIMEOUT_SECONDS']) ?? 10,
        receiveTimeoutSeconds:
            _parseInt(_mockEnvData['RECEIVE_TIMEOUT_SECONDS']) ?? 20,
        maxRetries: _parseInt(_mockEnvData['MAX_RETRIES']) ?? 2,
      ),
      authConfig: AuthConfig(
        allowedEmailDomain:
            _mockEnvData['ALLOWED_EMAIL_DOMAIN'] ?? '@test.chukyo-u.ac.jp',
      ),
      debugConfig: DebugConfig(
        logLevel: _mockEnvData['LOG_LEVEL'] ?? 'debug',
        enableConsoleLogging:
            _parseBool(_mockEnvData['ENABLE_CONSOLE_LOGGING']) ?? true,
        enableFileLogging:
            _parseBool(_mockEnvData['ENABLE_FILE_LOGGING']) ?? true,
        enableNetworkLogging:
            _parseBool(_mockEnvData['ENABLE_NETWORK_LOGGING']) ?? true,
        enableCrashlytics:
            _parseBool(_mockEnvData['ENABLE_CRASHLYTICS']) ?? false,
      ),
      featureFlags: FeatureFlags(
        enableOfflineMode:
            _parseBool(_mockEnvData['ENABLE_OFFLINE_MODE']) ?? true,
        enablePushNotifications:
            _parseBool(_mockEnvData['ENABLE_PUSH_NOTIFICATIONS']) ?? true,
        enableMaintenanceMode:
            _parseBool(_mockEnvData['ENABLE_MAINTENANCE_MODE']) ?? false,
      ),
      adminConfig: AdminConfig(
        appVersion: _mockEnvData['ADMIN_APP_VERSION'] ?? '1.0.0',
        minSupportedVersion: _mockEnvData['MIN_SUPPORTED_VERSION'] ?? '1.0.0',
        isMaintenanceMode:
            _parseBool(_mockEnvData['IS_MAINTENANCE_MODE']) ?? false,
        maintenanceMessage:
            _mockEnvData['MAINTENANCE_MESSAGE'] ?? 'Test maintenance message',
      ),
    );
  }

  bool? _parseBool(String? value) {
    if (value == null) return null;
    return value.toLowerCase() == 'true' || value == '1';
  }

  int? _parseInt(String? value) {
    if (value == null) return null;
    return int.tryParse(value);
  }
}

/// Mock DotEnv for testing
class MockDotEnv extends Mock implements DotEnv {}

/// Mock remote configuration source for testing
class MockRemoteConfigSource extends RemoteConfigSource {
  final Map<String, dynamic> _mockRemoteData;
  bool _shouldThrowError;
  String? _errorMessage;
  final StreamController<Map<String, dynamic>?> _updateController;

  MockRemoteConfigSource({
    Map<String, dynamic>? mockRemoteData,
    bool shouldThrowError = false,
    String? errorMessage,
  }) : _mockRemoteData = mockRemoteData ?? <String, dynamic>{},
       _shouldThrowError = shouldThrowError,
       _errorMessage = errorMessage,
       _updateController = StreamController<Map<String, dynamic>?>.broadcast(),
       super(remoteConfig: MockFirebaseRemoteConfig());

  @override
  Future<void> initialize() async {
    if (_shouldThrowError) {
      throw Exception(
        _errorMessage ?? 'Mock remote config initialization error',
      );
    }

    // Simulate initialization delay
    await Future.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<AppConfig> loadConfig({
    Duration? fetchTimeout,
    bool forceRefresh = false,
  }) async {
    if (_shouldThrowError) {
      throw Exception(_errorMessage ?? 'Mock remote config load error');
    }

    // Simulate loading delay
    await Future.delayed(const Duration(milliseconds: 100));

    return _parseConfigFromRemote();
  }

  /// Get stream of configuration updates
  Stream<Map<String, dynamic>?> getUpdateStream() {
    return _updateController.stream;
  }

  /// Stream of remote config updates (for RemoteConfigUpdateMonitor)
  @override
  Stream<RemoteConfigUpdate> get onConfigUpdated {
    return _updateController.stream.map((data) => MockRemoteConfigUpdate());
  }

  /// Set mock remote data
  void setMockRemoteData(Map<String, dynamic> data) {
    _mockRemoteData.clear();
    _mockRemoteData.addAll(data);
  }

  /// Set error state
  void setErrorState(bool shouldThrow, [String? errorMessage]) {
    _shouldThrowError = shouldThrow;
    _errorMessage = errorMessage;
  }

  /// Simulate remote config update
  void simulateUpdate(Map<String, dynamic> updatedData) {
    _mockRemoteData.clear();
    _mockRemoteData.addAll(updatedData);
    _updateController.add(updatedData);
  }

  /// Simulate remote config update (for integration tests)
  void simulateRemoteUpdate() {
    if (_shouldThrowError) {
      _updateController.addError(
        Exception(_errorMessage ?? 'Mock remote update error'),
      );
    } else {
      _updateController.add(_mockRemoteData);
    }
  }

  /// Clear remote config data
  void clearRemoteData() {
    _mockRemoteData.clear();
    _updateController.add(null);
  }

  /// Close the update stream
  void dispose() {
    _updateController.close();
  }

  /// Parse configuration from mock remote data
  AppConfig _parseConfigFromRemote() {
    return AppConfig(
      version: _mockRemoteData['app_version'] ?? '1.0.0',
      enableAnalytics: _mockRemoteData['enable_analytics'] ?? true,
      enableCrashReporting: _mockRemoteData['enable_crash_reporting'] ?? true,
      enableDebugMode: _mockRemoteData['enable_debug_mode'] ?? false,
      apiConfig: ApiConfig(
        manaboBaseUrl:
            _mockRemoteData['manabo_base_url'] ??
            'https://remote.manabo.chukyo-u.ac.jp',
        alboBaseUrl:
            _mockRemoteData['albo_base_url'] ??
            'https://remote.albo.chukyo-u.ac.jp',
        cubicsBaseUrl:
            _mockRemoteData['cubics_base_url'] ??
            'https://remote.cubics.chukyo-u.ac.jp',
        ssoUrl:
            _mockRemoteData['sso_url'] ?? 'https://remote.sso.chukyo-u.ac.jp',
        palApiBaseUrl:
            _mockRemoteData['pal_api_base_url'] ??
            'https://remote.api.chukyo-passpal.app/v1',
        connectionTimeoutSeconds:
            _mockRemoteData['connection_timeout_seconds'] ?? 30,
        receiveTimeoutSeconds: _mockRemoteData['receive_timeout_seconds'] ?? 60,
        maxRetries: _mockRemoteData['max_retries'] ?? 3,
      ),
      authConfig: AuthConfig(
        allowedEmailDomain:
            _mockRemoteData['allowed_email_domain'] ?? '@remote.chukyo-u.ac.jp',
      ),
      debugConfig: DebugConfig(
        logLevel: _mockRemoteData['log_level'] ?? 'info',
        enableConsoleLogging:
            _mockRemoteData['enable_console_logging'] ?? false,
        enableFileLogging: _mockRemoteData['enable_file_logging'] ?? false,
        enableNetworkLogging: _mockRemoteData['enable_network_logging'] ?? true,
        enableCrashlytics: _mockRemoteData['enable_crashlytics'] ?? true,
      ),
      featureFlags: FeatureFlags(
        enableOfflineMode: _mockRemoteData['enable_offline_mode'] ?? true,
        enablePushNotifications:
            _mockRemoteData['enable_push_notifications'] ?? true,
        enableMaintenanceMode:
            _mockRemoteData['enable_maintenance_mode'] ?? false,
      ),
      adminConfig: AdminConfig(
        appVersion: _mockRemoteData['admin_app_version'] ?? '1.0.0',
        minSupportedVersion:
            _mockRemoteData['min_supported_version'] ?? '1.0.0',
        isMaintenanceMode: _mockRemoteData['is_maintenance_mode'] ?? false,
        maintenanceMessage:
            _mockRemoteData['maintenance_message'] ??
            'Remote maintenance message',
      ),
    );
  }
}

/// Mock Firebase Remote Config for testing
class MockFirebaseRemoteConfig extends Mock implements FirebaseRemoteConfig {}

/// Mock Remote Config Update for testing
class MockRemoteConfigUpdate extends Mock implements RemoteConfigUpdate {}

/// Riverpod providers for mock configuration sources
@riverpod
MockEnvConfigSource mockEnvConfigSource(Ref ref) {
  return MockEnvConfigSource();
}

@riverpod
MockRemoteConfigSource mockRemoteConfigSource(Ref ref) {
  return MockRemoteConfigSource();
}

/// Factory methods for creating mock sources with specific configurations
class MockConfigSourceFactory {
  /// Create mock env source with development configuration
  static MockEnvConfigSource createEnvSource({
    bool shouldThrowError = false,
    String? errorMessage,
    Map<String, String>? customEnvData,
  }) {
    final defaultEnvData = {
      'APP_VERSION': '1.0.0',
      'ENABLE_ANALYTICS': 'true',
      'ENABLE_CRASH_REPORTING': 'true',
      'ENABLE_DEBUG_MODE': 'true',
      'MANABO_BASE_URL': 'https://dev.manabo.chukyo-u.ac.jp',
      'ALBO_BASE_URL': 'https://dev.albo.chukyo-u.ac.jp',
      'CUBICS_BASE_URL': 'https://dev.cubics.chukyo-u.ac.jp',
      'SSO_URL': 'https://dev.sso.chukyo-u.ac.jp',
      'PAL_API_BASE_URL': 'https://dev.api.chukyo-passpal.app/v1',
      'CONNECTION_TIMEOUT_SECONDS': '10',
      'RECEIVE_TIMEOUT_SECONDS': '20',
      'MAX_RETRIES': '2',
      'ALLOWED_EMAIL_DOMAIN': '@dev.chukyo-u.ac.jp',
      'LOG_LEVEL': 'debug',
      'ENABLE_CONSOLE_LOGGING': 'true',
      'ENABLE_FILE_LOGGING': 'true',
      'ENABLE_NETWORK_LOGGING': 'true',
      'ENABLE_CRASHLYTICS': 'false',
      'ENABLE_OFFLINE_MODE': 'true',
      'ENABLE_PUSH_NOTIFICATIONS': 'true',
      'ENABLE_MAINTENANCE_MODE': 'false',
      'ADMIN_APP_VERSION': '1.0.0',
      'MIN_SUPPORTED_VERSION': '1.0.0',
      'IS_MAINTENANCE_MODE': 'false',
      'MAINTENANCE_MESSAGE': 'Dev maintenance message',
    };

    final envData = customEnvData ?? defaultEnvData;

    return MockEnvConfigSource(
      mockEnvData: envData,
      shouldThrowError: shouldThrowError,
      errorMessage: errorMessage,
    );
  }

  /// Create mock remote source with production configuration
  static MockRemoteConfigSource createRemoteSource({
    bool shouldThrowError = false,
    String? errorMessage,
    Map<String, dynamic>? customRemoteData,
  }) {
    final defaultRemoteData = {
      'app_version': '1.0.0',
      'enable_analytics': true,
      'enable_crash_reporting': true,
      'enable_debug_mode': false,
      'manabo_base_url': 'https://prod.manabo.chukyo-u.ac.jp',
      'albo_base_url': 'https://prod.albo.chukyo-u.ac.jp',
      'cubics_base_url': 'https://prod.cubics.chukyo-u.ac.jp',
      'sso_url': 'https://prod.sso.chukyo-u.ac.jp',
      'pal_api_base_url': 'https://prod.api.chukyo-passpal.app/v1',
      'connection_timeout_seconds': 30,
      'receive_timeout_seconds': 60,
      'max_retries': 3,
      'allowed_email_domain': '@prod.chukyo-u.ac.jp',
      'log_level': 'info',
      'enable_console_logging': false,
      'enable_file_logging': false,
      'enable_network_logging': true,
      'enable_crashlytics': true,
      'enable_offline_mode': true,
      'enable_push_notifications': true,
      'enable_maintenance_mode': false,
      'admin_app_version': '1.0.0',
      'min_supported_version': '1.0.0',
      'is_maintenance_mode': false,
      'maintenance_message': 'Prod maintenance message',
    };

    final remoteData = customRemoteData ?? defaultRemoteData;

    return MockRemoteConfigSource(
      mockRemoteData: remoteData,
      shouldThrowError: shouldThrowError,
      errorMessage: errorMessage,
    );
  }

  /// Create mock sources for maintenance mode testing
  static MockRemoteConfigSource createMaintenanceRemoteSource() {
    return createRemoteSource(
      customRemoteData: {
        'enable_maintenance_mode': true,
        'is_maintenance_mode': true,
        'maintenance_message':
            'System is under maintenance. Please try again later.',
      },
    );
  }

  /// Create mock sources for error testing
  static MockEnvConfigSource createErrorEnvSource([String? errorMessage]) {
    return createEnvSource(
      shouldThrowError: true,
      errorMessage: errorMessage ?? 'Environment configuration error',
    );
  }

  /// Create mock sources for error testing
  static MockRemoteConfigSource createErrorRemoteSource([
    String? errorMessage,
  ]) {
    return createRemoteSource(
      shouldThrowError: true,
      errorMessage: errorMessage ?? 'Remote configuration error',
    );
  }
}
