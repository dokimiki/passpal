import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_constraints.freezed.dart';

/// Constraints for background task execution
@freezed
abstract class TaskConstraints with _$TaskConstraints {
  const factory TaskConstraints({
    @Default(false) bool networkRequired,
    @Default(false) bool chargingRequired,
    @Default(false) bool deviceIdleRequired,
    @Default(false) bool batteryNotLowRequired,
    @Default(false) bool storageNotLowRequired,
  }) = _TaskConstraints;
}
