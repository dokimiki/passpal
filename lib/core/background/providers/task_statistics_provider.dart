import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../storage/storage_providers.dart';
import '../monitoring/task_statistics_service.dart';

/// Provider for TaskStatisticsService
final taskStatisticsServiceProvider = Provider<TaskStatisticsService>((ref) {
  final cache = ref.watch(keyValueCacheProvider);
  return TaskStatisticsService(cache);
});
