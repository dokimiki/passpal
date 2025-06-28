import 'package:flutter/material.dart';

import '../../domain/entities/assignment.dart';
import '../../domain/enums/assignment_status.dart';

/// Card widget for displaying individual assignment information
class AssignmentCard extends StatelessWidget {
  final Assignment assignment;
  final VoidCallback? onTap;

  const AssignmentCard({super.key, required this.assignment, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      assignment.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildStatusBadge(context),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Chip(
                    label: Text(
                      assignment.courseName,
                      style: theme.textTheme.bodySmall,
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    assignment.type.displayName,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              if (assignment.dueAt != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: _getDueDateColor(assignment),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      assignment.dueDateDisplay ?? '',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _getDueDateColor(assignment),
                        fontWeight: assignment.isOverdue
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
              if (assignment.score != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.grade, size: 16, color: Colors.amber[700]),
                    const SizedBox(width: 4),
                    Text(
                      '${assignment.score}/${assignment.maxScore ?? '?'}点',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.amber[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (assignment.scorePercentage != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        '(${assignment.scorePercentage!.toStringAsFixed(1)}%)',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final theme = Theme.of(context);
    Color backgroundColor;
    Color textColor = Colors.white;

    switch (assignment.status) {
      case AssignmentStatus.notStarted:
        backgroundColor = Colors.grey;
        break;
      case AssignmentStatus.inProgress:
        backgroundColor = Colors.blue;
        break;
      case AssignmentStatus.submitted:
        backgroundColor = Colors.orange;
        break;
      case AssignmentStatus.graded:
        backgroundColor = Colors.green;
        break;
      case AssignmentStatus.overdue:
        backgroundColor = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        assignment.status.displayName,
        style: theme.textTheme.bodySmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getDueDateColor(Assignment assignment) {
    if (assignment.isOverdue) {
      return Colors.red;
    }

    final daysUntilDue = assignment.daysUntilDue;
    if (daysUntilDue == null) return Colors.grey;

    if (daysUntilDue <= 1) {
      return Colors.red;
    } else if (daysUntilDue <= 3) {
      return Colors.orange;
    } else {
      return Colors.grey[600] ?? Colors.grey;
    }
  }
}
