// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_error_types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DetailedNetworkErrorType {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailedNetworkErrorType);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DetailedNetworkErrorType()';
}


}

/// @nodoc
class $DetailedNetworkErrorTypeCopyWith<$Res>  {
$DetailedNetworkErrorTypeCopyWith(DetailedNetworkErrorType _, $Res Function(DetailedNetworkErrorType) __);
}


/// Adds pattern-matching-related methods to [DetailedNetworkErrorType].
extension DetailedNetworkErrorTypePatterns on DetailedNetworkErrorType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DetailedConnectionError value)?  connection,TResult Function( DetailedTimeoutError value)?  timeout,TResult Function( DetailedResponseError value)?  response,TResult Function( DetailedCancelledError value)?  cancelled,TResult Function( DetailedBadRequestError value)?  badRequest,TResult Function( DetailedCertificateError value)?  certificate,TResult Function( DetailedUnknownError value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DetailedConnectionError() when connection != null:
return connection(_that);case DetailedTimeoutError() when timeout != null:
return timeout(_that);case DetailedResponseError() when response != null:
return response(_that);case DetailedCancelledError() when cancelled != null:
return cancelled(_that);case DetailedBadRequestError() when badRequest != null:
return badRequest(_that);case DetailedCertificateError() when certificate != null:
return certificate(_that);case DetailedUnknownError() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DetailedConnectionError value)  connection,required TResult Function( DetailedTimeoutError value)  timeout,required TResult Function( DetailedResponseError value)  response,required TResult Function( DetailedCancelledError value)  cancelled,required TResult Function( DetailedBadRequestError value)  badRequest,required TResult Function( DetailedCertificateError value)  certificate,required TResult Function( DetailedUnknownError value)  unknown,}){
final _that = this;
switch (_that) {
case DetailedConnectionError():
return connection(_that);case DetailedTimeoutError():
return timeout(_that);case DetailedResponseError():
return response(_that);case DetailedCancelledError():
return cancelled(_that);case DetailedBadRequestError():
return badRequest(_that);case DetailedCertificateError():
return certificate(_that);case DetailedUnknownError():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DetailedConnectionError value)?  connection,TResult? Function( DetailedTimeoutError value)?  timeout,TResult? Function( DetailedResponseError value)?  response,TResult? Function( DetailedCancelledError value)?  cancelled,TResult? Function( DetailedBadRequestError value)?  badRequest,TResult? Function( DetailedCertificateError value)?  certificate,TResult? Function( DetailedUnknownError value)?  unknown,}){
final _that = this;
switch (_that) {
case DetailedConnectionError() when connection != null:
return connection(_that);case DetailedTimeoutError() when timeout != null:
return timeout(_that);case DetailedResponseError() when response != null:
return response(_that);case DetailedCancelledError() when cancelled != null:
return cancelled(_that);case DetailedBadRequestError() when badRequest != null:
return badRequest(_that);case DetailedCertificateError() when certificate != null:
return certificate(_that);case DetailedUnknownError() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String reason,  String? host,  int? port)?  connection,TResult Function( Duration timeoutDuration,  String timeoutType,  String? host)?  timeout,TResult Function( int statusCode,  String statusMessage,  String? reasonPhrase,  Map<String, dynamic>? responseHeaders)?  response,TResult Function( String reason,  bool isManual)?  cancelled,TResult Function( String reason,  String? requestPath,  Map<String, dynamic>? requestData)?  badRequest,TResult Function( String reason,  String? host,  String? certificateError)?  certificate,TResult Function( String reason,  String? originalErrorType)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DetailedConnectionError() when connection != null:
return connection(_that.reason,_that.host,_that.port);case DetailedTimeoutError() when timeout != null:
return timeout(_that.timeoutDuration,_that.timeoutType,_that.host);case DetailedResponseError() when response != null:
return response(_that.statusCode,_that.statusMessage,_that.reasonPhrase,_that.responseHeaders);case DetailedCancelledError() when cancelled != null:
return cancelled(_that.reason,_that.isManual);case DetailedBadRequestError() when badRequest != null:
return badRequest(_that.reason,_that.requestPath,_that.requestData);case DetailedCertificateError() when certificate != null:
return certificate(_that.reason,_that.host,_that.certificateError);case DetailedUnknownError() when unknown != null:
return unknown(_that.reason,_that.originalErrorType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String reason,  String? host,  int? port)  connection,required TResult Function( Duration timeoutDuration,  String timeoutType,  String? host)  timeout,required TResult Function( int statusCode,  String statusMessage,  String? reasonPhrase,  Map<String, dynamic>? responseHeaders)  response,required TResult Function( String reason,  bool isManual)  cancelled,required TResult Function( String reason,  String? requestPath,  Map<String, dynamic>? requestData)  badRequest,required TResult Function( String reason,  String? host,  String? certificateError)  certificate,required TResult Function( String reason,  String? originalErrorType)  unknown,}) {final _that = this;
switch (_that) {
case DetailedConnectionError():
return connection(_that.reason,_that.host,_that.port);case DetailedTimeoutError():
return timeout(_that.timeoutDuration,_that.timeoutType,_that.host);case DetailedResponseError():
return response(_that.statusCode,_that.statusMessage,_that.reasonPhrase,_that.responseHeaders);case DetailedCancelledError():
return cancelled(_that.reason,_that.isManual);case DetailedBadRequestError():
return badRequest(_that.reason,_that.requestPath,_that.requestData);case DetailedCertificateError():
return certificate(_that.reason,_that.host,_that.certificateError);case DetailedUnknownError():
return unknown(_that.reason,_that.originalErrorType);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String reason,  String? host,  int? port)?  connection,TResult? Function( Duration timeoutDuration,  String timeoutType,  String? host)?  timeout,TResult? Function( int statusCode,  String statusMessage,  String? reasonPhrase,  Map<String, dynamic>? responseHeaders)?  response,TResult? Function( String reason,  bool isManual)?  cancelled,TResult? Function( String reason,  String? requestPath,  Map<String, dynamic>? requestData)?  badRequest,TResult? Function( String reason,  String? host,  String? certificateError)?  certificate,TResult? Function( String reason,  String? originalErrorType)?  unknown,}) {final _that = this;
switch (_that) {
case DetailedConnectionError() when connection != null:
return connection(_that.reason,_that.host,_that.port);case DetailedTimeoutError() when timeout != null:
return timeout(_that.timeoutDuration,_that.timeoutType,_that.host);case DetailedResponseError() when response != null:
return response(_that.statusCode,_that.statusMessage,_that.reasonPhrase,_that.responseHeaders);case DetailedCancelledError() when cancelled != null:
return cancelled(_that.reason,_that.isManual);case DetailedBadRequestError() when badRequest != null:
return badRequest(_that.reason,_that.requestPath,_that.requestData);case DetailedCertificateError() when certificate != null:
return certificate(_that.reason,_that.host,_that.certificateError);case DetailedUnknownError() when unknown != null:
return unknown(_that.reason,_that.originalErrorType);case _:
  return null;

}
}

}

/// @nodoc


class DetailedConnectionError implements DetailedNetworkErrorType {
  const DetailedConnectionError({required this.reason, this.host, this.port});
  

 final  String reason;
 final  String? host;
 final  int? port;

/// Create a copy of DetailedNetworkErrorType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailedConnectionErrorCopyWith<DetailedConnectionError> get copyWith => _$DetailedConnectionErrorCopyWithImpl<DetailedConnectionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailedConnectionError&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.host, host) || other.host == host)&&(identical(other.port, port) || other.port == port));
}


@override
int get hashCode => Object.hash(runtimeType,reason,host,port);

@override
String toString() {
  return 'DetailedNetworkErrorType.connection(reason: $reason, host: $host, port: $port)';
}


}

/// @nodoc
abstract mixin class $DetailedConnectionErrorCopyWith<$Res> implements $DetailedNetworkErrorTypeCopyWith<$Res> {
  factory $DetailedConnectionErrorCopyWith(DetailedConnectionError value, $Res Function(DetailedConnectionError) _then) = _$DetailedConnectionErrorCopyWithImpl;
@useResult
$Res call({
 String reason, String? host, int? port
});




}
/// @nodoc
class _$DetailedConnectionErrorCopyWithImpl<$Res>
    implements $DetailedConnectionErrorCopyWith<$Res> {
  _$DetailedConnectionErrorCopyWithImpl(this._self, this._then);

  final DetailedConnectionError _self;
  final $Res Function(DetailedConnectionError) _then;

/// Create a copy of DetailedNetworkErrorType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,Object? host = freezed,Object? port = freezed,}) {
  return _then(DetailedConnectionError(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,host: freezed == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String?,port: freezed == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class DetailedTimeoutError implements DetailedNetworkErrorType {
  const DetailedTimeoutError({required this.timeoutDuration, required this.timeoutType, this.host});
  

 final  Duration timeoutDuration;
 final  String timeoutType;
// 'connect', 'send', 'receive'
 final  String? host;

/// Create a copy of DetailedNetworkErrorType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailedTimeoutErrorCopyWith<DetailedTimeoutError> get copyWith => _$DetailedTimeoutErrorCopyWithImpl<DetailedTimeoutError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailedTimeoutError&&(identical(other.timeoutDuration, timeoutDuration) || other.timeoutDuration == timeoutDuration)&&(identical(other.timeoutType, timeoutType) || other.timeoutType == timeoutType)&&(identical(other.host, host) || other.host == host));
}


@override
int get hashCode => Object.hash(runtimeType,timeoutDuration,timeoutType,host);

@override
String toString() {
  return 'DetailedNetworkErrorType.timeout(timeoutDuration: $timeoutDuration, timeoutType: $timeoutType, host: $host)';
}


}

/// @nodoc
abstract mixin class $DetailedTimeoutErrorCopyWith<$Res> implements $DetailedNetworkErrorTypeCopyWith<$Res> {
  factory $DetailedTimeoutErrorCopyWith(DetailedTimeoutError value, $Res Function(DetailedTimeoutError) _then) = _$DetailedTimeoutErrorCopyWithImpl;
@useResult
$Res call({
 Duration timeoutDuration, String timeoutType, String? host
});




}
/// @nodoc
class _$DetailedTimeoutErrorCopyWithImpl<$Res>
    implements $DetailedTimeoutErrorCopyWith<$Res> {
  _$DetailedTimeoutErrorCopyWithImpl(this._self, this._then);

  final DetailedTimeoutError _self;
  final $Res Function(DetailedTimeoutError) _then;

/// Create a copy of DetailedNetworkErrorType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? timeoutDuration = null,Object? timeoutType = null,Object? host = freezed,}) {
  return _then(DetailedTimeoutError(
timeoutDuration: null == timeoutDuration ? _self.timeoutDuration : timeoutDuration // ignore: cast_nullable_to_non_nullable
as Duration,timeoutType: null == timeoutType ? _self.timeoutType : timeoutType // ignore: cast_nullable_to_non_nullable
as String,host: freezed == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class DetailedResponseError implements DetailedNetworkErrorType {
  const DetailedResponseError({required this.statusCode, required this.statusMessage, this.reasonPhrase, final  Map<String, dynamic>? responseHeaders}): _responseHeaders = responseHeaders;
  

 final  int statusCode;
 final  String statusMessage;
 final  String? reasonPhrase;
 final  Map<String, dynamic>? _responseHeaders;
 Map<String, dynamic>? get responseHeaders {
  final value = _responseHeaders;
  if (value == null) return null;
  if (_responseHeaders is EqualUnmodifiableMapView) return _responseHeaders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of DetailedNetworkErrorType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailedResponseErrorCopyWith<DetailedResponseError> get copyWith => _$DetailedResponseErrorCopyWithImpl<DetailedResponseError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailedResponseError&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage)&&(identical(other.reasonPhrase, reasonPhrase) || other.reasonPhrase == reasonPhrase)&&const DeepCollectionEquality().equals(other._responseHeaders, _responseHeaders));
}


@override
int get hashCode => Object.hash(runtimeType,statusCode,statusMessage,reasonPhrase,const DeepCollectionEquality().hash(_responseHeaders));

@override
String toString() {
  return 'DetailedNetworkErrorType.response(statusCode: $statusCode, statusMessage: $statusMessage, reasonPhrase: $reasonPhrase, responseHeaders: $responseHeaders)';
}


}

/// @nodoc
abstract mixin class $DetailedResponseErrorCopyWith<$Res> implements $DetailedNetworkErrorTypeCopyWith<$Res> {
  factory $DetailedResponseErrorCopyWith(DetailedResponseError value, $Res Function(DetailedResponseError) _then) = _$DetailedResponseErrorCopyWithImpl;
@useResult
$Res call({
 int statusCode, String statusMessage, String? reasonPhrase, Map<String, dynamic>? responseHeaders
});




}
/// @nodoc
class _$DetailedResponseErrorCopyWithImpl<$Res>
    implements $DetailedResponseErrorCopyWith<$Res> {
  _$DetailedResponseErrorCopyWithImpl(this._self, this._then);

  final DetailedResponseError _self;
  final $Res Function(DetailedResponseError) _then;

/// Create a copy of DetailedNetworkErrorType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? statusCode = null,Object? statusMessage = null,Object? reasonPhrase = freezed,Object? responseHeaders = freezed,}) {
  return _then(DetailedResponseError(
statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,statusMessage: null == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String,reasonPhrase: freezed == reasonPhrase ? _self.reasonPhrase : reasonPhrase // ignore: cast_nullable_to_non_nullable
as String?,responseHeaders: freezed == responseHeaders ? _self._responseHeaders : responseHeaders // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class DetailedCancelledError implements DetailedNetworkErrorType {
  const DetailedCancelledError({required this.reason, this.isManual = false});
  

 final  String reason;
@JsonKey() final  bool isManual;

/// Create a copy of DetailedNetworkErrorType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailedCancelledErrorCopyWith<DetailedCancelledError> get copyWith => _$DetailedCancelledErrorCopyWithImpl<DetailedCancelledError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailedCancelledError&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.isManual, isManual) || other.isManual == isManual));
}


@override
int get hashCode => Object.hash(runtimeType,reason,isManual);

@override
String toString() {
  return 'DetailedNetworkErrorType.cancelled(reason: $reason, isManual: $isManual)';
}


}

/// @nodoc
abstract mixin class $DetailedCancelledErrorCopyWith<$Res> implements $DetailedNetworkErrorTypeCopyWith<$Res> {
  factory $DetailedCancelledErrorCopyWith(DetailedCancelledError value, $Res Function(DetailedCancelledError) _then) = _$DetailedCancelledErrorCopyWithImpl;
@useResult
$Res call({
 String reason, bool isManual
});




}
/// @nodoc
class _$DetailedCancelledErrorCopyWithImpl<$Res>
    implements $DetailedCancelledErrorCopyWith<$Res> {
  _$DetailedCancelledErrorCopyWithImpl(this._self, this._then);

  final DetailedCancelledError _self;
  final $Res Function(DetailedCancelledError) _then;

/// Create a copy of DetailedNetworkErrorType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,Object? isManual = null,}) {
  return _then(DetailedCancelledError(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,isManual: null == isManual ? _self.isManual : isManual // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class DetailedBadRequestError implements DetailedNetworkErrorType {
  const DetailedBadRequestError({required this.reason, this.requestPath, final  Map<String, dynamic>? requestData}): _requestData = requestData;
  

 final  String reason;
 final  String? requestPath;
 final  Map<String, dynamic>? _requestData;
 Map<String, dynamic>? get requestData {
  final value = _requestData;
  if (value == null) return null;
  if (_requestData is EqualUnmodifiableMapView) return _requestData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of DetailedNetworkErrorType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailedBadRequestErrorCopyWith<DetailedBadRequestError> get copyWith => _$DetailedBadRequestErrorCopyWithImpl<DetailedBadRequestError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailedBadRequestError&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.requestPath, requestPath) || other.requestPath == requestPath)&&const DeepCollectionEquality().equals(other._requestData, _requestData));
}


@override
int get hashCode => Object.hash(runtimeType,reason,requestPath,const DeepCollectionEquality().hash(_requestData));

@override
String toString() {
  return 'DetailedNetworkErrorType.badRequest(reason: $reason, requestPath: $requestPath, requestData: $requestData)';
}


}

/// @nodoc
abstract mixin class $DetailedBadRequestErrorCopyWith<$Res> implements $DetailedNetworkErrorTypeCopyWith<$Res> {
  factory $DetailedBadRequestErrorCopyWith(DetailedBadRequestError value, $Res Function(DetailedBadRequestError) _then) = _$DetailedBadRequestErrorCopyWithImpl;
@useResult
$Res call({
 String reason, String? requestPath, Map<String, dynamic>? requestData
});




}
/// @nodoc
class _$DetailedBadRequestErrorCopyWithImpl<$Res>
    implements $DetailedBadRequestErrorCopyWith<$Res> {
  _$DetailedBadRequestErrorCopyWithImpl(this._self, this._then);

  final DetailedBadRequestError _self;
  final $Res Function(DetailedBadRequestError) _then;

/// Create a copy of DetailedNetworkErrorType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,Object? requestPath = freezed,Object? requestData = freezed,}) {
  return _then(DetailedBadRequestError(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,requestPath: freezed == requestPath ? _self.requestPath : requestPath // ignore: cast_nullable_to_non_nullable
as String?,requestData: freezed == requestData ? _self._requestData : requestData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class DetailedCertificateError implements DetailedNetworkErrorType {
  const DetailedCertificateError({required this.reason, this.host, this.certificateError});
  

 final  String reason;
 final  String? host;
 final  String? certificateError;

/// Create a copy of DetailedNetworkErrorType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailedCertificateErrorCopyWith<DetailedCertificateError> get copyWith => _$DetailedCertificateErrorCopyWithImpl<DetailedCertificateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailedCertificateError&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.host, host) || other.host == host)&&(identical(other.certificateError, certificateError) || other.certificateError == certificateError));
}


@override
int get hashCode => Object.hash(runtimeType,reason,host,certificateError);

@override
String toString() {
  return 'DetailedNetworkErrorType.certificate(reason: $reason, host: $host, certificateError: $certificateError)';
}


}

/// @nodoc
abstract mixin class $DetailedCertificateErrorCopyWith<$Res> implements $DetailedNetworkErrorTypeCopyWith<$Res> {
  factory $DetailedCertificateErrorCopyWith(DetailedCertificateError value, $Res Function(DetailedCertificateError) _then) = _$DetailedCertificateErrorCopyWithImpl;
@useResult
$Res call({
 String reason, String? host, String? certificateError
});




}
/// @nodoc
class _$DetailedCertificateErrorCopyWithImpl<$Res>
    implements $DetailedCertificateErrorCopyWith<$Res> {
  _$DetailedCertificateErrorCopyWithImpl(this._self, this._then);

  final DetailedCertificateError _self;
  final $Res Function(DetailedCertificateError) _then;

/// Create a copy of DetailedNetworkErrorType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,Object? host = freezed,Object? certificateError = freezed,}) {
  return _then(DetailedCertificateError(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,host: freezed == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String?,certificateError: freezed == certificateError ? _self.certificateError : certificateError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class DetailedUnknownError implements DetailedNetworkErrorType {
  const DetailedUnknownError({required this.reason, this.originalErrorType});
  

 final  String reason;
 final  String? originalErrorType;

/// Create a copy of DetailedNetworkErrorType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailedUnknownErrorCopyWith<DetailedUnknownError> get copyWith => _$DetailedUnknownErrorCopyWithImpl<DetailedUnknownError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailedUnknownError&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.originalErrorType, originalErrorType) || other.originalErrorType == originalErrorType));
}


@override
int get hashCode => Object.hash(runtimeType,reason,originalErrorType);

@override
String toString() {
  return 'DetailedNetworkErrorType.unknown(reason: $reason, originalErrorType: $originalErrorType)';
}


}

/// @nodoc
abstract mixin class $DetailedUnknownErrorCopyWith<$Res> implements $DetailedNetworkErrorTypeCopyWith<$Res> {
  factory $DetailedUnknownErrorCopyWith(DetailedUnknownError value, $Res Function(DetailedUnknownError) _then) = _$DetailedUnknownErrorCopyWithImpl;
@useResult
$Res call({
 String reason, String? originalErrorType
});




}
/// @nodoc
class _$DetailedUnknownErrorCopyWithImpl<$Res>
    implements $DetailedUnknownErrorCopyWith<$Res> {
  _$DetailedUnknownErrorCopyWithImpl(this._self, this._then);

  final DetailedUnknownError _self;
  final $Res Function(DetailedUnknownError) _then;

/// Create a copy of DetailedNetworkErrorType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,Object? originalErrorType = freezed,}) {
  return _then(DetailedUnknownError(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,originalErrorType: freezed == originalErrorType ? _self.originalErrorType : originalErrorType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
