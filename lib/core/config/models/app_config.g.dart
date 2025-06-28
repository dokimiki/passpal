// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => _AppConfig(
  api: ApiConfig.fromJson(json['api'] as Map<String, dynamic>),
  features: FeatureFlags.fromJson(json['features'] as Map<String, dynamic>),
  debug: DebugConfig.fromJson(json['debug'] as Map<String, dynamic>),
  admin: AdminConfig.fromJson(json['admin'] as Map<String, dynamic>),
  auth: AuthConfig.fromJson(json['auth'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AppConfigToJson(_AppConfig instance) =>
    <String, dynamic>{
      'api': instance.api,
      'features': instance.features,
      'debug': instance.debug,
      'admin': instance.admin,
      'auth': instance.auth,
    };
