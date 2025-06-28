import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:passpal/features/system/shared/widgets/system_scaffold.dart';
import 'package:passpal/features/system/error/presentation/widgets/error_detail_card.dart';
import 'package:passpal/features/system/error/presentation/models/error_page_data.dart';

/// Error page displayed when routing fails or unhandled errors occur
class ErrorPage extends ConsumerWidget {
  const ErrorPage({super.key, this.errorData});

  final ErrorPageData? errorData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = errorData ?? const ErrorPageData();

    return SystemScaffold(
      title: 'エラー',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ErrorDetailCard(
            title: data.displayTitle,
            message: data.displayMessage,
            onRetryPressed: () => _onRetryPressed(context),
          ),
        ),
      ),
    );
  }

  void _onRetryPressed(BuildContext context) {
    // Try to go back to previous page, or home if no previous page
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }
}
