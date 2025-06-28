import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:passpal/core/routing/providers.dart';
import 'package:passpal/features/system/shared/widgets/system_scaffold.dart';
import 'package:passpal/features/system/maintenance/presentation/widgets/maintenance_illustration.dart';

/// Maintenance page displayed when the app is in maintenance mode
class MaintenancePage extends ConsumerWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SystemScaffold(
      title: 'メンテナンス',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MaintenanceIllustration(),
              const SizedBox(height: 32),
              Text(
                'ただいまメンテナンス中です',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'ご迷惑をおかけして申し訳ございません。\nしばらくお待ちください。',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: () => _onRetryPressed(context, ref),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onRetryPressed(BuildContext context, WidgetRef ref) {
    // Refresh the maintenance flag provider
    ref.invalidate(maintenanceFlagProvider);

    // Check if maintenance mode is still active
    final isMaintenanceMode = ref.read(maintenanceFlagProvider);

    if (!isMaintenanceMode) {
      // Exit maintenance mode and go to home
      context.go('/');
    }
    // If still in maintenance mode, the page will stay the same
  }
}
