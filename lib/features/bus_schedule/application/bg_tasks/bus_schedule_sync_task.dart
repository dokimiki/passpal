import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repository/holiday_repository.dart';
import '../../data/timetable_providers.dart';

part 'bus_schedule_sync_task.g.dart';

/// Background task for syncing bus schedule data
class BusScheduleSyncTask {
  static const String taskId = 'bus_schedule.sync';

  final HolidayRepository _holidayRepository;

  BusScheduleSyncTask({required HolidayRepository holidayRepository})
    : _holidayRepository = holidayRepository;

  /// Execute the sync task
  Future<void> execute() async {
    try {
      // Sync holiday data
      await _holidayRepository.getHolidays();

      // For now, just log success
      debugPrint('BusScheduleSyncTask: Holiday data synced successfully');

      // TODO: Sync timetable data for all lines
      // This would involve getting all available lines and syncing their timetables
    } catch (e) {
      // Log error but don't rethrow - background tasks should be resilient
      debugPrint('BusScheduleSyncTask: Error syncing data: $e');
      rethrow; // Allow retry mechanism to work
    }
  }

  /// Create task constraints for background execution
  static Map<String, dynamic> getTaskConstraints() {
    return {
      'networkRequired': true,
      'requiresBatteryNotLow': false,
      'requiresCharging': false,
      'requiresDeviceIdle': false,
    };
  }

  /// Get retry policy configuration
  static Map<String, dynamic> getRetryPolicy() {
    return {
      'maxRetries': 3,
      'initialDelaySeconds': 30,
      'maxDelaySeconds': 300,
      'backoffMultiplier': 2.0,
    };
  }
}

/// Provider for bus schedule sync task
@riverpod
BusScheduleSyncTask busScheduleSyncTask(Ref ref) {
  final holidayRepository = ref.watch(holidayRepositoryProvider);

  return BusScheduleSyncTask(holidayRepository: holidayRepository);
}
