import '../models/background_task.dart';
import '../models/task_result.dart';
import '../models/task_frequency.dart';
import '../dispatcher/task_dispatcher.dart';

/// Manual executor for testing and debugging
class ManualExecutor {
  const ManualExecutor();

  /// Execute task manually for testing
  Future<TaskResult> runTaskNow(BackgroundTask task) async {
    const dispatcher = TaskDispatcher();
    return await dispatcher.execute(task);
  }

  /// Execute task by ID with test data
  Future<TaskResult> runTaskById(String taskId, Map<String, dynamic> data) async {
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
  Future<Map<String, dynamic>> getExecutionStats() async {
    // This would typically fetch from persistent storage
    // For now, return mock data
    return {
      'total_executions': 0,
      'successful_executions': 0,
      'failed_executions': 0,
      'average_execution_time_ms': 0,
      'last_execution': null,
    };
  }
}
