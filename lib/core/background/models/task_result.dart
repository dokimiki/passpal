import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_result.freezed.dart';

/// Result of background task execution
@freezed
class TaskResult with _$TaskResult {
  const factory TaskResult.success({
    String? data,
    @Default(0) int executionTimeMs,
  }) = TaskResultSuccess;

  const factory TaskResult.failure({
    required String error,
    StackTrace? stackTrace,
    @Default(0) int executionTimeMs,
    @Default(false) bool shouldRetry,
  }) = TaskResultFailure;

  const factory TaskResult.cancelled({
    String? reason,
    @Default(0) int executionTimeMs,
  }) = TaskResultCancelled;
}
