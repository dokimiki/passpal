import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';
import 'package:passpal/features/assignments/application/providers.dart';
import 'package:passpal/features/assignments/domain/entities/assignment.dart';
import 'package:passpal/features/assignments/presentation/widgets/assignment_card.dart';
import 'package:passpal/features/assignments/presentation/widgets/assignment_group_header.dart';

class AssignmentsPage extends ConsumerWidget {
  const AssignmentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(assignmentsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(assignmentsNotifierProvider.notifier).refresh(),
          ),
        ],
      ),
      body: assignmentsAsync.when(
        data: (assignments) => _buildAssignmentsList(context, ref, assignments),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _buildErrorView(context, ref, error),
      ),
    );
  }

  Widget _buildAssignmentsList(
    BuildContext context,
    WidgetRef ref,
    List<Assignment> assignments,
  ) {
    if (assignments.isEmpty) {
      return const Center(child: Text('No assignments found.'));
    }

    final groupedAssignments = _groupAssignments(assignments);

    return RefreshIndicator(
      onRefresh: () => ref.read(assignmentsNotifierProvider.notifier).refresh(),
      child: ListView.builder(
        padding: const EdgeInsets.all(SpaceTokens.md),
        itemCount: groupedAssignments.length,
        itemBuilder: (context, index) {
          final group = groupedAssignments[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AssignmentGroupHeader(title: group.title),
              ...group.assignments.map(
                (assignment) => AssignmentCard(assignment: assignment),
              ),
              const SizedBox(height: SpaceTokens.md),
            ],
          );
        },
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, WidgetRef ref, Object error) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpaceTokens.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
            const SizedBox(height: SpaceTokens.md),
            Text(
              'Failed to load assignments',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: SpaceTokens.sm),
            Text(
              error.toString(),
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: SpaceTokens.lg),
            ElevatedButton.icon(
              onPressed: () =>
                  ref.read(assignmentsNotifierProvider.notifier).refresh(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  List<_AssignmentGroup> _groupAssignments(List<Assignment> assignments) {
    // Simplified grouping logic for now
    final upcoming = assignments.where((a) => !a.status.isCompleted).toList();
    final completed = assignments.where((a) => a.status.isCompleted).toList();

    final groups = <_AssignmentGroup>[];
    if (upcoming.isNotEmpty) {
      groups.add(_AssignmentGroup('Upcoming', upcoming));
    }
    if (completed.isNotEmpty) {
      groups.add(_AssignmentGroup('Completed', completed));
    }
    return groups;
  }
}

class _AssignmentGroup {
  final String title;
  final List<Assignment> assignments;

  _AssignmentGroup(this.title, this.assignments);
}
