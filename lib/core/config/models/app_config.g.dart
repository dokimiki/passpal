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
);

Map<String, dynamic> _$AppConfigToJson(_AppConfig instance) =>
    <String, dynamic>{
      'version': instance.version,
      'enableAnalytics': instance.enableAnalytics,
      'enableCrashReporting': instance.enableCrashReporting,
      'enableDebugMode': instance.enableDebugMode,
    };
