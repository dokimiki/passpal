// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DebugConfig _$DebugConfigFromJson(Map<String, dynamic> json) => _DebugConfig(
  logLevel: json['logLevel'] as String? ?? 'info',
  enableConsoleLogging: json['enableConsoleLogging'] as bool? ?? false,
  enableFileLogging: json['enableFileLogging'] as bool? ?? false,
  enableNetworkLogging: json['enableNetworkLogging'] as bool? ?? true,
  enableCrashlytics: json['enableCrashlytics'] as bool? ?? true,
);

Map<String, dynamic> _$DebugConfigToJson(_DebugConfig instance) =>
    <String, dynamic>{
      'logLevel': instance.logLevel,
      'enableConsoleLogging': instance.enableConsoleLogging,
      'enableFileLogging': instance.enableFileLogging,
      'enableNetworkLogging': instance.enableNetworkLogging,
      'enableCrashlytics': instance.enableCrashlytics,
    };
