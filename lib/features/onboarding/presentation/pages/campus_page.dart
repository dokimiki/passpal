import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/features/__shared__/models/campus.dart';
import 'package:passpal/features/onboarding/application/onboarding_controller.dart';

/// Campus selection page for onboarding
class CampusPage extends ConsumerWidget {
  const CampusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('キャンパス選択'), centerTitle: true),
      body: onboardingState.when(
        data: (status) => _buildContent(context, ref, status.campus),
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

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    Campus? selectedCampus,
  ) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),
          const Text(
            'どちらのキャンパスを利用しますか？',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Expanded(
            child: Column(
              children: [
                _buildCampusCard(
                  context: context,
                  ref: ref,
                  campus: const Campus.nagoya(),
                  icon: Icons.location_city,
                  title: '名古屋キャンパス',
                  subtitle: '法学部、経済学部、経営学部、文学部等',
                  isSelected: selectedCampus == const Campus.nagoya(),
                ),
                const SizedBox(height: 24),
                _buildCampusCard(
                  context: context,
                  ref: ref,
                  campus: const Campus.toyota(),
                  icon: Icons.nature,
                  title: '豊田キャンパス',
                  subtitle: '工学部、情報理工学部等',
                  isSelected: selectedCampus == const Campus.toyota(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: selectedCampus != null ? () => _onNext(context) : null,
            child: const Text('次へ'),
          ),
        ],
      ),
    );
  }

  Widget _buildCampusCard({
    required BuildContext context,
    required WidgetRef ref,
    required Campus campus,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);

    return Card(
      elevation: isSelected ? 8 : 2,
      color: isSelected ? theme.colorScheme.primaryContainer : null,
      child: InkWell(
        onTap: () => _selectCampus(ref, campus),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                icon,
                size: 48,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: isSelected ? theme.colorScheme.primary : null,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? theme.colorScheme.onPrimaryContainer
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: theme.colorScheme.primary,
                  size: 32,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectCampus(WidgetRef ref, Campus campus) {
    ref.read(onboardingControllerProvider.notifier).selectCampus(campus);
  }

  void _onNext(BuildContext context) {
    // Navigation will be handled by routing helpers
    Navigator.of(context).pushReplacementNamed('/setup/notification');
  }
}
