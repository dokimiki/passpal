import 'package:freezed_annotation/freezed_annotation.dart';

import 'admin_config.dart';
import 'api_config.dart';
import 'auth_config.dart';
import 'debug_config.dart';
import 'feature_flags.dart';

part 'app_config.freezed.dart';
part 'app_config.g.dart';

/// Default values for main application configuration
class AppConfigDefaults {
  static const String version = '1.0.0';
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enableDebugMode = false;
}

@freezed
abstract class AppConfig with _$AppConfig {
  const factory AppConfig({
    @Default(AppConfigDefaults.version) String version,
    @Default(AppConfigDefaults.enableAnalytics) bool enableAnalytics,
    @Default(AppConfigDefaults.enableCrashReporting) bool enableCrashReporting,
    @Default(AppConfigDefaults.enableDebugMode) bool enableDebugMode,
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
    version: AppConfigDefaults.version,
    enableAnalytics: AppConfigDefaults.enableAnalytics,
    enableCrashReporting: AppConfigDefaults.enableCrashReporting,
    enableDebugMode: AppConfigDefaults.enableDebugMode,
    apiConfig: ApiConfig.forTesting(),
    authConfig: AuthConfig.forTesting(),
    debugConfig: DebugConfig.forTesting(),
    featureFlags: FeatureFlags.forTesting(),
    adminConfig: AdminConfig.forTesting(),
  );

  /// Factory method that creates AppConfig with all default values
  factory AppConfig.withDefaults() => AppConfig(
    version: AppConfigDefaults.version,
    enableAnalytics: AppConfigDefaults.enableAnalytics,
    enableCrashReporting: AppConfigDefaults.enableCrashReporting,
    enableDebugMode: AppConfigDefaults.enableDebugMode,
    apiConfig: ApiConfig.withDefaults(),
    authConfig: AuthConfig.withDefaults(),
    debugConfig: DebugConfig.withDefaults(),
    featureFlags: FeatureFlags.withDefaults(),
    adminConfig: AdminConfig.withDefaults(),
  );

  const AppConfig._();
}
