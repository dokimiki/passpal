// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiConfig _$ApiConfigFromJson(Map<String, dynamic> json) => _ApiConfig(
  palapiBaseUrl: json['palapiBaseUrl'] as String,
  alboBaseUrl: json['alboBaseUrl'] as String,
  manaboBaseUrl: json['manaboBaseUrl'] as String,
  cubicsBaseUrl: json['cubicsBaseUrl'] as String,
  ssoBaseUrl: json['ssoBaseUrl'] as String,
);

Map<String, dynamic> _$ApiConfigToJson(_ApiConfig instance) =>
    <String, dynamic>{
      'palapiBaseUrl': instance.palapiBaseUrl,
      'alboBaseUrl': instance.alboBaseUrl,
      'manaboBaseUrl': instance.manaboBaseUrl,
      'cubicsBaseUrl': instance.cubicsBaseUrl,
      'ssoBaseUrl': instance.ssoBaseUrl,
    };
