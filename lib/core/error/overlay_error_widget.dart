import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Overlay error widget that displays network error banners at the top of the screen.
///
/// This widget is used to show non-blocking error messages for network failures
/// such as DioError or SocketException. The banner slides in from the top with
/// a smooth animation and provides retry and FAQ options.
class OverlayErrorWidget extends StatefulWidget {
  const OverlayErrorWidget({
    required this.error,
    required this.onRetry,
    super.key,
  });

  /// The error object (DioError or SocketException)
  final Object error;

  /// Callback function to execute when user taps retry button
  final VoidCallback onRetry;

  @override
  State<OverlayErrorWidget> createState() => _OverlayErrorWidgetState();
}

class _OverlayErrorWidgetState extends State<OverlayErrorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  static const String _faqUrl = 'https://passpal.app/faq#network-error';
  static const Duration _animationDuration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Start the slide-in animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Dismisses the error overlay with fade-out animation
  Future<void> _dismiss() async {
    await _animationController.reverse();
    if (mounted && Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  /// Handles retry button tap
  Future<void> _handleRetry() async {
    try {
      widget.onRetry();
      await _dismiss();
    } catch (e) {
      // If retry fails, keep the overlay visible
      debugPrint('Retry failed: $e');
    }
  }

  /// Opens FAQ URL in external browser
  Future<void> _openFaq() async {
    final Uri url = Uri.parse(_faqUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  /// Extracts error message from DioError or SocketException
  String _getErrorMessage() {
    if (widget.error is DioException) {
      final dioError = widget.error as DioException;
      final statusCode = dioError.response?.statusCode;
      if (statusCode != null) {
        return '通信に失敗しました ($statusCode)。再試行しますか？';
      }
      return '通信に失敗しました。再試行しますか？';
    } else if (widget.error is SocketException) {
      return 'ネットワークエラーが発生しました。再試行しますか？';
    }
    return '通信エラーが発生しました。再試行しますか？';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.wifi_off,
                            color: theme.colorScheme.onErrorContainer,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _getErrorMessage(),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onErrorContainer,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: _handleRetry,
                            child: Text(
                              '再試行',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: _openFaq,
                            icon: Icon(
                              Icons.help_outline,
                              size: 16,
                              color: theme.colorScheme.onErrorContainer
                                  .withOpacity(0.7),
                            ),
                            label: Text(
                              'FAQ を見る',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onErrorContainer
                                    .withOpacity(0.7),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: _dismiss,
                            child: Text(
                              '閉じる',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onErrorContainer
                                    .withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
