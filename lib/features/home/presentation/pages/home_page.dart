import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/home_notifier.dart';
import '../widgets/system_news_section.dart';
import '../widgets/mail_section.dart';
import '../widgets/albo_news_section.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.read(homeNotifierProvider.notifier).refresh(),
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(title: Text('ホーム'), floating: true, snap: true),
            SliverToBoxAdapter(
              child: homeState.when(
                data: (state) => Column(
                  children: [
                    SystemNewsSection(
                      newsState: state.systemNews,
                      onRetry: () =>
                          ref.read(homeNotifierProvider.notifier).refresh(),
                    ),
                    const SizedBox(height: 16),
                    MailSection(
                      mailState: state.receivedMail,
                      onRetry: () =>
                          ref.read(homeNotifierProvider.notifier).refresh(),
                    ),
                    const SizedBox(height: 16),
                    AlboNewsSection(
                      newsState: state.alboNews,
                      onRetry: () =>
                          ref.read(homeNotifierProvider.notifier).refresh(),
                    ),
                    const SizedBox(height: 32), // 最下部の余白
                  ],
                ),
                loading: () => const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'データの取得に失敗しました',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            ref.read(homeNotifierProvider.notifier).refresh(),
                        child: const Text('再試行'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
