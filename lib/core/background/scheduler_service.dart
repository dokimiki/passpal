/// Abstract interface for scheduling background tasks across platforms.
///
/// This service provides a unified API for scheduling one-off and periodic
/// background tasks on both Android and iOS platforms.
abstract class SchedulerService {
  /// Schedules a one-off background task to run after the specified delay.
  ///
  /// [taskId] - Unique identifier for the task
  /// [delay] - Time to wait before executing the task
  /// [inputData] - Optional data to pass to the task
  Future<void> scheduleOneOff({
    required String taskId,
    required Duration delay,
    Map<String, dynamic>? inputData,
  });

  /// Schedules a periodic background task to run at the specified frequency.
  ///
  /// [taskId] - Unique identifier for the task
  /// [frequency] - How often the task should run
  /// [inputData] - Optional data to pass to the task
  /// [flexEnabled] - Whether to allow flexible timing (Android only)
  Future<void> schedulePeriodic({
    required String taskId,
    required Duration frequency,
    Map<String, dynamic>? inputData,
    bool flexEnabled = true,
  });

  /// Cancels a previously scheduled task.
  ///
  /// [taskId] - Unique identifier of the task to cancel
  Future<void> cancel(String taskId);
}
