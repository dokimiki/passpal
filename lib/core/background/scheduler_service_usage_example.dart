import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/background/scheduler_provider.dart';

/// Usage example for the SchedulerService.
///
/// This demonstrates how to use the scheduler service in your application
/// to schedule background tasks.
class SchedulerServiceUsageExample extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulerService = ref.read(schedulerProvider);

    return Scaffold(
      appBar: AppBar(title: Text('スケジューラーサービス使用例')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Schedule a one-off task to check assignments after 30 minutes
                await schedulerService.scheduleOneOff(
                  taskId: 'assignmentCheck',
                  delay: const Duration(minutes: 30),
                  inputData: {
                    'action': 'checkAssignments',
                    'userId': 'user123',
                  },
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('課題チェックタスクを30分後にスケジュールしました')),
                );
              },
              child: Text('30分後に課題をチェック'),
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                // Schedule a periodic task to send reminder notifications every 2 hours
                await schedulerService.schedulePeriodic(
                  taskId: 'reminderNotification',
                  frequency: const Duration(hours: 2),
                  inputData: {
                    'action': 'sendReminders',
                    'notificationType': 'assignment',
                  },
                  flexEnabled: true,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('2時間毎のリマインダー通知をスケジュールしました')),
                );
              },
              child: Text('2時間毎にリマインダーを送信'),
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                // Cancel a scheduled task
                await schedulerService.cancel('assignmentCheck');

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('課題チェックタスクをキャンセルしました')));
              },
              child: Text('課題チェックタスクをキャンセル'),
            ),

            SizedBox(height: 32),

            Text('注意事項:', style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 8),
            Text(
              '• iOSではバックグラウンド処理に制限があります\n'
              '• Androidでは電池最適化設定の影響を受けます\n'
              '• タスクの実行は保証されません（ベストエフォート）',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
