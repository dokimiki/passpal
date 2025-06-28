// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_flags.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeatureFlags _$FeatureFlagsFromJson(Map<String, dynamic> json) =>
    _FeatureFlags(
      enableNewAssignmentParser: json['enableNewAssignmentParser'] as bool,
      enableBiometricAuth: json['enableBiometricAuth'] as bool,
      enableOfflineMode: json['enableOfflineMode'] as bool,
      enableExperimentalFeatures: json['enableExperimentalFeatures'] as bool,
    );

Map<String, dynamic> _$FeatureFlagsToJson(_FeatureFlags instance) =>
    <String, dynamic>{
      'enableNewAssignmentParser': instance.enableNewAssignmentParser,
      'enableBiometricAuth': instance.enableBiometricAuth,
      'enableOfflineMode': instance.enableOfflineMode,
      'enableExperimentalFeatures': instance.enableExperimentalFeatures,
    };
