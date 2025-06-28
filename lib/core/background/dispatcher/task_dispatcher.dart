import 'dart:convert';
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../error/app_exception.dart';
import '../models/background_task.dart';
import '../models/task_result.dart';
import '../providers/task_statistics_provider.dart';
import 'task_handler.dart';
import 'task_timeout.dart';

/// Dispatcher for background tasks - parses JSON args and calls handlers
class TaskDispatcher {
  const TaskDispatcher();

  /// Execute task from JSON data (used by WorkManager/BGTaskScheduler)
  Future<TaskResult> executeFromJson(String taskJson) async {
    final stopwatch = Stopwatch()..start();
    String? taskId;

    try {
      // Parse task JSON
      final taskData = jsonDecode(taskJson) as Map<String, dynamic>;
      taskId = taskData['id'] as String?;

      if (taskId == null) {
        throw BackgroundTaskException.handlerNotFound(
          taskId: 'unknown',
          message: 'Task ID not found in JSON data',
        );
      }

      // Get handler
      final handler = TaskHandlerRegistry.get(taskId);
      if (handler == null) {
        throw BackgroundTaskException.handlerNotFound(
          taskId: taskId,
          message: 'No handler registered for task: $taskId',
        );
      }

      // Extract data and timeout
      final data = taskData['data'] as Map<String, dynamic>? ?? {};
      final timeoutMs = taskData['timeout'] as int?;
      final timeout = timeoutMs != null
          ? Duration(milliseconds: timeoutMs)
          : const Duration(minutes: 10); // Default timeout

      // Execute with timeout
      final container = ProviderContainer();

      TaskResult result;
      try {
        result = await TaskTimeout.execute(
          () => handler.execute(container, data),
          timeout,
          taskId: taskId,
        );
      } finally {
        container.dispose();
      }

      stopwatch.stop();

      // Add execution time to result
      result = result.copyWith(executionTimeMs: stopwatch.elapsedMilliseconds);

      // Record statistics if possible
      try {
        final statsContainer = ProviderContainer();
        final statisticsService = statsContainer.read(
          taskStatisticsServiceProvider,
        );
        await statisticsService.recordExecution(taskId, result);
        await statisticsService.updateGlobalStatistics(result);
        statsContainer.dispose();
      } catch (e) {
        // Ignore statistics recording errors
      }

      return result;
    } catch (e, stack) {
      stopwatch.stop();

      // If it's already a proper exception, rethrow
      if (e is BackgroundTaskException) {
        rethrow;
      }

      // Wrap other exceptions
      final result = TaskResult.failure(
        error: e.toString(),
        stackTrace: stack,
        executionTimeMs: stopwatch.elapsedMilliseconds,
        shouldRetry: _shouldRetry(e),
      );

      // Record statistics if possible
      try {
        final statsContainer = ProviderContainer();
        final statisticsService = statsContainer.read(
          taskStatisticsServiceProvider,
        );
        await statisticsService.recordExecution(taskId ?? 'unknown', result);
        await statisticsService.updateGlobalStatistics(result);
        statsContainer.dispose();
      } catch (statsError) {
        // Ignore statistics recording errors
      }

      return result;
    }
  }

  /// Execute task directly
  Future<TaskResult> execute(BackgroundTask task) async {
    final stopwatch = Stopwatch()..start();

    try {
      final timeout = task.timeout ?? const Duration(minutes: 10);

      // Execute with timeout
      final container = ProviderContainer();

      TaskResult result;
      try {
        result = await TaskTimeout.execute(
          () => task.handler(container),
          timeout,
          taskId: task.id,
        );
      } finally {
        container.dispose();
      }

      stopwatch.stop();

      // Add execution time to result
      result = result.copyWith(executionTimeMs: stopwatch.elapsedMilliseconds);

      // Record statistics if possible
      try {
        final statsContainer = ProviderContainer();
        final statisticsService = statsContainer.read(
          taskStatisticsServiceProvider,
        );
        await statisticsService.recordExecution(task.id, result);
        await statisticsService.updateGlobalStatistics(result);
        statsContainer.dispose();
      } catch (e) {
        // Ignore statistics recording errors
      }

      return result;
    } catch (e, stack) {
      stopwatch.stop();

      final result = TaskResult.failure(
        error: e.toString(),
        stackTrace: stack,
        executionTimeMs: stopwatch.elapsedMilliseconds,
        shouldRetry: _shouldRetry(e),
      );

      // Record statistics if possible
      try {
        final statsContainer = ProviderContainer();
        final statisticsService = statsContainer.read(
          taskStatisticsServiceProvider,
        );
        await statisticsService.recordExecution(task.id, result);
        await statisticsService.updateGlobalStatistics(result);
        statsContainer.dispose();
      } catch (statsError) {
        // Ignore statistics recording errors
      }

      return result;
    }
  }

  /// Serialize task to JSON for WorkManager/BGTaskScheduler
  String taskToJson(BackgroundTask task) {
    return jsonEncode({
      'id': task.id,
      'data': task.data,
      'timeout': task.timeout?.inMilliseconds,
    });
  }

  /// Determine if error should trigger retry
  bool _shouldRetry(Object error) {
    // Don't retry on auth or maintenance exceptions
    if (error is AuthenticationException || error is MaintenanceException) {
      return false;
    }

    // Don't retry on handler not found or cancelled tasks
    if (error is BackgroundTaskException) {
      return switch (error) {
        BackgroundTaskException()
            when error.runtimeType.toString().contains('HandlerNotFound') =>
          false,
        BackgroundTaskException()
            when error.runtimeType.toString().contains('Cancelled') =>
          false,
        _ => true,
      };
    }

    // Retry on other errors
    return true;
  }
}
