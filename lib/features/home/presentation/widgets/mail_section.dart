import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';
import 'package:passpal/features/home/domain/entities/mail_summary.dart';
import 'package:passpal/features/home/presentation/widgets/mail_view_sheet.dart';
import 'package:shimmer/shimmer.dart';

class MailSection extends StatelessWidget {
  final AsyncValue<List<MailSummary>> mailState;
  final VoidCallback? onRetry;

  const MailSection({super.key, required this.mailState, this.onRetry});

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
                Icon(Icons.mail_outline, color: theme.colorScheme.primary),
                const SizedBox(width: SpaceTokens.sm),
                Text(
                  'Recent Mail',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: SpaceTokens.sm),
            const Divider(),
            const SizedBox(height: SpaceTokens.sm),
            mailState.when(
              data: (mails) => _buildMailList(context, mails),
              loading: () => const _MailShimmer(),
              error: (error, stack) => _ErrorSection(
                message: 'Failed to load mail.',
                onRetry: onRetry,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMailList(BuildContext context, List<MailSummary> mails) {
    if (mails.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: SpaceTokens.md),
        child: Center(child: Text('No new mail.')),
      );
    }

    return Column(
      children: mails
          .take(3)
          .map((mail) => _MailTile(mail: mail))
          .toList(),
    );
  }
}

class _MailTile extends StatelessWidget {
  final MailSummary mail;

  const _MailTile({required this.mail});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUnread = !mail.isRead;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: isUnread ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerHighest,
        child: Icon(
          isUnread ? Icons.mark_email_unread_outlined : Icons.mark_email_read_outlined,
          color: isUnread ? theme.colorScheme.onPrimary : theme.colorScheme.onSurfaceVariant,
        ),
      ),
      title: Text(
        mail.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        'From: ${mail.senderName} - ${mail.receivedAt.month}/${mail.receivedAt.day}',
        style: theme.textTheme.bodySmall,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showMailView(context, mail),
    );
  }

  void _showMailView(BuildContext context, MailSummary mail) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => MailViewSheet(mailId: mail.mailId),
    );
  }
}

class _MailShimmer extends StatelessWidget {
  const _MailShimmer();

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
              width: 120,
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
