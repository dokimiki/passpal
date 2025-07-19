// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_flags.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeatureFlags _$FeatureFlagsFromJson(Map<String, dynamic> json) =>
    _FeatureFlags(
      enableOfflineMode:
          json['enableOfflineMode'] as bool? ??
          FeatureFlagsDefaults.enableOfflineMode,
      enablePushNotifications:
          json['enablePushNotifications'] as bool? ??
          FeatureFlagsDefaults.enablePushNotifications,
      enableMaintenanceMode:
          json['enableMaintenanceMode'] as bool? ??
          FeatureFlagsDefaults.enableMaintenanceMode,
    );

Map<String, dynamic> _$FeatureFlagsToJson(_FeatureFlags instance) =>
    <String, dynamic>{
      'enableOfflineMode': instance.enableOfflineMode,
      'enablePushNotifications': instance.enablePushNotifications,
      'enableMaintenanceMode': instance.enableMaintenanceMode,
    };
