// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feature_flags.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeatureFlags {

 bool get enableOfflineMode; bool get enablePushNotifications; bool get enableMaintenanceMode;
/// Create a copy of FeatureFlags
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeatureFlagsCopyWith<FeatureFlags> get copyWith => _$FeatureFlagsCopyWithImpl<FeatureFlags>(this as FeatureFlags, _$identity);

  /// Serializes this FeatureFlags to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeatureFlags&&(identical(other.enableOfflineMode, enableOfflineMode) || other.enableOfflineMode == enableOfflineMode)&&(identical(other.enablePushNotifications, enablePushNotifications) || other.enablePushNotifications == enablePushNotifications)&&(identical(other.enableMaintenanceMode, enableMaintenanceMode) || other.enableMaintenanceMode == enableMaintenanceMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enableOfflineMode,enablePushNotifications,enableMaintenanceMode);

@override
String toString() {
  return 'FeatureFlags(enableOfflineMode: $enableOfflineMode, enablePushNotifications: $enablePushNotifications, enableMaintenanceMode: $enableMaintenanceMode)';
}


}

/// @nodoc
abstract mixin class $FeatureFlagsCopyWith<$Res>  {
  factory $FeatureFlagsCopyWith(FeatureFlags value, $Res Function(FeatureFlags) _then) = _$FeatureFlagsCopyWithImpl;
@useResult
$Res call({
 bool enableOfflineMode, bool enablePushNotifications, bool enableMaintenanceMode
});




}
/// @nodoc
class _$FeatureFlagsCopyWithImpl<$Res>
    implements $FeatureFlagsCopyWith<$Res> {
  _$FeatureFlagsCopyWithImpl(this._self, this._then);

  final FeatureFlags _self;
  final $Res Function(FeatureFlags) _then;

/// Create a copy of FeatureFlags
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enableOfflineMode = null,Object? enablePushNotifications = null,Object? enableMaintenanceMode = null,}) {
  return _then(_self.copyWith(
enableOfflineMode: null == enableOfflineMode ? _self.enableOfflineMode : enableOfflineMode // ignore: cast_nullable_to_non_nullable
as bool,enablePushNotifications: null == enablePushNotifications ? _self.enablePushNotifications : enablePushNotifications // ignore: cast_nullable_to_non_nullable
as bool,enableMaintenanceMode: null == enableMaintenanceMode ? _self.enableMaintenanceMode : enableMaintenanceMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FeatureFlags].
extension FeatureFlagsPatterns on FeatureFlags {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeatureFlags value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeatureFlags() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeatureFlags value)  $default,){
final _that = this;
switch (_that) {
case _FeatureFlags():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeatureFlags value)?  $default,){
final _that = this;
switch (_that) {
case _FeatureFlags() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enableOfflineMode,  bool enablePushNotifications,  bool enableMaintenanceMode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeatureFlags() when $default != null:
return $default(_that.enableOfflineMode,_that.enablePushNotifications,_that.enableMaintenanceMode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enableOfflineMode,  bool enablePushNotifications,  bool enableMaintenanceMode)  $default,) {final _that = this;
switch (_that) {
case _FeatureFlags():
return $default(_that.enableOfflineMode,_that.enablePushNotifications,_that.enableMaintenanceMode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enableOfflineMode,  bool enablePushNotifications,  bool enableMaintenanceMode)?  $default,) {final _that = this;
switch (_that) {
case _FeatureFlags() when $default != null:
return $default(_that.enableOfflineMode,_that.enablePushNotifications,_that.enableMaintenanceMode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeatureFlags extends FeatureFlags {
  const _FeatureFlags({this.enableOfflineMode = true, this.enablePushNotifications = true, this.enableMaintenanceMode = false}): super._();
  factory _FeatureFlags.fromJson(Map<String, dynamic> json) => _$FeatureFlagsFromJson(json);

@override@JsonKey() final  bool enableOfflineMode;
@override@JsonKey() final  bool enablePushNotifications;
@override@JsonKey() final  bool enableMaintenanceMode;

/// Create a copy of FeatureFlags
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeatureFlagsCopyWith<_FeatureFlags> get copyWith => __$FeatureFlagsCopyWithImpl<_FeatureFlags>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeatureFlagsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeatureFlags&&(identical(other.enableOfflineMode, enableOfflineMode) || other.enableOfflineMode == enableOfflineMode)&&(identical(other.enablePushNotifications, enablePushNotifications) || other.enablePushNotifications == enablePushNotifications)&&(identical(other.enableMaintenanceMode, enableMaintenanceMode) || other.enableMaintenanceMode == enableMaintenanceMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enableOfflineMode,enablePushNotifications,enableMaintenanceMode);

@override
String toString() {
  return 'FeatureFlags(enableOfflineMode: $enableOfflineMode, enablePushNotifications: $enablePushNotifications, enableMaintenanceMode: $enableMaintenanceMode)';
}


}

/// @nodoc
abstract mixin class _$FeatureFlagsCopyWith<$Res> implements $FeatureFlagsCopyWith<$Res> {
  factory _$FeatureFlagsCopyWith(_FeatureFlags value, $Res Function(_FeatureFlags) _then) = __$FeatureFlagsCopyWithImpl;
@override @useResult
$Res call({
 bool enableOfflineMode, bool enablePushNotifications, bool enableMaintenanceMode
});




}
/// @nodoc
class __$FeatureFlagsCopyWithImpl<$Res>
    implements _$FeatureFlagsCopyWith<$Res> {
  __$FeatureFlagsCopyWithImpl(this._self, this._then);

  final _FeatureFlags _self;
  final $Res Function(_FeatureFlags) _then;

/// Create a copy of FeatureFlags
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enableOfflineMode = null,Object? enablePushNotifications = null,Object? enableMaintenanceMode = null,}) {
  return _then(_FeatureFlags(
enableOfflineMode: null == enableOfflineMode ? _self.enableOfflineMode : enableOfflineMode // ignore: cast_nullable_to_non_nullable
as bool,enablePushNotifications: null == enablePushNotifications ? _self.enablePushNotifications : enablePushNotifications // ignore: cast_nullable_to_non_nullable
as bool,enableMaintenanceMode: null == enableMaintenanceMode ? _self.enableMaintenanceMode : enableMaintenanceMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
