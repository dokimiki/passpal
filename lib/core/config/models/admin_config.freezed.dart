// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminConfig {

 String get appVersion; String get minSupportedVersion; bool get isMaintenanceMode; String get maintenanceMessage;
/// Create a copy of AdminConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminConfigCopyWith<AdminConfig> get copyWith => _$AdminConfigCopyWithImpl<AdminConfig>(this as AdminConfig, _$identity);

  /// Serializes this AdminConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminConfig&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.minSupportedVersion, minSupportedVersion) || other.minSupportedVersion == minSupportedVersion)&&(identical(other.isMaintenanceMode, isMaintenanceMode) || other.isMaintenanceMode == isMaintenanceMode)&&(identical(other.maintenanceMessage, maintenanceMessage) || other.maintenanceMessage == maintenanceMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appVersion,minSupportedVersion,isMaintenanceMode,maintenanceMessage);

@override
String toString() {
  return 'AdminConfig(appVersion: $appVersion, minSupportedVersion: $minSupportedVersion, isMaintenanceMode: $isMaintenanceMode, maintenanceMessage: $maintenanceMessage)';
}


}

/// @nodoc
abstract mixin class $AdminConfigCopyWith<$Res>  {
  factory $AdminConfigCopyWith(AdminConfig value, $Res Function(AdminConfig) _then) = _$AdminConfigCopyWithImpl;
@useResult
$Res call({
 String appVersion, String minSupportedVersion, bool isMaintenanceMode, String maintenanceMessage
});




}
/// @nodoc
class _$AdminConfigCopyWithImpl<$Res>
    implements $AdminConfigCopyWith<$Res> {
  _$AdminConfigCopyWithImpl(this._self, this._then);

  final AdminConfig _self;
  final $Res Function(AdminConfig) _then;

/// Create a copy of AdminConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appVersion = null,Object? minSupportedVersion = null,Object? isMaintenanceMode = null,Object? maintenanceMessage = null,}) {
  return _then(_self.copyWith(
appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,minSupportedVersion: null == minSupportedVersion ? _self.minSupportedVersion : minSupportedVersion // ignore: cast_nullable_to_non_nullable
as String,isMaintenanceMode: null == isMaintenanceMode ? _self.isMaintenanceMode : isMaintenanceMode // ignore: cast_nullable_to_non_nullable
as bool,maintenanceMessage: null == maintenanceMessage ? _self.maintenanceMessage : maintenanceMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminConfig].
extension AdminConfigPatterns on AdminConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminConfig value)  $default,){
final _that = this;
switch (_that) {
case _AdminConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminConfig value)?  $default,){
final _that = this;
switch (_that) {
case _AdminConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String appVersion,  String minSupportedVersion,  bool isMaintenanceMode,  String maintenanceMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminConfig() when $default != null:
return $default(_that.appVersion,_that.minSupportedVersion,_that.isMaintenanceMode,_that.maintenanceMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String appVersion,  String minSupportedVersion,  bool isMaintenanceMode,  String maintenanceMessage)  $default,) {final _that = this;
switch (_that) {
case _AdminConfig():
return $default(_that.appVersion,_that.minSupportedVersion,_that.isMaintenanceMode,_that.maintenanceMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String appVersion,  String minSupportedVersion,  bool isMaintenanceMode,  String maintenanceMessage)?  $default,) {final _that = this;
switch (_that) {
case _AdminConfig() when $default != null:
return $default(_that.appVersion,_that.minSupportedVersion,_that.isMaintenanceMode,_that.maintenanceMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminConfig extends AdminConfig {
  const _AdminConfig({this.appVersion = AdminConfigDefaults.appVersion, this.minSupportedVersion = AdminConfigDefaults.minSupportedVersion, this.isMaintenanceMode = AdminConfigDefaults.isMaintenanceMode, this.maintenanceMessage = AdminConfigDefaults.maintenanceMessage}): super._();
  factory _AdminConfig.fromJson(Map<String, dynamic> json) => _$AdminConfigFromJson(json);

@override@JsonKey() final  String appVersion;
@override@JsonKey() final  String minSupportedVersion;
@override@JsonKey() final  bool isMaintenanceMode;
@override@JsonKey() final  String maintenanceMessage;

/// Create a copy of AdminConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminConfigCopyWith<_AdminConfig> get copyWith => __$AdminConfigCopyWithImpl<_AdminConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminConfig&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.minSupportedVersion, minSupportedVersion) || other.minSupportedVersion == minSupportedVersion)&&(identical(other.isMaintenanceMode, isMaintenanceMode) || other.isMaintenanceMode == isMaintenanceMode)&&(identical(other.maintenanceMessage, maintenanceMessage) || other.maintenanceMessage == maintenanceMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appVersion,minSupportedVersion,isMaintenanceMode,maintenanceMessage);

@override
String toString() {
  return 'AdminConfig(appVersion: $appVersion, minSupportedVersion: $minSupportedVersion, isMaintenanceMode: $isMaintenanceMode, maintenanceMessage: $maintenanceMessage)';
}


}

/// @nodoc
abstract mixin class _$AdminConfigCopyWith<$Res> implements $AdminConfigCopyWith<$Res> {
  factory _$AdminConfigCopyWith(_AdminConfig value, $Res Function(_AdminConfig) _then) = __$AdminConfigCopyWithImpl;
@override @useResult
$Res call({
 String appVersion, String minSupportedVersion, bool isMaintenanceMode, String maintenanceMessage
});




}
/// @nodoc
class __$AdminConfigCopyWithImpl<$Res>
    implements _$AdminConfigCopyWith<$Res> {
  __$AdminConfigCopyWithImpl(this._self, this._then);

  final _AdminConfig _self;
  final $Res Function(_AdminConfig) _then;

/// Create a copy of AdminConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appVersion = null,Object? minSupportedVersion = null,Object? isMaintenanceMode = null,Object? maintenanceMessage = null,}) {
  return _then(_AdminConfig(
appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,minSupportedVersion: null == minSupportedVersion ? _self.minSupportedVersion : minSupportedVersion // ignore: cast_nullable_to_non_nullable
as String,isMaintenanceMode: null == isMaintenanceMode ? _self.isMaintenanceMode : isMaintenanceMode // ignore: cast_nullable_to_non_nullable
as bool,maintenanceMessage: null == maintenanceMessage ? _self.maintenanceMessage : maintenanceMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
