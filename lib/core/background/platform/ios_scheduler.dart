import 'dart:io';

import 'package:background_fetch/background_fetch.dart' as bg;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../error/app_exception.dart';
import '../models/background_task.dart';
import '../models/task_result.dart';
import '../models/task_frequency.dart';
import 'background_scheduler.dart';

/// iOS-specific background scheduler using BGTaskScheduler
class IosScheduler implements BackgroundScheduler {
  IosScheduler();
  final Map<String, BackgroundTask> _registeredTasks = {};

  @override
  Future<void> scheduleOneShot(BackgroundTask task) async {
    if (!Platform.isIOS) {
      throw BackgroundTaskException.schedulingFailed(
        taskId: task.id,
        message: 'IosScheduler can only be used on iOS platform',
      );
    }

    try {
      _registeredTasks[task.id] = task;

      // Configure background fetch for iOS
      await bg.BackgroundFetch.configure(
        bg.BackgroundFetchConfig(
          minimumFetchInterval: 15000, // 15 minutes minimum
          stopOnTerminate: false,
          enableHeadless: true,
          startOnBoot: true,
          requiredNetworkType: task.constraints.networkRequired
              ? bg.NetworkType.ANY
              : bg.NetworkType.NONE,
        ),
        (String taskId) async {
          // Handle background fetch event
          await _handleBackgroundFetch(taskId);
        },
        (String taskId) async {
          // Handle timeout
          await _handleTimeout(taskId);
        },
      );

      // Start background fetch
      await bg.BackgroundFetch.start();
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
    if (!Platform.isIOS) {
      throw BackgroundTaskException.schedulingFailed(
        taskId: task.id,
        message: 'IosScheduler can only be used on iOS platform',
      );
    }

    final frequency = task.frequency;
    if (frequency is! TaskFrequencyPeriodic) {
      throw BackgroundTaskException.schedulingFailed(
        taskId: task.id,
        message: 'Task frequency must be periodic for schedulePeriodic',
      );
    }

    // iOS compliance: OS determines window 15min-6h, fallback to 6h
    final interval = frequency.interval;
    final maxInterval = const Duration(hours: 6);
    final actualInterval = interval > maxInterval ? maxInterval : interval;

    try {
      _registeredTasks[task.id] = task;

      await bg.BackgroundFetch.configure(
        bg.BackgroundFetchConfig(
          minimumFetchInterval: actualInterval.inMilliseconds,
          stopOnTerminate: false,
          enableHeadless: true,
          startOnBoot: true,
          requiredNetworkType: task.constraints.networkRequired
              ? bg.NetworkType.ANY
              : bg.NetworkType.NONE,
        ),
        (String taskId) async {
          await _handleBackgroundFetch(taskId);
        },
        (String taskId) async {
          await _handleTimeout(taskId);
        },
      );

      await bg.BackgroundFetch.start();
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
    if (!Platform.isIOS) return;

    try {
      _registeredTasks.remove(taskId);

      // If no more tasks, stop background fetch
      if (_registeredTasks.isEmpty) {
        await bg.BackgroundFetch.stop();
      }
    } catch (e) {
      // Ignore cancellation errors
    }
  }

  @override
  Future<void> cancelAll() async {
    if (!Platform.isIOS) return;

    try {
      _registeredTasks.clear();
      await bg.BackgroundFetch.stop();
    } catch (e) {
      // Ignore cancellation errors
    }
  }

  @override
  Future<bool> isScheduled(String taskId) async {
    return _registeredTasks.containsKey(taskId);
  }

  @override
  Future<List<String>> getScheduledTaskIds() async {
    return _registeredTasks.keys.toList();
  }

  /// Handle background fetch event
  Future<void> _handleBackgroundFetch(String taskId) async {
    final task = _registeredTasks[taskId];
    if (task == null) {
      await bg.BackgroundFetch.finish(taskId);
      return;
    }

    try {
      final result = await executeNow(task);

      // Finish with appropriate status
      switch (result) {
        case TaskResultSuccess():
          await bg.BackgroundFetch.finish(taskId);
        case TaskResultFailure():
          if (result.shouldRetry) {
            await bg.BackgroundFetch.finish(taskId);
          } else {
            await bg.BackgroundFetch.finish(taskId);
          }
        case TaskResultCancelled():
          await bg.BackgroundFetch.finish(taskId);
      }
    } catch (e) {
      await bg.BackgroundFetch.finish(taskId);
    }
  }

  /// Handle timeout event
  Future<void> _handleTimeout(String taskId) async {
    try {
      await bg.BackgroundFetch.finish(taskId);
    } catch (e) {
      // Ignore timeout handling errors
    }
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
