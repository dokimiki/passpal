import 'dart:io';

import 'package:workmanager/workmanager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../error/app_exception.dart';
import '../models/background_task.dart';
import '../models/task_result.dart';
import '../models/task_frequency.dart';
import '../models/task_constraints.dart';
import 'background_scheduler.dart';

/// Android-specific background scheduler using WorkManager
class AndroidScheduler implements BackgroundScheduler {
  const AndroidScheduler();
  static const String _taskPrefix = 'passpal_';

  @override
  Future<void> scheduleOneShot(BackgroundTask task) async {
    if (!Platform.isAndroid) {
      throw BackgroundTaskException.schedulingFailed(
        taskId: task.id,
        message: 'AndroidScheduler can only be used on Android platform',
      );
    }

    try {
      await Workmanager().registerOneOffTask(
        _taskPrefix + task.id,
        task.id,
        initialDelay: task.initialDelay ?? Duration.zero,
        constraints: _convertConstraints(task.constraints),
        inputData: task.data,
      );
    } catch (e, stack) {
      throw BackgroundTaskException.schedulingFailed(
        taskId: task.id,
        message: 'Failed to schedule one-shot task: $e',
        stack: stack,
      );
    }
  }

  @override
  Future<void> schedulePeriodic(BackgroundTask task) async {
    if (!Platform.isAndroid) {
      throw BackgroundTaskException.schedulingFailed(
        taskId: task.id,
        message: 'AndroidScheduler can only be used on Android platform',
      );
    }

    final frequency = task.frequency;
    if (frequency is! TaskFrequencyPeriodic) {
      throw BackgroundTaskException.schedulingFailed(
        taskId: task.id,
        message: 'Task frequency must be periodic for schedulePeriodic',
      );
    }

    // Android 14 compliance: minimum 15 minutes
    final interval = frequency.interval;
    final minInterval = const Duration(minutes: 15);
    final actualInterval = interval < minInterval ? minInterval : interval;

    try {
      await Workmanager().registerPeriodicTask(
        _taskPrefix + task.id,
        task.id,
        frequency: actualInterval,
        initialDelay: task.initialDelay ?? Duration.zero,
        constraints: _convertConstraints(task.constraints),
        inputData: task.data,
      );
    } catch (e, stack) {
      throw BackgroundTaskException.schedulingFailed(
        taskId: task.id,
        message: 'Failed to schedule periodic task: $e',
        stack: stack,
      );
    }
  }

  @override
  Future<void> registerUnique(BackgroundTask task) async {
    // Cancel existing task with same ID first
    await cancel(task.id);

    switch (task.frequency) {
      case TaskFrequencyOneShot():
        await scheduleOneShot(task);
      case TaskFrequencyPeriodic():
        await schedulePeriodic(task);
      case TaskFrequencyImmediate():
        await executeNow(task);
    }
  }

  @override
  Future<TaskResult> executeNow(BackgroundTask task) async {
    final stopwatch = Stopwatch()..start();

    try {
      // Execute in isolate with ProviderContainer
      final container = ProviderContainer();
      final result = await task.handler(container);
      container.dispose();

      stopwatch.stop();

      return result.copyWith(executionTimeMs: stopwatch.elapsedMilliseconds);
    } catch (e, stack) {
      stopwatch.stop();

      return TaskResult.failure(
        error: e.toString(),
        stackTrace: stack,
        executionTimeMs: stopwatch.elapsedMilliseconds,
        shouldRetry: _shouldRetry(e),
      );
    }
  }

  @override
  Future<void> cancel(String taskId) async {
    if (!Platform.isAndroid) return;

    try {
      await Workmanager().cancelByUniqueName(_taskPrefix + taskId);
    } catch (e) {
      // Ignore cancellation errors - task might not exist
    }
  }

  @override
  Future<void> cancelAll() async {
    if (!Platform.isAndroid) return;

    try {
      await Workmanager().cancelAll();
    } catch (e) {
      // Ignore cancellation errors
    }
  }

  @override
  Future<bool> isScheduled(String taskId) async {
    // WorkManager doesn't provide direct API to check scheduled tasks
    // This would require custom implementation using SharedPreferences
    // For now, return false
    return false;
  }

  @override
  Future<List<String>> getScheduledTaskIds() async {
    // WorkManager doesn't provide direct API to list scheduled tasks
    // This would require custom implementation using SharedPreferences
    // For now, return empty list
    return [];
  }

  /// Convert TaskConstraints to WorkManager Constraints
  Constraints _convertConstraints(TaskConstraints constraints) {
    return Constraints(
      networkType: constraints.networkRequired
          ? NetworkType.connected
          : NetworkType.not_required,
      requiresBatteryNotLow: constraints.batteryNotLowRequired,
      requiresCharging: constraints.chargingRequired,
      requiresDeviceIdle: constraints.deviceIdleRequired,
      requiresStorageNotLow: constraints.storageNotLowRequired,
    );
  }

  /// Determine if error should trigger retry
  bool _shouldRetry(Object error) {
    // Don't retry on auth or maintenance exceptions
    if (error is AuthenticationException || error is MaintenanceException) {
      return false;
    }

    // Retry on network and other recoverable errors
    return true;
  }
}
