import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';
import 'package:passpal/features/home/domain/entities/news_item.dart';
import 'package:shimmer/shimmer.dart';

class SystemNewsSection extends StatelessWidget {
  final AsyncValue<List<NewsItem>> newsState;
  final VoidCallback? onRetry;

  const SystemNewsSection({super.key, required this.newsState, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(SpaceTokens.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.campaign_outlined, color: theme.colorScheme.primary),
                const SizedBox(width: SpaceTokens.sm),
                Text(
                  'System News',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: SpaceTokens.sm),
            const Divider(),
            const SizedBox(height: SpaceTokens.sm),
            newsState.when(
              data: (news) => _buildNewsList(context, news),
              loading: () => const _NewsShimmer(),
              error: (error, stack) => _ErrorSection(
                message: 'Failed to load system news.',
                onRetry: onRetry,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsList(BuildContext context, List<NewsItem> news) {
    if (news.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: SpaceTokens.md),
        child: Center(child: Text('No system news at the moment.')),
      );
    }

    return Column(
      children: news
          .take(3)
          .map((item) => _NewsListTile(news: item))
          .toList(),
    );
  }
}

class _NewsListTile extends StatelessWidget {
  final NewsItem news;

  const _NewsListTile({required this.news});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Icon(Icons.article_outlined, color: theme.colorScheme.onPrimaryContainer),
      ),
      title: Text(news.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        '${news.publishedAt.month}/${news.publishedAt.day}',
        style: theme.textTheme.bodySmall,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showNewsDetail(context, news),
    );
  }

  void _showNewsDetail(BuildContext context, NewsItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.title),
        content: SingleChildScrollView(child: Text(item.bodyHtml)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _NewsShimmer extends StatelessWidget {
  const _NewsShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          3,
          (index) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(backgroundColor: Colors.white),
            title: Container(
              height: 16,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 12,
              width: 60,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorSection extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const _ErrorSection({required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpaceTokens.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: theme.colorScheme.error, size: 32),
          const SizedBox(height: SpaceTokens.sm),
          Text(
            message,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: SpaceTokens.sm),
            TextButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ],
      ),
    );
  }
}