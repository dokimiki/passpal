import 'dart:convert';

import '../../error/app_exception.dart';
import '../models/background_task.dart';
import '../models/task_frequency.dart';
import '../models/task_constraints.dart';

/// Parser for FCM task messages
class FcmTaskParser {
  /// Parse FCM data message to BackgroundTask
  static BackgroundTask? parseTask(Map<String, dynamic> fcmData) {
    try {
      // Check if message contains task data
      final taskData = fcmData['task'];
      if (taskData == null) {
        return null;
      }

      Map<String, dynamic> taskJson;
      if (taskData is String) {
        taskJson = jsonDecode(taskData) as Map<String, dynamic>;
      } else if (taskData is Map<String, dynamic>) {
        taskJson = taskData;
      } else {
        throw ParseFailure(
          message: 'Invalid task data format in FCM message',
          source: taskData.toString(),
        );
      }

      // Extract required fields
      final taskId = taskJson['id'] as String?;
      if (taskId == null) {
        throw ParseFailure(
          message: 'Task ID is required in FCM task data',
          source: taskJson.toString(),
        );
      }

      // Parse task data
      final data = taskJson['data'] as Map<String, dynamic>? ?? {};

      // Parse constraints
      final constraintsData =
          taskJson['constraints'] as Map<String, dynamic>? ?? {};
      final constraints = TaskConstraints(
        networkRequired: constraintsData['networkRequired'] as bool? ?? true,
        chargingRequired: constraintsData['chargingRequired'] as bool? ?? false,
        deviceIdleRequired:
            constraintsData['deviceIdleRequired'] as bool? ?? false,
        batteryNotLowRequired:
            constraintsData['batteryNotLowRequired'] as bool? ?? false,
        storageNotLowRequired:
            constraintsData['storageNotLowRequired'] as bool? ?? false,
      );

      // Parse timeout
      final timeoutMs = taskJson['timeout'] as int?;
      final timeout = timeoutMs != null
          ? Duration(milliseconds: timeoutMs)
          : null;

      // Create task with immediate frequency (FCM triggers immediate execution)
      return BackgroundTask(
        id: taskId,
        frequency: const TaskFrequency.immediate(),
        handler: (context) async {
          // Handler will be resolved by TaskDispatcher
          throw BackgroundTaskException.handlerNotFound(
            taskId: taskId,
            message: 'FCM task handler will be resolved by dispatcher',
          );
        },
        constraints: constraints,
        timeout: timeout,
        data: data,
      );
    } catch (e) {
      if (e is ParseFailure) rethrow;

      throw ParseFailure(
        message: 'Failed to parse FCM task data: $e',
        source: fcmData.toString(),
      );
    }
  }

  /// Check if FCM message contains task data
  static bool hasTaskData(Map<String, dynamic> fcmData) {
    return fcmData.containsKey('task');
  }

  /// Extract task ID from FCM data without full parsing
  static String? extractTaskId(Map<String, dynamic> fcmData) {
    try {
      final taskData = fcmData['task'];
      if (taskData == null) return null;

      Map<String, dynamic> taskJson;
      if (taskData is String) {
        taskJson = jsonDecode(taskData) as Map<String, dynamic>;
      } else if (taskData is Map<String, dynamic>) {
        taskJson = taskData;
      } else {
        return null;
      }

      return taskJson['id'] as String?;
    } catch (e) {
      return null;
    }
  }
}
