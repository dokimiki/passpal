import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_statistics.freezed.dart';
part 'task_statistics.g.dart';

/// Statistics for background task execution
@freezed
abstract class TaskStatistics with _$TaskStatistics {
  const factory TaskStatistics({
    @Default(0) int totalExecutions,
    @Default(0) int successfulExecutions,
    @Default(0) int failedExecutions,
    @Default(0) int averageExecutionTimeMs,
    DateTime? lastExecution,
    @Default({}) Map<String, int> errorCounts,
  }) = _TaskStatistics;

  factory TaskStatistics.fromJson(Map<String, dynamic> json) =>
      _$TaskStatisticsFromJson(json);
}

/// Per-task execution record
@freezed
abstract class TaskExecutionRecord with _$TaskExecutionRecord {
  const factory TaskExecutionRecord({
    required String taskId,
    required DateTime executedAt,
    required bool success,
    required int executionTimeMs,
    String? error,
  }) = _TaskExecutionRecord;

  factory TaskExecutionRecord.fromJson(Map<String, dynamic> json) =>
      _$TaskExecutionRecordFromJson(json);
}
