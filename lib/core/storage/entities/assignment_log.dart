import 'package:isar/isar.dart';

part 'assignment_log.g.dart';

/// Represents the action performed on an assignment.
enum AssignmentAction {
  /// Assignment was added to the system.
  added,

  /// Assignment was removed from the system.
  removed,
}

/// Represents a log entry for assignment changes.
///
/// This entity tracks when assignments are added or removed,
/// along with their due dates and notification status.
@collection
class AssignmentLog {
  /// Auto-incremented primary key.
  Id id = Isar.autoIncrement;

  /// Unique identifier from MaNaBo system.
  @Index(unique: true)
  late String assignmentId;

  /// Action performed on the assignment.
  @Enumerated(EnumType.ordinal)
  late AssignmentAction action;

  /// Due date of the assignment. Null if no due date is set.
  DateTime? dueAt;

  /// When this log entry was created.
  DateTime createdAt = DateTime.now();

  /// Whether push notification has been sent for this change.
  bool notified = false;

  /// Creates a new AssignmentLog entry.
  ///
  /// [assignmentId] MaNaBo unique identifier
  /// [action] Type of action performed
  /// [dueAt] Due date (optional)
  /// [notified] Notification status (defaults to false)
  AssignmentLog({
    required this.assignmentId,
    required this.action,
    this.dueAt,
    this.notified = false,
  }) {
    createdAt = DateTime.now();
  }

  /// Creates an empty AssignmentLog instance.
  AssignmentLog.empty();

  /// Returns true if this assignment has a due date.
  bool get hasDueDate => dueAt != null;

  /// Returns true if the assignment is overdue.
  bool get isOverdue {
    if (dueAt == null) return false;
    return DateTime.now().isAfter(dueAt!);
  }

  @override
  String toString() {
    return 'AssignmentLog(id: $id, assignmentId: $assignmentId, '
        'action: $action, dueAt: $dueAt, createdAt: $createdAt, '
        'notified: $notified)';
  }
}
