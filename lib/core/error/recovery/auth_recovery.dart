import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_error.dart';
import '../models/app_exception.dart';
import '../models/specific_errors.dart';
import 'recovery_strategy.dart';

part 'auth_recovery.g.dart';

/// Recovery strategy for authentication errors
class AuthRecoveryStrategy extends RecoveryStrategy with UserInteractionMixin {
  const AuthRecoveryStrategy();

  @override
  bool canHandle(AppError error) {
    return error is AuthenticationException;
  }

  @override
  Future<RecoveryResult> recover(AppError error) async {
    final authError = error as AuthenticationException;
    try {
      final errorType = authError.type;

      return await errorType.when(
        invalidCredentials: () => _handleInvalidCredentials(authError),
        sessionExpired: () => _handleSessionExpired(authError),
        credentialsNotFound: () => _handleCredentialsNotFound(authError),
      );
    } catch (e) {
      return RecoveryResult.failure(
        reason: 'Authentication recovery failed: $e',
      );
    }
  }

  Future<RecoveryResult> _handleInvalidCredentials(
    AuthenticationException error,
  ) async {
    // Clear stored credentials
    await _clearCredentials();

    // Show error message to user
    await showUserNotification('ログイン情報が正しくありません。再度ログインしてください。');

    // Redirect to login screen
    await redirectToScreen('/login');

    return const RecoveryResult.success();
  }

  Future<RecoveryResult> _handleSessionExpired(
    AuthenticationException error,
  ) async {
    // Clear expired session
    await _clearCredentials();

    // Show session expired message
    await showUserNotification('セッションが期限切れです。再度ログインしてください。');

    // Redirect to login screen
    await redirectToScreen('/login');

    return const RecoveryResult.success();
  }

  Future<RecoveryResult> _handleCredentialsNotFound(
    AuthenticationException error,
  ) async {
    // Show login prompt
    await showUserNotification('ログインが必要です。');

    // Redirect to login screen
    await redirectToScreen('/login');

    return const RecoveryResult.success();
  }

  Future<void> _clearCredentials() async {
    // TODO: Implement credential clearing logic
    // This should interact with the auth core module
    // For now, just a placeholder
  }

  @override
  Future<void> showUserNotification(String message) async {
    // TODO: Implement user notification logic
    // This should interact with the UI layer
    // For now, just a placeholder
  }

  @override
  Future<void> redirectToScreen(String route) async {
    // TODO: Implement navigation logic
    // This should interact with the routing system
    // For now, just a placeholder
  }

  @override
  RetryPolicy get retryPolicy => const RetryPolicy(
    maxAttempts: 1, // Authentication errors typically don't retry
    initialDelay: Duration.zero,
  );

  @override
  int get priority => 1; // High priority for auth errors
}

@riverpod
AuthRecoveryStrategy authRecoveryStrategy(Ref ref) {
  return const AuthRecoveryStrategy();
}
