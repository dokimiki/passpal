import 'package:flutter/material.dart';
import 'package:passpal/core/theme/extensions/passpal_theme_ext.dart';

/// Error detail card widget for error page
class ErrorDetailCard extends StatelessWidget {
  const ErrorDetailCard({
    super.key,
    required this.title,
    required this.message,
    this.onRetryPressed,
  });

  final String title;
  final String message;
  final VoidCallback? onRetryPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<PasspalThemeExt>()!;

    return Card(
      color: theme.errorBg,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetryPressed != null) ...[
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onRetryPressed,
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                  ),
                  child: const Text('再試行'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
