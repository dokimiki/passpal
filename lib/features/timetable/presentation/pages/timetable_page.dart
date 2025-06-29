import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';
import 'package:passpal/features/timetable/application/timetable_controller.dart';
import 'package:passpal/features/timetable/presentation/widgets/timetable_grid.dart';

class TimetablePage extends ConsumerWidget {
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timetableState = ref.watch(timetableControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
        actions: [
          IconButton(
            icon: const Icon(Icons.today_outlined),
            onPressed: () => _showTermSelector(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref
                .read(timetableControllerProvider.notifier)
                .refresh(forceRefresh: true),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref
            .read(timetableControllerProvider.notifier)
            .refresh(forceRefresh: true),
        child: timetableState.when(
          data: (slots) => TimetableGrid(slots: slots),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => _buildErrorWidget(context, ref, error),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, WidgetRef ref, Object error) {
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
              'Failed to load timetable',
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
                  ref.read(timetableControllerProvider.notifier).refresh(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTermSelector(BuildContext context, WidgetRef ref) {
    // This would be implemented with a proper term selection logic
    // For now, it's a placeholder.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Term selection coming soon!')),
    );
  }
}
