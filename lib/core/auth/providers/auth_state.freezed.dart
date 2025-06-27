// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// @nodoc


class _AuthStateUnauthenticated implements AuthState {
  const _AuthStateUnauthenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthStateUnauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.unauthenticated()';
}


}




/// @nodoc


class _AuthStateAuthenticating implements AuthState {
  const _AuthStateAuthenticating();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthStateAuthenticating);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.authenticating()';
}


}




/// @nodoc


class _AuthStateAuthenticated implements AuthState {
  const _AuthStateAuthenticated({required this.session});
  

 final  AuthSession session;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateAuthenticatedCopyWith<_AuthStateAuthenticated> get copyWith => __$AuthStateAuthenticatedCopyWithImpl<_AuthStateAuthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthStateAuthenticated&&(identical(other.session, session) || other.session == session));
}


@override
int get hashCode => Object.hash(runtimeType,session);

@override
String toString() {
  return 'AuthState.authenticated(session: $session)';
}


}

/// @nodoc
abstract mixin class _$AuthStateAuthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateAuthenticatedCopyWith(_AuthStateAuthenticated value, $Res Function(_AuthStateAuthenticated) _then) = __$AuthStateAuthenticatedCopyWithImpl;
@useResult
$Res call({
 AuthSession session
});


$AuthSessionCopyWith<$Res> get session;

}
/// @nodoc
class __$AuthStateAuthenticatedCopyWithImpl<$Res>
    implements _$AuthStateAuthenticatedCopyWith<$Res> {
  __$AuthStateAuthenticatedCopyWithImpl(this._self, this._then);

  final _AuthStateAuthenticated _self;
  final $Res Function(_AuthStateAuthenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? session = null,}) {
  return _then(_AuthStateAuthenticated(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as AuthSession,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthSessionCopyWith<$Res> get session {
  
  return $AuthSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

/// @nodoc


class _AuthStateRefreshing implements AuthState {
  const _AuthStateRefreshing({required this.session});
  

 final  AuthSession session;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateRefreshingCopyWith<_AuthStateRefreshing> get copyWith => __$AuthStateRefreshingCopyWithImpl<_AuthStateRefreshing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthStateRefreshing&&(identical(other.session, session) || other.session == session));
}


@override
int get hashCode => Object.hash(runtimeType,session);

@override
String toString() {
  return 'AuthState.refreshing(session: $session)';
}


}

/// @nodoc
abstract mixin class _$AuthStateRefreshingCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateRefreshingCopyWith(_AuthStateRefreshing value, $Res Function(_AuthStateRefreshing) _then) = __$AuthStateRefreshingCopyWithImpl;
@useResult
$Res call({
 AuthSession session
});


$AuthSessionCopyWith<$Res> get session;

}
/// @nodoc
class __$AuthStateRefreshingCopyWithImpl<$Res>
    implements _$AuthStateRefreshingCopyWith<$Res> {
  __$AuthStateRefreshingCopyWithImpl(this._self, this._then);

  final _AuthStateRefreshing _self;
  final $Res Function(_AuthStateRefreshing) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? session = null,}) {
  return _then(_AuthStateRefreshing(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as AuthSession,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthSessionCopyWith<$Res> get session {
  
  return $AuthSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

/// @nodoc


class _AuthStateError implements AuthState {
  const _AuthStateError({required this.message, this.exception, this.stack});
  

 final  String message;
 final  Object? exception;
 final  StackTrace? stack;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateErrorCopyWith<_AuthStateError> get copyWith => __$AuthStateErrorCopyWithImpl<_AuthStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthStateError&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.exception, exception)&&(identical(other.stack, stack) || other.stack == stack));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(exception),stack);

@override
String toString() {
  return 'AuthState.error(message: $message, exception: $exception, stack: $stack)';
}


}

/// @nodoc
abstract mixin class _$AuthStateErrorCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateErrorCopyWith(_AuthStateError value, $Res Function(_AuthStateError) _then) = __$AuthStateErrorCopyWithImpl;
@useResult
$Res call({
 String message, Object? exception, StackTrace? stack
});




}
/// @nodoc
class __$AuthStateErrorCopyWithImpl<$Res>
    implements _$AuthStateErrorCopyWith<$Res> {
  __$AuthStateErrorCopyWithImpl(this._self, this._then);

  final _AuthStateError _self;
  final $Res Function(_AuthStateError) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? exception = freezed,Object? stack = freezed,}) {
  return _then(_AuthStateError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,exception: freezed == exception ? _self.exception : exception ,stack: freezed == stack ? _self.stack : stack // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

// dart format on
