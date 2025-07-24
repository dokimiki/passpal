// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NetworkRequest _$NetworkRequestFromJson(Map<String, dynamic> json) =>
    _NetworkRequest(
      method: $enumDecode(_$HttpMethodEnumMap, json['method']),
      url: json['url'] as String,
      headers:
          (json['headers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      queryParameters:
          json['queryParameters'] as Map<String, dynamic>? ?? const {},
      data: json['data'],
      cacheStrategy:
          $enumDecodeNullable(_$CacheStrategyEnumMap, json['cacheStrategy']) ??
          CacheStrategy.networkFirst,
      timeoutMs: (json['timeoutMs'] as num?)?.toInt(),
      followRedirects: json['followRedirects'] as bool? ?? true,
      maxRedirects: (json['maxRedirects'] as num?)?.toInt() ?? 5,
      contentType: json['contentType'] as String?,
      validateStatus: json['validateStatus'] as bool? ?? true,
      tag: json['tag'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$NetworkRequestToJson(_NetworkRequest instance) =>
    <String, dynamic>{
      'method': _$HttpMethodEnumMap[instance.method]!,
      'url': instance.url,
      'headers': instance.headers,
      'queryParameters': instance.queryParameters,
      'data': instance.data,
      'cacheStrategy': _$CacheStrategyEnumMap[instance.cacheStrategy]!,
      'timeoutMs': instance.timeoutMs,
      'followRedirects': instance.followRedirects,
      'maxRedirects': instance.maxRedirects,
      'contentType': instance.contentType,
      'validateStatus': instance.validateStatus,
      'tag': instance.tag,
      'metadata': instance.metadata,
    };

const _$HttpMethodEnumMap = {
  HttpMethod.get: 'get',
  HttpMethod.post: 'post',
  HttpMethod.put: 'put',
  HttpMethod.patch: 'patch',
  HttpMethod.delete: 'delete',
  HttpMethod.head: 'head',
  HttpMethod.options: 'options',
};

const _$CacheStrategyEnumMap = {
  CacheStrategy.noCache: 'noCache',
  CacheStrategy.cacheOnly: 'cacheOnly',
  CacheStrategy.cacheFirst: 'cacheFirst',
  CacheStrategy.networkFirst: 'networkFirst',
  CacheStrategy.staleWhileRevalidate: 'staleWhileRevalidate',
  CacheStrategy.forceRefresh: 'forceRefresh',
};
