// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => _AppConfig(
  version: json['version'] as String? ?? '1.0.0',
  enableAnalytics: json['enableAnalytics'] as bool? ?? true,
  enableCrashReporting: json['enableCrashReporting'] as bool? ?? true,
  enableDebugMode: json['enableDebugMode'] as bool? ?? false,
  apiConfig: ApiConfig.fromJson(json['apiConfig'] as Map<String, dynamic>),
  authConfig: AuthConfig.fromJson(json['authConfig'] as Map<String, dynamic>),
  debugConfig: DebugConfig.fromJson(
    json['debugConfig'] as Map<String, dynamic>,
  ),
  featureFlags: FeatureFlags.fromJson(
    json['featureFlags'] as Map<String, dynamic>,
  ),
  adminConfig: AdminConfig.fromJson(
    json['adminConfig'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AppConfigToJson(_AppConfig instance) =>
    <String, dynamic>{
      'version': instance.version,
      'enableAnalytics': instance.enableAnalytics,
      'enableCrashReporting': instance.enableCrashReporting,
      'enableDebugMode': instance.enableDebugMode,
      'apiConfig': instance.apiConfig,
      'authConfig': instance.authConfig,
      'debugConfig': instance.debugConfig,
      'featureFlags': instance.featureFlags,
      'adminConfig': instance.adminConfig,
    };
