import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';
import 'package:passpal/features/home/domain/entities/albo_news_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class AlboNewsSection extends StatelessWidget {
  final AsyncValue<List<AlboNewsItem>> newsState;
  final VoidCallback? onRetry;

  const AlboNewsSection({super.key, required this.newsState, this.onRetry});

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
                Icon(Icons.article_outlined, color: theme.colorScheme.primary),
                const SizedBox(width: SpaceTokens.sm),
                Text(
                  'ALBO Bulletin Board',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: SpaceTokens.sm),
            const Divider(),
            const SizedBox(height: SpaceTokens.sm),
            newsState.when(
              data: (news) => _buildNewsList(context, news),
              loading: () => const _AlboNewsShimmer(),
              error: (error, stack) => _ErrorSection(
                message: 'Failed to load ALBO news.',
                onRetry: onRetry,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsList(BuildContext context, List<AlboNewsItem> news) {
    if (news.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: SpaceTokens.md),
        child: Center(child: Text('No new announcements.')),
      );
    }

    return Column(
      children: news
          .take(5)
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
      contentPadding: EdgeInsets.zero,
      leading: _buildCategoryIcon(theme),
      title: Text(
        newsItem.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: !newsItem.isRead ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Row(
        children: [
          _buildCategoryChip(theme),
          const Spacer(),
          if (newsItem.hasAttachment == true)
            const Icon(Icons.attach_file, size: 14),
          const SizedBox(width: 4),
          Text(_formatDateTime(newsItem.publishedAt)),
        ],
      ),
      onTap: () => _openNews(context),
    );
  }

  Widget _buildCategoryIcon(ThemeData theme) {
    // Simplified icon for consistency
    return CircleAvatar(
      backgroundColor: theme.colorScheme.secondaryContainer,
      child: Icon(
        Icons.school_outlined,
        color: theme.colorScheme.onSecondaryContainer,
      ),
    );
  }

  Widget _buildCategoryChip(ThemeData theme) {
    return Chip(
      label: Text(newsItem.category.name),
      backgroundColor: theme.colorScheme.tertiaryContainer,
      labelStyle: theme.textTheme.labelSmall?.copyWith(
        color: theme.colorScheme.onTertiaryContainer,
      ),
      padding: EdgeInsets.zero,
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    if (difference.inDays == 0) {
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
    return '${dateTime.month}/${dateTime.day}';
  }

  Future<void> _openNews(BuildContext context) async {
    if (!await launchUrl(newsItem.detailUrl)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the link.')),
        );
      }
    }
  }
}

class _AlboNewsShimmer extends StatelessWidget {
  const _AlboNewsShimmer();

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
            title: Container(height: 16, color: Colors.white),
            subtitle: Container(height: 12, width: 100, color: Colors.white),
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
