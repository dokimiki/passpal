import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task_result.dart';

/// Abstract interface for task handlers
abstract class TaskHandler {
  Future<TaskResult> execute(
    ProviderContainer context,
    Map<String, dynamic> data,
  );
}

/// Registry for task handlers
class TaskHandlerRegistry {
  static final Map<String, TaskHandler> _handlers = {};

  /// Register a task handler
  static void register(String taskId, TaskHandler handler) {
    _handlers[taskId] = handler;
  }

  /// Get task handler by ID
  static TaskHandler? get(String taskId) {
    return _handlers[taskId];
  }

  /// Unregister a task handler
  static void unregister(String taskId) {
    _handlers.remove(taskId);
  }

  /// Clear all handlers
  static void clear() {
    _handlers.clear();
  }

  /// Get all registered task IDs
  static List<String> getRegisteredIds() {
    return _handlers.keys.toList();
  }
}
