// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiConfig _$ApiConfigFromJson(Map<String, dynamic> json) => _ApiConfig(
  manaboBaseUrl:
      json['manaboBaseUrl'] as String? ?? 'https://manabo.cnc.chukyo-u.ac.jp',
  alboBaseUrl:
      json['alboBaseUrl'] as String? ??
      'https://cubics-pt-out.mng.chukyo-u.ac.jp',
  cubicsBaseUrl:
      json['cubicsBaseUrl'] as String? ??
      'https://cubics-as-out.mng.chukyo-u.ac.jp',
  ssoUrl: json['ssoUrl'] as String? ?? 'https://shib.chukyo-u.ac.jp',
  palApiBaseUrl:
      json['palApiBaseUrl'] as String? ?? 'https://api.chukyo-passpal.app/v1',
  connectionTimeoutSeconds:
      (json['connectionTimeoutSeconds'] as num?)?.toInt() ?? 30,
  receiveTimeoutSeconds: (json['receiveTimeoutSeconds'] as num?)?.toInt() ?? 60,
  maxRetries: (json['maxRetries'] as num?)?.toInt() ?? 3,
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
