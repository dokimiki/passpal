import 'dart:async';
import 'package:passpal/core/config/models/admin_config.dart';
import 'package:passpal/core/config/repository/config_repository.dart';
import 'package:passpal/core/config/models/app_config.dart';
import 'package:passpal/core/config/models/api_config.dart';
import 'package:passpal/core/config/models/feature_flags.dart';
import 'package:passpal/core/config/models/debug_config.dart';

/// 設定管理のフロントエンドサービス
class ConfigService {
  ConfigService(this._repository);

  final ConfigRepository _repository;

  /// アプリ設定を取得
  Future<AppConfig> getAppConfig() async {
    return _repository.getAppConfig();
  }

  /// API設定を取得
  Future<ApiConfig> getApiConfig() async {
    final config = await getAppConfig();
    return config.api;
  }

  /// 機能フラグを取得
  Future<FeatureFlags> getFeatureFlags() async {
    final config = await getAppConfig();
    return config.features;
  }

  /// デバッグ設定を取得
  Future<DebugConfig> getDebugConfig() async {
    final config = await getAppConfig();
    return config.debug;
  }

  /// 管理者設定を取得
  Future<AdminConfig> getAdminConfig() async {
    final config = await getAppConfig();
    return config.admin;
  }

  /// 特定の機能フラグの状態を取得
  Future<bool> isFeatureEnabled(String featureName) async {
    final features = await getFeatureFlags();
    switch (featureName) {
      case 'newAssignmentParser':
        return features.enableNewAssignmentParser;
      case 'biometricAuth':
        return features.enableBiometricAuth;
      case 'offlineMode':
        return features.enableOfflineMode;
      case 'experimentalFeatures':
        return features.enableExperimentalFeatures;
      default:
        return false;
    }
  }

  /// 最小必須バージョンを取得
  Future<String?> getMinimumVersion() async {
    final adminConfig = await getAdminConfig();
    final minVersion = adminConfig.minimumVersion;
    return minVersion.isEmpty || minVersion == '0.0.0' ? null : minVersion;
  }

  /// 設定変更のストリーム
  Stream<AppConfig> get configStream => _repository.configStream;

  /// 特定の機能フラグ変更のストリーム
  Stream<bool> featureStream(String featureName) {
    return configStream.map((config) {
      switch (featureName) {
        case 'newAssignmentParser':
          return config.features.enableNewAssignmentParser;
        case 'biometricAuth':
          return config.features.enableBiometricAuth;
        case 'offlineMode':
          return config.features.enableOfflineMode;
        case 'experimentalFeatures':
          return config.features.enableExperimentalFeatures;
        default:
          return false;
      }
    }).distinct();
  }

  /// リソースのクリーンアップ
  Future<void> dispose() async {
    await _repository.dispose();
  }
}
