import 'package:firebase_messaging/firebase_messaging.dart';

import '../models/task_result.dart';
import 'fcm_task_parser.dart';
import 'immediate_executor.dart';

/// Bridge between FCM and background tasks
class PushToTaskBridge {
  PushToTaskBridge();

  final ImmediateExecutor _executor = const ImmediateExecutor();

  /// Handle FCM message and execute as background task if applicable
  Future<TaskResult?> handleMessage(RemoteMessage message) async {
    try {
      // Convert RemoteMessage data to Map
      final fcmData = Map<String, dynamic>.from(message.data);

      // Check if message contains task data
      if (!FcmTaskParser.hasTaskData(fcmData)) {
        return null; // Not a task message
      }

      // Execute task immediately
      final result = await _executor.executeFromFcm(fcmData);

      return result;
    } catch (e, stack) {
      return TaskResult.failure(
        error: 'Failed to handle FCM task message: $e',
        stackTrace: stack,
        shouldRetry: false,
      );
    }
  }

  /// Handle FCM message from data map (for background message handler)
  Future<TaskResult?> handleMessageData(Map<String, dynamic> fcmData) async {
    try {
      // Check if message contains task data
      if (!FcmTaskParser.hasTaskData(fcmData)) {
        return null; // Not a task message
      }

      // Execute task immediately
      final result = await _executor.executeFromFcm(fcmData);

      return result;
    } catch (e, stack) {
      return TaskResult.failure(
        error: 'Failed to handle FCM task message data: $e',
        stackTrace: stack,
        shouldRetry: false,
      );
    }
  }

  /// Check if FCM message is a task message
  bool isTaskMessage(RemoteMessage message) {
    return FcmTaskParser.hasTaskData(Map<String, dynamic>.from(message.data));
  }

  /// Extract task ID from FCM message
  String? extractTaskId(RemoteMessage message) {
    return FcmTaskParser.extractTaskId(Map<String, dynamic>.from(message.data));
  }
}
