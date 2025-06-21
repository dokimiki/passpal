import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import 'isar_service.dart';

/// Riverpod provider for the Isar database instance.
///
/// This provider gives access to the initialized Isar database.
/// The database must be opened using [IsarService.instance.open()]
/// before this provider can be used.
///
/// Example usage:
/// ```dart
/// class MyWidget extends ConsumerWidget {
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     final isar = ref.read(isarProvider);
///     // Use isar for database operations
///     return Container();
///   }
/// }
/// ```
///
/// Throws [StateError] if the database hasn't been opened yet.
/// Call [IsarService.instance.open()] during app initialization.
final isarProvider = Provider<Isar>((ref) {
  final service = IsarService.instance;
  final isar = service.isar;

  if (isar == null) {
    throw StateError(
      'Isar database not opened. Call IsarService.instance.open() first.',
    );
  }

  return isar;
});

/// Riverpod provider for the IsarService singleton.
///
/// This provider gives access to the IsarService instance for
/// database management operations like opening, closing, and clearing.
///
/// Example usage:
/// ```dart
/// // In your app initialization
/// final isarService = ref.read(isarServiceProvider);
/// await isarService.open();
/// ```
final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService.instance;
});

/// Riverpod provider for database statistics.
///
/// This provider returns database statistics including collection counts
/// and database information. It's useful for debugging and monitoring.
///
/// Example usage:
/// ```dart
/// final stats = await ref.read(databaseStatsProvider.future);
/// print('Timetable entries: ${stats['timetable_count']}');
/// ```
final databaseStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final service = ref.read(isarServiceProvider);
  return await service.getStats();
});
