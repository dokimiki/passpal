// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_flags.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeatureFlags _$FeatureFlagsFromJson(Map<String, dynamic> json) =>
    _FeatureFlags(
      enableOfflineMode: json['enableOfflineMode'] as bool? ?? true,
      enablePushNotifications: json['enablePushNotifications'] as bool? ?? true,
      enableMaintenanceMode: json['enableMaintenanceMode'] as bool? ?? false,
    );

Map<String, dynamic> _$FeatureFlagsToJson(_FeatureFlags instance) =>
    <String, dynamic>{
      'enableOfflineMode': instance.enableOfflineMode,
      'enablePushNotifications': instance.enablePushNotifications,
      'enableMaintenanceMode': instance.enableMaintenanceMode,
    };
