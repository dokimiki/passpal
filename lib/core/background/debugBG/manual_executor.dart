import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/background_task.dart';
import '../models/task_result.dart';
import '../models/task_frequency.dart';
import '../dispatcher/task_dispatcher.dart';
import '../providers/task_statistics_provider.dart';

/// Manual executor for testing and debugging
class ManualExecutor {
  const ManualExecutor();

  /// Execute task manually for testing
  Future<TaskResult> runTaskNow(BackgroundTask task) async {
    const dispatcher = TaskDispatcher();
    return await dispatcher.execute(task);
  }

  /// Execute task by ID with test data
  Future<TaskResult> runTaskById(
    String taskId,
    Map<String, dynamic> data,
  ) async {
    const dispatcher = TaskDispatcher();

    // Create test JSON
    final taskJson = dispatcher.taskToJson(
      BackgroundTask(
        id: taskId,
        frequency: const TaskFrequency.immediate(),
        handler: (context) async {
          throw UnimplementedError('Handler will be resolved by dispatcher');
        },
        data: data,
      ),
    );

    return await dispatcher.executeFromJson(taskJson);
  }

  /// Get execution statistics
  Future<Map<String, dynamic>> getExecutionStats([
    ProviderContainer? container,
  ]) async {
    if (container == null) {
      // Fallback to mock data if no container provided
      return {
        'total_executions': 0,
        'successful_executions': 0,
        'failed_executions': 0,
        'average_execution_time_ms': 0,
        'last_execution': null,
      };
    }

    try {
      final statisticsService = container.read(taskStatisticsServiceProvider);
      return await statisticsService.getGlobalStatistics();
    } catch (e) {
      // Return mock data if statistics service fails
      return {
        'total_executions': 0,
        'successful_executions': 0,
        'failed_executions': 0,
        'average_execution_time_ms': 0,
        'last_execution': null,
      };
    }
  }

  /// Get execution statistics for a specific task
  Future<Map<String, dynamic>> getTaskExecutionStats(
    String taskId, [
    ProviderContainer? container,
  ]) async {
    if (container == null) {
      return {
        'task_id': taskId,
        'total_executions': 0,
        'successful_executions': 0,
        'failed_executions': 0,
        'average_execution_time_ms': 0,
        'last_execution': null,
        'error_counts': <String, int>{},
      };
    }

    try {
      final statisticsService = container.read(taskStatisticsServiceProvider);
      final stats = await statisticsService.getTaskStatistics(taskId);
      return {
        'task_id': taskId,
        'total_executions': stats.totalExecutions,
        'successful_executions': stats.successfulExecutions,
        'failed_executions': stats.failedExecutions,
        'average_execution_time_ms': stats.averageExecutionTimeMs,
        'last_execution': stats.lastExecution?.toIso8601String(),
        'error_counts': stats.errorCounts,
      };
    } catch (e) {
      return {
        'task_id': taskId,
        'total_executions': 0,
        'successful_executions': 0,
        'failed_executions': 0,
        'average_execution_time_ms': 0,
        'last_execution': null,
        'error_counts': <String, int>{},
      };
    }
  }
}
