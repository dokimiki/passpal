import 'package:flutter/material.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';

class AssignmentGroupHeader extends StatelessWidget {
  final String title;

  const AssignmentGroupHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: SpaceTokens.md, bottom: SpaceTokens.sm),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}