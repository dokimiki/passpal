import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'task_constraints.dart';
import 'task_frequency.dart';
import 'task_result.dart';

part 'background_task.freezed.dart';

/// Handler function type for background tasks
typedef BackgroundTaskHandler =
    Future<TaskResult> Function(ProviderContainer context);

/// Background task definition
@freezed
abstract class BackgroundTask with _$BackgroundTask {
  const factory BackgroundTask({
    required String id,
    required TaskFrequency frequency,
    required BackgroundTaskHandler handler,
    @Default(TaskConstraints()) TaskConstraints constraints,
    Duration? initialDelay,
    Duration? timeout,
    @Default({}) Map<String, dynamic> data,
  }) = _BackgroundTask;
}
