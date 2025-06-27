// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskResult {

 int get executionTimeMs;
/// Create a copy of TaskResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskResultCopyWith<TaskResult> get copyWith => _$TaskResultCopyWithImpl<TaskResult>(this as TaskResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskResult&&(identical(other.executionTimeMs, executionTimeMs) || other.executionTimeMs == executionTimeMs));
}


@override
int get hashCode => Object.hash(runtimeType,executionTimeMs);

@override
String toString() {
  return 'TaskResult(executionTimeMs: $executionTimeMs)';
}


}

/// @nodoc
abstract mixin class $TaskResultCopyWith<$Res>  {
  factory $TaskResultCopyWith(TaskResult value, $Res Function(TaskResult) _then) = _$TaskResultCopyWithImpl;
@useResult
$Res call({
 int executionTimeMs
});




}
/// @nodoc
class _$TaskResultCopyWithImpl<$Res>
    implements $TaskResultCopyWith<$Res> {
  _$TaskResultCopyWithImpl(this._self, this._then);

  final TaskResult _self;
  final $Res Function(TaskResult) _then;

/// Create a copy of TaskResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? executionTimeMs = null,}) {
  return _then(_self.copyWith(
executionTimeMs: null == executionTimeMs ? _self.executionTimeMs : executionTimeMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class TaskResultSuccess implements TaskResult {
  const TaskResultSuccess({this.data, this.executionTimeMs = 0});
  

 final  String? data;
@override@JsonKey() final  int executionTimeMs;

/// Create a copy of TaskResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskResultSuccessCopyWith<TaskResultSuccess> get copyWith => _$TaskResultSuccessCopyWithImpl<TaskResultSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskResultSuccess&&(identical(other.data, data) || other.data == data)&&(identical(other.executionTimeMs, executionTimeMs) || other.executionTimeMs == executionTimeMs));
}


@override
int get hashCode => Object.hash(runtimeType,data,executionTimeMs);

@override
String toString() {
  return 'TaskResult.success(data: $data, executionTimeMs: $executionTimeMs)';
}


}

/// @nodoc
abstract mixin class $TaskResultSuccessCopyWith<$Res> implements $TaskResultCopyWith<$Res> {
  factory $TaskResultSuccessCopyWith(TaskResultSuccess value, $Res Function(TaskResultSuccess) _then) = _$TaskResultSuccessCopyWithImpl;
@override @useResult
$Res call({
 String? data, int executionTimeMs
});




}
/// @nodoc
class _$TaskResultSuccessCopyWithImpl<$Res>
    implements $TaskResultSuccessCopyWith<$Res> {
  _$TaskResultSuccessCopyWithImpl(this._self, this._then);

  final TaskResultSuccess _self;
  final $Res Function(TaskResultSuccess) _then;

/// Create a copy of TaskResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? executionTimeMs = null,}) {
  return _then(TaskResultSuccess(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,executionTimeMs: null == executionTimeMs ? _self.executionTimeMs : executionTimeMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class TaskResultFailure implements TaskResult {
  const TaskResultFailure({required this.error, this.stackTrace, this.executionTimeMs = 0, this.shouldRetry = false});
  

 final  String error;
 final  StackTrace? stackTrace;
@override@JsonKey() final  int executionTimeMs;
@JsonKey() final  bool shouldRetry;

/// Create a copy of TaskResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskResultFailureCopyWith<TaskResultFailure> get copyWith => _$TaskResultFailureCopyWithImpl<TaskResultFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskResultFailure&&(identical(other.error, error) || other.error == error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.executionTimeMs, executionTimeMs) || other.executionTimeMs == executionTimeMs)&&(identical(other.shouldRetry, shouldRetry) || other.shouldRetry == shouldRetry));
}


@override
int get hashCode => Object.hash(runtimeType,error,stackTrace,executionTimeMs,shouldRetry);

@override
String toString() {
  return 'TaskResult.failure(error: $error, stackTrace: $stackTrace, executionTimeMs: $executionTimeMs, shouldRetry: $shouldRetry)';
}


}

/// @nodoc
abstract mixin class $TaskResultFailureCopyWith<$Res> implements $TaskResultCopyWith<$Res> {
  factory $TaskResultFailureCopyWith(TaskResultFailure value, $Res Function(TaskResultFailure) _then) = _$TaskResultFailureCopyWithImpl;
@override @useResult
$Res call({
 String error, StackTrace? stackTrace, int executionTimeMs, bool shouldRetry
});




}
/// @nodoc
class _$TaskResultFailureCopyWithImpl<$Res>
    implements $TaskResultFailureCopyWith<$Res> {
  _$TaskResultFailureCopyWithImpl(this._self, this._then);

  final TaskResultFailure _self;
  final $Res Function(TaskResultFailure) _then;

/// Create a copy of TaskResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = null,Object? stackTrace = freezed,Object? executionTimeMs = null,Object? shouldRetry = null,}) {
  return _then(TaskResultFailure(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,executionTimeMs: null == executionTimeMs ? _self.executionTimeMs : executionTimeMs // ignore: cast_nullable_to_non_nullable
as int,shouldRetry: null == shouldRetry ? _self.shouldRetry : shouldRetry // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class TaskResultCancelled implements TaskResult {
  const TaskResultCancelled({this.reason, this.executionTimeMs = 0});
  

 final  String? reason;
@override@JsonKey() final  int executionTimeMs;

/// Create a copy of TaskResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskResultCancelledCopyWith<TaskResultCancelled> get copyWith => _$TaskResultCancelledCopyWithImpl<TaskResultCancelled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskResultCancelled&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.executionTimeMs, executionTimeMs) || other.executionTimeMs == executionTimeMs));
}


@override
int get hashCode => Object.hash(runtimeType,reason,executionTimeMs);

@override
String toString() {
  return 'TaskResult.cancelled(reason: $reason, executionTimeMs: $executionTimeMs)';
}


}

/// @nodoc
abstract mixin class $TaskResultCancelledCopyWith<$Res> implements $TaskResultCopyWith<$Res> {
  factory $TaskResultCancelledCopyWith(TaskResultCancelled value, $Res Function(TaskResultCancelled) _then) = _$TaskResultCancelledCopyWithImpl;
@override @useResult
$Res call({
 String? reason, int executionTimeMs
});




}
/// @nodoc
class _$TaskResultCancelledCopyWithImpl<$Res>
    implements $TaskResultCancelledCopyWith<$Res> {
  _$TaskResultCancelledCopyWithImpl(this._self, this._then);

  final TaskResultCancelled _self;
  final $Res Function(TaskResultCancelled) _then;

/// Create a copy of TaskResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reason = freezed,Object? executionTimeMs = null,}) {
  return _then(TaskResultCancelled(
reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,executionTimeMs: null == executionTimeMs ? _self.executionTimeMs : executionTimeMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
