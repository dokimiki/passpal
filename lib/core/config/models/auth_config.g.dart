// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthConfig _$AuthConfigFromJson(Map<String, dynamic> json) => _AuthConfig(
  allowedEmailDomain:
      json['allowedEmailDomain'] as String? ??
      AuthConfigDefaults.allowedEmailDomain,
);

Map<String, dynamic> _$AuthConfigToJson(_AuthConfig instance) =>
    <String, dynamic>{'allowedEmailDomain': instance.allowedEmailDomain};
