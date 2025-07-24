// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceConfig {

/// Service identifier
 String get serviceId;/// Display name for the service
 String get displayName;/// Base URL for the service
 String get baseUrl;/// Authentication type
 AuthType get authType;/// Default timeout in milliseconds
 int get timeoutMs;/// Connection timeout in milliseconds
 int get connectTimeoutMs;/// Read timeout in milliseconds
 int get readTimeoutMs;/// Write timeout in milliseconds
 int get writeTimeoutMs;/// Maximum number of redirects to follow
 int get maxRedirects;/// Whether to follow redirects
 bool get followRedirects;/// Default cache strategy for this service
 CacheStrategy get defaultCacheStrategy;/// Cache TTL in milliseconds
 int get cacheTtlMs;// 5 minutes default
/// Maximum cache size for this service in bytes
 int get maxCacheSize;// 10MB default
/// Default headers for all requests to this service
 Map<String, String> get defaultHeaders;/// Base path to append to baseUrl for all requests
 String? get basePath;/// API version (for versioned APIs)
 String? get apiVersion;/// Rate limit configuration
 RateLimitConfig? get rateLimit;/// Retry configuration
 RetryConfig? get retryConfig;/// Whether to validate SSL certificates
 bool get validateSsl;/// Whether to persist cookies
 bool get persistCookies;/// Whether this service supports background operations
 bool get supportsBackground;/// Whether requests to this service are critical
 bool get isCritical;/// Custom configuration for the service
 Map<String, dynamic> get customConfig;/// Additional metadata
 Map<String, dynamic> get metadata;
/// Create a copy of ServiceConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceConfigCopyWith<ServiceConfig> get copyWith => _$ServiceConfigCopyWithImpl<ServiceConfig>(this as ServiceConfig, _$identity);

  /// Serializes this ServiceConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceConfig&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.authType, authType) || other.authType == authType)&&(identical(other.timeoutMs, timeoutMs) || other.timeoutMs == timeoutMs)&&(identical(other.connectTimeoutMs, connectTimeoutMs) || other.connectTimeoutMs == connectTimeoutMs)&&(identical(other.readTimeoutMs, readTimeoutMs) || other.readTimeoutMs == readTimeoutMs)&&(identical(other.writeTimeoutMs, writeTimeoutMs) || other.writeTimeoutMs == writeTimeoutMs)&&(identical(other.maxRedirects, maxRedirects) || other.maxRedirects == maxRedirects)&&(identical(other.followRedirects, followRedirects) || other.followRedirects == followRedirects)&&(identical(other.defaultCacheStrategy, defaultCacheStrategy) || other.defaultCacheStrategy == defaultCacheStrategy)&&(identical(other.cacheTtlMs, cacheTtlMs) || other.cacheTtlMs == cacheTtlMs)&&(identical(other.maxCacheSize, maxCacheSize) || other.maxCacheSize == maxCacheSize)&&const DeepCollectionEquality().equals(other.defaultHeaders, defaultHeaders)&&(identical(other.basePath, basePath) || other.basePath == basePath)&&(identical(other.apiVersion, apiVersion) || other.apiVersion == apiVersion)&&(identical(other.rateLimit, rateLimit) || other.rateLimit == rateLimit)&&(identical(other.retryConfig, retryConfig) || other.retryConfig == retryConfig)&&(identical(other.validateSsl, validateSsl) || other.validateSsl == validateSsl)&&(identical(other.persistCookies, persistCookies) || other.persistCookies == persistCookies)&&(identical(other.supportsBackground, supportsBackground) || other.supportsBackground == supportsBackground)&&(identical(other.isCritical, isCritical) || other.isCritical == isCritical)&&const DeepCollectionEquality().equals(other.customConfig, customConfig)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,serviceId,displayName,baseUrl,authType,timeoutMs,connectTimeoutMs,readTimeoutMs,writeTimeoutMs,maxRedirects,followRedirects,defaultCacheStrategy,cacheTtlMs,maxCacheSize,const DeepCollectionEquality().hash(defaultHeaders),basePath,apiVersion,rateLimit,retryConfig,validateSsl,persistCookies,supportsBackground,isCritical,const DeepCollectionEquality().hash(customConfig),const DeepCollectionEquality().hash(metadata)]);

@override
String toString() {
  return 'ServiceConfig(serviceId: $serviceId, displayName: $displayName, baseUrl: $baseUrl, authType: $authType, timeoutMs: $timeoutMs, connectTimeoutMs: $connectTimeoutMs, readTimeoutMs: $readTimeoutMs, writeTimeoutMs: $writeTimeoutMs, maxRedirects: $maxRedirects, followRedirects: $followRedirects, defaultCacheStrategy: $defaultCacheStrategy, cacheTtlMs: $cacheTtlMs, maxCacheSize: $maxCacheSize, defaultHeaders: $defaultHeaders, basePath: $basePath, apiVersion: $apiVersion, rateLimit: $rateLimit, retryConfig: $retryConfig, validateSsl: $validateSsl, persistCookies: $persistCookies, supportsBackground: $supportsBackground, isCritical: $isCritical, customConfig: $customConfig, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ServiceConfigCopyWith<$Res>  {
  factory $ServiceConfigCopyWith(ServiceConfig value, $Res Function(ServiceConfig) _then) = _$ServiceConfigCopyWithImpl;
@useResult
$Res call({
 String serviceId, String displayName, String baseUrl, AuthType authType, int timeoutMs, int connectTimeoutMs, int readTimeoutMs, int writeTimeoutMs, int maxRedirects, bool followRedirects, CacheStrategy defaultCacheStrategy, int cacheTtlMs, int maxCacheSize, Map<String, String> defaultHeaders, String? basePath, String? apiVersion, RateLimitConfig? rateLimit, RetryConfig? retryConfig, bool validateSsl, bool persistCookies, bool supportsBackground, bool isCritical, Map<String, dynamic> customConfig, Map<String, dynamic> metadata
});


$RateLimitConfigCopyWith<$Res>? get rateLimit;$RetryConfigCopyWith<$Res>? get retryConfig;

}
/// @nodoc
class _$ServiceConfigCopyWithImpl<$Res>
    implements $ServiceConfigCopyWith<$Res> {
  _$ServiceConfigCopyWithImpl(this._self, this._then);

  final ServiceConfig _self;
  final $Res Function(ServiceConfig) _then;

/// Create a copy of ServiceConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serviceId = null,Object? displayName = null,Object? baseUrl = null,Object? authType = null,Object? timeoutMs = null,Object? connectTimeoutMs = null,Object? readTimeoutMs = null,Object? writeTimeoutMs = null,Object? maxRedirects = null,Object? followRedirects = null,Object? defaultCacheStrategy = null,Object? cacheTtlMs = null,Object? maxCacheSize = null,Object? defaultHeaders = null,Object? basePath = freezed,Object? apiVersion = freezed,Object? rateLimit = freezed,Object? retryConfig = freezed,Object? validateSsl = null,Object? persistCookies = null,Object? supportsBackground = null,Object? isCritical = null,Object? customConfig = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,authType: null == authType ? _self.authType : authType // ignore: cast_nullable_to_non_nullable
as AuthType,timeoutMs: null == timeoutMs ? _self.timeoutMs : timeoutMs // ignore: cast_nullable_to_non_nullable
as int,connectTimeoutMs: null == connectTimeoutMs ? _self.connectTimeoutMs : connectTimeoutMs // ignore: cast_nullable_to_non_nullable
as int,readTimeoutMs: null == readTimeoutMs ? _self.readTimeoutMs : readTimeoutMs // ignore: cast_nullable_to_non_nullable
as int,writeTimeoutMs: null == writeTimeoutMs ? _self.writeTimeoutMs : writeTimeoutMs // ignore: cast_nullable_to_non_nullable
as int,maxRedirects: null == maxRedirects ? _self.maxRedirects : maxRedirects // ignore: cast_nullable_to_non_nullable
as int,followRedirects: null == followRedirects ? _self.followRedirects : followRedirects // ignore: cast_nullable_to_non_nullable
as bool,defaultCacheStrategy: null == defaultCacheStrategy ? _self.defaultCacheStrategy : defaultCacheStrategy // ignore: cast_nullable_to_non_nullable
as CacheStrategy,cacheTtlMs: null == cacheTtlMs ? _self.cacheTtlMs : cacheTtlMs // ignore: cast_nullable_to_non_nullable
as int,maxCacheSize: null == maxCacheSize ? _self.maxCacheSize : maxCacheSize // ignore: cast_nullable_to_non_nullable
as int,defaultHeaders: null == defaultHeaders ? _self.defaultHeaders : defaultHeaders // ignore: cast_nullable_to_non_nullable
as Map<String, String>,basePath: freezed == basePath ? _self.basePath : basePath // ignore: cast_nullable_to_non_nullable
as String?,apiVersion: freezed == apiVersion ? _self.apiVersion : apiVersion // ignore: cast_nullable_to_non_nullable
as String?,rateLimit: freezed == rateLimit ? _self.rateLimit : rateLimit // ignore: cast_nullable_to_non_nullable
as RateLimitConfig?,retryConfig: freezed == retryConfig ? _self.retryConfig : retryConfig // ignore: cast_nullable_to_non_nullable
as RetryConfig?,validateSsl: null == validateSsl ? _self.validateSsl : validateSsl // ignore: cast_nullable_to_non_nullable
as bool,persistCookies: null == persistCookies ? _self.persistCookies : persistCookies // ignore: cast_nullable_to_non_nullable
as bool,supportsBackground: null == supportsBackground ? _self.supportsBackground : supportsBackground // ignore: cast_nullable_to_non_nullable
as bool,isCritical: null == isCritical ? _self.isCritical : isCritical // ignore: cast_nullable_to_non_nullable
as bool,customConfig: null == customConfig ? _self.customConfig : customConfig // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}
/// Create a copy of ServiceConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RateLimitConfigCopyWith<$Res>? get rateLimit {
    if (_self.rateLimit == null) {
    return null;
  }

  return $RateLimitConfigCopyWith<$Res>(_self.rateLimit!, (value) {
    return _then(_self.copyWith(rateLimit: value));
  });
}/// Create a copy of ServiceConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RetryConfigCopyWith<$Res>? get retryConfig {
    if (_self.retryConfig == null) {
    return null;
  }

  return $RetryConfigCopyWith<$Res>(_self.retryConfig!, (value) {
    return _then(_self.copyWith(retryConfig: value));
  });
}
}


/// Adds pattern-matching-related methods to [ServiceConfig].
extension ServiceConfigPatterns on ServiceConfig {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceConfig() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceConfig value)  $default,){
final _that = this;
switch (_that) {
case _ServiceConfig():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceConfig() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String serviceId,  String displayName,  String baseUrl,  AuthType authType,  int timeoutMs,  int connectTimeoutMs,  int readTimeoutMs,  int writeTimeoutMs,  int maxRedirects,  bool followRedirects,  CacheStrategy defaultCacheStrategy,  int cacheTtlMs,  int maxCacheSize,  Map<String, String> defaultHeaders,  String? basePath,  String? apiVersion,  RateLimitConfig? rateLimit,  RetryConfig? retryConfig,  bool validateSsl,  bool persistCookies,  bool supportsBackground,  bool isCritical,  Map<String, dynamic> customConfig,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceConfig() when $default != null:
return $default(_that.serviceId,_that.displayName,_that.baseUrl,_that.authType,_that.timeoutMs,_that.connectTimeoutMs,_that.readTimeoutMs,_that.writeTimeoutMs,_that.maxRedirects,_that.followRedirects,_that.defaultCacheStrategy,_that.cacheTtlMs,_that.maxCacheSize,_that.defaultHeaders,_that.basePath,_that.apiVersion,_that.rateLimit,_that.retryConfig,_that.validateSsl,_that.persistCookies,_that.supportsBackground,_that.isCritical,_that.customConfig,_that.metadata);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String serviceId,  String displayName,  String baseUrl,  AuthType authType,  int timeoutMs,  int connectTimeoutMs,  int readTimeoutMs,  int writeTimeoutMs,  int maxRedirects,  bool followRedirects,  CacheStrategy defaultCacheStrategy,  int cacheTtlMs,  int maxCacheSize,  Map<String, String> defaultHeaders,  String? basePath,  String? apiVersion,  RateLimitConfig? rateLimit,  RetryConfig? retryConfig,  bool validateSsl,  bool persistCookies,  bool supportsBackground,  bool isCritical,  Map<String, dynamic> customConfig,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _ServiceConfig():
return $default(_that.serviceId,_that.displayName,_that.baseUrl,_that.authType,_that.timeoutMs,_that.connectTimeoutMs,_that.readTimeoutMs,_that.writeTimeoutMs,_that.maxRedirects,_that.followRedirects,_that.defaultCacheStrategy,_that.cacheTtlMs,_that.maxCacheSize,_that.defaultHeaders,_that.basePath,_that.apiVersion,_that.rateLimit,_that.retryConfig,_that.validateSsl,_that.persistCookies,_that.supportsBackground,_that.isCritical,_that.customConfig,_that.metadata);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String serviceId,  String displayName,  String baseUrl,  AuthType authType,  int timeoutMs,  int connectTimeoutMs,  int readTimeoutMs,  int writeTimeoutMs,  int maxRedirects,  bool followRedirects,  CacheStrategy defaultCacheStrategy,  int cacheTtlMs,  int maxCacheSize,  Map<String, String> defaultHeaders,  String? basePath,  String? apiVersion,  RateLimitConfig? rateLimit,  RetryConfig? retryConfig,  bool validateSsl,  bool persistCookies,  bool supportsBackground,  bool isCritical,  Map<String, dynamic> customConfig,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _ServiceConfig() when $default != null:
return $default(_that.serviceId,_that.displayName,_that.baseUrl,_that.authType,_that.timeoutMs,_that.connectTimeoutMs,_that.readTimeoutMs,_that.writeTimeoutMs,_that.maxRedirects,_that.followRedirects,_that.defaultCacheStrategy,_that.cacheTtlMs,_that.maxCacheSize,_that.defaultHeaders,_that.basePath,_that.apiVersion,_that.rateLimit,_that.retryConfig,_that.validateSsl,_that.persistCookies,_that.supportsBackground,_that.isCritical,_that.customConfig,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceConfig implements ServiceConfig {
  const _ServiceConfig({required this.serviceId, required this.displayName, required this.baseUrl, this.authType = AuthType.none, this.timeoutMs = 30000, this.connectTimeoutMs = 10000, this.readTimeoutMs = 30000, this.writeTimeoutMs = 30000, this.maxRedirects = 5, this.followRedirects = true, this.defaultCacheStrategy = CacheStrategy.networkFirst, this.cacheTtlMs = 300000, this.maxCacheSize = 10485760, final  Map<String, String> defaultHeaders = const {}, this.basePath, this.apiVersion, this.rateLimit, this.retryConfig, this.validateSsl = true, this.persistCookies = true, this.supportsBackground = true, this.isCritical = false, final  Map<String, dynamic> customConfig = const {}, final  Map<String, dynamic> metadata = const {}}): _defaultHeaders = defaultHeaders,_customConfig = customConfig,_metadata = metadata;
  factory _ServiceConfig.fromJson(Map<String, dynamic> json) => _$ServiceConfigFromJson(json);

/// Service identifier
@override final  String serviceId;
/// Display name for the service
@override final  String displayName;
/// Base URL for the service
@override final  String baseUrl;
/// Authentication type
@override@JsonKey() final  AuthType authType;
/// Default timeout in milliseconds
@override@JsonKey() final  int timeoutMs;
/// Connection timeout in milliseconds
@override@JsonKey() final  int connectTimeoutMs;
/// Read timeout in milliseconds
@override@JsonKey() final  int readTimeoutMs;
/// Write timeout in milliseconds
@override@JsonKey() final  int writeTimeoutMs;
/// Maximum number of redirects to follow
@override@JsonKey() final  int maxRedirects;
/// Whether to follow redirects
@override@JsonKey() final  bool followRedirects;
/// Default cache strategy for this service
@override@JsonKey() final  CacheStrategy defaultCacheStrategy;
/// Cache TTL in milliseconds
@override@JsonKey() final  int cacheTtlMs;
// 5 minutes default
/// Maximum cache size for this service in bytes
@override@JsonKey() final  int maxCacheSize;
// 10MB default
/// Default headers for all requests to this service
 final  Map<String, String> _defaultHeaders;
// 10MB default
/// Default headers for all requests to this service
@override@JsonKey() Map<String, String> get defaultHeaders {
  if (_defaultHeaders is EqualUnmodifiableMapView) return _defaultHeaders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_defaultHeaders);
}

/// Base path to append to baseUrl for all requests
@override final  String? basePath;
/// API version (for versioned APIs)
@override final  String? apiVersion;
/// Rate limit configuration
@override final  RateLimitConfig? rateLimit;
/// Retry configuration
@override final  RetryConfig? retryConfig;
/// Whether to validate SSL certificates
@override@JsonKey() final  bool validateSsl;
/// Whether to persist cookies
@override@JsonKey() final  bool persistCookies;
/// Whether this service supports background operations
@override@JsonKey() final  bool supportsBackground;
/// Whether requests to this service are critical
@override@JsonKey() final  bool isCritical;
/// Custom configuration for the service
 final  Map<String, dynamic> _customConfig;
/// Custom configuration for the service
@override@JsonKey() Map<String, dynamic> get customConfig {
  if (_customConfig is EqualUnmodifiableMapView) return _customConfig;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_customConfig);
}

/// Additional metadata
 final  Map<String, dynamic> _metadata;
/// Additional metadata
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of ServiceConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceConfigCopyWith<_ServiceConfig> get copyWith => __$ServiceConfigCopyWithImpl<_ServiceConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceConfig&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.authType, authType) || other.authType == authType)&&(identical(other.timeoutMs, timeoutMs) || other.timeoutMs == timeoutMs)&&(identical(other.connectTimeoutMs, connectTimeoutMs) || other.connectTimeoutMs == connectTimeoutMs)&&(identical(other.readTimeoutMs, readTimeoutMs) || other.readTimeoutMs == readTimeoutMs)&&(identical(other.writeTimeoutMs, writeTimeoutMs) || other.writeTimeoutMs == writeTimeoutMs)&&(identical(other.maxRedirects, maxRedirects) || other.maxRedirects == maxRedirects)&&(identical(other.followRedirects, followRedirects) || other.followRedirects == followRedirects)&&(identical(other.defaultCacheStrategy, defaultCacheStrategy) || other.defaultCacheStrategy == defaultCacheStrategy)&&(identical(other.cacheTtlMs, cacheTtlMs) || other.cacheTtlMs == cacheTtlMs)&&(identical(other.maxCacheSize, maxCacheSize) || other.maxCacheSize == maxCacheSize)&&const DeepCollectionEquality().equals(other._defaultHeaders, _defaultHeaders)&&(identical(other.basePath, basePath) || other.basePath == basePath)&&(identical(other.apiVersion, apiVersion) || other.apiVersion == apiVersion)&&(identical(other.rateLimit, rateLimit) || other.rateLimit == rateLimit)&&(identical(other.retryConfig, retryConfig) || other.retryConfig == retryConfig)&&(identical(other.validateSsl, validateSsl) || other.validateSsl == validateSsl)&&(identical(other.persistCookies, persistCookies) || other.persistCookies == persistCookies)&&(identical(other.supportsBackground, supportsBackground) || other.supportsBackground == supportsBackground)&&(identical(other.isCritical, isCritical) || other.isCritical == isCritical)&&const DeepCollectionEquality().equals(other._customConfig, _customConfig)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,serviceId,displayName,baseUrl,authType,timeoutMs,connectTimeoutMs,readTimeoutMs,writeTimeoutMs,maxRedirects,followRedirects,defaultCacheStrategy,cacheTtlMs,maxCacheSize,const DeepCollectionEquality().hash(_defaultHeaders),basePath,apiVersion,rateLimit,retryConfig,validateSsl,persistCookies,supportsBackground,isCritical,const DeepCollectionEquality().hash(_customConfig),const DeepCollectionEquality().hash(_metadata)]);

@override
String toString() {
  return 'ServiceConfig(serviceId: $serviceId, displayName: $displayName, baseUrl: $baseUrl, authType: $authType, timeoutMs: $timeoutMs, connectTimeoutMs: $connectTimeoutMs, readTimeoutMs: $readTimeoutMs, writeTimeoutMs: $writeTimeoutMs, maxRedirects: $maxRedirects, followRedirects: $followRedirects, defaultCacheStrategy: $defaultCacheStrategy, cacheTtlMs: $cacheTtlMs, maxCacheSize: $maxCacheSize, defaultHeaders: $defaultHeaders, basePath: $basePath, apiVersion: $apiVersion, rateLimit: $rateLimit, retryConfig: $retryConfig, validateSsl: $validateSsl, persistCookies: $persistCookies, supportsBackground: $supportsBackground, isCritical: $isCritical, customConfig: $customConfig, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$ServiceConfigCopyWith<$Res> implements $ServiceConfigCopyWith<$Res> {
  factory _$ServiceConfigCopyWith(_ServiceConfig value, $Res Function(_ServiceConfig) _then) = __$ServiceConfigCopyWithImpl;
@override @useResult
$Res call({
 String serviceId, String displayName, String baseUrl, AuthType authType, int timeoutMs, int connectTimeoutMs, int readTimeoutMs, int writeTimeoutMs, int maxRedirects, bool followRedirects, CacheStrategy defaultCacheStrategy, int cacheTtlMs, int maxCacheSize, Map<String, String> defaultHeaders, String? basePath, String? apiVersion, RateLimitConfig? rateLimit, RetryConfig? retryConfig, bool validateSsl, bool persistCookies, bool supportsBackground, bool isCritical, Map<String, dynamic> customConfig, Map<String, dynamic> metadata
});


@override $RateLimitConfigCopyWith<$Res>? get rateLimit;@override $RetryConfigCopyWith<$Res>? get retryConfig;

}
/// @nodoc
class __$ServiceConfigCopyWithImpl<$Res>
    implements _$ServiceConfigCopyWith<$Res> {
  __$ServiceConfigCopyWithImpl(this._self, this._then);

  final _ServiceConfig _self;
  final $Res Function(_ServiceConfig) _then;

/// Create a copy of ServiceConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serviceId = null,Object? displayName = null,Object? baseUrl = null,Object? authType = null,Object? timeoutMs = null,Object? connectTimeoutMs = null,Object? readTimeoutMs = null,Object? writeTimeoutMs = null,Object? maxRedirects = null,Object? followRedirects = null,Object? defaultCacheStrategy = null,Object? cacheTtlMs = null,Object? maxCacheSize = null,Object? defaultHeaders = null,Object? basePath = freezed,Object? apiVersion = freezed,Object? rateLimit = freezed,Object? retryConfig = freezed,Object? validateSsl = null,Object? persistCookies = null,Object? supportsBackground = null,Object? isCritical = null,Object? customConfig = null,Object? metadata = null,}) {
  return _then(_ServiceConfig(
serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,authType: null == authType ? _self.authType : authType // ignore: cast_nullable_to_non_nullable
as AuthType,timeoutMs: null == timeoutMs ? _self.timeoutMs : timeoutMs // ignore: cast_nullable_to_non_nullable
as int,connectTimeoutMs: null == connectTimeoutMs ? _self.connectTimeoutMs : connectTimeoutMs // ignore: cast_nullable_to_non_nullable
as int,readTimeoutMs: null == readTimeoutMs ? _self.readTimeoutMs : readTimeoutMs // ignore: cast_nullable_to_non_nullable
as int,writeTimeoutMs: null == writeTimeoutMs ? _self.writeTimeoutMs : writeTimeoutMs // ignore: cast_nullable_to_non_nullable
as int,maxRedirects: null == maxRedirects ? _self.maxRedirects : maxRedirects // ignore: cast_nullable_to_non_nullable
as int,followRedirects: null == followRedirects ? _self.followRedirects : followRedirects // ignore: cast_nullable_to_non_nullable
as bool,defaultCacheStrategy: null == defaultCacheStrategy ? _self.defaultCacheStrategy : defaultCacheStrategy // ignore: cast_nullable_to_non_nullable
as CacheStrategy,cacheTtlMs: null == cacheTtlMs ? _self.cacheTtlMs : cacheTtlMs // ignore: cast_nullable_to_non_nullable
as int,maxCacheSize: null == maxCacheSize ? _self.maxCacheSize : maxCacheSize // ignore: cast_nullable_to_non_nullable
as int,defaultHeaders: null == defaultHeaders ? _self._defaultHeaders : defaultHeaders // ignore: cast_nullable_to_non_nullable
as Map<String, String>,basePath: freezed == basePath ? _self.basePath : basePath // ignore: cast_nullable_to_non_nullable
as String?,apiVersion: freezed == apiVersion ? _self.apiVersion : apiVersion // ignore: cast_nullable_to_non_nullable
as String?,rateLimit: freezed == rateLimit ? _self.rateLimit : rateLimit // ignore: cast_nullable_to_non_nullable
as RateLimitConfig?,retryConfig: freezed == retryConfig ? _self.retryConfig : retryConfig // ignore: cast_nullable_to_non_nullable
as RetryConfig?,validateSsl: null == validateSsl ? _self.validateSsl : validateSsl // ignore: cast_nullable_to_non_nullable
as bool,persistCookies: null == persistCookies ? _self.persistCookies : persistCookies // ignore: cast_nullable_to_non_nullable
as bool,supportsBackground: null == supportsBackground ? _self.supportsBackground : supportsBackground // ignore: cast_nullable_to_non_nullable
as bool,isCritical: null == isCritical ? _self.isCritical : isCritical // ignore: cast_nullable_to_non_nullable
as bool,customConfig: null == customConfig ? _self._customConfig : customConfig // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of ServiceConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RateLimitConfigCopyWith<$Res>? get rateLimit {
    if (_self.rateLimit == null) {
    return null;
  }

  return $RateLimitConfigCopyWith<$Res>(_self.rateLimit!, (value) {
    return _then(_self.copyWith(rateLimit: value));
  });
}/// Create a copy of ServiceConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RetryConfigCopyWith<$Res>? get retryConfig {
    if (_self.retryConfig == null) {
    return null;
  }

  return $RetryConfigCopyWith<$Res>(_self.retryConfig!, (value) {
    return _then(_self.copyWith(retryConfig: value));
  });
}
}


/// @nodoc
mixin _$RateLimitConfig {

/// Maximum requests per window
 int get maxRequests;/// Time window in milliseconds
 int get windowMs;/// Whether to queue requests when rate limited
 bool get queueRequests;/// Maximum queue size
 int get maxQueueSize;/// Delay between retries when rate limited in milliseconds
 int get retryDelayMs;
/// Create a copy of RateLimitConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RateLimitConfigCopyWith<RateLimitConfig> get copyWith => _$RateLimitConfigCopyWithImpl<RateLimitConfig>(this as RateLimitConfig, _$identity);

  /// Serializes this RateLimitConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateLimitConfig&&(identical(other.maxRequests, maxRequests) || other.maxRequests == maxRequests)&&(identical(other.windowMs, windowMs) || other.windowMs == windowMs)&&(identical(other.queueRequests, queueRequests) || other.queueRequests == queueRequests)&&(identical(other.maxQueueSize, maxQueueSize) || other.maxQueueSize == maxQueueSize)&&(identical(other.retryDelayMs, retryDelayMs) || other.retryDelayMs == retryDelayMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxRequests,windowMs,queueRequests,maxQueueSize,retryDelayMs);

@override
String toString() {
  return 'RateLimitConfig(maxRequests: $maxRequests, windowMs: $windowMs, queueRequests: $queueRequests, maxQueueSize: $maxQueueSize, retryDelayMs: $retryDelayMs)';
}


}

/// @nodoc
abstract mixin class $RateLimitConfigCopyWith<$Res>  {
  factory $RateLimitConfigCopyWith(RateLimitConfig value, $Res Function(RateLimitConfig) _then) = _$RateLimitConfigCopyWithImpl;
@useResult
$Res call({
 int maxRequests, int windowMs, bool queueRequests, int maxQueueSize, int retryDelayMs
});




}
/// @nodoc
class _$RateLimitConfigCopyWithImpl<$Res>
    implements $RateLimitConfigCopyWith<$Res> {
  _$RateLimitConfigCopyWithImpl(this._self, this._then);

  final RateLimitConfig _self;
  final $Res Function(RateLimitConfig) _then;

/// Create a copy of RateLimitConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxRequests = null,Object? windowMs = null,Object? queueRequests = null,Object? maxQueueSize = null,Object? retryDelayMs = null,}) {
  return _then(_self.copyWith(
maxRequests: null == maxRequests ? _self.maxRequests : maxRequests // ignore: cast_nullable_to_non_nullable
as int,windowMs: null == windowMs ? _self.windowMs : windowMs // ignore: cast_nullable_to_non_nullable
as int,queueRequests: null == queueRequests ? _self.queueRequests : queueRequests // ignore: cast_nullable_to_non_nullable
as bool,maxQueueSize: null == maxQueueSize ? _self.maxQueueSize : maxQueueSize // ignore: cast_nullable_to_non_nullable
as int,retryDelayMs: null == retryDelayMs ? _self.retryDelayMs : retryDelayMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RateLimitConfig].
extension RateLimitConfigPatterns on RateLimitConfig {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RateLimitConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RateLimitConfig() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RateLimitConfig value)  $default,){
final _that = this;
switch (_that) {
case _RateLimitConfig():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RateLimitConfig value)?  $default,){
final _that = this;
switch (_that) {
case _RateLimitConfig() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int maxRequests,  int windowMs,  bool queueRequests,  int maxQueueSize,  int retryDelayMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RateLimitConfig() when $default != null:
return $default(_that.maxRequests,_that.windowMs,_that.queueRequests,_that.maxQueueSize,_that.retryDelayMs);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int maxRequests,  int windowMs,  bool queueRequests,  int maxQueueSize,  int retryDelayMs)  $default,) {final _that = this;
switch (_that) {
case _RateLimitConfig():
return $default(_that.maxRequests,_that.windowMs,_that.queueRequests,_that.maxQueueSize,_that.retryDelayMs);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int maxRequests,  int windowMs,  bool queueRequests,  int maxQueueSize,  int retryDelayMs)?  $default,) {final _that = this;
switch (_that) {
case _RateLimitConfig() when $default != null:
return $default(_that.maxRequests,_that.windowMs,_that.queueRequests,_that.maxQueueSize,_that.retryDelayMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RateLimitConfig implements RateLimitConfig {
  const _RateLimitConfig({required this.maxRequests, required this.windowMs, this.queueRequests = true, this.maxQueueSize = 100, this.retryDelayMs = 1000});
  factory _RateLimitConfig.fromJson(Map<String, dynamic> json) => _$RateLimitConfigFromJson(json);

/// Maximum requests per window
@override final  int maxRequests;
/// Time window in milliseconds
@override final  int windowMs;
/// Whether to queue requests when rate limited
@override@JsonKey() final  bool queueRequests;
/// Maximum queue size
@override@JsonKey() final  int maxQueueSize;
/// Delay between retries when rate limited in milliseconds
@override@JsonKey() final  int retryDelayMs;

/// Create a copy of RateLimitConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RateLimitConfigCopyWith<_RateLimitConfig> get copyWith => __$RateLimitConfigCopyWithImpl<_RateLimitConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RateLimitConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RateLimitConfig&&(identical(other.maxRequests, maxRequests) || other.maxRequests == maxRequests)&&(identical(other.windowMs, windowMs) || other.windowMs == windowMs)&&(identical(other.queueRequests, queueRequests) || other.queueRequests == queueRequests)&&(identical(other.maxQueueSize, maxQueueSize) || other.maxQueueSize == maxQueueSize)&&(identical(other.retryDelayMs, retryDelayMs) || other.retryDelayMs == retryDelayMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxRequests,windowMs,queueRequests,maxQueueSize,retryDelayMs);

@override
String toString() {
  return 'RateLimitConfig(maxRequests: $maxRequests, windowMs: $windowMs, queueRequests: $queueRequests, maxQueueSize: $maxQueueSize, retryDelayMs: $retryDelayMs)';
}


}

/// @nodoc
abstract mixin class _$RateLimitConfigCopyWith<$Res> implements $RateLimitConfigCopyWith<$Res> {
  factory _$RateLimitConfigCopyWith(_RateLimitConfig value, $Res Function(_RateLimitConfig) _then) = __$RateLimitConfigCopyWithImpl;
@override @useResult
$Res call({
 int maxRequests, int windowMs, bool queueRequests, int maxQueueSize, int retryDelayMs
});




}
/// @nodoc
class __$RateLimitConfigCopyWithImpl<$Res>
    implements _$RateLimitConfigCopyWith<$Res> {
  __$RateLimitConfigCopyWithImpl(this._self, this._then);

  final _RateLimitConfig _self;
  final $Res Function(_RateLimitConfig) _then;

/// Create a copy of RateLimitConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxRequests = null,Object? windowMs = null,Object? queueRequests = null,Object? maxQueueSize = null,Object? retryDelayMs = null,}) {
  return _then(_RateLimitConfig(
maxRequests: null == maxRequests ? _self.maxRequests : maxRequests // ignore: cast_nullable_to_non_nullable
as int,windowMs: null == windowMs ? _self.windowMs : windowMs // ignore: cast_nullable_to_non_nullable
as int,queueRequests: null == queueRequests ? _self.queueRequests : queueRequests // ignore: cast_nullable_to_non_nullable
as bool,maxQueueSize: null == maxQueueSize ? _self.maxQueueSize : maxQueueSize // ignore: cast_nullable_to_non_nullable
as int,retryDelayMs: null == retryDelayMs ? _self.retryDelayMs : retryDelayMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RetryConfig {

/// Maximum number of retries
 int get maxRetries;/// Base delay between retries in milliseconds
 int get baseDelayMs;/// Maximum delay between retries in milliseconds
 int get maxDelayMs;/// Exponential backoff multiplier
 double get backoffMultiplier;/// Whether to add jitter to retry delays
 bool get enableJitter;/// HTTP status codes that should trigger retries
 List<int> get retryableStatusCodes;/// Whether to retry on network errors
 bool get retryOnNetworkError;/// Whether to retry on timeout
 bool get retryOnTimeout;
/// Create a copy of RetryConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RetryConfigCopyWith<RetryConfig> get copyWith => _$RetryConfigCopyWithImpl<RetryConfig>(this as RetryConfig, _$identity);

  /// Serializes this RetryConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RetryConfig&&(identical(other.maxRetries, maxRetries) || other.maxRetries == maxRetries)&&(identical(other.baseDelayMs, baseDelayMs) || other.baseDelayMs == baseDelayMs)&&(identical(other.maxDelayMs, maxDelayMs) || other.maxDelayMs == maxDelayMs)&&(identical(other.backoffMultiplier, backoffMultiplier) || other.backoffMultiplier == backoffMultiplier)&&(identical(other.enableJitter, enableJitter) || other.enableJitter == enableJitter)&&const DeepCollectionEquality().equals(other.retryableStatusCodes, retryableStatusCodes)&&(identical(other.retryOnNetworkError, retryOnNetworkError) || other.retryOnNetworkError == retryOnNetworkError)&&(identical(other.retryOnTimeout, retryOnTimeout) || other.retryOnTimeout == retryOnTimeout));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxRetries,baseDelayMs,maxDelayMs,backoffMultiplier,enableJitter,const DeepCollectionEquality().hash(retryableStatusCodes),retryOnNetworkError,retryOnTimeout);

@override
String toString() {
  return 'RetryConfig(maxRetries: $maxRetries, baseDelayMs: $baseDelayMs, maxDelayMs: $maxDelayMs, backoffMultiplier: $backoffMultiplier, enableJitter: $enableJitter, retryableStatusCodes: $retryableStatusCodes, retryOnNetworkError: $retryOnNetworkError, retryOnTimeout: $retryOnTimeout)';
}


}

/// @nodoc
abstract mixin class $RetryConfigCopyWith<$Res>  {
  factory $RetryConfigCopyWith(RetryConfig value, $Res Function(RetryConfig) _then) = _$RetryConfigCopyWithImpl;
@useResult
$Res call({
 int maxRetries, int baseDelayMs, int maxDelayMs, double backoffMultiplier, bool enableJitter, List<int> retryableStatusCodes, bool retryOnNetworkError, bool retryOnTimeout
});




}
/// @nodoc
class _$RetryConfigCopyWithImpl<$Res>
    implements $RetryConfigCopyWith<$Res> {
  _$RetryConfigCopyWithImpl(this._self, this._then);

  final RetryConfig _self;
  final $Res Function(RetryConfig) _then;

/// Create a copy of RetryConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxRetries = null,Object? baseDelayMs = null,Object? maxDelayMs = null,Object? backoffMultiplier = null,Object? enableJitter = null,Object? retryableStatusCodes = null,Object? retryOnNetworkError = null,Object? retryOnTimeout = null,}) {
  return _then(_self.copyWith(
maxRetries: null == maxRetries ? _self.maxRetries : maxRetries // ignore: cast_nullable_to_non_nullable
as int,baseDelayMs: null == baseDelayMs ? _self.baseDelayMs : baseDelayMs // ignore: cast_nullable_to_non_nullable
as int,maxDelayMs: null == maxDelayMs ? _self.maxDelayMs : maxDelayMs // ignore: cast_nullable_to_non_nullable
as int,backoffMultiplier: null == backoffMultiplier ? _self.backoffMultiplier : backoffMultiplier // ignore: cast_nullable_to_non_nullable
as double,enableJitter: null == enableJitter ? _self.enableJitter : enableJitter // ignore: cast_nullable_to_non_nullable
as bool,retryableStatusCodes: null == retryableStatusCodes ? _self.retryableStatusCodes : retryableStatusCodes // ignore: cast_nullable_to_non_nullable
as List<int>,retryOnNetworkError: null == retryOnNetworkError ? _self.retryOnNetworkError : retryOnNetworkError // ignore: cast_nullable_to_non_nullable
as bool,retryOnTimeout: null == retryOnTimeout ? _self.retryOnTimeout : retryOnTimeout // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RetryConfig].
extension RetryConfigPatterns on RetryConfig {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RetryConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RetryConfig() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RetryConfig value)  $default,){
final _that = this;
switch (_that) {
case _RetryConfig():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RetryConfig value)?  $default,){
final _that = this;
switch (_that) {
case _RetryConfig() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int maxRetries,  int baseDelayMs,  int maxDelayMs,  double backoffMultiplier,  bool enableJitter,  List<int> retryableStatusCodes,  bool retryOnNetworkError,  bool retryOnTimeout)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RetryConfig() when $default != null:
return $default(_that.maxRetries,_that.baseDelayMs,_that.maxDelayMs,_that.backoffMultiplier,_that.enableJitter,_that.retryableStatusCodes,_that.retryOnNetworkError,_that.retryOnTimeout);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int maxRetries,  int baseDelayMs,  int maxDelayMs,  double backoffMultiplier,  bool enableJitter,  List<int> retryableStatusCodes,  bool retryOnNetworkError,  bool retryOnTimeout)  $default,) {final _that = this;
switch (_that) {
case _RetryConfig():
return $default(_that.maxRetries,_that.baseDelayMs,_that.maxDelayMs,_that.backoffMultiplier,_that.enableJitter,_that.retryableStatusCodes,_that.retryOnNetworkError,_that.retryOnTimeout);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int maxRetries,  int baseDelayMs,  int maxDelayMs,  double backoffMultiplier,  bool enableJitter,  List<int> retryableStatusCodes,  bool retryOnNetworkError,  bool retryOnTimeout)?  $default,) {final _that = this;
switch (_that) {
case _RetryConfig() when $default != null:
return $default(_that.maxRetries,_that.baseDelayMs,_that.maxDelayMs,_that.backoffMultiplier,_that.enableJitter,_that.retryableStatusCodes,_that.retryOnNetworkError,_that.retryOnTimeout);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RetryConfig implements RetryConfig {
  const _RetryConfig({this.maxRetries = 3, this.baseDelayMs = 1000, this.maxDelayMs = 30000, this.backoffMultiplier = 2.0, this.enableJitter = true, final  List<int> retryableStatusCodes = const [408, 429, 500, 502, 503, 504], this.retryOnNetworkError = true, this.retryOnTimeout = true}): _retryableStatusCodes = retryableStatusCodes;
  factory _RetryConfig.fromJson(Map<String, dynamic> json) => _$RetryConfigFromJson(json);

/// Maximum number of retries
@override@JsonKey() final  int maxRetries;
/// Base delay between retries in milliseconds
@override@JsonKey() final  int baseDelayMs;
/// Maximum delay between retries in milliseconds
@override@JsonKey() final  int maxDelayMs;
/// Exponential backoff multiplier
@override@JsonKey() final  double backoffMultiplier;
/// Whether to add jitter to retry delays
@override@JsonKey() final  bool enableJitter;
/// HTTP status codes that should trigger retries
 final  List<int> _retryableStatusCodes;
/// HTTP status codes that should trigger retries
@override@JsonKey() List<int> get retryableStatusCodes {
  if (_retryableStatusCodes is EqualUnmodifiableListView) return _retryableStatusCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_retryableStatusCodes);
}

/// Whether to retry on network errors
@override@JsonKey() final  bool retryOnNetworkError;
/// Whether to retry on timeout
@override@JsonKey() final  bool retryOnTimeout;

/// Create a copy of RetryConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RetryConfigCopyWith<_RetryConfig> get copyWith => __$RetryConfigCopyWithImpl<_RetryConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RetryConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetryConfig&&(identical(other.maxRetries, maxRetries) || other.maxRetries == maxRetries)&&(identical(other.baseDelayMs, baseDelayMs) || other.baseDelayMs == baseDelayMs)&&(identical(other.maxDelayMs, maxDelayMs) || other.maxDelayMs == maxDelayMs)&&(identical(other.backoffMultiplier, backoffMultiplier) || other.backoffMultiplier == backoffMultiplier)&&(identical(other.enableJitter, enableJitter) || other.enableJitter == enableJitter)&&const DeepCollectionEquality().equals(other._retryableStatusCodes, _retryableStatusCodes)&&(identical(other.retryOnNetworkError, retryOnNetworkError) || other.retryOnNetworkError == retryOnNetworkError)&&(identical(other.retryOnTimeout, retryOnTimeout) || other.retryOnTimeout == retryOnTimeout));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxRetries,baseDelayMs,maxDelayMs,backoffMultiplier,enableJitter,const DeepCollectionEquality().hash(_retryableStatusCodes),retryOnNetworkError,retryOnTimeout);

@override
String toString() {
  return 'RetryConfig(maxRetries: $maxRetries, baseDelayMs: $baseDelayMs, maxDelayMs: $maxDelayMs, backoffMultiplier: $backoffMultiplier, enableJitter: $enableJitter, retryableStatusCodes: $retryableStatusCodes, retryOnNetworkError: $retryOnNetworkError, retryOnTimeout: $retryOnTimeout)';
}


}

/// @nodoc
abstract mixin class _$RetryConfigCopyWith<$Res> implements $RetryConfigCopyWith<$Res> {
  factory _$RetryConfigCopyWith(_RetryConfig value, $Res Function(_RetryConfig) _then) = __$RetryConfigCopyWithImpl;
@override @useResult
$Res call({
 int maxRetries, int baseDelayMs, int maxDelayMs, double backoffMultiplier, bool enableJitter, List<int> retryableStatusCodes, bool retryOnNetworkError, bool retryOnTimeout
});




}
/// @nodoc
class __$RetryConfigCopyWithImpl<$Res>
    implements _$RetryConfigCopyWith<$Res> {
  __$RetryConfigCopyWithImpl(this._self, this._then);

  final _RetryConfig _self;
  final $Res Function(_RetryConfig) _then;

/// Create a copy of RetryConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxRetries = null,Object? baseDelayMs = null,Object? maxDelayMs = null,Object? backoffMultiplier = null,Object? enableJitter = null,Object? retryableStatusCodes = null,Object? retryOnNetworkError = null,Object? retryOnTimeout = null,}) {
  return _then(_RetryConfig(
maxRetries: null == maxRetries ? _self.maxRetries : maxRetries // ignore: cast_nullable_to_non_nullable
as int,baseDelayMs: null == baseDelayMs ? _self.baseDelayMs : baseDelayMs // ignore: cast_nullable_to_non_nullable
as int,maxDelayMs: null == maxDelayMs ? _self.maxDelayMs : maxDelayMs // ignore: cast_nullable_to_non_nullable
as int,backoffMultiplier: null == backoffMultiplier ? _self.backoffMultiplier : backoffMultiplier // ignore: cast_nullable_to_non_nullable
as double,enableJitter: null == enableJitter ? _self.enableJitter : enableJitter // ignore: cast_nullable_to_non_nullable
as bool,retryableStatusCodes: null == retryableStatusCodes ? _self._retryableStatusCodes : retryableStatusCodes // ignore: cast_nullable_to_non_nullable
as List<int>,retryOnNetworkError: null == retryOnNetworkError ? _self.retryOnNetworkError : retryOnNetworkError // ignore: cast_nullable_to_non_nullable
as bool,retryOnTimeout: null == retryOnTimeout ? _self.retryOnTimeout : retryOnTimeout // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
