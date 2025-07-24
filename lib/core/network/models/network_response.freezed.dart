// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NetworkResponse<T> {

/// HTTP status code
 int get statusCode;/// Response body data
 T? get data;/// Response headers
 Map<String, List<String>> get headers;/// Content type from response headers
 String? get contentType;/// Response timestamp
 DateTime get timestamp;/// Whether the response came from cache
 bool get fromCache;/// Cache age in milliseconds (if from cache)
 int? get cacheAge;/// Original request URL
 String? get requestUrl;/// Response time in milliseconds
 int? get responseTimeMs;/// Additional metadata
 Map<String, dynamic> get metadata;
/// Create a copy of NetworkResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkResponseCopyWith<T, NetworkResponse<T>> get copyWith => _$NetworkResponseCopyWithImpl<T, NetworkResponse<T>>(this as NetworkResponse<T>, _$identity);

  /// Serializes this NetworkResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkResponse<T>&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&const DeepCollectionEquality().equals(other.data, data)&&const DeepCollectionEquality().equals(other.headers, headers)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.fromCache, fromCache) || other.fromCache == fromCache)&&(identical(other.cacheAge, cacheAge) || other.cacheAge == cacheAge)&&(identical(other.requestUrl, requestUrl) || other.requestUrl == requestUrl)&&(identical(other.responseTimeMs, responseTimeMs) || other.responseTimeMs == responseTimeMs)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusCode,const DeepCollectionEquality().hash(data),const DeepCollectionEquality().hash(headers),contentType,timestamp,fromCache,cacheAge,requestUrl,responseTimeMs,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'NetworkResponse<$T>(statusCode: $statusCode, data: $data, headers: $headers, contentType: $contentType, timestamp: $timestamp, fromCache: $fromCache, cacheAge: $cacheAge, requestUrl: $requestUrl, responseTimeMs: $responseTimeMs, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $NetworkResponseCopyWith<T,$Res>  {
  factory $NetworkResponseCopyWith(NetworkResponse<T> value, $Res Function(NetworkResponse<T>) _then) = _$NetworkResponseCopyWithImpl;
@useResult
$Res call({
 int statusCode, T? data, Map<String, List<String>> headers, String? contentType, DateTime timestamp, bool fromCache, int? cacheAge, String? requestUrl, int? responseTimeMs, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$NetworkResponseCopyWithImpl<T,$Res>
    implements $NetworkResponseCopyWith<T, $Res> {
  _$NetworkResponseCopyWithImpl(this._self, this._then);

  final NetworkResponse<T> _self;
  final $Res Function(NetworkResponse<T>) _then;

/// Create a copy of NetworkResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statusCode = null,Object? data = freezed,Object? headers = null,Object? contentType = freezed,Object? timestamp = null,Object? fromCache = null,Object? cacheAge = freezed,Object? requestUrl = freezed,Object? responseTimeMs = freezed,Object? metadata = null,}) {
  return _then(_self.copyWith(
statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,headers: null == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,contentType: freezed == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,fromCache: null == fromCache ? _self.fromCache : fromCache // ignore: cast_nullable_to_non_nullable
as bool,cacheAge: freezed == cacheAge ? _self.cacheAge : cacheAge // ignore: cast_nullable_to_non_nullable
as int?,requestUrl: freezed == requestUrl ? _self.requestUrl : requestUrl // ignore: cast_nullable_to_non_nullable
as String?,responseTimeMs: freezed == responseTimeMs ? _self.responseTimeMs : responseTimeMs // ignore: cast_nullable_to_non_nullable
as int?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [NetworkResponse].
extension NetworkResponsePatterns<T> on NetworkResponse<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NetworkResponse<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NetworkResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NetworkResponse<T> value)  $default,){
final _that = this;
switch (_that) {
case _NetworkResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NetworkResponse<T> value)?  $default,){
final _that = this;
switch (_that) {
case _NetworkResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int statusCode,  T? data,  Map<String, List<String>> headers,  String? contentType,  DateTime timestamp,  bool fromCache,  int? cacheAge,  String? requestUrl,  int? responseTimeMs,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetworkResponse() when $default != null:
return $default(_that.statusCode,_that.data,_that.headers,_that.contentType,_that.timestamp,_that.fromCache,_that.cacheAge,_that.requestUrl,_that.responseTimeMs,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int statusCode,  T? data,  Map<String, List<String>> headers,  String? contentType,  DateTime timestamp,  bool fromCache,  int? cacheAge,  String? requestUrl,  int? responseTimeMs,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _NetworkResponse():
return $default(_that.statusCode,_that.data,_that.headers,_that.contentType,_that.timestamp,_that.fromCache,_that.cacheAge,_that.requestUrl,_that.responseTimeMs,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int statusCode,  T? data,  Map<String, List<String>> headers,  String? contentType,  DateTime timestamp,  bool fromCache,  int? cacheAge,  String? requestUrl,  int? responseTimeMs,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _NetworkResponse() when $default != null:
return $default(_that.statusCode,_that.data,_that.headers,_that.contentType,_that.timestamp,_that.fromCache,_that.cacheAge,_that.requestUrl,_that.responseTimeMs,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _NetworkResponse<T> implements NetworkResponse<T> {
  const _NetworkResponse({required this.statusCode, this.data, final  Map<String, List<String>> headers = const {}, this.contentType, required this.timestamp, this.fromCache = false, this.cacheAge, this.requestUrl, this.responseTimeMs, final  Map<String, dynamic> metadata = const {}}): _headers = headers,_metadata = metadata;
  factory _NetworkResponse.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$NetworkResponseFromJson(json,fromJsonT);

/// HTTP status code
@override final  int statusCode;
/// Response body data
@override final  T? data;
/// Response headers
 final  Map<String, List<String>> _headers;
/// Response headers
@override@JsonKey() Map<String, List<String>> get headers {
  if (_headers is EqualUnmodifiableMapView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_headers);
}

/// Content type from response headers
@override final  String? contentType;
/// Response timestamp
@override final  DateTime timestamp;
/// Whether the response came from cache
@override@JsonKey() final  bool fromCache;
/// Cache age in milliseconds (if from cache)
@override final  int? cacheAge;
/// Original request URL
@override final  String? requestUrl;
/// Response time in milliseconds
@override final  int? responseTimeMs;
/// Additional metadata
 final  Map<String, dynamic> _metadata;
/// Additional metadata
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of NetworkResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkResponseCopyWith<T, _NetworkResponse<T>> get copyWith => __$NetworkResponseCopyWithImpl<T, _NetworkResponse<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$NetworkResponseToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkResponse<T>&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&const DeepCollectionEquality().equals(other.data, data)&&const DeepCollectionEquality().equals(other._headers, _headers)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.fromCache, fromCache) || other.fromCache == fromCache)&&(identical(other.cacheAge, cacheAge) || other.cacheAge == cacheAge)&&(identical(other.requestUrl, requestUrl) || other.requestUrl == requestUrl)&&(identical(other.responseTimeMs, responseTimeMs) || other.responseTimeMs == responseTimeMs)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusCode,const DeepCollectionEquality().hash(data),const DeepCollectionEquality().hash(_headers),contentType,timestamp,fromCache,cacheAge,requestUrl,responseTimeMs,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'NetworkResponse<$T>(statusCode: $statusCode, data: $data, headers: $headers, contentType: $contentType, timestamp: $timestamp, fromCache: $fromCache, cacheAge: $cacheAge, requestUrl: $requestUrl, responseTimeMs: $responseTimeMs, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$NetworkResponseCopyWith<T,$Res> implements $NetworkResponseCopyWith<T, $Res> {
  factory _$NetworkResponseCopyWith(_NetworkResponse<T> value, $Res Function(_NetworkResponse<T>) _then) = __$NetworkResponseCopyWithImpl;
@override @useResult
$Res call({
 int statusCode, T? data, Map<String, List<String>> headers, String? contentType, DateTime timestamp, bool fromCache, int? cacheAge, String? requestUrl, int? responseTimeMs, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$NetworkResponseCopyWithImpl<T,$Res>
    implements _$NetworkResponseCopyWith<T, $Res> {
  __$NetworkResponseCopyWithImpl(this._self, this._then);

  final _NetworkResponse<T> _self;
  final $Res Function(_NetworkResponse<T>) _then;

/// Create a copy of NetworkResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statusCode = null,Object? data = freezed,Object? headers = null,Object? contentType = freezed,Object? timestamp = null,Object? fromCache = null,Object? cacheAge = freezed,Object? requestUrl = freezed,Object? responseTimeMs = freezed,Object? metadata = null,}) {
  return _then(_NetworkResponse<T>(
statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,headers: null == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,contentType: freezed == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,fromCache: null == fromCache ? _self.fromCache : fromCache // ignore: cast_nullable_to_non_nullable
as bool,cacheAge: freezed == cacheAge ? _self.cacheAge : cacheAge // ignore: cast_nullable_to_non_nullable
as int?,requestUrl: freezed == requestUrl ? _self.requestUrl : requestUrl // ignore: cast_nullable_to_non_nullable
as String?,responseTimeMs: freezed == responseTimeMs ? _self.responseTimeMs : responseTimeMs // ignore: cast_nullable_to_non_nullable
as int?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
