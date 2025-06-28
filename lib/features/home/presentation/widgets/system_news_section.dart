import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/news_item.dart';

class SystemNewsSection extends StatelessWidget {
  final AsyncValue<List<NewsItem>> newsState;
  final VoidCallback? onRetry;

  const SystemNewsSection({
    super.key,
    required this.newsState,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.notifications_outlined),
                const SizedBox(width: 8),
                Text(
                  'システムお知らせ',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          newsState.when(
            data: (news) => _buildNewsList(context, news),
            loading: () => const _NewsShimmer(),
            error: (error, stack) => _ErrorSection(
              message: 'システムお知らせの取得に失敗しました',
              onRetry: onRetry ?? () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsList(BuildContext context, List<NewsItem> news) {
    if (news.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('現在システムからのお知らせはありません'),
      );
    }

    return Column(
      children: news.take(5).map((item) => _NewsListTile(
        news: item,
        onTap: () => _showNewsDetail(context, item),
      )).toList(),
    );
  }

  void _showNewsDetail(BuildContext context, NewsItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.title),
        content: Text(item.bodyHtml),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }
}

class _NewsListTile extends StatelessWidget {
  final NewsItem news;
  final VoidCallback onTap;

  const _NewsListTile({
    required this.news,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.article_outlined),
      title: Text(
        news.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${news.publishedAt.month}/${news.publishedAt.day}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: onTap,
      trailing: const Icon(Icons.chevron_right),
    );
  }
}

class _NewsShimmer extends StatelessWidget {
  const _NewsShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (index) => ListTile(
        leading: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        title: Container(
          height: 16,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        subtitle: Container(
          height: 12,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      )),
    );
  }
}

class _ErrorSection extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorSection({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onRetry,
            child: const Text('再試行'),
          ),
        ],
      ),
    );
  }
}
