import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/background/background.dart';
import 'providers.dart';

/// Service responsible for scheduling background tasks for home feature data
class HomeBackgroundTasks {
  final BackgroundScheduler _backgroundScheduler;

  const HomeBackgroundTasks(this._backgroundScheduler);

  /// Schedule all home-related background tasks
  Future<void> scheduleAllTasks() async {
    try {
      // 1. System news sync (every 2 hours)
      await _backgroundScheduler.registerUnique(
        BackgroundTask(
          id: 'home.system_news.sync',
          frequency: const TaskFrequency.periodic(interval: Duration(hours: 2)),
          constraints: const TaskConstraints(networkRequired: true),
          handler: _systemNewsSyncHandler,
        ),
      );

      // 2. Mail sync (every 30 minutes)
      await _backgroundScheduler.registerUnique(
        BackgroundTask(
          id: 'home.mail.sync',
          frequency: const TaskFrequency.periodic(
            interval: Duration(minutes: 30),
          ),
          constraints: const TaskConstraints(networkRequired: true),
          handler: _mailSyncHandler,
        ),
      );

      // 3. ALBO news sync (every hour)
      await _backgroundScheduler.registerUnique(
        BackgroundTask(
          id: 'home.albo_news.sync',
          frequency: const TaskFrequency.periodic(interval: Duration(hours: 1)),
          constraints: const TaskConstraints(networkRequired: true),
          handler: _alboNewsSyncHandler,
        ),
      );

      debugPrint('[HomeBackgroundTasks] Background tasks scheduling completed');
    } catch (e) {
      debugPrint('[HomeBackgroundTasks] Error scheduling background tasks: $e');
      rethrow;
    }
  }

  /// Cancel all home-related background tasks
  Future<void> cancelAllTasks() async {
    try {
      await Future.wait([
        _backgroundScheduler.cancel('home.system_news.sync'),
        _backgroundScheduler.cancel('home.mail.sync'),
        _backgroundScheduler.cancel('home.albo_news.sync'),
      ]);
      debugPrint('[HomeBackgroundTasks] All background tasks cancelled');
    } catch (e) {
      debugPrint('[HomeBackgroundTasks] Error cancelling background tasks: $e');
      rethrow;
    }
  }

  /// Handler for system news background sync
  static Future<TaskResult> _systemNewsSyncHandler(
    ProviderContainer container,
  ) async {
    try {
      final useCase = container.read(getSystemNewsUseCaseProvider);
      final news = await useCase.execute();

      debugPrint(
        '[HomeBackgroundTasks] System news sync completed: ${news.length} items',
      );
      return const TaskResult.success();
    } catch (e, stackTrace) {
      debugPrint('[HomeBackgroundTasks] System news sync failed: $e');
      return TaskResult.failure(
        error: 'System news sync failed: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Handler for mail background sync
  static Future<TaskResult> _mailSyncHandler(
    ProviderContainer container,
  ) async {
    try {
      final useCase = container.read(getReceivedMailUseCaseProvider);
      final mails = await useCase.execute();

      debugPrint(
        '[HomeBackgroundTasks] Mail sync completed: ${mails.length} items',
      );
      return const TaskResult.success();
    } catch (e, stackTrace) {
      debugPrint('[HomeBackgroundTasks] Mail sync failed: $e');
      return TaskResult.failure(
        error: 'Mail sync failed: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Handler for ALBO news background sync
  static Future<TaskResult> _alboNewsSyncHandler(
    ProviderContainer container,
  ) async {
    try {
      final useCase = container.read(getAlboNewsUseCaseProvider);
      final news = await useCase.execute();

      debugPrint(
        '[HomeBackgroundTasks] ALBO news sync completed: ${news.length} items',
      );
      return const TaskResult.success();
    } catch (e, stackTrace) {
      debugPrint('[HomeBackgroundTasks] ALBO news sync failed: $e');
      return TaskResult.failure(
        error: 'ALBO news sync failed: $e',
        stackTrace: stackTrace,
      );
    }
  }
}

/// Provider for HomeBackgroundTasks
final homeBackgroundTasksProvider = Provider<HomeBackgroundTasks>((ref) {
  final scheduler = ref.read(backgroundSchedulerProvider);
  return HomeBackgroundTasks(scheduler);
});
