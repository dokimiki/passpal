import 'dart:async';
import 'package:passpal/core/config/sources/config_source.dart';

/// デフォルト設定値を提供するソース
class DefaultConfigSource implements ConfigSource {
  const DefaultConfigSource();

  static final StreamController<String> _configChangeController =
      StreamController<String>.broadcast();

  @override
  String get sourceName => 'Default';

  @override
  Future<void> initialize() async {
    // デフォルト値の初期化は不要
  }

  @override
  Future<String?> getString(String key) async {
    return _getDefaultValue(key) as String?;
  }

  @override
  Future<bool?> getBool(String key) async {
    return _getDefaultValue(key) as bool?;
  }

  @override
  Future<int?> getInt(String key) async {
    return _getDefaultValue(key) as int?;
  }

  @override
  Future<double?> getDouble(String key) async {
    return _getDefaultValue(key) as double?;
  }

  @override
  Stream<String> get onConfigChanged => _configChangeController.stream;

  @override
  Future<void> dispose() async {
    await _configChangeController.close();
  }

  /// デフォルト値を取得
  dynamic _getDefaultValue(String key) {
    return _defaultValues[key];
  }

  /// デフォルト設定値のマップ
  static const Map<String, dynamic> _defaultValues = {
    // API設定
    'PAL_API_BASE_URL': 'https://api.chukyo-passpal.app/v1',
    'ALBO_BASE_URL': 'https://cubics-pt-out.mng.chukyo-u.ac.jp',
    'MANABO_BASE_URL': 'https://manabo.cnc.chukyo-u.ac.jp',
    'CUBICS_BASE_URL': 'https://cubics-as-out.mng.chukyo-u.ac.jp',
    'SSO_BASE_URL': 'https://shib.chukyo-u.ac.jp',

    // 機能フラグ
    'FEATURE_NEW_ASSIGNMENT_PARSER': false,
    'FEATURE_BIOMETRIC_AUTH': false,
    'FEATURE_OFFLINE_MODE': false,
    'FEATURE_EXPERIMENTAL': false,

    // デバッグ設定
    'DEBUG_SHOW_LOGS': false,
    'DEBUG_MOCK_DATA': false,
    'DEBUG_NETWORK_LOGGING': false,
    'DEBUG_PERFORMANCE_MONITORING': false,
  };
}
