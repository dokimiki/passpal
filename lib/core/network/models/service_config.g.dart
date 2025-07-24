// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceConfig _$ServiceConfigFromJson(Map<String, dynamic> json) =>
    _ServiceConfig(
      serviceId: json['serviceId'] as String,
      displayName: json['displayName'] as String,
      baseUrl: json['baseUrl'] as String,
      authType:
          $enumDecodeNullable(_$AuthTypeEnumMap, json['authType']) ??
          AuthType.none,
      timeoutMs: (json['timeoutMs'] as num?)?.toInt() ?? 30000,
      connectTimeoutMs: (json['connectTimeoutMs'] as num?)?.toInt() ?? 10000,
      readTimeoutMs: (json['readTimeoutMs'] as num?)?.toInt() ?? 30000,
      writeTimeoutMs: (json['writeTimeoutMs'] as num?)?.toInt() ?? 30000,
      maxRedirects: (json['maxRedirects'] as num?)?.toInt() ?? 5,
      followRedirects: json['followRedirects'] as bool? ?? true,
      defaultCacheStrategy:
          $enumDecodeNullable(
            _$CacheStrategyEnumMap,
            json['defaultCacheStrategy'],
          ) ??
          CacheStrategy.networkFirst,
      cacheTtlMs: (json['cacheTtlMs'] as num?)?.toInt() ?? 300000,
      maxCacheSize: (json['maxCacheSize'] as num?)?.toInt() ?? 10485760,
      defaultHeaders:
          (json['defaultHeaders'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      basePath: json['basePath'] as String?,
      apiVersion: json['apiVersion'] as String?,
      rateLimit: json['rateLimit'] == null
          ? null
          : RateLimitConfig.fromJson(json['rateLimit'] as Map<String, dynamic>),
      retryConfig: json['retryConfig'] == null
          ? null
          : RetryConfig.fromJson(json['retryConfig'] as Map<String, dynamic>),
      validateSsl: json['validateSsl'] as bool? ?? true,
      persistCookies: json['persistCookies'] as bool? ?? true,
      supportsBackground: json['supportsBackground'] as bool? ?? true,
      isCritical: json['isCritical'] as bool? ?? false,
      customConfig: json['customConfig'] as Map<String, dynamic>? ?? const {},
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$ServiceConfigToJson(_ServiceConfig instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'displayName': instance.displayName,
      'baseUrl': instance.baseUrl,
      'authType': _$AuthTypeEnumMap[instance.authType]!,
      'timeoutMs': instance.timeoutMs,
      'connectTimeoutMs': instance.connectTimeoutMs,
      'readTimeoutMs': instance.readTimeoutMs,
      'writeTimeoutMs': instance.writeTimeoutMs,
      'maxRedirects': instance.maxRedirects,
      'followRedirects': instance.followRedirects,
      'defaultCacheStrategy':
          _$CacheStrategyEnumMap[instance.defaultCacheStrategy]!,
      'cacheTtlMs': instance.cacheTtlMs,
      'maxCacheSize': instance.maxCacheSize,
      'defaultHeaders': instance.defaultHeaders,
      'basePath': instance.basePath,
      'apiVersion': instance.apiVersion,
      'rateLimit': instance.rateLimit,
      'retryConfig': instance.retryConfig,
      'validateSsl': instance.validateSsl,
      'persistCookies': instance.persistCookies,
      'supportsBackground': instance.supportsBackground,
      'isCritical': instance.isCritical,
      'customConfig': instance.customConfig,
      'metadata': instance.metadata,
    };

const _$AuthTypeEnumMap = {
  AuthType.none: 'none',
  AuthType.token: 'token',
  AuthType.cookie: 'cookie',
  AuthType.form: 'form',
  AuthType.oauth2: 'oauth2',
  AuthType.custom: 'custom',
};

const _$CacheStrategyEnumMap = {
  CacheStrategy.noCache: 'noCache',
  CacheStrategy.cacheOnly: 'cacheOnly',
  CacheStrategy.cacheFirst: 'cacheFirst',
  CacheStrategy.networkFirst: 'networkFirst',
  CacheStrategy.staleWhileRevalidate: 'staleWhileRevalidate',
  CacheStrategy.forceRefresh: 'forceRefresh',
};

_RateLimitConfig _$RateLimitConfigFromJson(Map<String, dynamic> json) =>
    _RateLimitConfig(
      maxRequests: (json['maxRequests'] as num).toInt(),
      windowMs: (json['windowMs'] as num).toInt(),
      queueRequests: json['queueRequests'] as bool? ?? true,
      maxQueueSize: (json['maxQueueSize'] as num?)?.toInt() ?? 100,
      retryDelayMs: (json['retryDelayMs'] as num?)?.toInt() ?? 1000,
    );

Map<String, dynamic> _$RateLimitConfigToJson(_RateLimitConfig instance) =>
    <String, dynamic>{
      'maxRequests': instance.maxRequests,
      'windowMs': instance.windowMs,
      'queueRequests': instance.queueRequests,
      'maxQueueSize': instance.maxQueueSize,
      'retryDelayMs': instance.retryDelayMs,
    };

_RetryConfig _$RetryConfigFromJson(Map<String, dynamic> json) => _RetryConfig(
  maxRetries: (json['maxRetries'] as num?)?.toInt() ?? 3,
  baseDelayMs: (json['baseDelayMs'] as num?)?.toInt() ?? 1000,
  maxDelayMs: (json['maxDelayMs'] as num?)?.toInt() ?? 30000,
  backoffMultiplier: (json['backoffMultiplier'] as num?)?.toDouble() ?? 2.0,
  enableJitter: json['enableJitter'] as bool? ?? true,
  retryableStatusCodes:
      (json['retryableStatusCodes'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [408, 429, 500, 502, 503, 504],
  retryOnNetworkError: json['retryOnNetworkError'] as bool? ?? true,
  retryOnTimeout: json['retryOnTimeout'] as bool? ?? true,
);

Map<String, dynamic> _$RetryConfigToJson(_RetryConfig instance) =>
    <String, dynamic>{
      'maxRetries': instance.maxRetries,
      'baseDelayMs': instance.baseDelayMs,
      'maxDelayMs': instance.maxDelayMs,
      'backoffMultiplier': instance.backoffMultiplier,
      'enableJitter': instance.enableJitter,
      'retryableStatusCodes': instance.retryableStatusCodes,
      'retryOnNetworkError': instance.retryOnNetworkError,
      'retryOnTimeout': instance.retryOnTimeout,
    };
