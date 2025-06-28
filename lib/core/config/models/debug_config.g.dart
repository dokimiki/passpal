// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DebugConfig _$DebugConfigFromJson(Map<String, dynamic> json) => _DebugConfig(
  showLogs: json['showLogs'] as bool,
  useMockData: json['useMockData'] as bool,
  enableNetworkLogging: json['enableNetworkLogging'] as bool,
  enablePerformanceMonitoring: json['enablePerformanceMonitoring'] as bool,
);

Map<String, dynamic> _$DebugConfigToJson(_DebugConfig instance) =>
    <String, dynamic>{
      'showLogs': instance.showLogs,
      'useMockData': instance.useMockData,
      'enableNetworkLogging': instance.enableNetworkLogging,
      'enablePerformanceMonitoring': instance.enablePerformanceMonitoring,
    };
