// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiConfig _$ApiConfigFromJson(Map<String, dynamic> json) => _ApiConfig(
  manaboBaseUrl:
      json['manaboBaseUrl'] as String? ?? ApiConfigDefaults.manaboBaseUrl,
  alboBaseUrl: json['alboBaseUrl'] as String? ?? ApiConfigDefaults.alboBaseUrl,
  cubicsBaseUrl:
      json['cubicsBaseUrl'] as String? ?? ApiConfigDefaults.cubicsBaseUrl,
  ssoUrl: json['ssoUrl'] as String? ?? ApiConfigDefaults.ssoUrl,
  palApiBaseUrl:
      json['palApiBaseUrl'] as String? ?? ApiConfigDefaults.palApiBaseUrl,
  connectionTimeoutSeconds:
      (json['connectionTimeoutSeconds'] as num?)?.toInt() ??
      ApiConfigDefaults.connectionTimeoutSeconds,
  receiveTimeoutSeconds:
      (json['receiveTimeoutSeconds'] as num?)?.toInt() ??
      ApiConfigDefaults.receiveTimeoutSeconds,
  maxRetries:
      (json['maxRetries'] as num?)?.toInt() ?? ApiConfigDefaults.maxRetries,
);

Map<String, dynamic> _$ApiConfigToJson(_ApiConfig instance) =>
    <String, dynamic>{
      'manaboBaseUrl': instance.manaboBaseUrl,
      'alboBaseUrl': instance.alboBaseUrl,
      'cubicsBaseUrl': instance.cubicsBaseUrl,
      'ssoUrl': instance.ssoUrl,
      'palApiBaseUrl': instance.palApiBaseUrl,
      'connectionTimeoutSeconds': instance.connectionTimeoutSeconds,
      'receiveTimeoutSeconds': instance.receiveTimeoutSeconds,
      'maxRetries': instance.maxRetries,
    };
