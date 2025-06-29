import 'package:flutter/material.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';
import 'package:passpal/features/assignments/domain/entities/assignment.dart';

class AssignmentCard extends StatelessWidget {
  final Assignment assignment;

  const AssignmentCard({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompleted = assignment.status.isCompleted;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: SpaceTokens.sm),
      elevation: isCompleted ? 0 : 2,
      color: isCompleted
          ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
          : theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(SpaceTokens.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              assignment.courseName,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: SpaceTokens.sm),
            Text(
              assignment.title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            const SizedBox(height: SpaceTokens.md),
            Row(
              children: [
                _buildStatusChip(theme),
                const Spacer(),
                if (assignment.dueAt != null)
                  Text(
                    'Due: ${assignment.dueAt!.month}/${assignment.dueAt!.day}',
                    style: theme.textTheme.bodyMedium,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(ThemeData theme) {
    return Chip(
      label: Text(assignment.status.displayName),
      backgroundColor: assignment.status.isCompleted
          ? Colors.grey.shade300
          : theme.colorScheme.secondaryContainer,
      labelStyle: TextStyle(
        color: assignment.status.isCompleted
            ? Colors.grey.shade800
            : theme.colorScheme.onSecondaryContainer,
      ),
      padding: EdgeInsets.zero,
    );
  }
}
