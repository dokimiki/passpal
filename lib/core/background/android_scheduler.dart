import 'package:workmanager/workmanager.dart';
import 'scheduler_service.dart';

/// Android implementation of [SchedulerService] using WorkManager.
///
/// This implementation uses the WorkManager plugin to schedule background
/// tasks on Android devices with appropriate constraints for battery optimization.
class AndroidScheduler implements SchedulerService {
  final Workmanager _workmanager;

  /// Creates an instance of [AndroidScheduler].
  ///
  /// [workmanager] - Optional WorkManager instance for testing.
  /// If not provided, uses the default Workmanager() instance.
  AndroidScheduler({Workmanager? workmanager})
    : _workmanager = workmanager ?? Workmanager();

  @override
  Future<void> scheduleOneOff({
    required String taskId,
    required Duration delay,
    Map<String, dynamic>? inputData,
  }) async {
    await _workmanager.registerOneOffTask(
      taskId,
      taskId,
      initialDelay: delay,
      inputData: inputData,
      constraints: _createConstraints(),
    );
  }

  @override
  Future<void> schedulePeriodic({
    required String taskId,
    required Duration frequency,
    Map<String, dynamic>? inputData,
    bool flexEnabled = true,
  }) async {
    await _workmanager.registerPeriodicTask(
      taskId,
      taskId,
      frequency: frequency,
      inputData: inputData,
      constraints: _createConstraints(),
    );
  }

  @override
  Future<void> cancel(String taskId) async {
    await _workmanager.cancelByUniqueName(taskId);
  }

  /// Creates WorkManager constraints optimized for battery life.
  ///
  /// These constraints ensure tasks run only when:
  /// - Battery is not low
  /// - Device has network connectivity
  Constraints _createConstraints() {
    return Constraints(
      networkType: NetworkType.connected,
      requiresBatteryNotLow: true,
    );
  }
}
