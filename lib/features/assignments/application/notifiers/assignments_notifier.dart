import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/assignment.dart';
import '../providers.dart';

/// Notifier for managing assignments state
class AssignmentsNotifier extends AutoDisposeAsyncNotifier<List<Assignment>> {
  String? _currentTerm;

  @override
  Future<List<Assignment>> build() async {
    // Initialize with current term (you might want to get this from a term provider)
    _currentTerm = '2025_spring'; // This should come from current term provider

    final useCase = ref.read(getAssignmentsUseCaseProvider);

    // Subscribe to assignments stream
    final stream = useCase(_currentTerm!);

    // Return the first value and keep listening for updates
    final firstValue = await stream.first;

    // Continue listening for updates in the background
    ref.listen(streamProvider(stream), (previous, next) {
      next.when(
        data: (assignments) => state = AsyncData(assignments),
        loading: () {}, // Keep current state during loading
        error: (error, stack) => state = AsyncError(error, stack),
      );
    });

    return firstValue;
  }

  /// Refresh assignments from remote source
  Future<void> refresh() async {
    if (_currentTerm == null) return;

    state = const AsyncLoading();

    try {
      final repository = ref.read(assignmentsRepositoryProvider);
      await repository.refreshAssignments(_currentTerm!);

      // The state will be updated automatically through the stream listener
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// Switch to a different term
  Future<void> switchTerm(String term) async {
    if (_currentTerm == term) return;

    _currentTerm = term;
    state = const AsyncLoading();

    try {
      final useCase = ref.read(getAssignmentsUseCaseProvider);
      final stream = useCase(term);
      final assignments = await stream.first;
      state = AsyncData(assignments);

      // Update stream listener for new term
      ref.listen(streamProvider(stream), (previous, next) {
        next.when(
          data: (assignments) => state = AsyncData(assignments),
          loading: () {},
          error: (error, stack) => state = AsyncError(error, stack),
        );
      });
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// Mark an assignment as viewed
  Future<void> markAsViewed(String assignmentId) async {
    try {
      final repository = ref.read(assignmentsRepositoryProvider);
      await repository.markSeen(assignmentId);
    } catch (error) {
      // Log error but don't change state for this non-critical operation
      // You might want to add logging here
    }
  }

  /// Get current term
  String? get currentTerm => _currentTerm;
}

/// Helper provider for creating stream providers
final streamProvider =
    StreamProvider.family<List<Assignment>, Stream<List<Assignment>>>((
      ref,
      stream,
    ) {
      return stream;
    });
