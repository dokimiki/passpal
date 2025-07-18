import 'package:freezed_annotation/freezed_annotation.dart';

import 'admin_config.dart';
import 'api_config.dart';
import 'auth_config.dart';
import 'debug_config.dart';
import 'feature_flags.dart';

part 'app_config.freezed.dart';
part 'app_config.g.dart';

@freezed
abstract class AppConfig with _$AppConfig {
  const factory AppConfig({
    @Default('1.0.0') String version,
    @Default(true) bool enableAnalytics,
    @Default(true) bool enableCrashReporting,
    @Default(false) bool enableDebugMode,
    required ApiConfig apiConfig,
    required AuthConfig authConfig,
    required DebugConfig debugConfig,
    required FeatureFlags featureFlags,
    required AdminConfig adminConfig,
  }) = _AppConfig;

  factory AppConfig.fromJson(Map<String, Object?> json) =>
      _$AppConfigFromJson(json);

  /// Factory method for testing purposes
  factory AppConfig.forTesting() => AppConfig(
    version: '1.0.0',
    enableAnalytics: true,
    enableCrashReporting: true,
    enableDebugMode: false,
    apiConfig: ApiConfig.forTesting(),
    authConfig: AuthConfig.forTesting(),
    debugConfig: DebugConfig.forTesting(),
    featureFlags: FeatureFlags.forTesting(),
    adminConfig: AdminConfig.forTesting(),
  );

  const AppConfig._();
}
