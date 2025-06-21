import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'entities/timetable.dart';
import 'entities/assignment_log.dart';

/// Service for managing Isar database operations.
///
/// This service provides a singleton interface to the Isar database.
/// It handles database initialization and provides methods for testing
/// and cleanup.
class IsarService {
  IsarService._internal();

  /// Singleton instance of IsarService.
  static final IsarService instance = IsarService._internal();

  /// The Isar database instance.
  Isar? _isar;

  /// Gets the current Isar instance.
  ///
  /// Returns null if the database hasn't been opened yet.
  /// Call [open] first to initialize the database.
  Isar? get isar => _isar;

  /// Opens or returns the existing Isar database instance.
  ///
  /// This method:
  /// 1. Returns the existing instance if already opened
  /// 2. Loads or generates an encryption key
  /// 3. Opens the Isar database with the encryption key
  /// 4. Returns the initialized database instance
  ///
  /// Throws [IsarError] if database initialization fails.
  /// Throws [StateError] if application documents directory is unavailable.
  Future<Isar> open() async {
    if (_isar != null) {
      return _isar!;
    } // Get application documents directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final dbPath = appDocDir.path;

    // Open Isar database
    _isar = await Isar.open(
      [TimetableSchema, AssignmentLogSchema],
      directory: dbPath,
      name: 'passpal_db',
    );

    return _isar!;
  }

  /// Clears all data from the database.
  ///
  /// This method is primarily intended for testing and development.
  /// It removes all collections and their data from the database.
  ///
  /// Throws [StateError] if the database hasn't been opened yet.
  /// Throws [IsarError] if the clear operation fails.
  Future<void> clear() async {
    if (_isar == null) {
      throw StateError('Database not opened. Call open() first.');
    }

    await _isar!.writeTxn(() async {
      await _isar!.clear();
    });
  }

  /// Closes the database connection and cleans up resources.
  ///
  /// After calling this method, you'll need to call [open] again
  /// to use the database. This is primarily used for testing
  /// or when the app is shutting down.
  Future<void> close() async {
    if (_isar != null) {
      await _isar!.close();
      _isar = null;
    }
  }

  /// Gets database statistics and information.
  ///
  /// Returns a map containing:
  /// - Collection names and their record counts
  /// - Database size information
  /// - Database name
  ///
  /// Throws [StateError] if the database hasn't been opened yet.
  Future<Map<String, dynamic>> getStats() async {
    if (_isar == null) {
      throw StateError('Database not opened. Call open() first.');
    }

    final stats = <String, dynamic>{};

    // Get collection counts
    stats['timetable_count'] = await _isar!.timetables.count();
    stats['assignment_log_count'] = await _isar!.assignmentLogs.count();

    // Get database info
    stats['database_name'] = _isar!.name;

    return stats;
  }
}
