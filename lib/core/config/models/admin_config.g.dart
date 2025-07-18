// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminConfig _$AdminConfigFromJson(Map<String, dynamic> json) => _AdminConfig(
  appVersion: json['appVersion'] as String? ?? '1.0.0',
  minSupportedVersion: json['minSupportedVersion'] as String? ?? '1.0.0',
  isMaintenanceMode: json['isMaintenanceMode'] as bool? ?? false,
  maintenanceMessage: json['maintenanceMessage'] as String? ?? '',
);

Map<String, dynamic> _$AdminConfigToJson(_AdminConfig instance) =>
    <String, dynamic>{
      'appVersion': instance.appVersion,
      'minSupportedVersion': instance.minSupportedVersion,
      'isMaintenanceMode': instance.isMaintenanceMode,
      'maintenanceMessage': instance.maintenanceMessage,
    };
