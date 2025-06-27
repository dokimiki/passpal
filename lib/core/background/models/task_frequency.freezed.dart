// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_frequency.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskFrequency {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskFrequency);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskFrequency()';
}


}

/// @nodoc
class $TaskFrequencyCopyWith<$Res>  {
$TaskFrequencyCopyWith(TaskFrequency _, $Res Function(TaskFrequency) __);
}


/// @nodoc


class TaskFrequencyOneShot implements TaskFrequency {
  const TaskFrequencyOneShot();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskFrequencyOneShot);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskFrequency.oneShot()';
}


}




/// @nodoc


class TaskFrequencyPeriodic implements TaskFrequency {
  const TaskFrequencyPeriodic({required this.interval});
  

 final  Duration interval;

/// Create a copy of TaskFrequency
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskFrequencyPeriodicCopyWith<TaskFrequencyPeriodic> get copyWith => _$TaskFrequencyPeriodicCopyWithImpl<TaskFrequencyPeriodic>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskFrequencyPeriodic&&(identical(other.interval, interval) || other.interval == interval));
}


@override
int get hashCode => Object.hash(runtimeType,interval);

@override
String toString() {
  return 'TaskFrequency.periodic(interval: $interval)';
}


}

/// @nodoc
abstract mixin class $TaskFrequencyPeriodicCopyWith<$Res> implements $TaskFrequencyCopyWith<$Res> {
  factory $TaskFrequencyPeriodicCopyWith(TaskFrequencyPeriodic value, $Res Function(TaskFrequencyPeriodic) _then) = _$TaskFrequencyPeriodicCopyWithImpl;
@useResult
$Res call({
 Duration interval
});




}
/// @nodoc
class _$TaskFrequencyPeriodicCopyWithImpl<$Res>
    implements $TaskFrequencyPeriodicCopyWith<$Res> {
  _$TaskFrequencyPeriodicCopyWithImpl(this._self, this._then);

  final TaskFrequencyPeriodic _self;
  final $Res Function(TaskFrequencyPeriodic) _then;

/// Create a copy of TaskFrequency
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? interval = null,}) {
  return _then(TaskFrequencyPeriodic(
interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

/// @nodoc


class TaskFrequencyImmediate implements TaskFrequency {
  const TaskFrequencyImmediate();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskFrequencyImmediate);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskFrequency.immediate()';
}


}




// dart format on
