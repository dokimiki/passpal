import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/background_task.dart';
import '../models/task_result.dart';
import '../dispatcher/task_handler.dart';
import '../providers/background_scheduler_provider.dart';
import 'manual_executor.dart';

/// Debug console for background tasks (only available in debug mode)
class DebugConsole {
  DebugConsole(this._ref);

  final Ref _ref;
  late final ManualExecutor _executor = const ManualExecutor();

  /// Check if debug console is available
  bool get isAvailable => kDebugMode;

  /// Run task immediately for testing
  Future<TaskResult> runTaskNow(String taskId, [Map<String, dynamic>? data]) async {
    if (!isAvailable) {
      throw UnsupportedError('Debug console only available in debug mode');
    }

    return await _executor.runTaskById(taskId, data ?? {});
  }

  /// Schedule test task
  Future<void> scheduleTestTask(BackgroundTask task) async {
    if (!isAvailable) {
      throw UnsupportedError('Debug console only available in debug mode');
    }

    final scheduler = _ref.read(backgroundSchedulerProvider);
    await scheduler.registerUnique(task);
  }

  /// Get list of registered task handlers
  List<String> getRegisteredTaskIds() {
    if (!isAvailable) return [];

    return TaskHandlerRegistry.getRegisteredIds();
  }

  /// Get list of scheduled tasks
  Future<List<String>> getScheduledTaskIds() async {
    if (!isAvailable) return [];

    final scheduler = _ref.read(backgroundSchedulerProvider);
    return await scheduler.getScheduledTaskIds();
  }

  /// Cancel all scheduled tasks
  Future<void> cancelAllTasks() async {
    if (!isAvailable) return;

    final scheduler = _ref.read(backgroundSchedulerProvider);
    await scheduler.cancelAll();
  }

  /// Get execution statistics
  Future<Map<String, dynamic>> getExecutionStats() async {
    if (!isAvailable) return {};

    return await _executor.getExecutionStats();
  }

  /// Test task with various scenarios
  Future<List<TaskResult>> runTestScenarios(String taskId) async {
    if (!isAvailable) {
      throw UnsupportedError('Debug console only available in debug mode');
    }

    final results = <TaskResult>[];

    // Test normal execution
    results.add(await runTaskNow(taskId, {'scenario': 'normal'}));

    // Test with network error simulation
    results.add(await runTaskNow(taskId, {'scenario': 'network_error'}));

    // Test with large data
    results.add(await runTaskNow(taskId, {'scenario': 'large_data', 'data': List.generate(1000, (i) => 'item_$i')}));

    return results;
  }

  /// Generate debug report
  Map<String, dynamic> generateDebugReport() {
    if (!isAvailable) return {};

    return {
      'debug_mode': true,
      'registered_handlers': getRegisteredTaskIds(),
      'timestamp': DateTime.now().toIso8601String(),
      'platform': _getPlatformInfo(),
    };
  }

  Map<String, dynamic> _getPlatformInfo() {
    return {
      'is_android': defaultTargetPlatform == TargetPlatform.android,
      'is_ios': defaultTargetPlatform == TargetPlatform.iOS,
      'debug_mode': kDebugMode,
      'profile_mode': kProfileMode,
      'release_mode': kReleaseMode,
    };
  }
}
