/// Status of an assignment submission
enum AssignmentStatus {
  /// Assignment has not been started
  notStarted,

  /// Assignment is in progress
  inProgress,

  /// Assignment has been submitted
  submitted,

  /// Assignment has been graded
  graded,

  /// Assignment is past due date
  overdue;

  /// Get display name for the assignment status
  String get displayName {
    switch (this) {
      case AssignmentStatus.notStarted:
        return '未着手';
      case AssignmentStatus.inProgress:
        return '進行中';
      case AssignmentStatus.submitted:
        return '提出済み';
      case AssignmentStatus.graded:
        return '採点済み';
      case AssignmentStatus.overdue:
        return '期限切れ';
    }
  }

  /// Get color representation for the status
  String get colorName {
    switch (this) {
      case AssignmentStatus.notStarted:
        return 'grey';
      case AssignmentStatus.inProgress:
        return 'blue';
      case AssignmentStatus.submitted:
        return 'orange';
      case AssignmentStatus.graded:
        return 'green';
      case AssignmentStatus.overdue:
        return 'red';
    }
  }

  /// Check if assignment is completed (submitted or graded)
  bool get isCompleted {
    return this == AssignmentStatus.submitted ||
        this == AssignmentStatus.graded;
  }
}
