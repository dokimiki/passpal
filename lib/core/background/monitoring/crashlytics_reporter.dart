import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../models/task_result.dart';

/// Crashlytics reporter for background tasks
class CrashlyticsReporter {
  static FirebaseCrashlytics get _crashlytics => FirebaseCrashlytics.instance;

  /// Report task start
  static Future<void> reportTaskStart(
    String taskId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _crashlytics.log('Background task started: $taskId');
      await _crashlytics.setCustomKey('current_background_task', taskId);
      await _crashlytics.setCustomKey('task_data', data.toString());
    } catch (e) {
      // Ignore crashlytics errors
    }
  }

  /// Report task completion
  static Future<void> reportTaskComplete(
    String taskId,
    TaskResult result,
  ) async {
    try {
      switch (result) {
        case TaskResultSuccess():
          await _crashlytics.log(
            'Background task completed successfully: $taskId (${result.executionTimeMs}ms)',
          );
          await _crashlytics.setCustomKey('last_successful_task', taskId);
          await _crashlytics.setCustomKey(
            'last_task_duration_ms',
            result.executionTimeMs,
          );

        case TaskResultFailure():
          await _crashlytics.log(
            'Background task failed: $taskId (${result.executionTimeMs}ms) - ${result.error}',
          );

          // Report as non-fatal error
          await _crashlytics.recordError(
            Exception('Background task failed: ${result.error}'),
            result.stackTrace,
            fatal: false,
            information: [
              DiagnosticsProperty('task_id', taskId),
              DiagnosticsProperty('execution_time_ms', result.executionTimeMs),
              DiagnosticsProperty('should_retry', result.shouldRetry),
            ],
          );

        case TaskResultCancelled():
          await _crashlytics.log(
            'Background task cancelled: $taskId (${result.executionTimeMs}ms) - ${result.reason ?? "unknown reason"}',
          );
          await _crashlytics.setCustomKey('last_cancelled_task', taskId);
      }

      // Clear current task
      await _crashlytics.setCustomKey('current_background_task', 'none');
    } catch (e) {
      // Ignore crashlytics errors
    }
  }

  /// Report task timeout
  static Future<void> reportTaskTimeout(String taskId, Duration timeout) async {
    try {
      await _crashlytics.log(
        'Background task timed out: $taskId after ${timeout.inSeconds}s',
      );

      await _crashlytics.recordError(
        Exception('Background task timeout'),
        null,
        fatal: false,
        information: [
          DiagnosticsProperty('task_id', taskId),
          DiagnosticsProperty('timeout_seconds', timeout.inSeconds),
        ],
      );
    } catch (e) {
      // Ignore crashlytics errors
    }
  }

  /// Report scheduling failure
  static Future<void> reportSchedulingFailure(
    String taskId,
    String error,
    StackTrace? stackTrace,
  ) async {
    try {
      await _crashlytics.log(
        'Background task scheduling failed: $taskId - $error',
      );

      await _crashlytics.recordError(
        Exception('Background task scheduling failed: $error'),
        stackTrace,
        fatal: false,
        information: [
          DiagnosticsProperty('task_id', taskId),
          DiagnosticsProperty('error_type', 'scheduling_failure'),
        ],
      );
    } catch (e) {
      // Ignore crashlytics errors
    }
  }

  /// Set background task context for ANR debugging
  static Future<void> setBackgroundTaskContext(
    String taskId,
    String phase, // 'starting', 'executing', 'finishing'
  ) async {
    try {
      await _crashlytics.setCustomKey('bg_task_id', taskId);
      await _crashlytics.setCustomKey('bg_task_phase', phase);
      await _crashlytics.setCustomKey(
        'bg_task_timestamp',
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      // Ignore crashlytics errors
    }
  }

  /// Clear background task context
  static Future<void> clearBackgroundTaskContext() async {
    try {
      await _crashlytics.setCustomKey('bg_task_id', 'none');
      await _crashlytics.setCustomKey('bg_task_phase', 'none');
    } catch (e) {
      // Ignore crashlytics errors
    }
  }
}

/// Diagnostics property for Crashlytics
class DiagnosticsProperty {
  const DiagnosticsProperty(this.name, this.value);

  final String name;
  final dynamic value;
}
