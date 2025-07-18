import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:mockito/mockito.dart';

/// Mock implementation of Firebase Remote Config for testing
class MockFirebaseRemoteConfig extends Mock implements FirebaseRemoteConfig {
  final Map<String, RemoteConfigValue> _values = {};
  final Map<String, dynamic> _defaults = {};
  RemoteConfigSettings? _settings;
  DateTime? _lastFetchTime;
  RemoteConfigFetchStatus _fetchStatus = RemoteConfigFetchStatus.success;
  final StreamController<RemoteConfigUpdate> _onConfigUpdatedController =
      StreamController<RemoteConfigUpdate>.broadcast();

  /// Set a mock value for a key
  void setMockValue(String key, dynamic value) {
    _values[key] = MockRemoteConfigValue(value);
  }

  /// Set multiple mock values
  void setMockValues(Map<String, dynamic> values) {
    values.forEach((key, value) {
      setMockValue(key, value);
    });
  }

  /// Clear all mock values
  void clearMockValues() {
    _values.clear();
  }

  /// Simulate a configuration update
  void simulateConfigUpdate(List<String> updatedKeys) {
    final update = RemoteConfigUpdate(updatedKeys.toSet());
    _onConfigUpdatedController.add(update);
  }

  /// Set mock fetch status
  void setMockFetchStatus(RemoteConfigFetchStatus status) {
    _fetchStatus = status;
  }

  /// Set mock last fetch time
  void setMockLastFetchTime(DateTime time) {
    _lastFetchTime = time;
  }

  @override
  Future<void> setDefaults(Map<String, dynamic> defaults) async {
    _defaults.addAll(defaults);
  }

  @override
  Future<void> setConfigSettings(RemoteConfigSettings settings) async {
    _settings = settings;
  }

  @override
  Future<bool> fetchAndActivate() async {
    _lastFetchTime = DateTime.now();
    return true;
  }

  @override
  Future<void> fetch() async {
    _lastFetchTime = DateTime.now();
  }

  @override
  Future<bool> activate() async {
    return true;
  }

  @override
  RemoteConfigValue getValue(String key) {
    if (_values.containsKey(key)) {
      return _values[key]!;
    }

    if (_defaults.containsKey(key)) {
      return MockRemoteConfigValue(_defaults[key]);
    }

    return MockRemoteConfigValue(null);
  }

  @override
  String getString(String key) {
    final value = getValue(key);
    return value.asString();
  }

  @override
  int getInt(String key) {
    final value = getValue(key);
    return value.asInt();
  }

  @override
  double getDouble(String key) {
    final value = getValue(key);
    return value.asDouble();
  }

  @override
  bool getBool(String key) {
    final value = getValue(key);
    return value.asBool();
  }

  @override
  Map<String, RemoteConfigValue> getAll() {
    final result = <String, RemoteConfigValue>{};
    result.addAll(_values);
    _defaults.forEach((key, value) {
      if (!result.containsKey(key)) {
        result[key] = MockRemoteConfigValue(value);
      }
    });
    return result;
  }

  @override
  DateTime get lastFetchTime => _lastFetchTime ?? DateTime.now();

  @override
  RemoteConfigFetchStatus get lastFetchStatus => _fetchStatus;

  @override
  RemoteConfigSettings get settings =>
      _settings ??
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 30),
        minimumFetchInterval: const Duration(hours: 1),
      );

  @override
  Stream<RemoteConfigUpdate> get onConfigUpdated =>
      _onConfigUpdatedController.stream;

  /// Dispose of the mock
  void dispose() {
    _onConfigUpdatedController.close();
  }
}

/// Mock implementation of RemoteConfigValue
class MockRemoteConfigValue implements RemoteConfigValue {
  final dynamic _value;
  final ValueSource _source;

  MockRemoteConfigValue(this._value, [this._source = ValueSource.valueDefault]);

  @override
  bool asBool() {
    if (_value == null) return false;
    if (_value is bool) return _value;
    if (_value is String) {
      return _value.toLowerCase() == 'true' || _value == '1';
    }
    if (_value is int) return _value != 0;
    return false;
  }

  @override
  double asDouble() {
    if (_value == null) return 0.0;
    if (_value is double) return _value;
    if (_value is int) return _value.toDouble();
    if (_value is String) return double.tryParse(_value) ?? 0.0;
    return 0.0;
  }

  @override
  int asInt() {
    if (_value == null) return 0;
    if (_value is int) return _value;
    if (_value is double) return _value.toInt();
    if (_value is String) return int.tryParse(_value) ?? 0;
    return 0;
  }

  @override
  String asString() {
    if (_value == null) return '';
    if (_value is String) return _value;
    if (_value is Map || _value is List) {
      return jsonEncode(_value);
    }
    return _value.toString();
  }

  @override
  ValueSource get source => _source;
}

/// Factory class for creating mock remote config instances
class MockRemoteConfigFactory {
  /// Create a mock remote config with default values
  static MockFirebaseRemoteConfig createDefault() {
    final mock = MockFirebaseRemoteConfig();

    // Set default configuration values
    mock.setMockValues({
      'app_version': '1.0.0',
      'enable_analytics': true,
      'enable_crash_reporting': true,
      'enable_debug_mode': false,
      'manabo_base_url': 'https://manabo.cnc.chukyo-u.ac.jp',
      'albo_base_url': 'https://cubics-pt-out.mng.chukyo-u.ac.jp',
      'cubics_base_url': 'https://cubics-as-out.mng.chukyo-u.ac.jp',
      'sso_url': 'https://shib.chukyo-u.ac.jp',
      'pal_api_base_url': 'https://api.chukyo-passpal.app/v1',
      'connection_timeout_seconds': 30,
      'receive_timeout_seconds': 60,
      'max_retries': 3,
      'allowed_email_domain': '@m.chukyo-u.ac.jp',
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
      'maintenance_message': '',
    });

    return mock;
  }

  /// Create a mock remote config for development environment
  static MockFirebaseRemoteConfig createDevelopment() {
    final mock = createDefault();

    // Override with development values
    mock.setMockValues({
      'enable_debug_mode': true,
      'log_level': 'debug',
      'enable_console_logging': true,
      'enable_file_logging': true,
      'enable_crashlytics': false,
      'manabo_base_url': 'https://dev.manabo.chukyo-u.ac.jp',
      'albo_base_url': 'https://dev.albo.chukyo-u.ac.jp',
      'cubics_base_url': 'https://dev.cubics.chukyo-u.ac.jp',
      'sso_url': 'https://dev.sso.chukyo-u.ac.jp',
      'pal_api_base_url': 'https://dev.api.chukyo-passpal.app/v1',
      'allowed_email_domain': '@dev.chukyo-u.ac.jp',
    });

    return mock;
  }

  /// Create a mock remote config for maintenance mode
  static MockFirebaseRemoteConfig createMaintenance() {
    final mock = createDefault();

    // Override with maintenance values
    mock.setMockValues({
      'enable_maintenance_mode': true,
      'is_maintenance_mode': true,
      'maintenance_message':
          'System is under maintenance. Please try again later.',
    });

    return mock;
  }

  /// Create a mock remote config that throws errors
  static MockFirebaseRemoteConfig createError() {
    final mock = MockFirebaseRemoteConfig();

    // Set error fetch status
    mock.setMockFetchStatus(RemoteConfigFetchStatus.failure);

    return mock;
  }

  /// Create a mock remote config with custom values
  static MockFirebaseRemoteConfig createCustom(Map<String, dynamic> values) {
    final mock = createDefault();
    mock.setMockValues(values);
    return mock;
  }
}
