import 'package:flutter/material.dart';
import 'package:passpal/core/routing/models/route_data.dart';

/// Error page for routing failures and exceptions
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.args});

  final ErrorPageArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('エラー')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 24),
              Text(
                args.title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                args.message,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (args.canRetry) ...[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('戻る'),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    // TODO: Implement retry logic
                  },
                  child: const Text('再試行'),
                ),
              ] else ...[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('戻る'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
