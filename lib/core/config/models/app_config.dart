import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passpal/core/config/models/api_config.dart';
import 'package:passpal/core/config/models/feature_flags.dart';
import 'package:passpal/core/config/models/debug_config.dart';

part 'app_config.freezed.dart';
part 'app_config.g.dart';

/// アプリケーション全体の設定を統合するメインクラス
@freezed
abstract class AppConfig with _$AppConfig {
  const factory AppConfig({
    required ApiConfig api,
    required FeatureFlags features,
    required DebugConfig debug,
  }) = _AppConfig;

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);

  /// デフォルトの設定
  static const AppConfig defaultConfig = AppConfig(
    api: ApiConfig.defaultConfig,
    features: FeatureFlags.defaultConfig,
    debug: DebugConfig.defaultConfig,
  );
}
