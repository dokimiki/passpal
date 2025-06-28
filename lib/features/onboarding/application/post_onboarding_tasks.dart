import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/background/background.dart';

/// Service responsible for scheduling background tasks after onboarding completion
class PostOnboardingTasks {
  final BackgroundScheduler _backgroundScheduler;

  const PostOnboardingTasks(this._backgroundScheduler);

  /// Schedule all necessary background tasks after onboarding completion
  Future<void> scheduleAllTasks() async {
    try {
      // Schedule periodic sync tasks with unique constraint to avoid duplicates

      // 1. Period master sync (weekly)
      await _backgroundScheduler.registerUnique(
        BackgroundTask(
          id: 'period_master.sync',
          frequency: const TaskFrequency.periodic(interval: Duration(days: 7)),
          constraints: const TaskConstraints(networkRequired: true),
          handler: _periodMasterSyncHandler,
        ),
      );

      // 2. Timetable sync (daily)
      await _backgroundScheduler.registerUnique(
        BackgroundTask(
          id: 'timetable.sync',
          frequency: const TaskFrequency.periodic(interval: Duration(days: 1)),
          constraints: const TaskConstraints(networkRequired: true),
          handler: _timetableSyncHandler,
        ),
      );

      // 3. Assignment sync (every 6 hours)
      await _backgroundScheduler.registerUnique(
        BackgroundTask(
          id: 'assignments.sync',
          frequency: const TaskFrequency.periodic(interval: Duration(hours: 6)),
          constraints: const TaskConstraints(networkRequired: true),
          handler: _assignmentsSyncHandler,
        ),
      );

      // 4. Bus schedule sync (daily)
      await _backgroundScheduler.registerUnique(
        BackgroundTask(
          id: 'bus_schedule.sync',
          frequency: const TaskFrequency.periodic(interval: Duration(days: 1)),
          constraints: const TaskConstraints(networkRequired: true),
          handler: _busScheduleSyncHandler,
        ),
      );

      debugPrint('[PostOnboardingTasks] Background tasks scheduling completed');
    } catch (e) {
      debugPrint('[PostOnboardingTasks] Error scheduling background tasks: $e');
      rethrow;
    }
  }

  /// Handler for period master sync task
  Future<TaskResult> _periodMasterSyncHandler(ProviderContainer context) async {
    try {
      debugPrint('[PostOnboardingTasks] Executing period master sync');
      // TODO: Implement actual period master sync
      // final repository = context.read(periodMasterRepositoryProvider);
      // await repository.sync();
      return const TaskResult.success();
    } catch (e) {
      debugPrint('[PostOnboardingTasks] Period master sync failed: $e');
      return TaskResult.failure(error: e.toString());
    }
  }

  /// Handler for timetable sync task
  Future<TaskResult> _timetableSyncHandler(ProviderContainer context) async {
    try {
      debugPrint('[PostOnboardingTasks] Executing timetable sync');
      // TODO: Implement actual timetable sync
      // final repository = context.read(timetableRepositoryProvider);
      // await repository.sync();
      return const TaskResult.success();
    } catch (e) {
      debugPrint('[PostOnboardingTasks] Timetable sync failed: $e');
      return TaskResult.failure(error: e.toString());
    }
  }

  /// Handler for assignments sync task
  Future<TaskResult> _assignmentsSyncHandler(ProviderContainer context) async {
    try {
      debugPrint('[PostOnboardingTasks] Executing assignments sync');
      // TODO: Implement actual assignments sync
      // final repository = context.read(assignmentsRepositoryProvider);
      // await repository.sync();
      return const TaskResult.success();
    } catch (e) {
      debugPrint('[PostOnboardingTasks] Assignments sync failed: $e');
      return TaskResult.failure(error: e.toString());
    }
  }

  /// Handler for bus schedule sync task
  Future<TaskResult> _busScheduleSyncHandler(ProviderContainer context) async {
    try {
      debugPrint('[PostOnboardingTasks] Executing bus schedule sync');
      // TODO: Implement actual bus schedule sync
      // final repository = context.read(busScheduleRepositoryProvider);
      // await repository.sync();
      return const TaskResult.success();
    } catch (e) {
      debugPrint('[PostOnboardingTasks] Bus schedule sync failed: $e');
      return TaskResult.failure(error: e.toString());
    }
  }
}

/// Provider for post onboarding tasks service
final postOnboardingTasksProvider = Provider<PostOnboardingTasks>((ref) {
  final backgroundScheduler = ref.read(backgroundSchedulerProvider);
  return PostOnboardingTasks(backgroundScheduler);
});
