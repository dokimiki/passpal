import 'get_assignments.dart';

/// Use case for synchronizing assignments
class SyncAssignments {
  final AssignmentRepository _repository;

  const SyncAssignments(this._repository);

  /// Sync assignments for a specific term
  /// Returns the number of new assignments found
  Future<int> call(String term) async {
    // Get current count before refresh
    final currentAssignments = await _repository.watchAssignments(term).first;
    final beforeCount = currentAssignments.length;

    // Refresh assignments
    await _repository.refreshAssignments(term);

    // Get new count after refresh
    final newAssignments = await _repository.watchAssignments(term).first;
    final afterCount = newAssignments.length;

    return afterCount - beforeCount;
  }
}
