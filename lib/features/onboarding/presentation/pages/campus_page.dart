import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:passpal/core/routing/routes.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';
import 'package:passpal/features/__shared__/models/campus.dart';
import 'package:passpal/features/onboarding/application/onboarding_controller.dart';
import 'package:passpal/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:passpal/features/login/presentation/widgets/primary_button.dart';

/// Campus selection page for onboarding
class CampusPage extends ConsumerWidget {
  const CampusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingControllerProvider);
    final theme = Theme.of(context);

    return OnboardingScaffold(
      title: 'Step 1: Campus',
      child: onboardingState.when(
        data: (status) {
          final selectedCampus = status.campus;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Which campus will you be using?',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SpaceTokens.sm),
              Text(
                'This helps personalize your experience.',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SpaceTokens.lg),
              _CampusCard(
                campus: const Campus.nagoya(),
                icon: Icons.school_outlined,
                title: 'Nagoya Campus',
                subtitle: 'Law, Economics, Business, etc.',
                isSelected: selectedCampus == const Campus.nagoya(),
                onTap: () => ref
                    .read(onboardingControllerProvider.notifier)
                    .selectCampus(const Campus.nagoya()),
              ),
              const SizedBox(height: SpaceTokens.md),
              _CampusCard(
                campus: const Campus.toyota(),
                icon: Icons.directions_car_outlined,
                title: 'Toyota Campus',
                subtitle: 'Engineering, Information Tech, etc.',
                isSelected: selectedCampus == const Campus.toyota(),
                onTap: () => ref
                    .read(onboardingControllerProvider.notifier)
                    .selectCampus(const Campus.toyota()),
              ),
              const Spacer(),
              PrimaryButton(
                text: 'Next',
                isEnabled: selectedCampus != null,
                onPressed: () =>
                    context.goNamed(AppRoute.setupNotification.name),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _CampusCard extends StatelessWidget {
  const _CampusCard({
    required this.campus,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final Campus campus;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(SpaceTokens.md),
          child: Row(
            children: [
              Icon(icon, size: 40, color: theme.colorScheme.primary),
              const SizedBox(width: SpaceTokens.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: SpaceTokens.xs),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
