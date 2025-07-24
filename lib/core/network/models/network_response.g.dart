// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NetworkResponse<T> _$NetworkResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _NetworkResponse<T>(
  statusCode: (json['statusCode'] as num).toInt(),
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  headers:
      (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ) ??
      const {},
  contentType: json['contentType'] as String?,
  timestamp: DateTime.parse(json['timestamp'] as String),
  fromCache: json['fromCache'] as bool? ?? false,
  cacheAge: (json['cacheAge'] as num?)?.toInt(),
  requestUrl: json['requestUrl'] as String?,
  responseTimeMs: (json['responseTimeMs'] as num?)?.toInt(),
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$NetworkResponseToJson<T>(
  _NetworkResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'headers': instance.headers,
  'contentType': instance.contentType,
  'timestamp': instance.timestamp.toIso8601String(),
  'fromCache': instance.fromCache,
  'cacheAge': instance.cacheAge,
  'requestUrl': instance.requestUrl,
  'responseTimeMs': instance.responseTimeMs,
  'metadata': instance.metadata,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);
