// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthSession {

 String get username; Map<String, String> get cookies; String? get firebaseIdToken; DateTime get expiresAt; DateTime get lastRefreshed;
/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSessionCopyWith<AuthSession> get copyWith => _$AuthSessionCopyWithImpl<AuthSession>(this as AuthSession, _$identity);

  /// Serializes this AuthSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSession&&(identical(other.username, username) || other.username == username)&&const DeepCollectionEquality().equals(other.cookies, cookies)&&(identical(other.firebaseIdToken, firebaseIdToken) || other.firebaseIdToken == firebaseIdToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.lastRefreshed, lastRefreshed) || other.lastRefreshed == lastRefreshed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,const DeepCollectionEquality().hash(cookies),firebaseIdToken,expiresAt,lastRefreshed);

@override
String toString() {
  return 'AuthSession(username: $username, cookies: $cookies, firebaseIdToken: $firebaseIdToken, expiresAt: $expiresAt, lastRefreshed: $lastRefreshed)';
}


}

/// @nodoc
abstract mixin class $AuthSessionCopyWith<$Res>  {
  factory $AuthSessionCopyWith(AuthSession value, $Res Function(AuthSession) _then) = _$AuthSessionCopyWithImpl;
@useResult
$Res call({
 String username, Map<String, String> cookies, String? firebaseIdToken, DateTime expiresAt, DateTime lastRefreshed
});




}
/// @nodoc
class _$AuthSessionCopyWithImpl<$Res>
    implements $AuthSessionCopyWith<$Res> {
  _$AuthSessionCopyWithImpl(this._self, this._then);

  final AuthSession _self;
  final $Res Function(AuthSession) _then;

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? cookies = null,Object? firebaseIdToken = freezed,Object? expiresAt = null,Object? lastRefreshed = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,cookies: null == cookies ? _self.cookies : cookies // ignore: cast_nullable_to_non_nullable
as Map<String, String>,firebaseIdToken: freezed == firebaseIdToken ? _self.firebaseIdToken : firebaseIdToken // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastRefreshed: null == lastRefreshed ? _self.lastRefreshed : lastRefreshed // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AuthSession implements AuthSession {
  const _AuthSession({required this.username, required final  Map<String, String> cookies, this.firebaseIdToken, required this.expiresAt, required this.lastRefreshed}): _cookies = cookies;
  factory _AuthSession.fromJson(Map<String, dynamic> json) => _$AuthSessionFromJson(json);

@override final  String username;
 final  Map<String, String> _cookies;
@override Map<String, String> get cookies {
  if (_cookies is EqualUnmodifiableMapView) return _cookies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_cookies);
}

@override final  String? firebaseIdToken;
@override final  DateTime expiresAt;
@override final  DateTime lastRefreshed;

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthSessionCopyWith<_AuthSession> get copyWith => __$AuthSessionCopyWithImpl<_AuthSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthSession&&(identical(other.username, username) || other.username == username)&&const DeepCollectionEquality().equals(other._cookies, _cookies)&&(identical(other.firebaseIdToken, firebaseIdToken) || other.firebaseIdToken == firebaseIdToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.lastRefreshed, lastRefreshed) || other.lastRefreshed == lastRefreshed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,const DeepCollectionEquality().hash(_cookies),firebaseIdToken,expiresAt,lastRefreshed);

@override
String toString() {
  return 'AuthSession(username: $username, cookies: $cookies, firebaseIdToken: $firebaseIdToken, expiresAt: $expiresAt, lastRefreshed: $lastRefreshed)';
}


}

/// @nodoc
abstract mixin class _$AuthSessionCopyWith<$Res> implements $AuthSessionCopyWith<$Res> {
  factory _$AuthSessionCopyWith(_AuthSession value, $Res Function(_AuthSession) _then) = __$AuthSessionCopyWithImpl;
@override @useResult
$Res call({
 String username, Map<String, String> cookies, String? firebaseIdToken, DateTime expiresAt, DateTime lastRefreshed
});




}
/// @nodoc
class __$AuthSessionCopyWithImpl<$Res>
    implements _$AuthSessionCopyWith<$Res> {
  __$AuthSessionCopyWithImpl(this._self, this._then);

  final _AuthSession _self;
  final $Res Function(_AuthSession) _then;

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? cookies = null,Object? firebaseIdToken = freezed,Object? expiresAt = null,Object? lastRefreshed = null,}) {
  return _then(_AuthSession(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,cookies: null == cookies ? _self._cookies : cookies // ignore: cast_nullable_to_non_nullable
as Map<String, String>,firebaseIdToken: freezed == firebaseIdToken ? _self.firebaseIdToken : firebaseIdToken // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastRefreshed: null == lastRefreshed ? _self.lastRefreshed : lastRefreshed // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
