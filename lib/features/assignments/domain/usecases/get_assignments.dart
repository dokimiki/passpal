import '../entities/assignment.dart';
import '../value_objects/course_id.dart';

/// Abstract repository interface for assignments
abstract class AssignmentRepository {
  /// Watch assignments for a specific term
  Stream<List<Assignment>> watchAssignments(String term);

  /// Refresh assignments from remote source
  Future<void> refreshAssignments(String term);

  /// Mark an assignment as seen/viewed
  Future<void> markSeen(String assignmentId);

  /// Get assignments for a specific course
  Future<List<Assignment>> getAssignmentsForCourse(CourseId courseId);

  /// Get current assignments count
  Future<int> getAssignmentsCount(String term);
}

/// Use case for getting assignments
class GetAssignments {
  final AssignmentRepository _repository;

  const GetAssignments(this._repository);

  /// Get assignments for a specific term
  Stream<List<Assignment>> call(String term) {
    return _repository.watchAssignments(term);
  }
}
