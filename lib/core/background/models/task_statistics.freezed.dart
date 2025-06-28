// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskStatistics {

 int get totalExecutions; int get successfulExecutions; int get failedExecutions; int get averageExecutionTimeMs; DateTime? get lastExecution; Map<String, int> get errorCounts;
/// Create a copy of TaskStatistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskStatisticsCopyWith<TaskStatistics> get copyWith => _$TaskStatisticsCopyWithImpl<TaskStatistics>(this as TaskStatistics, _$identity);

  /// Serializes this TaskStatistics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskStatistics&&(identical(other.totalExecutions, totalExecutions) || other.totalExecutions == totalExecutions)&&(identical(other.successfulExecutions, successfulExecutions) || other.successfulExecutions == successfulExecutions)&&(identical(other.failedExecutions, failedExecutions) || other.failedExecutions == failedExecutions)&&(identical(other.averageExecutionTimeMs, averageExecutionTimeMs) || other.averageExecutionTimeMs == averageExecutionTimeMs)&&(identical(other.lastExecution, lastExecution) || other.lastExecution == lastExecution)&&const DeepCollectionEquality().equals(other.errorCounts, errorCounts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalExecutions,successfulExecutions,failedExecutions,averageExecutionTimeMs,lastExecution,const DeepCollectionEquality().hash(errorCounts));

@override
String toString() {
  return 'TaskStatistics(totalExecutions: $totalExecutions, successfulExecutions: $successfulExecutions, failedExecutions: $failedExecutions, averageExecutionTimeMs: $averageExecutionTimeMs, lastExecution: $lastExecution, errorCounts: $errorCounts)';
}


}

/// @nodoc
abstract mixin class $TaskStatisticsCopyWith<$Res>  {
  factory $TaskStatisticsCopyWith(TaskStatistics value, $Res Function(TaskStatistics) _then) = _$TaskStatisticsCopyWithImpl;
@useResult
$Res call({
 int totalExecutions, int successfulExecutions, int failedExecutions, int averageExecutionTimeMs, DateTime? lastExecution, Map<String, int> errorCounts
});




}
/// @nodoc
class _$TaskStatisticsCopyWithImpl<$Res>
    implements $TaskStatisticsCopyWith<$Res> {
  _$TaskStatisticsCopyWithImpl(this._self, this._then);

  final TaskStatistics _self;
  final $Res Function(TaskStatistics) _then;

/// Create a copy of TaskStatistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalExecutions = null,Object? successfulExecutions = null,Object? failedExecutions = null,Object? averageExecutionTimeMs = null,Object? lastExecution = freezed,Object? errorCounts = null,}) {
  return _then(_self.copyWith(
totalExecutions: null == totalExecutions ? _self.totalExecutions : totalExecutions // ignore: cast_nullable_to_non_nullable
as int,successfulExecutions: null == successfulExecutions ? _self.successfulExecutions : successfulExecutions // ignore: cast_nullable_to_non_nullable
as int,failedExecutions: null == failedExecutions ? _self.failedExecutions : failedExecutions // ignore: cast_nullable_to_non_nullable
as int,averageExecutionTimeMs: null == averageExecutionTimeMs ? _self.averageExecutionTimeMs : averageExecutionTimeMs // ignore: cast_nullable_to_non_nullable
as int,lastExecution: freezed == lastExecution ? _self.lastExecution : lastExecution // ignore: cast_nullable_to_non_nullable
as DateTime?,errorCounts: null == errorCounts ? _self.errorCounts : errorCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TaskStatistics implements TaskStatistics {
  const _TaskStatistics({this.totalExecutions = 0, this.successfulExecutions = 0, this.failedExecutions = 0, this.averageExecutionTimeMs = 0, this.lastExecution, final  Map<String, int> errorCounts = const {}}): _errorCounts = errorCounts;
  factory _TaskStatistics.fromJson(Map<String, dynamic> json) => _$TaskStatisticsFromJson(json);

@override@JsonKey() final  int totalExecutions;
@override@JsonKey() final  int successfulExecutions;
@override@JsonKey() final  int failedExecutions;
@override@JsonKey() final  int averageExecutionTimeMs;
@override final  DateTime? lastExecution;
 final  Map<String, int> _errorCounts;
@override@JsonKey() Map<String, int> get errorCounts {
  if (_errorCounts is EqualUnmodifiableMapView) return _errorCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_errorCounts);
}


/// Create a copy of TaskStatistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskStatisticsCopyWith<_TaskStatistics> get copyWith => __$TaskStatisticsCopyWithImpl<_TaskStatistics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskStatisticsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskStatistics&&(identical(other.totalExecutions, totalExecutions) || other.totalExecutions == totalExecutions)&&(identical(other.successfulExecutions, successfulExecutions) || other.successfulExecutions == successfulExecutions)&&(identical(other.failedExecutions, failedExecutions) || other.failedExecutions == failedExecutions)&&(identical(other.averageExecutionTimeMs, averageExecutionTimeMs) || other.averageExecutionTimeMs == averageExecutionTimeMs)&&(identical(other.lastExecution, lastExecution) || other.lastExecution == lastExecution)&&const DeepCollectionEquality().equals(other._errorCounts, _errorCounts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalExecutions,successfulExecutions,failedExecutions,averageExecutionTimeMs,lastExecution,const DeepCollectionEquality().hash(_errorCounts));

@override
String toString() {
  return 'TaskStatistics(totalExecutions: $totalExecutions, successfulExecutions: $successfulExecutions, failedExecutions: $failedExecutions, averageExecutionTimeMs: $averageExecutionTimeMs, lastExecution: $lastExecution, errorCounts: $errorCounts)';
}


}

/// @nodoc
abstract mixin class _$TaskStatisticsCopyWith<$Res> implements $TaskStatisticsCopyWith<$Res> {
  factory _$TaskStatisticsCopyWith(_TaskStatistics value, $Res Function(_TaskStatistics) _then) = __$TaskStatisticsCopyWithImpl;
@override @useResult
$Res call({
 int totalExecutions, int successfulExecutions, int failedExecutions, int averageExecutionTimeMs, DateTime? lastExecution, Map<String, int> errorCounts
});




}
/// @nodoc
class __$TaskStatisticsCopyWithImpl<$Res>
    implements _$TaskStatisticsCopyWith<$Res> {
  __$TaskStatisticsCopyWithImpl(this._self, this._then);

  final _TaskStatistics _self;
  final $Res Function(_TaskStatistics) _then;

/// Create a copy of TaskStatistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalExecutions = null,Object? successfulExecutions = null,Object? failedExecutions = null,Object? averageExecutionTimeMs = null,Object? lastExecution = freezed,Object? errorCounts = null,}) {
  return _then(_TaskStatistics(
totalExecutions: null == totalExecutions ? _self.totalExecutions : totalExecutions // ignore: cast_nullable_to_non_nullable
as int,successfulExecutions: null == successfulExecutions ? _self.successfulExecutions : successfulExecutions // ignore: cast_nullable_to_non_nullable
as int,failedExecutions: null == failedExecutions ? _self.failedExecutions : failedExecutions // ignore: cast_nullable_to_non_nullable
as int,averageExecutionTimeMs: null == averageExecutionTimeMs ? _self.averageExecutionTimeMs : averageExecutionTimeMs // ignore: cast_nullable_to_non_nullable
as int,lastExecution: freezed == lastExecution ? _self.lastExecution : lastExecution // ignore: cast_nullable_to_non_nullable
as DateTime?,errorCounts: null == errorCounts ? _self._errorCounts : errorCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}


/// @nodoc
mixin _$TaskExecutionRecord {

 String get taskId; DateTime get executedAt; bool get success; int get executionTimeMs; String? get error;
/// Create a copy of TaskExecutionRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskExecutionRecordCopyWith<TaskExecutionRecord> get copyWith => _$TaskExecutionRecordCopyWithImpl<TaskExecutionRecord>(this as TaskExecutionRecord, _$identity);

  /// Serializes this TaskExecutionRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskExecutionRecord&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.executedAt, executedAt) || other.executedAt == executedAt)&&(identical(other.success, success) || other.success == success)&&(identical(other.executionTimeMs, executionTimeMs) || other.executionTimeMs == executionTimeMs)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskId,executedAt,success,executionTimeMs,error);

@override
String toString() {
  return 'TaskExecutionRecord(taskId: $taskId, executedAt: $executedAt, success: $success, executionTimeMs: $executionTimeMs, error: $error)';
}


}

/// @nodoc
abstract mixin class $TaskExecutionRecordCopyWith<$Res>  {
  factory $TaskExecutionRecordCopyWith(TaskExecutionRecord value, $Res Function(TaskExecutionRecord) _then) = _$TaskExecutionRecordCopyWithImpl;
@useResult
$Res call({
 String taskId, DateTime executedAt, bool success, int executionTimeMs, String? error
});




}
/// @nodoc
class _$TaskExecutionRecordCopyWithImpl<$Res>
    implements $TaskExecutionRecordCopyWith<$Res> {
  _$TaskExecutionRecordCopyWithImpl(this._self, this._then);

  final TaskExecutionRecord _self;
  final $Res Function(TaskExecutionRecord) _then;

/// Create a copy of TaskExecutionRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? taskId = null,Object? executedAt = null,Object? success = null,Object? executionTimeMs = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,executedAt: null == executedAt ? _self.executedAt : executedAt // ignore: cast_nullable_to_non_nullable
as DateTime,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,executionTimeMs: null == executionTimeMs ? _self.executionTimeMs : executionTimeMs // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TaskExecutionRecord implements TaskExecutionRecord {
  const _TaskExecutionRecord({required this.taskId, required this.executedAt, required this.success, required this.executionTimeMs, this.error});
  factory _TaskExecutionRecord.fromJson(Map<String, dynamic> json) => _$TaskExecutionRecordFromJson(json);

@override final  String taskId;
@override final  DateTime executedAt;
@override final  bool success;
@override final  int executionTimeMs;
@override final  String? error;

/// Create a copy of TaskExecutionRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskExecutionRecordCopyWith<_TaskExecutionRecord> get copyWith => __$TaskExecutionRecordCopyWithImpl<_TaskExecutionRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskExecutionRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskExecutionRecord&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.executedAt, executedAt) || other.executedAt == executedAt)&&(identical(other.success, success) || other.success == success)&&(identical(other.executionTimeMs, executionTimeMs) || other.executionTimeMs == executionTimeMs)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskId,executedAt,success,executionTimeMs,error);

@override
String toString() {
  return 'TaskExecutionRecord(taskId: $taskId, executedAt: $executedAt, success: $success, executionTimeMs: $executionTimeMs, error: $error)';
}


}

/// @nodoc
abstract mixin class _$TaskExecutionRecordCopyWith<$Res> implements $TaskExecutionRecordCopyWith<$Res> {
  factory _$TaskExecutionRecordCopyWith(_TaskExecutionRecord value, $Res Function(_TaskExecutionRecord) _then) = __$TaskExecutionRecordCopyWithImpl;
@override @useResult
$Res call({
 String taskId, DateTime executedAt, bool success, int executionTimeMs, String? error
});




}
/// @nodoc
class __$TaskExecutionRecordCopyWithImpl<$Res>
    implements _$TaskExecutionRecordCopyWith<$Res> {
  __$TaskExecutionRecordCopyWithImpl(this._self, this._then);

  final _TaskExecutionRecord _self;
  final $Res Function(_TaskExecutionRecord) _then;

/// Create a copy of TaskExecutionRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taskId = null,Object? executedAt = null,Object? success = null,Object? executionTimeMs = null,Object? error = freezed,}) {
  return _then(_TaskExecutionRecord(
taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,executedAt: null == executedAt ? _self.executedAt : executedAt // ignore: cast_nullable_to_non_nullable
as DateTime,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,executionTimeMs: null == executionTimeMs ? _self.executionTimeMs : executionTimeMs // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
