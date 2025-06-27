// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'background_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BackgroundTask {

 String get id; TaskFrequency get frequency; BackgroundTaskHandler get handler; TaskConstraints get constraints; Duration? get initialDelay; Duration? get timeout; Map<String, dynamic> get data;
/// Create a copy of BackgroundTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackgroundTaskCopyWith<BackgroundTask> get copyWith => _$BackgroundTaskCopyWithImpl<BackgroundTask>(this as BackgroundTask, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackgroundTask&&(identical(other.id, id) || other.id == id)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.handler, handler) || other.handler == handler)&&(identical(other.constraints, constraints) || other.constraints == constraints)&&(identical(other.initialDelay, initialDelay) || other.initialDelay == initialDelay)&&(identical(other.timeout, timeout) || other.timeout == timeout)&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,id,frequency,handler,constraints,initialDelay,timeout,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'BackgroundTask(id: $id, frequency: $frequency, handler: $handler, constraints: $constraints, initialDelay: $initialDelay, timeout: $timeout, data: $data)';
}


}

/// @nodoc
abstract mixin class $BackgroundTaskCopyWith<$Res>  {
  factory $BackgroundTaskCopyWith(BackgroundTask value, $Res Function(BackgroundTask) _then) = _$BackgroundTaskCopyWithImpl;
@useResult
$Res call({
 String id, TaskFrequency frequency, BackgroundTaskHandler handler, TaskConstraints constraints, Duration? initialDelay, Duration? timeout, Map<String, dynamic> data
});


$TaskFrequencyCopyWith<$Res> get frequency;$TaskConstraintsCopyWith<$Res> get constraints;

}
/// @nodoc
class _$BackgroundTaskCopyWithImpl<$Res>
    implements $BackgroundTaskCopyWith<$Res> {
  _$BackgroundTaskCopyWithImpl(this._self, this._then);

  final BackgroundTask _self;
  final $Res Function(BackgroundTask) _then;

/// Create a copy of BackgroundTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? frequency = null,Object? handler = null,Object? constraints = null,Object? initialDelay = freezed,Object? timeout = freezed,Object? data = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as TaskFrequency,handler: null == handler ? _self.handler : handler // ignore: cast_nullable_to_non_nullable
as BackgroundTaskHandler,constraints: null == constraints ? _self.constraints : constraints // ignore: cast_nullable_to_non_nullable
as TaskConstraints,initialDelay: freezed == initialDelay ? _self.initialDelay : initialDelay // ignore: cast_nullable_to_non_nullable
as Duration?,timeout: freezed == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as Duration?,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}
/// Create a copy of BackgroundTask
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskFrequencyCopyWith<$Res> get frequency {
  
  return $TaskFrequencyCopyWith<$Res>(_self.frequency, (value) {
    return _then(_self.copyWith(frequency: value));
  });
}/// Create a copy of BackgroundTask
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskConstraintsCopyWith<$Res> get constraints {
  
  return $TaskConstraintsCopyWith<$Res>(_self.constraints, (value) {
    return _then(_self.copyWith(constraints: value));
  });
}
}


/// @nodoc


class _BackgroundTask implements BackgroundTask {
  const _BackgroundTask({required this.id, required this.frequency, required this.handler, this.constraints = const TaskConstraints(), this.initialDelay, this.timeout, final  Map<String, dynamic> data = const {}}): _data = data;
  

@override final  String id;
@override final  TaskFrequency frequency;
@override final  BackgroundTaskHandler handler;
@override@JsonKey() final  TaskConstraints constraints;
@override final  Duration? initialDelay;
@override final  Duration? timeout;
 final  Map<String, dynamic> _data;
@override@JsonKey() Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}


/// Create a copy of BackgroundTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackgroundTaskCopyWith<_BackgroundTask> get copyWith => __$BackgroundTaskCopyWithImpl<_BackgroundTask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackgroundTask&&(identical(other.id, id) || other.id == id)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.handler, handler) || other.handler == handler)&&(identical(other.constraints, constraints) || other.constraints == constraints)&&(identical(other.initialDelay, initialDelay) || other.initialDelay == initialDelay)&&(identical(other.timeout, timeout) || other.timeout == timeout)&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,id,frequency,handler,constraints,initialDelay,timeout,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'BackgroundTask(id: $id, frequency: $frequency, handler: $handler, constraints: $constraints, initialDelay: $initialDelay, timeout: $timeout, data: $data)';
}


}

/// @nodoc
abstract mixin class _$BackgroundTaskCopyWith<$Res> implements $BackgroundTaskCopyWith<$Res> {
  factory _$BackgroundTaskCopyWith(_BackgroundTask value, $Res Function(_BackgroundTask) _then) = __$BackgroundTaskCopyWithImpl;
@override @useResult
$Res call({
 String id, TaskFrequency frequency, BackgroundTaskHandler handler, TaskConstraints constraints, Duration? initialDelay, Duration? timeout, Map<String, dynamic> data
});


@override $TaskFrequencyCopyWith<$Res> get frequency;@override $TaskConstraintsCopyWith<$Res> get constraints;

}
/// @nodoc
class __$BackgroundTaskCopyWithImpl<$Res>
    implements _$BackgroundTaskCopyWith<$Res> {
  __$BackgroundTaskCopyWithImpl(this._self, this._then);

  final _BackgroundTask _self;
  final $Res Function(_BackgroundTask) _then;

/// Create a copy of BackgroundTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? frequency = null,Object? handler = null,Object? constraints = null,Object? initialDelay = freezed,Object? timeout = freezed,Object? data = null,}) {
  return _then(_BackgroundTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as TaskFrequency,handler: null == handler ? _self.handler : handler // ignore: cast_nullable_to_non_nullable
as BackgroundTaskHandler,constraints: null == constraints ? _self.constraints : constraints // ignore: cast_nullable_to_non_nullable
as TaskConstraints,initialDelay: freezed == initialDelay ? _self.initialDelay : initialDelay // ignore: cast_nullable_to_non_nullable
as Duration?,timeout: freezed == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as Duration?,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of BackgroundTask
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskFrequencyCopyWith<$Res> get frequency {
  
  return $TaskFrequencyCopyWith<$Res>(_self.frequency, (value) {
    return _then(_self.copyWith(frequency: value));
  });
}/// Create a copy of BackgroundTask
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskConstraintsCopyWith<$Res> get constraints {
  
  return $TaskConstraintsCopyWith<$Res>(_self.constraints, (value) {
    return _then(_self.copyWith(constraints: value));
  });
}
}

// dart format on
