import 'dart:async';

import '../../error/app_exception.dart';

/// Timeout management for background tasks
class TaskTimeout {
  /// Execute function with timeout
  static Future<T> execute<T>(
    Future<T> Function() operation,
    Duration timeout, {
    String? taskId,
  }) async {
    try {
      return await operation().timeout(timeout);
    } on TimeoutException catch (e, stack) {
      throw BackgroundTaskException.timeout(
        taskId: taskId ?? 'unknown',
        message: 'Task execution timed out after ${timeout.inSeconds}s',
        stack: stack,
      );
    }
  }

  /// Create a completer that will timeout after given duration
  static Completer<T> createTimeoutCompleter<T>(
    Duration timeout, {
    String? taskId,
  }) {
    final completer = Completer<T>();

    Timer(timeout, () {
      if (!completer.isCompleted) {
        completer.completeError(
          BackgroundTaskException.timeout(
            taskId: taskId ?? 'unknown',
            message: 'Task execution timed out after ${timeout.inSeconds}s',
          ),
        );
      }
    });

    return completer;
  }
}
