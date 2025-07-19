// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DebugConfig _$DebugConfigFromJson(Map<String, dynamic> json) => _DebugConfig(
  logLevel: json['logLevel'] as String? ?? DebugConfigDefaults.logLevel,
  enableConsoleLogging:
      json['enableConsoleLogging'] as bool? ??
      DebugConfigDefaults.enableConsoleLogging,
  enableFileLogging:
      json['enableFileLogging'] as bool? ??
      DebugConfigDefaults.enableFileLogging,
  enableNetworkLogging:
      json['enableNetworkLogging'] as bool? ??
      DebugConfigDefaults.enableNetworkLogging,
  enableCrashlytics:
      json['enableCrashlytics'] as bool? ??
      DebugConfigDefaults.enableCrashlytics,
);

Map<String, dynamic> _$DebugConfigToJson(_DebugConfig instance) =>
    <String, dynamic>{
      'logLevel': instance.logLevel,
      'enableConsoleLogging': instance.enableConsoleLogging,
      'enableFileLogging': instance.enableFileLogging,
      'enableNetworkLogging': instance.enableNetworkLogging,
      'enableCrashlytics': instance.enableCrashlytics,
    };
