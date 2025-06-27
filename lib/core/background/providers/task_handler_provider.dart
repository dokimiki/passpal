import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dispatcher/task_handler.dart';
import '../dispatcher/task_dispatcher.dart';

/// Provider for task handler registry (singleton)
final taskHandlerRegistryProvider = Provider<TaskHandlerRegistry>((ref) {
  return TaskHandlerRegistry();
});

/// Provider family for task handlers
final taskHandlerProvider = Provider.family<TaskHandler?, String>((
  ref,
  taskId,
) {
  return TaskHandlerRegistry.get(taskId);
});

/// Provider for task dispatcher
final taskDispatcherProvider = Provider<TaskDispatcher>((ref) {
  return const TaskDispatcher();
});
