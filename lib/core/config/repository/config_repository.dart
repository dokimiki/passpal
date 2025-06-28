import 'dart:async';
import 'package:passpal/core/config/sources/config_source.dart';
import 'package:passpal/core/config/sources/dotenv_config_source.dart';
import 'package:passpal/core/config/sources/remote_config_source.dart';
import 'package:passpal/core/config/sources/default_config_source.dart';
import 'package:passpal/core/config/models/app_config.dart';
import 'package:passpal/core/config/models/api_config.dart';
import 'package:passpal/core/config/models/feature_flags.dart';
import 'package:passpal/core/config/models/debug_config.dart';

/// 複数の設定ソースを統合して管理するリポジトリ
class ConfigRepository {
  ConfigRepository({
    required this.dotEnvSource,
    required this.remoteSource,
    required this.defaultSource,
  });

  final DotEnvConfigSource dotEnvSource;
  final RemoteConfigSource remoteSource;
  final DefaultConfigSource defaultSource;

  final StreamController<AppConfig> _configChangeController =
      StreamController<AppConfig>.broadcast();
  late final List<ConfigSource> _sources;
  AppConfig? _cachedConfig;

  /// 設定変更のストリーム
  Stream<AppConfig> get configStream => _configChangeController.stream;

  /// 初期化処理
  Future<void> initialize() async {
    _sources = [remoteSource, dotEnvSource, defaultSource];

    // 各ソースを初期化
    for (final source in _sources) {
      await source.initialize();

      // 設定変更を監視
      source.onConfigChanged.listen((_) {
        _onConfigChanged();
      });
    }
  }

  /// 統合されたアプリ設定を取得
  Future<AppConfig> getAppConfig() async {
    if (_cachedConfig != null) {
      return _cachedConfig!;
    }

    final apiConfig = await _buildApiConfig();
    final featureFlags = await _buildFeatureFlags();
    final debugConfig = await _buildDebugConfig();

    _cachedConfig = AppConfig(
      api: apiConfig,
      features: featureFlags,
      debug: debugConfig,
    );

    return _cachedConfig!;
  }

  /// API設定を構築
  Future<ApiConfig> _buildApiConfig() async {
    final baseUrl =
        await _getValue('PAL_API_BASE_URL') ?? ApiConfig.defaultConfig.baseUrl;

    return ApiConfig(
      baseUrl: baseUrl,
    );
  }

  /// 機能フラグを構築
  Future<FeatureFlags> _buildFeatureFlags() async {
    final enableNewParser =
        await _getBoolValue('FEATURE_NEW_ASSIGNMENT_PARSER') ??
        FeatureFlags.defaultConfig.enableNewAssignmentParser;
    final enableBiometric =
        await _getBoolValue('FEATURE_BIOMETRIC_AUTH') ??
        FeatureFlags.defaultConfig.enableBiometricAuth;
    final enableOffline =
        await _getBoolValue('FEATURE_OFFLINE_MODE') ??
        FeatureFlags.defaultConfig.enableOfflineMode;
    final enableExperimental =
        await _getBoolValue('FEATURE_EXPERIMENTAL') ??
        FeatureFlags.defaultConfig.enableExperimentalFeatures;

    return FeatureFlags(
      enableNewAssignmentParser: enableNewParser,
      enableBiometricAuth: enableBiometric,
      enableOfflineMode: enableOffline,
      enableExperimentalFeatures: enableExperimental,
    );
  }

  /// デバッグ設定を構築
  Future<DebugConfig> _buildDebugConfig() async {
    final showLogs =
        await _getBoolValue('DEBUG_SHOW_LOGS') ??
        DebugConfig.defaultConfig.showLogs;
    final useMockData =
        await _getBoolValue('DEBUG_MOCK_DATA') ??
        DebugConfig.defaultConfig.useMockData;
    final enableNetworkLogging =
        await _getBoolValue('DEBUG_NETWORK_LOGGING') ??
        DebugConfig.defaultConfig.enableNetworkLogging;
    final enablePerformanceMonitoring =
        await _getBoolValue('DEBUG_PERFORMANCE_MONITORING') ??
        DebugConfig.defaultConfig.enablePerformanceMonitoring;

    return DebugConfig(
      showLogs: showLogs,
      useMockData: useMockData,
      enableNetworkLogging: enableNetworkLogging,
      enablePerformanceMonitoring: enablePerformanceMonitoring,
    );
  }

  /// 優先度順に設定値を取得（型指定なし）
  Future<T?> _getValue<T>(String key) async {
    for (final source in _sources) {
      try {
        T? value;
        if (T == String) {
          value = await source.getString(key) as T?;
        } else if (T == int) {
          value = await source.getInt(key) as T?;
        } else if (T == double) {
          value = await source.getDouble(key) as T?;
        } else if (T == bool) {
          value = await source.getBool(key) as T?;
        }

        if (value != null) {
          return value;
        }
      } catch (e) {
        // このソースでのエラーは無視して次のソースを試す
        continue;
      }
    }
    return null;
  }

  /// ブール値を取得
  Future<bool?> _getBoolValue(String key) async {
    return _getValue<bool>(key);
  }

  /// 設定変更時の処理
  void _onConfigChanged() {
    _cachedConfig = null; // キャッシュをクリア
    getAppConfig()
        .then((config) {
          _configChangeController.add(config);
        })
        .catchError((error) {
          // エラーハンドリング：ログ出力やデフォルト設定の使用
        });
  }

  /// リソースのクリーンアップ
  Future<void> dispose() async {
    await _configChangeController.close();
    for (final source in _sources) {
      await source.dispose();
    }
  }
}
