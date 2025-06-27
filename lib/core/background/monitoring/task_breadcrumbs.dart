import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// Task breadcrumbs for debugging
class TaskBreadcrumbs {
  static FirebaseCrashlytics get _crashlytics => FirebaseCrashlytics.instance;

  /// Add breadcrumb for task event
  static Future<void> add(
    String taskId,
    String event, [
    Map<String, dynamic>? data,
  ]) async {
    try {
      final timestamp = DateTime.now().toIso8601String();
      final message = '[$timestamp] $taskId: $event';

      await _crashlytics.log(message);

      if (data != null) {
        for (final entry in data.entries) {
          await _crashlytics.setCustomKey(
            'breadcrumb_${entry.key}',
            entry.value,
          );
        }
      }
    } catch (e) {
      // Ignore breadcrumb errors
    }
  }

  /// Add breadcrumb for task start
  static Future<void> taskStarted(
    String taskId,
    Map<String, dynamic> data,
  ) async {
    await add(taskId, 'started', {'data_size': data.length});
  }

  /// Add breadcrumb for task progress
  static Future<void> taskProgress(
    String taskId,
    String step, [
    double? progress,
  ]) async {
    final data = <String, dynamic>{'step': step};
    if (progress != null) {
      data['progress'] = progress;
    }
    await add(taskId, 'progress', data);
  }

  /// Add breadcrumb for task success
  static Future<void> taskSucceeded(String taskId, int executionTimeMs) async {
    await add(taskId, 'succeeded', {'execution_time_ms': executionTimeMs});
  }

  /// Add breadcrumb for task failure
  static Future<void> taskFailed(
    String taskId,
    String error,
    bool shouldRetry,
  ) async {
    await add(taskId, 'failed', {'error': error, 'should_retry': shouldRetry});
  }

  /// Add breadcrumb for task timeout
  static Future<void> taskTimedOut(String taskId, int timeoutSeconds) async {
    await add(taskId, 'timeout', {'timeout_seconds': timeoutSeconds});
  }

  /// Add breadcrumb for task cancellation
  static Future<void> taskCancelled(String taskId, String? reason) async {
    await add(taskId, 'cancelled', {'reason': reason ?? 'unknown'});
  }

  /// Add breadcrumb for retry attempt
  static Future<void> retryAttempt(
    String taskId,
    int attemptNumber,
    Duration delay,
  ) async {
    await add(taskId, 'retry_attempt', {
      'attempt': attemptNumber,
      'delay_ms': delay.inMilliseconds,
    });
  }

  /// Add breadcrumb for FCM trigger
  static Future<void> fcmTriggered(
    String taskId,
    Map<String, dynamic> fcmData,
  ) async {
    await add(taskId, 'fcm_triggered', {
      'fcm_data_size': fcmData.length,
      'has_notification': fcmData.containsKey('notification'),
    });
  }
}
