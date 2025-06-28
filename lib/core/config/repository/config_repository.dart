import 'dart:async';
import 'package:passpal/core/config/models/admin_config.dart';
import 'package:passpal/core/config/models/auth_config.dart';
import 'package:passpal/core/config/sources/config_source.dart';
import 'package:passpal/core/config/sources/dotenv_config_source.dart';
import 'package:passpal/core/config/sources/remote_config_source.dart';
import 'package:passpal/core/config/models/app_config.dart';
import 'package:passpal/core/config/models/api_config.dart';
import 'package:passpal/core/config/models/feature_flags.dart';
import 'package:passpal/core/config/models/debug_config.dart';

/// 複数の設定ソースを統合して管理するリポジトリ
class ConfigRepository {
  ConfigRepository({required this.dotEnvSource, required this.remoteSource});

  final DotEnvConfigSource dotEnvSource;
  final RemoteConfigSource remoteSource;

  final StreamController<AppConfig> _configChangeController =
      StreamController<AppConfig>.broadcast();
  late final List<ConfigSource> _sources;
  AppConfig? _cachedConfig;

  /// 設定変更のストリーム
  Stream<AppConfig> get configStream => _configChangeController.stream;

  /// 初期化処理
  Future<void> initialize() async {
    _sources = [remoteSource, dotEnvSource];

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
    final adminConfig = await _buildAdminConfig();
    final authConfig = await _buildAuthConfig();

    _cachedConfig = AppConfig(
      api: apiConfig,
      features: featureFlags,
      debug: debugConfig,
      admin: adminConfig,
      auth: authConfig,
    );

    return _cachedConfig!;
  }

  /// API設定を構築
  Future<ApiConfig> _buildApiConfig() async {
    final palapiBaseUrl =
        await _getValue('API_PAL_API_BASE_URL') ??
        ApiConfig.defaultConfig.palapiBaseUrl;
    final alboBaseUrl =
        await _getValue('API_ALBO_BASE_URL') ??
        ApiConfig.defaultConfig.alboBaseUrl;
    final manaboBaseUrl =
        await _getValue('API_MANABO_BASE_URL') ??
        ApiConfig.defaultConfig.manaboBaseUrl;
    final cubicsBaseUrl =
        await _getValue('API_CUBICS_BASE_URL') ??
        ApiConfig.defaultConfig.cubicsBaseUrl;
    final ssoBaseUrl =
        await _getValue('API_SSO_BASE_URL') ??
        ApiConfig.defaultConfig.ssoBaseUrl;

    return ApiConfig(
      palapiBaseUrl: palapiBaseUrl,
      alboBaseUrl: alboBaseUrl,
      manaboBaseUrl: manaboBaseUrl,
      cubicsBaseUrl: cubicsBaseUrl,
      ssoBaseUrl: ssoBaseUrl,
    );
  }

  /// 認証設定を構築
  Future<AuthConfig> _buildAuthConfig() async {
    final allowedMailDomain =
        await _getValue<String>('AUTH_ALLOWED_MAIL_DOMAIN') ??
        AuthConfig.defaultConfig.allowedMailDomain;

    return AuthConfig(allowedMailDomain: allowedMailDomain);
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

  Future<AdminConfig> _buildAdminConfig() async {
    final maintenanceMode =
        await _getBoolValue('ADMIN_MAINTENANCE_MODE') ??
        AdminConfig.defaultConfig.maintenanceMode;
    final minimumVersion =
        await _getValue<String>('ADMIN_MINIMUM_VERSION') ??
        AdminConfig.defaultConfig.minimumVersion;

    return AdminConfig(
      maintenanceMode: maintenanceMode,
      minimumVersion: minimumVersion,
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
