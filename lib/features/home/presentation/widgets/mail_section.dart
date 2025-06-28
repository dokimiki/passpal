import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/mail_summary.dart';
import 'mail_view_sheet.dart';

class MailSection extends StatelessWidget {
  final AsyncValue<List<MailSummary>> mailState;
  final VoidCallback? onRetry;

  const MailSection({
    super.key,
    required this.mailState,
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
                const Icon(Icons.mail_outline),
                const SizedBox(width: 8),
                Text(
                  '受信メール',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          mailState.when(
            data: (mails) => _buildMailList(context, mails),
            loading: () => const _MailShimmer(),
            error: (error, stack) => _ErrorSection(
              message: 'メールの取得に失敗しました',
              onRetry: onRetry ?? () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMailList(BuildContext context, List<MailSummary> mails) {
    if (mails.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('新しいメールはありません'),
      );
    }

    return Column(
      children: mails.take(5).map((mail) => _MailTile(
        mail: mail,
        onTap: () => _showMailView(context, mail),
      )).toList(),
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

class _MailTile extends StatelessWidget {
  final MailSummary mail;
  final VoidCallback onTap;

  const _MailTile({
    required this.mail,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: mail.isRead ? Colors.grey[300] : Theme.of(context).primaryColor,
        child: Icon(
          mail.isRead ? Icons.mail_outline : Icons.mail,
          color: mail.isRead ? Colors.grey[600] : Colors.white,
          size: 20,
        ),
      ),
      title: Text(
        mail.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: mail.isRead ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mail.senderName,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            '${mail.receivedAt.month}/${mail.receivedAt.day} ${mail.receivedAt.hour}:${mail.receivedAt.minute.toString().padLeft(2, '0')}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      onTap: onTap,
      trailing: const Icon(Icons.chevron_right),
    );
  }
}

class _MailShimmer extends StatelessWidget {
  const _MailShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (index) => ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[300],
        ),
        title: Container(
          height: 16,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 12,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 12,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
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
