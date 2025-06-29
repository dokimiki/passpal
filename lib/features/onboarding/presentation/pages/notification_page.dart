import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:passpal/core/routing/routes.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';
import 'package:passpal/features/onboarding/application/onboarding_controller.dart';
import 'package:passpal/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:passpal/features/login/presentation/widgets/primary_button.dart';

/// Notification permission page for onboarding
class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return OnboardingScaffold(
      title: 'Step 2: Notifications',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Icon(
            Icons.notifications_active_outlined,
            size: 80,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: SpaceTokens.md),
          Text(
            'Enable Notifications',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: SpaceTokens.md),
          Text(
            'Get timely reminders for assignments, class schedules, and important announcements.',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: SpaceTokens.lg),
          _PermissionInfoCard(),
          const Spacer(flex: 2),
          PrimaryButton(
            text: 'Allow Notifications',
            onPressed: () async {
              await ref
                  .read(onboardingControllerProvider.notifier)
                  .requestNotificationPermission();
              if (context.mounted) {
                context.goNamed(AppRoute.setupStart.name);
              }
            },
          ),
          const SizedBox(height: SpaceTokens.sm),
          TextButton(
            onPressed: () {
              // No permission request, just navigate
              context.goNamed(AppRoute.setupStart.name);
            },
            child: const Text('Maybe Later'),
          ),
        ],
      ),
    );
  }
}

class _PermissionInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.4),
      child: Padding(
        padding: const EdgeInsets.all(SpaceTokens.md),
        child: Column(
          children: [
            _buildFeatureItem(
              context,
              icon: Icons.assignment_late_outlined,
              text: 'Assignment due date reminders',
            ),
            const Divider(height: SpaceTokens.md),
            _buildFeatureItem(
              context,
              icon: Icons.schedule_outlined,
              text: 'Class start time alerts',
            ),
            const Divider(height: SpaceTokens.md),
            _buildFeatureItem(
              context,
              icon: Icons.campaign_outlined,
              text: 'Important school announcements',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.onSecondaryContainer),
        const SizedBox(width: SpaceTokens.md),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSecondaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}
