import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/albo_news_item.dart';

class AlboNewsSection extends StatelessWidget {
  final AsyncValue<List<AlboNewsItem>> newsState;
  final VoidCallback? onRetry;

  const AlboNewsSection({
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
                const Icon(Icons.school_outlined),
                const SizedBox(width: 8),
                Text(
                  'ALBO掲示板',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          newsState.when(
            data: (news) => _buildNewsList(context, news),
            loading: () => const _AlboNewsShimmer(),
            error: (error, stack) => _ErrorSection(
              message: 'ALBO掲示板の取得に失敗しました',
              onRetry: onRetry ?? () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsList(BuildContext context, List<AlboNewsItem> news) {
    if (news.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text('新しいお知らせはありません'),
        ),
      );
    }

    return Column(
      children: news
          .take(5) // 最新5件のみ表示
          .map((item) => _AlboNewsListTile(newsItem: item))
          .toList(),
    );
  }
}

class _AlboNewsListTile extends StatelessWidget {
  final AlboNewsItem newsItem;

  const _AlboNewsListTile({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ListTile(
      leading: _buildCategoryIcon(),
      title: Row(
        children: [
          if (newsItem.isImportant) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '重要',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          if (!newsItem.isRead) ...[
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              newsItem.title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: newsItem.isRead ? FontWeight.normal : FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          _buildCategoryChip(),
          const Spacer(),
          if (newsItem.hasAttachment == true) ...[
            const Icon(
              Icons.attach_file,
              size: 14,
              color: Colors.grey,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            _formatDateTime(newsItem.publishedAt),
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
      onTap: () => _openNews(context),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildCategoryIcon() {
    IconData icon;
    Color color;

    switch (newsItem.category) {
      case AlboNewsCategory.kyoumu:
        icon = Icons.school;
        color = Colors.blue;
        break;
      case AlboNewsCategory.studentLife:
        icon = Icons.people;
        color = Colors.green;
        break;
      case AlboNewsCategory.kyoshoku:
        icon = Icons.work;
        color = Colors.orange;
        break;
      case AlboNewsCategory.career:
        icon = Icons.business_center;
        color = Colors.purple;
        break;
      case AlboNewsCategory.international:
        icon = Icons.public;
        color = Colors.teal;
        break;
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 16,
        color: color,
      ),
    );
  }

  Widget _buildCategoryChip() {
    String label;
    Color color;

    switch (newsItem.category) {
      case AlboNewsCategory.kyoumu:
        label = '教務';
        color = Colors.blue;
        break;
      case AlboNewsCategory.studentLife:
        label = '学生生活';
        color = Colors.green;
        break;
      case AlboNewsCategory.kyoshoku:
        label = '教職';
        color = Colors.orange;
        break;
      case AlboNewsCategory.career:
        label = 'キャリア';
        color = Colors.purple;
        break;
      case AlboNewsCategory.international:
        label = '国際';
        color = Colors.teal;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}日前';
    } else {
      return '${dateTime.month}/${dateTime.day}';
    }
  }

  Future<void> _openNews(BuildContext context) async {
    try {
      await launchUrl(
        newsItem.detailUrl,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('リンクを開けませんでした'),
          ),
        );
      }
    }
  }
}

class _AlboNewsShimmer extends StatelessWidget {
  const _AlboNewsShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (index) => ListTile(
          leading: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),
          title: Container(
            height: 16,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          subtitle: Row(
            children: [
              Container(
                width: 40,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const Spacer(),
              Container(
                width: 60,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        ),
      ),
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
            size: 32,
            color: Colors.red.shade400,
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
