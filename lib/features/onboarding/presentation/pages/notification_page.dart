import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/features/onboarding/application/onboarding_controller.dart';

/// Notification permission page for onboarding
class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('通知設定'), centerTitle: true),
      body: onboardingState.when(
        data: (status) => _buildContent(context, ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text('エラーが発生しました: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(onboardingControllerProvider),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),
          Icon(
            Icons.notifications_active,
            size: 80,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 32),
          const Text(
            '通知を許可しますか？',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: theme.colorScheme.primary),
                      const SizedBox(width: 12),
                      const Text(
                        '通知を許可すると',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    icon: Icons.assignment,
                    text: '課題の締切日をお知らせ',
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(icon: Icons.schedule, text: '授業開始時間をリマインド'),
                  const SizedBox(height: 12),
                  _buildFeatureItem(icon: Icons.campaign, text: '重要なお知らせを受信'),
                ],
              ),
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () => _requestPermission(ref),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('通知を許可', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => _skipPermission(ref),
                child: const Text('後で設定する'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.green),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
      ],
    );
  }

  void _requestPermission(WidgetRef ref) async {
    await ref
        .read(onboardingControllerProvider.notifier)
        .requestNotificationPermission();
    // Navigate to next page
    // This will be handled by routing logic based on state changes
  }

  void _skipPermission(WidgetRef ref) async {
    await ref
        .read(onboardingControllerProvider.notifier)
        .skipNotificationPermission();
    // Navigate to next page
    // This will be handled by routing logic based on state changes
  }
}
