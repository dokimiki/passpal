// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

 String get version; bool get enableAnalytics; bool get enableCrashReporting; bool get enableDebugMode; ApiConfig get apiConfig; AuthConfig get authConfig; DebugConfig get debugConfig; FeatureFlags get featureFlags; AdminConfig get adminConfig;
/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigCopyWith<AppConfig> get copyWith => _$AppConfigCopyWithImpl<AppConfig>(this as AppConfig, _$identity);

  /// Serializes this AppConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfig&&(identical(other.version, version) || other.version == version)&&(identical(other.enableAnalytics, enableAnalytics) || other.enableAnalytics == enableAnalytics)&&(identical(other.enableCrashReporting, enableCrashReporting) || other.enableCrashReporting == enableCrashReporting)&&(identical(other.enableDebugMode, enableDebugMode) || other.enableDebugMode == enableDebugMode)&&(identical(other.apiConfig, apiConfig) || other.apiConfig == apiConfig)&&(identical(other.authConfig, authConfig) || other.authConfig == authConfig)&&(identical(other.debugConfig, debugConfig) || other.debugConfig == debugConfig)&&(identical(other.featureFlags, featureFlags) || other.featureFlags == featureFlags)&&(identical(other.adminConfig, adminConfig) || other.adminConfig == adminConfig));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,enableAnalytics,enableCrashReporting,enableDebugMode,apiConfig,authConfig,debugConfig,featureFlags,adminConfig);

@override
String toString() {
  return 'AppConfig(version: $version, enableAnalytics: $enableAnalytics, enableCrashReporting: $enableCrashReporting, enableDebugMode: $enableDebugMode, apiConfig: $apiConfig, authConfig: $authConfig, debugConfig: $debugConfig, featureFlags: $featureFlags, adminConfig: $adminConfig)';
}


}

/// @nodoc
abstract mixin class $AppConfigCopyWith<$Res>  {
  factory $AppConfigCopyWith(AppConfig value, $Res Function(AppConfig) _then) = _$AppConfigCopyWithImpl;
@useResult
$Res call({
 String version, bool enableAnalytics, bool enableCrashReporting, bool enableDebugMode, ApiConfig apiConfig, AuthConfig authConfig, DebugConfig debugConfig, FeatureFlags featureFlags, AdminConfig adminConfig
});


$ApiConfigCopyWith<$Res> get apiConfig;$AuthConfigCopyWith<$Res> get authConfig;$DebugConfigCopyWith<$Res> get debugConfig;$FeatureFlagsCopyWith<$Res> get featureFlags;$AdminConfigCopyWith<$Res> get adminConfig;

}
/// @nodoc
class _$AppConfigCopyWithImpl<$Res>
    implements $AppConfigCopyWith<$Res> {
  _$AppConfigCopyWithImpl(this._self, this._then);

  final AppConfig _self;
  final $Res Function(AppConfig) _then;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? enableAnalytics = null,Object? enableCrashReporting = null,Object? enableDebugMode = null,Object? apiConfig = null,Object? authConfig = null,Object? debugConfig = null,Object? featureFlags = null,Object? adminConfig = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,enableAnalytics: null == enableAnalytics ? _self.enableAnalytics : enableAnalytics // ignore: cast_nullable_to_non_nullable
as bool,enableCrashReporting: null == enableCrashReporting ? _self.enableCrashReporting : enableCrashReporting // ignore: cast_nullable_to_non_nullable
as bool,enableDebugMode: null == enableDebugMode ? _self.enableDebugMode : enableDebugMode // ignore: cast_nullable_to_non_nullable
as bool,apiConfig: null == apiConfig ? _self.apiConfig : apiConfig // ignore: cast_nullable_to_non_nullable
as ApiConfig,authConfig: null == authConfig ? _self.authConfig : authConfig // ignore: cast_nullable_to_non_nullable
as AuthConfig,debugConfig: null == debugConfig ? _self.debugConfig : debugConfig // ignore: cast_nullable_to_non_nullable
as DebugConfig,featureFlags: null == featureFlags ? _self.featureFlags : featureFlags // ignore: cast_nullable_to_non_nullable
as FeatureFlags,adminConfig: null == adminConfig ? _self.adminConfig : adminConfig // ignore: cast_nullable_to_non_nullable
as AdminConfig,
  ));
}
/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiConfigCopyWith<$Res> get apiConfig {
  
  return $ApiConfigCopyWith<$Res>(_self.apiConfig, (value) {
    return _then(_self.copyWith(apiConfig: value));
  });
}/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthConfigCopyWith<$Res> get authConfig {
  
  return $AuthConfigCopyWith<$Res>(_self.authConfig, (value) {
    return _then(_self.copyWith(authConfig: value));
  });
}/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DebugConfigCopyWith<$Res> get debugConfig {
  
  return $DebugConfigCopyWith<$Res>(_self.debugConfig, (value) {
    return _then(_self.copyWith(debugConfig: value));
  });
}/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeatureFlagsCopyWith<$Res> get featureFlags {
  
  return $FeatureFlagsCopyWith<$Res>(_self.featureFlags, (value) {
    return _then(_self.copyWith(featureFlags: value));
  });
}/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminConfigCopyWith<$Res> get adminConfig {
  
  return $AdminConfigCopyWith<$Res>(_self.adminConfig, (value) {
    return _then(_self.copyWith(adminConfig: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppConfig].
extension AppConfigPatterns on AppConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppConfig value)  $default,){
final _that = this;
switch (_that) {
case _AppConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppConfig value)?  $default,){
final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String version,  bool enableAnalytics,  bool enableCrashReporting,  bool enableDebugMode,  ApiConfig apiConfig,  AuthConfig authConfig,  DebugConfig debugConfig,  FeatureFlags featureFlags,  AdminConfig adminConfig)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
return $default(_that.version,_that.enableAnalytics,_that.enableCrashReporting,_that.enableDebugMode,_that.apiConfig,_that.authConfig,_that.debugConfig,_that.featureFlags,_that.adminConfig);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String version,  bool enableAnalytics,  bool enableCrashReporting,  bool enableDebugMode,  ApiConfig apiConfig,  AuthConfig authConfig,  DebugConfig debugConfig,  FeatureFlags featureFlags,  AdminConfig adminConfig)  $default,) {final _that = this;
switch (_that) {
case _AppConfig():
return $default(_that.version,_that.enableAnalytics,_that.enableCrashReporting,_that.enableDebugMode,_that.apiConfig,_that.authConfig,_that.debugConfig,_that.featureFlags,_that.adminConfig);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String version,  bool enableAnalytics,  bool enableCrashReporting,  bool enableDebugMode,  ApiConfig apiConfig,  AuthConfig authConfig,  DebugConfig debugConfig,  FeatureFlags featureFlags,  AdminConfig adminConfig)?  $default,) {final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
return $default(_that.version,_that.enableAnalytics,_that.enableCrashReporting,_that.enableDebugMode,_that.apiConfig,_that.authConfig,_that.debugConfig,_that.featureFlags,_that.adminConfig);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppConfig extends AppConfig {
  const _AppConfig({this.version = '1.0.0', this.enableAnalytics = true, this.enableCrashReporting = true, this.enableDebugMode = false, required this.apiConfig, required this.authConfig, required this.debugConfig, required this.featureFlags, required this.adminConfig}): super._();
  factory _AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);

@override@JsonKey() final  String version;
@override@JsonKey() final  bool enableAnalytics;
@override@JsonKey() final  bool enableCrashReporting;
@override@JsonKey() final  bool enableDebugMode;
@override final  ApiConfig apiConfig;
@override final  AuthConfig authConfig;
@override final  DebugConfig debugConfig;
@override final  FeatureFlags featureFlags;
@override final  AdminConfig adminConfig;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppConfig&&(identical(other.version, version) || other.version == version)&&(identical(other.enableAnalytics, enableAnalytics) || other.enableAnalytics == enableAnalytics)&&(identical(other.enableCrashReporting, enableCrashReporting) || other.enableCrashReporting == enableCrashReporting)&&(identical(other.enableDebugMode, enableDebugMode) || other.enableDebugMode == enableDebugMode)&&(identical(other.apiConfig, apiConfig) || other.apiConfig == apiConfig)&&(identical(other.authConfig, authConfig) || other.authConfig == authConfig)&&(identical(other.debugConfig, debugConfig) || other.debugConfig == debugConfig)&&(identical(other.featureFlags, featureFlags) || other.featureFlags == featureFlags)&&(identical(other.adminConfig, adminConfig) || other.adminConfig == adminConfig));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,enableAnalytics,enableCrashReporting,enableDebugMode,apiConfig,authConfig,debugConfig,featureFlags,adminConfig);

@override
String toString() {
  return 'AppConfig(version: $version, enableAnalytics: $enableAnalytics, enableCrashReporting: $enableCrashReporting, enableDebugMode: $enableDebugMode, apiConfig: $apiConfig, authConfig: $authConfig, debugConfig: $debugConfig, featureFlags: $featureFlags, adminConfig: $adminConfig)';
}


}

/// @nodoc
abstract mixin class _$AppConfigCopyWith<$Res> implements $AppConfigCopyWith<$Res> {
  factory _$AppConfigCopyWith(_AppConfig value, $Res Function(_AppConfig) _then) = __$AppConfigCopyWithImpl;
@override @useResult
$Res call({
 String version, bool enableAnalytics, bool enableCrashReporting, bool enableDebugMode, ApiConfig apiConfig, AuthConfig authConfig, DebugConfig debugConfig, FeatureFlags featureFlags, AdminConfig adminConfig
});


@override $ApiConfigCopyWith<$Res> get apiConfig;@override $AuthConfigCopyWith<$Res> get authConfig;@override $DebugConfigCopyWith<$Res> get debugConfig;@override $FeatureFlagsCopyWith<$Res> get featureFlags;@override $AdminConfigCopyWith<$Res> get adminConfig;

}
/// @nodoc
class __$AppConfigCopyWithImpl<$Res>
    implements _$AppConfigCopyWith<$Res> {
  __$AppConfigCopyWithImpl(this._self, this._then);

  final _AppConfig _self;
  final $Res Function(_AppConfig) _then;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? enableAnalytics = null,Object? enableCrashReporting = null,Object? enableDebugMode = null,Object? apiConfig = null,Object? authConfig = null,Object? debugConfig = null,Object? featureFlags = null,Object? adminConfig = null,}) {
  return _then(_AppConfig(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,enableAnalytics: null == enableAnalytics ? _self.enableAnalytics : enableAnalytics // ignore: cast_nullable_to_non_nullable
as bool,enableCrashReporting: null == enableCrashReporting ? _self.enableCrashReporting : enableCrashReporting // ignore: cast_nullable_to_non_nullable
as bool,enableDebugMode: null == enableDebugMode ? _self.enableDebugMode : enableDebugMode // ignore: cast_nullable_to_non_nullable
as bool,apiConfig: null == apiConfig ? _self.apiConfig : apiConfig // ignore: cast_nullable_to_non_nullable
as ApiConfig,authConfig: null == authConfig ? _self.authConfig : authConfig // ignore: cast_nullable_to_non_nullable
as AuthConfig,debugConfig: null == debugConfig ? _self.debugConfig : debugConfig // ignore: cast_nullable_to_non_nullable
as DebugConfig,featureFlags: null == featureFlags ? _self.featureFlags : featureFlags // ignore: cast_nullable_to_non_nullable
as FeatureFlags,adminConfig: null == adminConfig ? _self.adminConfig : adminConfig // ignore: cast_nullable_to_non_nullable
as AdminConfig,
  ));
}

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiConfigCopyWith<$Res> get apiConfig {
  
  return $ApiConfigCopyWith<$Res>(_self.apiConfig, (value) {
    return _then(_self.copyWith(apiConfig: value));
  });
}/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthConfigCopyWith<$Res> get authConfig {
  
  return $AuthConfigCopyWith<$Res>(_self.authConfig, (value) {
    return _then(_self.copyWith(authConfig: value));
  });
}/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DebugConfigCopyWith<$Res> get debugConfig {
  
  return $DebugConfigCopyWith<$Res>(_self.debugConfig, (value) {
    return _then(_self.copyWith(debugConfig: value));
  });
}/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeatureFlagsCopyWith<$Res> get featureFlags {
  
  return $FeatureFlagsCopyWith<$Res>(_self.featureFlags, (value) {
    return _then(_self.copyWith(featureFlags: value));
  });
}/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminConfigCopyWith<$Res> get adminConfig {
  
  return $AdminConfigCopyWith<$Res>(_self.adminConfig, (value) {
    return _then(_self.copyWith(adminConfig: value));
  });
}
}

// dart format on
