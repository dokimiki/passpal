// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminConfig _$AdminConfigFromJson(Map<String, dynamic> json) => _AdminConfig(
  appVersion: json['appVersion'] as String? ?? AdminConfigDefaults.appVersion,
  minSupportedVersion:
      json['minSupportedVersion'] as String? ??
      AdminConfigDefaults.minSupportedVersion,
  isMaintenanceMode:
      json['isMaintenanceMode'] as bool? ??
      AdminConfigDefaults.isMaintenanceMode,
  maintenanceMessage:
      json['maintenanceMessage'] as String? ??
      AdminConfigDefaults.maintenanceMessage,
);

Map<String, dynamic> _$AdminConfigToJson(_AdminConfig instance) =>
    <String, dynamic>{
      'appVersion': instance.appVersion,
      'minSupportedVersion': instance.minSupportedVersion,
      'isMaintenanceMode': instance.isMaintenanceMode,
      'maintenanceMessage': instance.maintenanceMessage,
    };
