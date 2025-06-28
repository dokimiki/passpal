// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppConfig {

 ApiConfig get api; FeatureFlags get features; DebugConfig get debug; AdminConfig get admin; AuthConfig get auth;
/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigCopyWith<AppConfig> get copyWith => _$AppConfigCopyWithImpl<AppConfig>(this as AppConfig, _$identity);

  /// Serializes this AppConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfig&&(identical(other.api, api) || other.api == api)&&(identical(other.features, features) || other.features == features)&&(identical(other.debug, debug) || other.debug == debug)&&(identical(other.admin, admin) || other.admin == admin)&&(identical(other.auth, auth) || other.auth == auth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,api,features,debug,admin,auth);

@override
String toString() {
  return 'AppConfig(api: $api, features: $features, debug: $debug, admin: $admin, auth: $auth)';
}


}

/// @nodoc
abstract mixin class $AppConfigCopyWith<$Res>  {
  factory $AppConfigCopyWith(AppConfig value, $Res Function(AppConfig) _then) = _$AppConfigCopyWithImpl;
@useResult
$Res call({
 ApiConfig api, FeatureFlags features, DebugConfig debug, AdminConfig admin, AuthConfig auth
});


$ApiConfigCopyWith<$Res> get api;$FeatureFlagsCopyWith<$Res> get features;$DebugConfigCopyWith<$Res> get debug;$AdminConfigCopyWith<$Res> get admin;$AuthConfigCopyWith<$Res> get auth;

}
/// @nodoc
class _$AppConfigCopyWithImpl<$Res>
    implements $AppConfigCopyWith<$Res> {
  _$AppConfigCopyWithImpl(this._self, this._then);

  final AppConfig _self;
  final $Res Function(AppConfig) _then;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? api = null,Object? features = null,Object? debug = null,Object? admin = null,Object? auth = null,}) {
  return _then(_self.copyWith(
api: null == api ? _self.api : api // ignore: cast_nullable_to_non_nullable
as ApiConfig,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as FeatureFlags,debug: null == debug ? _self.debug : debug // ignore: cast_nullable_to_non_nullable
as DebugConfig,admin: null == admin ? _self.admin : admin // ignore: cast_nullable_to_non_nullable
as AdminConfig,auth: null == auth ? _self.auth : auth // ignore: cast_nullable_to_non_nullable
as AuthConfig,
  ));
}
/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiConfigCopyWith<$Res> get api {
  
  return $ApiConfigCopyWith<$Res>(_self.api, (value) {
    return _then(_self.copyWith(api: value));
  });
}/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeatureFlagsCopyWith<$Res> get features {
  
  return $FeatureFlagsCopyWith<$Res>(_self.features, (value) {
    return _then(_self.copyWith(features: value));
  });
}/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DebugConfigCopyWith<$Res> get debug {
  
  return $DebugConfigCopyWith<$Res>(_self.debug, (value) {
    return _then(_self.copyWith(debug: value));
  });
}/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminConfigCopyWith<$Res> get admin {
  
  return $AdminConfigCopyWith<$Res>(_self.admin, (value) {
    return _then(_self.copyWith(admin: value));
  });
}/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthConfigCopyWith<$Res> get auth {
  
  return $AuthConfigCopyWith<$Res>(_self.auth, (value) {
    return _then(_self.copyWith(auth: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _AppConfig implements AppConfig {
  const _AppConfig({required this.api, required this.features, required this.debug, required this.admin, required this.auth});
  factory _AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);

@override final  ApiConfig api;
@override final  FeatureFlags features;
@override final  DebugConfig debug;
@override final  AdminConfig admin;
@override final  AuthConfig auth;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppConfigCopyWith<_AppConfig> get copyWith => __$AppConfigCopyWithImpl<_AppConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppConfig&&(identical(other.api, api) || other.api == api)&&(identical(other.features, features) || other.features == features)&&(identical(other.debug, debug) || other.debug == debug)&&(identical(other.admin, admin) || other.admin == admin)&&(identical(other.auth, auth) || other.auth == auth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,api,features,debug,admin,auth);

@override
String toString() {
  return 'AppConfig(api: $api, features: $features, debug: $debug, admin: $admin, auth: $auth)';
}


}

/// @nodoc
abstract mixin class _$AppConfigCopyWith<$Res> implements $AppConfigCopyWith<$Res> {
  factory _$AppConfigCopyWith(_AppConfig value, $Res Function(_AppConfig) _then) = __$AppConfigCopyWithImpl;
@override @useResult
$Res call({
 ApiConfig api, FeatureFlags features, DebugConfig debug, AdminConfig admin, AuthConfig auth
});


@override $ApiConfigCopyWith<$Res> get api;@override $FeatureFlagsCopyWith<$Res> get features;@override $DebugConfigCopyWith<$Res> get debug;@override $AdminConfigCopyWith<$Res> get admin;@override $AuthConfigCopyWith<$Res> get auth;

}
/// @nodoc
class __$AppConfigCopyWithImpl<$Res>
    implements _$AppConfigCopyWith<$Res> {
  __$AppConfigCopyWithImpl(this._self, this._then);

  final _AppConfig _self;
  final $Res Function(_AppConfig) _then;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? api = null,Object? features = null,Object? debug = null,Object? admin = null,Object? auth = null,}) {
  return _then(_AppConfig(
api: null == api ? _self.api : api // ignore: cast_nullable_to_non_nullable
as ApiConfig,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as FeatureFlags,debug: null == debug ? _self.debug : debug // ignore: cast_nullable_to_non_nullable
as DebugConfig,admin: null == admin ? _self.admin : admin // ignore: cast_nullable_to_non_nullable
as AdminConfig,auth: null == auth ? _self.auth : auth // ignore: cast_nullable_to_non_nullable
as AuthConfig,
  ));
}

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiConfigCopyWith<$Res> get api {
  
  return $ApiConfigCopyWith<$Res>(_self.api, (value) {
    return _then(_self.copyWith(api: value));
  });
}/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeatureFlagsCopyWith<$Res> get features {
  
  return $FeatureFlagsCopyWith<$Res>(_self.features, (value) {
    return _then(_self.copyWith(features: value));
  });
}/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DebugConfigCopyWith<$Res> get debug {
  
  return $DebugConfigCopyWith<$Res>(_self.debug, (value) {
    return _then(_self.copyWith(debug: value));
  });
}/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminConfigCopyWith<$Res> get admin {
  
  return $AdminConfigCopyWith<$Res>(_self.admin, (value) {
    return _then(_self.copyWith(admin: value));
  });
}/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthConfigCopyWith<$Res> get auth {
  
  return $AuthConfigCopyWith<$Res>(_self.auth, (value) {
    return _then(_self.copyWith(auth: value));
  });
}
}

// dart format on
