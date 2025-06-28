// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminConfig _$AdminConfigFromJson(Map<String, dynamic> json) => _AdminConfig(
  maintenanceMode: json['maintenanceMode'] as bool,
  minimumVersion: json['minimumVersion'] as String,
);

Map<String, dynamic> _$AdminConfigToJson(_AdminConfig instance) =>
    <String, dynamic>{
      'maintenanceMode': instance.maintenanceMode,
      'minimumVersion': instance.minimumVersion,
    };
