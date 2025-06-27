import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_frequency.freezed.dart';

/// Defines how frequently a background task should run
@freezed
class TaskFrequency with _$TaskFrequency {
  const factory TaskFrequency.oneShot() = TaskFrequencyOneShot;

  const factory TaskFrequency.periodic({required Duration interval}) =
      TaskFrequencyPeriodic;

  const factory TaskFrequency.immediate() = TaskFrequencyImmediate;
}
