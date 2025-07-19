// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApiConfig {

 String get manaboBaseUrl; String get alboBaseUrl; String get cubicsBaseUrl; String get ssoUrl; String get palApiBaseUrl; int get connectionTimeoutSeconds; int get receiveTimeoutSeconds; int get maxRetries;
/// Create a copy of ApiConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiConfigCopyWith<ApiConfig> get copyWith => _$ApiConfigCopyWithImpl<ApiConfig>(this as ApiConfig, _$identity);

  /// Serializes this ApiConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiConfig&&(identical(other.manaboBaseUrl, manaboBaseUrl) || other.manaboBaseUrl == manaboBaseUrl)&&(identical(other.alboBaseUrl, alboBaseUrl) || other.alboBaseUrl == alboBaseUrl)&&(identical(other.cubicsBaseUrl, cubicsBaseUrl) || other.cubicsBaseUrl == cubicsBaseUrl)&&(identical(other.ssoUrl, ssoUrl) || other.ssoUrl == ssoUrl)&&(identical(other.palApiBaseUrl, palApiBaseUrl) || other.palApiBaseUrl == palApiBaseUrl)&&(identical(other.connectionTimeoutSeconds, connectionTimeoutSeconds) || other.connectionTimeoutSeconds == connectionTimeoutSeconds)&&(identical(other.receiveTimeoutSeconds, receiveTimeoutSeconds) || other.receiveTimeoutSeconds == receiveTimeoutSeconds)&&(identical(other.maxRetries, maxRetries) || other.maxRetries == maxRetries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,manaboBaseUrl,alboBaseUrl,cubicsBaseUrl,ssoUrl,palApiBaseUrl,connectionTimeoutSeconds,receiveTimeoutSeconds,maxRetries);

@override
String toString() {
  return 'ApiConfig(manaboBaseUrl: $manaboBaseUrl, alboBaseUrl: $alboBaseUrl, cubicsBaseUrl: $cubicsBaseUrl, ssoUrl: $ssoUrl, palApiBaseUrl: $palApiBaseUrl, connectionTimeoutSeconds: $connectionTimeoutSeconds, receiveTimeoutSeconds: $receiveTimeoutSeconds, maxRetries: $maxRetries)';
}


}

/// @nodoc
abstract mixin class $ApiConfigCopyWith<$Res>  {
  factory $ApiConfigCopyWith(ApiConfig value, $Res Function(ApiConfig) _then) = _$ApiConfigCopyWithImpl;
@useResult
$Res call({
 String manaboBaseUrl, String alboBaseUrl, String cubicsBaseUrl, String ssoUrl, String palApiBaseUrl, int connectionTimeoutSeconds, int receiveTimeoutSeconds, int maxRetries
});




}
/// @nodoc
class _$ApiConfigCopyWithImpl<$Res>
    implements $ApiConfigCopyWith<$Res> {
  _$ApiConfigCopyWithImpl(this._self, this._then);

  final ApiConfig _self;
  final $Res Function(ApiConfig) _then;

/// Create a copy of ApiConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? manaboBaseUrl = null,Object? alboBaseUrl = null,Object? cubicsBaseUrl = null,Object? ssoUrl = null,Object? palApiBaseUrl = null,Object? connectionTimeoutSeconds = null,Object? receiveTimeoutSeconds = null,Object? maxRetries = null,}) {
  return _then(_self.copyWith(
manaboBaseUrl: null == manaboBaseUrl ? _self.manaboBaseUrl : manaboBaseUrl // ignore: cast_nullable_to_non_nullable
as String,alboBaseUrl: null == alboBaseUrl ? _self.alboBaseUrl : alboBaseUrl // ignore: cast_nullable_to_non_nullable
as String,cubicsBaseUrl: null == cubicsBaseUrl ? _self.cubicsBaseUrl : cubicsBaseUrl // ignore: cast_nullable_to_non_nullable
as String,ssoUrl: null == ssoUrl ? _self.ssoUrl : ssoUrl // ignore: cast_nullable_to_non_nullable
as String,palApiBaseUrl: null == palApiBaseUrl ? _self.palApiBaseUrl : palApiBaseUrl // ignore: cast_nullable_to_non_nullable
as String,connectionTimeoutSeconds: null == connectionTimeoutSeconds ? _self.connectionTimeoutSeconds : connectionTimeoutSeconds // ignore: cast_nullable_to_non_nullable
as int,receiveTimeoutSeconds: null == receiveTimeoutSeconds ? _self.receiveTimeoutSeconds : receiveTimeoutSeconds // ignore: cast_nullable_to_non_nullable
as int,maxRetries: null == maxRetries ? _self.maxRetries : maxRetries // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiConfig].
extension ApiConfigPatterns on ApiConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiConfig value)  $default,){
final _that = this;
switch (_that) {
case _ApiConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ApiConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String manaboBaseUrl,  String alboBaseUrl,  String cubicsBaseUrl,  String ssoUrl,  String palApiBaseUrl,  int connectionTimeoutSeconds,  int receiveTimeoutSeconds,  int maxRetries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiConfig() when $default != null:
return $default(_that.manaboBaseUrl,_that.alboBaseUrl,_that.cubicsBaseUrl,_that.ssoUrl,_that.palApiBaseUrl,_that.connectionTimeoutSeconds,_that.receiveTimeoutSeconds,_that.maxRetries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String manaboBaseUrl,  String alboBaseUrl,  String cubicsBaseUrl,  String ssoUrl,  String palApiBaseUrl,  int connectionTimeoutSeconds,  int receiveTimeoutSeconds,  int maxRetries)  $default,) {final _that = this;
switch (_that) {
case _ApiConfig():
return $default(_that.manaboBaseUrl,_that.alboBaseUrl,_that.cubicsBaseUrl,_that.ssoUrl,_that.palApiBaseUrl,_that.connectionTimeoutSeconds,_that.receiveTimeoutSeconds,_that.maxRetries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String manaboBaseUrl,  String alboBaseUrl,  String cubicsBaseUrl,  String ssoUrl,  String palApiBaseUrl,  int connectionTimeoutSeconds,  int receiveTimeoutSeconds,  int maxRetries)?  $default,) {final _that = this;
switch (_that) {
case _ApiConfig() when $default != null:
return $default(_that.manaboBaseUrl,_that.alboBaseUrl,_that.cubicsBaseUrl,_that.ssoUrl,_that.palApiBaseUrl,_that.connectionTimeoutSeconds,_that.receiveTimeoutSeconds,_that.maxRetries);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApiConfig extends ApiConfig {
  const _ApiConfig({this.manaboBaseUrl = ApiConfigDefaults.manaboBaseUrl, this.alboBaseUrl = ApiConfigDefaults.alboBaseUrl, this.cubicsBaseUrl = ApiConfigDefaults.cubicsBaseUrl, this.ssoUrl = ApiConfigDefaults.ssoUrl, this.palApiBaseUrl = ApiConfigDefaults.palApiBaseUrl, this.connectionTimeoutSeconds = ApiConfigDefaults.connectionTimeoutSeconds, this.receiveTimeoutSeconds = ApiConfigDefaults.receiveTimeoutSeconds, this.maxRetries = ApiConfigDefaults.maxRetries}): super._();
  factory _ApiConfig.fromJson(Map<String, dynamic> json) => _$ApiConfigFromJson(json);

@override@JsonKey() final  String manaboBaseUrl;
@override@JsonKey() final  String alboBaseUrl;
@override@JsonKey() final  String cubicsBaseUrl;
@override@JsonKey() final  String ssoUrl;
@override@JsonKey() final  String palApiBaseUrl;
@override@JsonKey() final  int connectionTimeoutSeconds;
@override@JsonKey() final  int receiveTimeoutSeconds;
@override@JsonKey() final  int maxRetries;

/// Create a copy of ApiConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiConfigCopyWith<_ApiConfig> get copyWith => __$ApiConfigCopyWithImpl<_ApiConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiConfig&&(identical(other.manaboBaseUrl, manaboBaseUrl) || other.manaboBaseUrl == manaboBaseUrl)&&(identical(other.alboBaseUrl, alboBaseUrl) || other.alboBaseUrl == alboBaseUrl)&&(identical(other.cubicsBaseUrl, cubicsBaseUrl) || other.cubicsBaseUrl == cubicsBaseUrl)&&(identical(other.ssoUrl, ssoUrl) || other.ssoUrl == ssoUrl)&&(identical(other.palApiBaseUrl, palApiBaseUrl) || other.palApiBaseUrl == palApiBaseUrl)&&(identical(other.connectionTimeoutSeconds, connectionTimeoutSeconds) || other.connectionTimeoutSeconds == connectionTimeoutSeconds)&&(identical(other.receiveTimeoutSeconds, receiveTimeoutSeconds) || other.receiveTimeoutSeconds == receiveTimeoutSeconds)&&(identical(other.maxRetries, maxRetries) || other.maxRetries == maxRetries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,manaboBaseUrl,alboBaseUrl,cubicsBaseUrl,ssoUrl,palApiBaseUrl,connectionTimeoutSeconds,receiveTimeoutSeconds,maxRetries);

@override
String toString() {
  return 'ApiConfig(manaboBaseUrl: $manaboBaseUrl, alboBaseUrl: $alboBaseUrl, cubicsBaseUrl: $cubicsBaseUrl, ssoUrl: $ssoUrl, palApiBaseUrl: $palApiBaseUrl, connectionTimeoutSeconds: $connectionTimeoutSeconds, receiveTimeoutSeconds: $receiveTimeoutSeconds, maxRetries: $maxRetries)';
}


}

/// @nodoc
abstract mixin class _$ApiConfigCopyWith<$Res> implements $ApiConfigCopyWith<$Res> {
  factory _$ApiConfigCopyWith(_ApiConfig value, $Res Function(_ApiConfig) _then) = __$ApiConfigCopyWithImpl;
@override @useResult
$Res call({
 String manaboBaseUrl, String alboBaseUrl, String cubicsBaseUrl, String ssoUrl, String palApiBaseUrl, int connectionTimeoutSeconds, int receiveTimeoutSeconds, int maxRetries
});




}
/// @nodoc
class __$ApiConfigCopyWithImpl<$Res>
    implements _$ApiConfigCopyWith<$Res> {
  __$ApiConfigCopyWithImpl(this._self, this._then);

  final _ApiConfig _self;
  final $Res Function(_ApiConfig) _then;

/// Create a copy of ApiConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? manaboBaseUrl = null,Object? alboBaseUrl = null,Object? cubicsBaseUrl = null,Object? ssoUrl = null,Object? palApiBaseUrl = null,Object? connectionTimeoutSeconds = null,Object? receiveTimeoutSeconds = null,Object? maxRetries = null,}) {
  return _then(_ApiConfig(
manaboBaseUrl: null == manaboBaseUrl ? _self.manaboBaseUrl : manaboBaseUrl // ignore: cast_nullable_to_non_nullable
as String,alboBaseUrl: null == alboBaseUrl ? _self.alboBaseUrl : alboBaseUrl // ignore: cast_nullable_to_non_nullable
as String,cubicsBaseUrl: null == cubicsBaseUrl ? _self.cubicsBaseUrl : cubicsBaseUrl // ignore: cast_nullable_to_non_nullable
as String,ssoUrl: null == ssoUrl ? _self.ssoUrl : ssoUrl // ignore: cast_nullable_to_non_nullable
as String,palApiBaseUrl: null == palApiBaseUrl ? _self.palApiBaseUrl : palApiBaseUrl // ignore: cast_nullable_to_non_nullable
as String,connectionTimeoutSeconds: null == connectionTimeoutSeconds ? _self.connectionTimeoutSeconds : connectionTimeoutSeconds // ignore: cast_nullable_to_non_nullable
as int,receiveTimeoutSeconds: null == receiveTimeoutSeconds ? _self.receiveTimeoutSeconds : receiveTimeoutSeconds // ignore: cast_nullable_to_non_nullable
as int,maxRetries: null == maxRetries ? _self.maxRetries : maxRetries // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
