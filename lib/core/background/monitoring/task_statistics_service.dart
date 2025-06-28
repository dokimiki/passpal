import '../../storage/kv/key_value_cache.dart';
import '../models/task_result.dart';
import '../models/task_statistics.dart';

/// Service for tracking and storing background task execution statistics
class TaskStatisticsService {
  TaskStatisticsService(this._cache);

  final KeyValueCache _cache;
  static const String _statsKey = 'background_task_statistics';

  /// Record a task execution
  Future<void> recordExecution(String taskId, TaskResult result) async {
    final stats = await getTaskStatistics(taskId);
    final now = DateTime.now();

    final newStats = stats.copyWith(
      totalExecutions: stats.totalExecutions + 1,
      successfulExecutions: result is TaskResultSuccess
          ? stats.successfulExecutions + 1
          : stats.successfulExecutions,
      failedExecutions: result is TaskResultFailure
          ? stats.failedExecutions + 1
          : stats.failedExecutions,
      lastExecution: now,
      averageExecutionTimeMs: _calculateNewAverage(
        stats.averageExecutionTimeMs,
        stats.totalExecutions,
        result.executionTimeMs,
      ),
    );

    // Update error counts if it's a failure
    if (result is TaskResultFailure) {
      final errorCounts = Map<String, int>.from(stats.errorCounts);
      final errorKey = _extractErrorType(result.error);
      errorCounts[errorKey] = (errorCounts[errorKey] ?? 0) + 1;
      final updatedStats = newStats.copyWith(errorCounts: errorCounts);
      await _saveTaskStatistics(taskId, updatedStats);
    } else {
      await _saveTaskStatistics(taskId, newStats);
    }

    // Record individual execution
    await _recordExecutionHistory(taskId, result, now);
  }

  /// Get statistics for a specific task
  Future<TaskStatistics> getTaskStatistics(String taskId) async {
    try {
      final data = await _cache.watchJson('${_statsKey}_$taskId').first;
      if (data == null) {
        return const TaskStatistics();
      }
      return TaskStatistics.fromJson(data);
    } catch (e) {
      return const TaskStatistics();
    }
  }

  /// Get aggregated statistics for all tasks
  Future<Map<String, dynamic>> getGlobalStatistics() async {
    try {
      final data = await _cache.watchJson('${_statsKey}_global').first;
      return data ??
          {
            'total_executions': 0,
            'successful_executions': 0,
            'failed_executions': 0,
            'average_execution_time_ms': 0,
            'last_execution': null,
          };
    } catch (e) {
      return {
        'total_executions': 0,
        'successful_executions': 0,
        'failed_executions': 0,
        'average_execution_time_ms': 0,
        'last_execution': null,
      };
    }
  }

  /// Update global statistics
  Future<void> updateGlobalStatistics(TaskResult result) async {
    final currentStats = await getGlobalStatistics();
    final totalExecutions = (currentStats['total_executions'] as int) + 1;
    final successfulExecutions = result is TaskResultSuccess
        ? (currentStats['successful_executions'] as int) + 1
        : currentStats['successful_executions'] as int;
    final failedExecutions = result is TaskResultFailure
        ? (currentStats['failed_executions'] as int) + 1
        : currentStats['failed_executions'] as int;

    final newStats = {
      'total_executions': totalExecutions,
      'successful_executions': successfulExecutions,
      'failed_executions': failedExecutions,
      'average_execution_time_ms': _calculateNewAverage(
        currentStats['average_execution_time_ms'] as int,
        totalExecutions - 1,
        result.executionTimeMs,
      ),
      'last_execution': DateTime.now().toIso8601String(),
    };

    await _cache.putJson('${_statsKey}_global', newStats);
  }

  /// Clear all statistics
  Future<void> clearAllStatistics() async {
    await _cache.remove('${_statsKey}_global');
    // Note: Individual task stats would need to be tracked separately to clear them all
  }

  /// Save task-specific statistics
  Future<void> _saveTaskStatistics(String taskId, TaskStatistics stats) async {
    await _cache.putJson('${_statsKey}_$taskId', stats.toJson());
  }

  /// Record individual execution history (last 10 executions)
  Future<void> _recordExecutionHistory(
    String taskId,
    TaskResult result,
    DateTime executedAt,
  ) async {
    final historyKey = '${_statsKey}_history_$taskId';
    final currentHistoryData = await _cache.watchJson(historyKey).first;

    final record = TaskExecutionRecord(
      taskId: taskId,
      executedAt: executedAt,
      success: result is TaskResultSuccess,
      executionTimeMs: result.executionTimeMs,
      error: result is TaskResultFailure ? result.error : null,
    );

    // Extract history array or initialize empty
    final currentHistory =
        currentHistoryData?['history'] as List<dynamic>? ?? [];
    final history = List<Map<String, dynamic>>.from(currentHistory);
    history.insert(0, record.toJson());

    // Keep only last 10 executions
    if (history.length > 10) {
      history.removeRange(10, history.length);
    }

    // Store as an object with history array
    await _cache.putJson(historyKey, {
      'history': history,
      'lastUpdated': DateTime.now().toIso8601String(),
    });
  }

  /// Calculate new average execution time
  int _calculateNewAverage(int currentAverage, int count, int newValue) {
    if (count == 0) return newValue;
    return ((currentAverage * count) + newValue) ~/ (count + 1);
  }

  /// Extract error type for categorization
  String _extractErrorType(String error) {
    if (error.contains('NetworkException')) return 'network';
    if (error.contains('AuthenticationException')) return 'auth';
    if (error.contains('TimeoutException')) return 'timeout';
    if (error.contains('ParseFailure')) return 'parse';
    return 'other';
  }
}
