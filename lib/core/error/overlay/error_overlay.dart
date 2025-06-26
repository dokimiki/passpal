import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_exception.dart';

/// Error overlay widget for displaying errors to users
class ErrorOverlay extends StatelessWidget {
  const ErrorOverlay({
    super.key,
    required this.exception,
    this.onRetry,
    this.onDismiss,
    this.onFaqTap,
  }) : _isSnackbar = false;

  /// Create a snackbar version of the error overlay
  const ErrorOverlay.snackbar({
    super.key,
    required this.exception,
    this.onRetry,
    this.onDismiss,
    this.onFaqTap,
  }) : _isSnackbar = true;

  final AppException exception;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;
  final VoidCallback? onFaqTap;
  final bool _isSnackbar;

  @override
  Widget build(BuildContext context) {
    if (_isSnackbar) {
      return _buildSnackbar(context);
    }

    return _buildOverlay(context);
  }

  Widget _buildOverlay(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      color: Colors.black54,
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button (if not fatal)
                if (!exception.isFatal && onDismiss != null)
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: onDismiss,
                      icon: const Icon(Icons.close),
                    ),
                  ),

                // Error icon
                Icon(
                  _getErrorIcon(),
                  size: 64,
                  color: _getErrorColor(colorScheme),
                ),

                const SizedBox(height: 16),

                // Error title
                Text(
                  _getErrorTitle(),
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                // Error message
                Text(
                  exception.message,
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),

                // Additional info for specific error types
                if (exception is MaintenanceException)
                  _buildMaintenanceInfo(theme),

                const SizedBox(height: 24),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Primary action button
                    if (onRetry != null)
                      ElevatedButton.icon(
                        onPressed: onRetry,
                        icon: Icon(_getActionIcon()),
                        label: Text(_getActionText()),
                      ),

                    // FAQ button for certain errors
                    if (_shouldShowFaq() && onFaqTap != null) ...[
                      const SizedBox(width: 16),
                      TextButton.icon(
                        onPressed: onFaqTap,
                        icon: const Icon(Icons.help_outline),
                        label: const Text('FAQ'),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSnackbar(BuildContext context) {
    return SnackBar(
      content: Row(
        children: [
          Icon(_getErrorIcon(), color: Colors.white),
          const SizedBox(width: 12),
          Expanded(child: Text(exception.message)),
        ],
      ),
      action: onRetry != null
          ? SnackBarAction(label: _getActionText(), onPressed: onRetry!)
          : null,
      backgroundColor: _getErrorColor(Theme.of(context).colorScheme),
      behavior: SnackBarBehavior.floating,
    );
  }

  Widget _buildMaintenanceInfo(ThemeData theme) {
    final maintenance = exception as MaintenanceException;
    if (maintenance.estimatedEndTime == null) {
      return const SizedBox.shrink();
    }

    final formatter = DateFormat('MMM dd, yyyy HH:mm');
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          'Expected completion: ${formatter.format(maintenance.estimatedEndTime!)}',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  IconData _getErrorIcon() {
    return switch (exception) {
      NetworkFailure(kind: NetworkFailureKind.offline) => Icons.wifi_off,
      NetworkFailure() => Icons.cloud_off,
      AuthenticationException() => Icons.login,
      MaintenanceException() => Icons.build,
      ParseFailure() => Icons.error_outline,
      UnknownException() => Icons.error,
      UpdateRequiredException() => Icons.system_update,
      _ => Icons.error,
    };
  }

  Color _getErrorColor(ColorScheme colorScheme) {
    return switch (exception) {
      NetworkFailure() => colorScheme.error,
      AuthenticationException() => colorScheme.primary,
      MaintenanceException() => colorScheme.tertiary,
      ParseFailure() => colorScheme.error,
      UnknownException() => colorScheme.error,
      UpdateRequiredException() => colorScheme.primary,
      _ => colorScheme.error,
    };
  }

  String _getErrorTitle() {
    return switch (exception) {
      NetworkFailure(kind: NetworkFailureKind.offline) =>
        'No Internet Connection',
      NetworkFailure() => 'Network Error',
      AuthenticationException() => 'Authentication Required',
      MaintenanceException() => 'System Maintenance',
      ParseFailure() => 'Data Error',
      UnknownException() => 'Unexpected Error',
      UpdateRequiredException() => 'Update Required',
      _ => 'Error',
    };
  }

  IconData _getActionIcon() {
    return switch (exception) {
      NetworkFailure() => Icons.refresh,
      AuthenticationException() => Icons.login,
      MaintenanceException() => Icons.refresh,
      ParseFailure() => Icons.refresh,
      UnknownException() => Icons.restart_alt,
      UpdateRequiredException() => Icons.system_update,
      _ => Icons.refresh,
    };
  }

  String _getActionText() {
    return switch (exception) {
      NetworkFailure() => 'Retry',
      AuthenticationException() => 'Log In',
      MaintenanceException() => 'Check Again',
      ParseFailure() => 'Retry',
      UnknownException() => 'Restart App',
      UpdateRequiredException() => 'Update Now',
      _ => 'Retry',
    };
  }

  bool _shouldShowFaq() {
    return switch (exception) {
      ParseFailure _ => true,
      UnknownException _ => true,
      _ => false,
    };
  }
}
