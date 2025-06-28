import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/timetable_grid.dart';
import '../../application/timetable_controller.dart';

/// 時間割ページ
class TimetablePage extends ConsumerWidget {
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timetableState = ref.watch(timetableControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('時間割'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              _showTermSelector(context, ref);
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref
                  .read(timetableControllerProvider.notifier)
                  .refresh(forceRefresh: true);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(timetableControllerProvider.notifier)
              .refresh(forceRefresh: true);
        },
        child: timetableState.when(
          data: (slots) => TimetableGrid(slots: slots),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'エラーが発生しました',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '$error',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.read(timetableControllerProvider.notifier).refresh();
                  },
                  child: const Text('再読み込み'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showTermSelector(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('学期選択', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('前期'),
              onTap: () {
                Navigator.pop(context);
                // TODO: 前期の時間割を読み込み
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('後期'),
              onTap: () {
                Navigator.pop(context);
                // TODO: 後期の時間割を読み込み
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('集中講義'),
              onTap: () {
                Navigator.pop(context);
                // TODO: 集中講義の時間割を読み込み
              },
            ),
          ],
        ),
      ),
    );
  }
}
