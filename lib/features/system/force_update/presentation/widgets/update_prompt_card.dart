import 'package:flutter/material.dart';
import 'package:passpal/core/theme/extensions/passpal_theme_ext.dart';

/// Update prompt card widget for force update page
class UpdatePromptCard extends StatelessWidget {
  const UpdatePromptCard({
    super.key,
    required this.currentVersion,
    required this.requiredVersion,
    required this.onUpdatePressed,
  });

  final String currentVersion;
  final String requiredVersion;
  final VoidCallback onUpdatePressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<PasspalThemeExt>()!;

    return Card(
      color: theme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.system_update_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              '最新バージョンへアップデートしてください',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'このバージョンのアプリはサポートが終了しました。\n継続してご利用いただくには、最新バージョンへの\nアップデートが必要です。',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '現在のバージョン',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      currentVersion,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '必要バージョン',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      requiredVersion,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onUpdatePressed,
                child: const Text('アップデート'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
