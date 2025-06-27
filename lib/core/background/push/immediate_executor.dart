import '../dispatcher/task_dispatcher.dart';
import '../models/background_task.dart';
import '../models/task_result.dart';
import 'fcm_task_parser.dart';

/// Executor for immediate task execution (FCM triggered)
class ImmediateExecutor {
  const ImmediateExecutor();

  /// Execute task immediately
  Future<TaskResult> execute(BackgroundTask task) async {
    const dispatcher = TaskDispatcher();
    return await dispatcher.execute(task);
  }

  /// Execute task from FCM data
  Future<TaskResult> executeFromFcm(Map<String, dynamic> fcmData) async {
    try {
      // Parse task from FCM data
      final task = FcmTaskParser.parseTask(fcmData);
      if (task == null) {
        return const TaskResult.failure(
          error: 'No task data found in FCM message',
          shouldRetry: false,
        );
      }

      // Execute task using dispatcher (which will resolve the actual handler)
      const dispatcher = TaskDispatcher();
      final taskJson = dispatcher.taskToJson(task);
      return await dispatcher.executeFromJson(taskJson);
    } catch (e, stack) {
      return TaskResult.failure(
        error: e.toString(),
        stackTrace: stack,
        shouldRetry: false, // FCM immediate tasks don't retry
      );
    }
  }
}
