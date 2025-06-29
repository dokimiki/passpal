import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:passpal/core/routing/routes.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';
import 'package:passpal/features/onboarding/application/onboarding_controller.dart';
import 'package:passpal/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:passpal/features/login/presentation/widgets/primary_button.dart';

/// Start/completion page for onboarding
class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return OnboardingScaffold(
      title: 'Step 3: All Set!',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Icon(
            Icons.check_circle_outline,
            size: 100,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: SpaceTokens.md),
          Text(
            'Setup Complete!',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: SpaceTokens.md),
          Text(
            'Welcome to PassPal. Your campus life, simplified.',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: SpaceTokens.lg),
          _FeatureHighlightCard(),
          const Spacer(flex: 2),
          PrimaryButton(
            text: 'Start Using PassPal',
            onPressed: () async {
              await ref
                  .read(onboardingControllerProvider.notifier)
                  .completeOnboarding();
              if (context.mounted) {
                context.goNamed(AppRoute.mainHome.name);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _FeatureHighlightCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(SpaceTokens.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Key Features:',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: SpaceTokens.md),
            _buildFeatureItem(
              context,
              icon: Icons.calendar_today_outlined,
              title: 'Timetable Management',
              description: 'View your class schedule at a glance.',
            ),
            const SizedBox(height: SpaceTokens.sm),
            _buildFeatureItem(
              context,
              icon: Icons.assignment_turned_in_outlined,
              title: 'Assignment Tracking',
              description: 'Never miss a deadline again.',
            ),
            const SizedBox(height: SpaceTokens.sm),
            _buildFeatureItem(
              context,
              icon: Icons.directions_bus_outlined,
              title: 'Bus Timetables',
              description: 'Check bus schedules between campuses.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: theme.colorScheme.primary),
        const SizedBox(width: SpaceTokens.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
