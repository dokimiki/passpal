import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/assignment_status.dart';
import '../enums/assignment_type.dart';
import '../value_objects/assignment_id.dart';
import '../value_objects/course_id.dart';

part 'assignment.freezed.dart';
part 'assignment.g.dart';

/// Domain entity representing an assignment from MaNaBo
@freezed
abstract class Assignment with _$Assignment {
  const factory Assignment({
    required AssignmentId id,
    required String title,
    required CourseId courseId,
    required String courseName,
    required AssignmentType type,
    required AssignmentStatus status,
    DateTime? dueAt,
    DateTime? submittedAt,
    int? score,
    int? maxScore,
    String? resultUrl,
    String? contentUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Assignment;

  factory Assignment.fromJson(Map<String, dynamic> json) =>
      _$AssignmentFromJson(json);
}

extension AssignmentExt on Assignment {
  /// Calculate the percentage score if available
  double? get scorePercentage {
    if (score != null && maxScore != null && maxScore! > 0) {
      return (score! / maxScore!) * 100;
    }
    return null;
  }

  /// Check if assignment is overdue
  bool get isOverdue {
    if (dueAt == null) return false;
    return DateTime.now().isAfter(dueAt!) && !status.isCompleted;
  }

  /// Get days remaining until due date
  int? get daysUntilDue {
    if (dueAt == null) return null;
    final now = DateTime.now();
    final difference = dueAt!.difference(now);
    return difference.inDays;
  }

  /// Get formatted due date string
  String? get dueDateDisplay {
    if (dueAt == null) return null;
    final days = daysUntilDue;
    if (days == null) return null;

    if (days < 0) {
      return '期限切れ';
    } else if (days == 0) {
      return '今日まで';
    } else if (days == 1) {
      return '明日まで';
    } else {
      return 'あと$days日';
    }
  }
}
