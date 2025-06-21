import 'package:isar/isar.dart';

part 'timetable.g.dart';

/// Represents a timetable entry for a specific campus, weekday, and period.
///
/// This entity stores course information including the course name, instructor,
/// and metadata for efficient querying and caching.
@collection
class Timetable {
  /// Auto-incremented primary key.
  Id id = Isar.autoIncrement;

  /// Campus identifier (e.g., "toyota", "nagoya").
  late String campusId;

  /// Day of the week (1=Monday, 2=Tuesday, ..., 6=Saturday).
  late int weekday;

  /// Period number (1限, 2限, etc.).
  late int period;

  /// Name of the course.
  late String courseName;

  /// Name of the instructor.
  late String instructor;

  /// Last update timestamp for cache management.
  DateTime updatedAt = DateTime.now();

  /// Composite index for efficient querying by campus, weekday, and period.
  @Index(
    composite: [
      CompositeIndex('campusId'),
      CompositeIndex('weekday'),
      CompositeIndex('period'),
    ],
  )
  String get searchKey => '$campusId-$weekday-$period';

  /// Creates a new Timetable entry.
  ///
  /// [campusId] Campus identifier
  /// [weekday] Day of the week (1-6)
  /// [period] Period number
  /// [courseName] Course name
  /// [instructor] Instructor name
  Timetable({
    required this.campusId,
    required this.weekday,
    required this.period,
    required this.courseName,
    required this.instructor,
  }) {
    updatedAt = DateTime.now();
  }

  /// Creates an empty Timetable instance.
  Timetable.empty();

  @override
  String toString() {
    return 'Timetable(id: $id, campusId: $campusId, weekday: $weekday, '
        'period: $period, courseName: $courseName, instructor: $instructor, '
        'updatedAt: $updatedAt)';
  }
}
