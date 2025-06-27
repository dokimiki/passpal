// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_constraints.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskConstraints {

 bool get networkRequired; bool get chargingRequired; bool get deviceIdleRequired; bool get batteryNotLowRequired; bool get storageNotLowRequired;
/// Create a copy of TaskConstraints
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskConstraintsCopyWith<TaskConstraints> get copyWith => _$TaskConstraintsCopyWithImpl<TaskConstraints>(this as TaskConstraints, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskConstraints&&(identical(other.networkRequired, networkRequired) || other.networkRequired == networkRequired)&&(identical(other.chargingRequired, chargingRequired) || other.chargingRequired == chargingRequired)&&(identical(other.deviceIdleRequired, deviceIdleRequired) || other.deviceIdleRequired == deviceIdleRequired)&&(identical(other.batteryNotLowRequired, batteryNotLowRequired) || other.batteryNotLowRequired == batteryNotLowRequired)&&(identical(other.storageNotLowRequired, storageNotLowRequired) || other.storageNotLowRequired == storageNotLowRequired));
}


@override
int get hashCode => Object.hash(runtimeType,networkRequired,chargingRequired,deviceIdleRequired,batteryNotLowRequired,storageNotLowRequired);

@override
String toString() {
  return 'TaskConstraints(networkRequired: $networkRequired, chargingRequired: $chargingRequired, deviceIdleRequired: $deviceIdleRequired, batteryNotLowRequired: $batteryNotLowRequired, storageNotLowRequired: $storageNotLowRequired)';
}


}

/// @nodoc
abstract mixin class $TaskConstraintsCopyWith<$Res>  {
  factory $TaskConstraintsCopyWith(TaskConstraints value, $Res Function(TaskConstraints) _then) = _$TaskConstraintsCopyWithImpl;
@useResult
$Res call({
 bool networkRequired, bool chargingRequired, bool deviceIdleRequired, bool batteryNotLowRequired, bool storageNotLowRequired
});




}
/// @nodoc
class _$TaskConstraintsCopyWithImpl<$Res>
    implements $TaskConstraintsCopyWith<$Res> {
  _$TaskConstraintsCopyWithImpl(this._self, this._then);

  final TaskConstraints _self;
  final $Res Function(TaskConstraints) _then;

/// Create a copy of TaskConstraints
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? networkRequired = null,Object? chargingRequired = null,Object? deviceIdleRequired = null,Object? batteryNotLowRequired = null,Object? storageNotLowRequired = null,}) {
  return _then(_self.copyWith(
networkRequired: null == networkRequired ? _self.networkRequired : networkRequired // ignore: cast_nullable_to_non_nullable
as bool,chargingRequired: null == chargingRequired ? _self.chargingRequired : chargingRequired // ignore: cast_nullable_to_non_nullable
as bool,deviceIdleRequired: null == deviceIdleRequired ? _self.deviceIdleRequired : deviceIdleRequired // ignore: cast_nullable_to_non_nullable
as bool,batteryNotLowRequired: null == batteryNotLowRequired ? _self.batteryNotLowRequired : batteryNotLowRequired // ignore: cast_nullable_to_non_nullable
as bool,storageNotLowRequired: null == storageNotLowRequired ? _self.storageNotLowRequired : storageNotLowRequired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _TaskConstraints implements TaskConstraints {
  const _TaskConstraints({this.networkRequired = false, this.chargingRequired = false, this.deviceIdleRequired = false, this.batteryNotLowRequired = false, this.storageNotLowRequired = false});
  

@override@JsonKey() final  bool networkRequired;
@override@JsonKey() final  bool chargingRequired;
@override@JsonKey() final  bool deviceIdleRequired;
@override@JsonKey() final  bool batteryNotLowRequired;
@override@JsonKey() final  bool storageNotLowRequired;

/// Create a copy of TaskConstraints
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskConstraintsCopyWith<_TaskConstraints> get copyWith => __$TaskConstraintsCopyWithImpl<_TaskConstraints>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskConstraints&&(identical(other.networkRequired, networkRequired) || other.networkRequired == networkRequired)&&(identical(other.chargingRequired, chargingRequired) || other.chargingRequired == chargingRequired)&&(identical(other.deviceIdleRequired, deviceIdleRequired) || other.deviceIdleRequired == deviceIdleRequired)&&(identical(other.batteryNotLowRequired, batteryNotLowRequired) || other.batteryNotLowRequired == batteryNotLowRequired)&&(identical(other.storageNotLowRequired, storageNotLowRequired) || other.storageNotLowRequired == storageNotLowRequired));
}


@override
int get hashCode => Object.hash(runtimeType,networkRequired,chargingRequired,deviceIdleRequired,batteryNotLowRequired,storageNotLowRequired);

@override
String toString() {
  return 'TaskConstraints(networkRequired: $networkRequired, chargingRequired: $chargingRequired, deviceIdleRequired: $deviceIdleRequired, batteryNotLowRequired: $batteryNotLowRequired, storageNotLowRequired: $storageNotLowRequired)';
}


}

/// @nodoc
abstract mixin class _$TaskConstraintsCopyWith<$Res> implements $TaskConstraintsCopyWith<$Res> {
  factory _$TaskConstraintsCopyWith(_TaskConstraints value, $Res Function(_TaskConstraints) _then) = __$TaskConstraintsCopyWithImpl;
@override @useResult
$Res call({
 bool networkRequired, bool chargingRequired, bool deviceIdleRequired, bool batteryNotLowRequired, bool storageNotLowRequired
});




}
/// @nodoc
class __$TaskConstraintsCopyWithImpl<$Res>
    implements _$TaskConstraintsCopyWith<$Res> {
  __$TaskConstraintsCopyWithImpl(this._self, this._then);

  final _TaskConstraints _self;
  final $Res Function(_TaskConstraints) _then;

/// Create a copy of TaskConstraints
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? networkRequired = null,Object? chargingRequired = null,Object? deviceIdleRequired = null,Object? batteryNotLowRequired = null,Object? storageNotLowRequired = null,}) {
  return _then(_TaskConstraints(
networkRequired: null == networkRequired ? _self.networkRequired : networkRequired // ignore: cast_nullable_to_non_nullable
as bool,chargingRequired: null == chargingRequired ? _self.chargingRequired : chargingRequired // ignore: cast_nullable_to_non_nullable
as bool,deviceIdleRequired: null == deviceIdleRequired ? _self.deviceIdleRequired : deviceIdleRequired // ignore: cast_nullable_to_non_nullable
as bool,batteryNotLowRequired: null == batteryNotLowRequired ? _self.batteryNotLowRequired : batteryNotLowRequired // ignore: cast_nullable_to_non_nullable
as bool,storageNotLowRequired: null == storageNotLowRequired ? _self.storageNotLowRequired : storageNotLowRequired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
