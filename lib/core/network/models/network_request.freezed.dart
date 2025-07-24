// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NetworkRequest {

/// HTTP method
 HttpMethod get method;/// Request URL
 String get url;/// Request headers
 Map<String, String> get headers;/// Query parameters
 Map<String, dynamic> get queryParameters;/// Request body (JSON serializable)
 Object? get data;/// Caching strategy for this request
 CacheStrategy get cacheStrategy;/// Request timeout in milliseconds
 int? get timeoutMs;/// Whether to follow redirects
 bool get followRedirects;/// Maximum number of redirects to follow
 int get maxRedirects;/// Content type for request body
 String? get contentType;/// Whether to validate SSL certificates
 bool get validateStatus;/// Custom tag for request identification/debugging
 String? get tag;/// Additional metadata for the request
 Map<String, dynamic> get metadata;
/// Create a copy of NetworkRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkRequestCopyWith<NetworkRequest> get copyWith => _$NetworkRequestCopyWithImpl<NetworkRequest>(this as NetworkRequest, _$identity);

  /// Serializes this NetworkRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkRequest&&(identical(other.method, method) || other.method == method)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.headers, headers)&&const DeepCollectionEquality().equals(other.queryParameters, queryParameters)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.cacheStrategy, cacheStrategy) || other.cacheStrategy == cacheStrategy)&&(identical(other.timeoutMs, timeoutMs) || other.timeoutMs == timeoutMs)&&(identical(other.followRedirects, followRedirects) || other.followRedirects == followRedirects)&&(identical(other.maxRedirects, maxRedirects) || other.maxRedirects == maxRedirects)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.validateStatus, validateStatus) || other.validateStatus == validateStatus)&&(identical(other.tag, tag) || other.tag == tag)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,method,url,const DeepCollectionEquality().hash(headers),const DeepCollectionEquality().hash(queryParameters),const DeepCollectionEquality().hash(data),cacheStrategy,timeoutMs,followRedirects,maxRedirects,contentType,validateStatus,tag,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'NetworkRequest(method: $method, url: $url, headers: $headers, queryParameters: $queryParameters, data: $data, cacheStrategy: $cacheStrategy, timeoutMs: $timeoutMs, followRedirects: $followRedirects, maxRedirects: $maxRedirects, contentType: $contentType, validateStatus: $validateStatus, tag: $tag, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $NetworkRequestCopyWith<$Res>  {
  factory $NetworkRequestCopyWith(NetworkRequest value, $Res Function(NetworkRequest) _then) = _$NetworkRequestCopyWithImpl;
@useResult
$Res call({
 HttpMethod method, String url, Map<String, String> headers, Map<String, dynamic> queryParameters, Object? data, CacheStrategy cacheStrategy, int? timeoutMs, bool followRedirects, int maxRedirects, String? contentType, bool validateStatus, String? tag, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$NetworkRequestCopyWithImpl<$Res>
    implements $NetworkRequestCopyWith<$Res> {
  _$NetworkRequestCopyWithImpl(this._self, this._then);

  final NetworkRequest _self;
  final $Res Function(NetworkRequest) _then;

/// Create a copy of NetworkRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? method = null,Object? url = null,Object? headers = null,Object? queryParameters = null,Object? data = freezed,Object? cacheStrategy = null,Object? timeoutMs = freezed,Object? followRedirects = null,Object? maxRedirects = null,Object? contentType = freezed,Object? validateStatus = null,Object? tag = freezed,Object? metadata = null,}) {
  return _then(_self.copyWith(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as HttpMethod,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,headers: null == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>,queryParameters: null == queryParameters ? _self.queryParameters : queryParameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,data: freezed == data ? _self.data : data ,cacheStrategy: null == cacheStrategy ? _self.cacheStrategy : cacheStrategy // ignore: cast_nullable_to_non_nullable
as CacheStrategy,timeoutMs: freezed == timeoutMs ? _self.timeoutMs : timeoutMs // ignore: cast_nullable_to_non_nullable
as int?,followRedirects: null == followRedirects ? _self.followRedirects : followRedirects // ignore: cast_nullable_to_non_nullable
as bool,maxRedirects: null == maxRedirects ? _self.maxRedirects : maxRedirects // ignore: cast_nullable_to_non_nullable
as int,contentType: freezed == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String?,validateStatus: null == validateStatus ? _self.validateStatus : validateStatus // ignore: cast_nullable_to_non_nullable
as bool,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [NetworkRequest].
extension NetworkRequestPatterns on NetworkRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NetworkRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NetworkRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NetworkRequest value)  $default,){
final _that = this;
switch (_that) {
case _NetworkRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NetworkRequest value)?  $default,){
final _that = this;
switch (_that) {
case _NetworkRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HttpMethod method,  String url,  Map<String, String> headers,  Map<String, dynamic> queryParameters,  Object? data,  CacheStrategy cacheStrategy,  int? timeoutMs,  bool followRedirects,  int maxRedirects,  String? contentType,  bool validateStatus,  String? tag,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetworkRequest() when $default != null:
return $default(_that.method,_that.url,_that.headers,_that.queryParameters,_that.data,_that.cacheStrategy,_that.timeoutMs,_that.followRedirects,_that.maxRedirects,_that.contentType,_that.validateStatus,_that.tag,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HttpMethod method,  String url,  Map<String, String> headers,  Map<String, dynamic> queryParameters,  Object? data,  CacheStrategy cacheStrategy,  int? timeoutMs,  bool followRedirects,  int maxRedirects,  String? contentType,  bool validateStatus,  String? tag,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _NetworkRequest():
return $default(_that.method,_that.url,_that.headers,_that.queryParameters,_that.data,_that.cacheStrategy,_that.timeoutMs,_that.followRedirects,_that.maxRedirects,_that.contentType,_that.validateStatus,_that.tag,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HttpMethod method,  String url,  Map<String, String> headers,  Map<String, dynamic> queryParameters,  Object? data,  CacheStrategy cacheStrategy,  int? timeoutMs,  bool followRedirects,  int maxRedirects,  String? contentType,  bool validateStatus,  String? tag,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _NetworkRequest() when $default != null:
return $default(_that.method,_that.url,_that.headers,_that.queryParameters,_that.data,_that.cacheStrategy,_that.timeoutMs,_that.followRedirects,_that.maxRedirects,_that.contentType,_that.validateStatus,_that.tag,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NetworkRequest implements NetworkRequest {
  const _NetworkRequest({required this.method, required this.url, final  Map<String, String> headers = const {}, final  Map<String, dynamic> queryParameters = const {}, this.data, this.cacheStrategy = CacheStrategy.networkFirst, this.timeoutMs, this.followRedirects = true, this.maxRedirects = 5, this.contentType, this.validateStatus = true, this.tag, final  Map<String, dynamic> metadata = const {}}): _headers = headers,_queryParameters = queryParameters,_metadata = metadata;
  factory _NetworkRequest.fromJson(Map<String, dynamic> json) => _$NetworkRequestFromJson(json);

/// HTTP method
@override final  HttpMethod method;
/// Request URL
@override final  String url;
/// Request headers
 final  Map<String, String> _headers;
/// Request headers
@override@JsonKey() Map<String, String> get headers {
  if (_headers is EqualUnmodifiableMapView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_headers);
}

/// Query parameters
 final  Map<String, dynamic> _queryParameters;
/// Query parameters
@override@JsonKey() Map<String, dynamic> get queryParameters {
  if (_queryParameters is EqualUnmodifiableMapView) return _queryParameters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_queryParameters);
}

/// Request body (JSON serializable)
@override final  Object? data;
/// Caching strategy for this request
@override@JsonKey() final  CacheStrategy cacheStrategy;
/// Request timeout in milliseconds
@override final  int? timeoutMs;
/// Whether to follow redirects
@override@JsonKey() final  bool followRedirects;
/// Maximum number of redirects to follow
@override@JsonKey() final  int maxRedirects;
/// Content type for request body
@override final  String? contentType;
/// Whether to validate SSL certificates
@override@JsonKey() final  bool validateStatus;
/// Custom tag for request identification/debugging
@override final  String? tag;
/// Additional metadata for the request
 final  Map<String, dynamic> _metadata;
/// Additional metadata for the request
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of NetworkRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkRequestCopyWith<_NetworkRequest> get copyWith => __$NetworkRequestCopyWithImpl<_NetworkRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NetworkRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkRequest&&(identical(other.method, method) || other.method == method)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._headers, _headers)&&const DeepCollectionEquality().equals(other._queryParameters, _queryParameters)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.cacheStrategy, cacheStrategy) || other.cacheStrategy == cacheStrategy)&&(identical(other.timeoutMs, timeoutMs) || other.timeoutMs == timeoutMs)&&(identical(other.followRedirects, followRedirects) || other.followRedirects == followRedirects)&&(identical(other.maxRedirects, maxRedirects) || other.maxRedirects == maxRedirects)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.validateStatus, validateStatus) || other.validateStatus == validateStatus)&&(identical(other.tag, tag) || other.tag == tag)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,method,url,const DeepCollectionEquality().hash(_headers),const DeepCollectionEquality().hash(_queryParameters),const DeepCollectionEquality().hash(data),cacheStrategy,timeoutMs,followRedirects,maxRedirects,contentType,validateStatus,tag,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'NetworkRequest(method: $method, url: $url, headers: $headers, queryParameters: $queryParameters, data: $data, cacheStrategy: $cacheStrategy, timeoutMs: $timeoutMs, followRedirects: $followRedirects, maxRedirects: $maxRedirects, contentType: $contentType, validateStatus: $validateStatus, tag: $tag, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$NetworkRequestCopyWith<$Res> implements $NetworkRequestCopyWith<$Res> {
  factory _$NetworkRequestCopyWith(_NetworkRequest value, $Res Function(_NetworkRequest) _then) = __$NetworkRequestCopyWithImpl;
@override @useResult
$Res call({
 HttpMethod method, String url, Map<String, String> headers, Map<String, dynamic> queryParameters, Object? data, CacheStrategy cacheStrategy, int? timeoutMs, bool followRedirects, int maxRedirects, String? contentType, bool validateStatus, String? tag, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$NetworkRequestCopyWithImpl<$Res>
    implements _$NetworkRequestCopyWith<$Res> {
  __$NetworkRequestCopyWithImpl(this._self, this._then);

  final _NetworkRequest _self;
  final $Res Function(_NetworkRequest) _then;

/// Create a copy of NetworkRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? method = null,Object? url = null,Object? headers = null,Object? queryParameters = null,Object? data = freezed,Object? cacheStrategy = null,Object? timeoutMs = freezed,Object? followRedirects = null,Object? maxRedirects = null,Object? contentType = freezed,Object? validateStatus = null,Object? tag = freezed,Object? metadata = null,}) {
  return _then(_NetworkRequest(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as HttpMethod,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,headers: null == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>,queryParameters: null == queryParameters ? _self._queryParameters : queryParameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,data: freezed == data ? _self.data : data ,cacheStrategy: null == cacheStrategy ? _self.cacheStrategy : cacheStrategy // ignore: cast_nullable_to_non_nullable
as CacheStrategy,timeoutMs: freezed == timeoutMs ? _self.timeoutMs : timeoutMs // ignore: cast_nullable_to_non_nullable
as int?,followRedirects: null == followRedirects ? _self.followRedirects : followRedirects // ignore: cast_nullable_to_non_nullable
as bool,maxRedirects: null == maxRedirects ? _self.maxRedirects : maxRedirects // ignore: cast_nullable_to_non_nullable
as int,contentType: freezed == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String?,validateStatus: null == validateStatus ? _self.validateStatus : validateStatus // ignore: cast_nullable_to_non_nullable
as bool,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
