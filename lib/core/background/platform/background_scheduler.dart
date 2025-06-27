import '../models/background_task.dart';
import '../models/task_result.dart';

/// Abstract interface for background task scheduling
abstract class BackgroundScheduler {
  /// Schedule a one-shot task
  Future<void> scheduleOneShot(BackgroundTask task);

  /// Schedule a periodic task
  Future<void> schedulePeriodic(BackgroundTask task);

  /// Register a task with unique constraint (cancel existing if duplicate)
  Future<void> registerUnique(BackgroundTask task);

  /// Execute a task immediately
  Future<TaskResult> executeNow(BackgroundTask task);

  /// Cancel a specific task
  Future<void> cancel(String taskId);

  /// Cancel all tasks
  Future<void> cancelAll();

  /// Check if a task is scheduled
  Future<bool> isScheduled(String taskId);

  /// Get scheduled task IDs
  Future<List<String>> getScheduledTaskIds();
}
