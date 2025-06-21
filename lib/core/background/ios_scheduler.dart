import 'dart:async';
import 'package:background_fetch/background_fetch.dart';
import 'scheduler_service.dart';

/// iOS implementation of [SchedulerService] using Background Fetch.
///
/// This implementation uses the background_fetch plugin to schedule background
/// tasks on iOS devices. Due to iOS limitations, periodic tasks are simulated
/// by rescheduling one-off tasks after completion.
class IosScheduler implements SchedulerService {
  static final Map<String, Timer?> _periodicTasks = {};
  static final Map<String, Map<String, dynamic>?> _taskData = {};

  /// Initializes the iOS scheduler.
  ///
  /// This should be called once during app startup to configure
  /// the background fetch service.
  static Future<void> initialize() async {
    await BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 15000, // 15 seconds minimum
        stopOnTerminate: false,
        enableHeadless: true,
        startOnBoot: true,
      ),
      _onBackgroundFetch,
      _onBackgroundFetchTimeout,
    );
  }

  /// Background fetch callback handler.
  static Future<void> _onBackgroundFetch(String taskId) async {
    // TODO: Implement task execution logic
    // This would typically dispatch to the appropriate task handler
    // based on the taskId
    // Check if this is a periodic task that needs rescheduling
    if (_periodicTasks.containsKey(taskId)) {
      final timer = _periodicTasks[taskId];
      if (timer != null && timer.isActive) {
        // Reschedule the task
        await BackgroundFetch.scheduleTask(
          TaskConfig(
            taskId: taskId,
            delay: timer.tick * 1000, // Convert to milliseconds
          ),
        );
      }
    }

    BackgroundFetch.finish(taskId);
  }

  /// Background fetch timeout callback.
  static Future<void> _onBackgroundFetchTimeout(String taskId) async {
    BackgroundFetch.finish(taskId);
  }

  @override
  Future<void> scheduleOneOff({
    required String taskId,
    required Duration delay,
    Map<String, dynamic>? inputData,
  }) async {
    // Store task data for later retrieval
    _taskData[taskId] = inputData;

    await BackgroundFetch.scheduleTask(
      TaskConfig(
        taskId: taskId,
        delay: delay.inMilliseconds,
        periodic: false,
        requiredNetworkType: NetworkType.ANY,
        requiresCharging: false,
        requiresDeviceIdle: false,
        stopOnTerminate: false,
        startOnBoot: true,
      ),
    );
  }

  @override
  Future<void> schedulePeriodic({
    required String taskId,
    required Duration frequency,
    Map<String, dynamic>? inputData,
    bool flexEnabled = true,
  }) async {
    // Store task data for later retrieval
    _taskData[taskId] = inputData;

    // Create a timer to track the frequency for rescheduling
    _periodicTasks[taskId] = Timer.periodic(frequency, (_) {});

    // Schedule the initial task
    await BackgroundFetch.scheduleTask(
      TaskConfig(
        taskId: taskId,
        delay: frequency.inMilliseconds,
        periodic: true,
        requiredNetworkType: NetworkType.ANY,
        requiresCharging: false,
        requiresDeviceIdle: false,
        stopOnTerminate: false,
        startOnBoot: true,
      ),
    );
  }

  @override
  Future<void> cancel(String taskId) async {
    // Cancel the timer if it's a periodic task
    final timer = _periodicTasks.remove(taskId);
    timer?.cancel();

    // Remove stored data
    _taskData.remove(taskId);

    // Stop the background task
    await BackgroundFetch.stop(taskId);
  }
}
