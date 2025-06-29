import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';
import 'package:passpal/features/home/application/home_notifier.dart';
import 'package:passpal/features/home/presentation/widgets/albo_news_section.dart';
import 'package:passpal/features/home/presentation/widgets/mail_section.dart';
import 'package:passpal/features/home/presentation/widgets/system_news_section.dart';
import 'package:passpal/features/settings/presentation/pages/settings_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PassPal Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(homeNotifierProvider.notifier).refresh(),
        child: homeState.when(
          data: (state) => ListView(
            padding: const EdgeInsets.all(SpaceTokens.md),
            children: [
              Text(
                'Welcome Back!',
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: SpaceTokens.lg),
              SystemNewsSection(
                newsState: state.systemNews,
                onRetry: () =>
                    ref.read(homeNotifierProvider.notifier).refresh(),
              ),
              const SizedBox(height: SpaceTokens.md),
              MailSection(
                mailState: state.receivedMail,
                onRetry: () =>
                    ref.read(homeNotifierProvider.notifier).refresh(),
              ),
              const SizedBox(height: SpaceTokens.md),
              AlboNewsSection(
                newsState: state.alboNews,
                onRetry: () =>
                    ref.read(homeNotifierProvider.notifier).refresh(),
              ),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => _buildErrorWidget(context, ref, error),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(
      BuildContext context, WidgetRef ref, Object error) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpaceTokens.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: SpaceTokens.md),
            Text(
              'Failed to load data',
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: SpaceTokens.sm),
            Text(
              error.toString(),
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: SpaceTokens.lg),
            ElevatedButton.icon(
              onPressed: () => ref.read(homeNotifierProvider.notifier).refresh(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}