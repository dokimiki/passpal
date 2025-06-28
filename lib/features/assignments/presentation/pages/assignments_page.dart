import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../../domain/entities/assignment.dart';
import '../widgets/assignment_card.dart';
import '../widgets/assignment_group_header.dart';

/// Main assignments page showing all assignments grouped by due date
class AssignmentsPage extends ConsumerWidget {
  const AssignmentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(assignmentsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('課題'),
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
        error: (error, stack) => _buildErrorView(context, ref, error),
      ),
    );
  }

  Widget _buildAssignmentsList(
    BuildContext context,
    WidgetRef ref,
    List<Assignment> assignments,
  ) {
    if (assignments.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              '課題がありません',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    final groupedAssignments = _groupAssignmentsByDueDate(assignments);

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(assignmentsNotifierProvider.notifier).refresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: groupedAssignments.length,
        itemBuilder: (context, index) {
          final group = groupedAssignments[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AssignmentGroupHeader(
                title: group.title,
                count: group.assignments.length,
              ),
              const SizedBox(height: 8),
              ...group.assignments.map(
                (assignment) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AssignmentCard(
                    assignment: assignment,
                    onTap: () => _openAssignment(context, assignment),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, WidgetRef ref, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text('エラーが発生しました', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                ref.read(assignmentsNotifierProvider.notifier).refresh(),
            child: const Text('再試行'),
          ),
        ],
      ),
    );
  }

  List<AssignmentGroup> _groupAssignmentsByDueDate(
    List<Assignment> assignments,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final nextWeek = today.add(const Duration(days: 7));

    final groups = <AssignmentGroup>[
      AssignmentGroup('今日', []),
      AssignmentGroup('明日', []),
      AssignmentGroup('今週', []),
      AssignmentGroup('来週', []),
      AssignmentGroup('期限なし', []),
      AssignmentGroup('完了済み', []),
    ];

    for (final assignment in assignments) {
      if (assignment.status.isCompleted) {
        groups[5].assignments.add(assignment);
      } else if (assignment.dueAt == null) {
        groups[4].assignments.add(assignment);
      } else {
        final dueDate = DateTime(
          assignment.dueAt!.year,
          assignment.dueAt!.month,
          assignment.dueAt!.day,
        );

        if (dueDate.isAtSameMomentAs(today)) {
          groups[0].assignments.add(assignment);
        } else if (dueDate.isAtSameMomentAs(tomorrow)) {
          groups[1].assignments.add(assignment);
        } else if (dueDate.isBefore(nextWeek)) {
          groups[2].assignments.add(assignment);
        } else {
          groups[3].assignments.add(assignment);
        }
      }
    }

    // Remove empty groups
    return groups.where((group) => group.assignments.isNotEmpty).toList();
  }

  void _openAssignment(BuildContext context, Assignment assignment) {
    // Navigate to assignment detail or open in WebView
    // For now, we'll show a simple dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(assignment.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('授業: ${assignment.courseName}'),
            Text('タイプ: ${assignment.type.displayName}'),
            Text('ステータス: ${assignment.status.displayName}'),
            if (assignment.dueAt != null)
              Text('期限: ${assignment.dueDateDisplay ?? ''}'),
            if (assignment.score != null)
              Text('得点: ${assignment.score}/${assignment.maxScore ?? '?'}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
          if (assignment.contentUrl != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Open in WebView
                // _openInWebView(assignment.contentUrl!);
              },
              child: const Text('開く'),
            ),
        ],
      ),
    );
  }
}

/// Helper class for grouping assignments
class AssignmentGroup {
  final String title;
  final List<Assignment> assignments;

  AssignmentGroup(this.title, this.assignments);
}
