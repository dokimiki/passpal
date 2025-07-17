import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_error.dart';
import '../models/failure.dart';
import '../models/specific_errors.dart';
import 'recovery_strategy.dart';

part 'network_recovery.g.dart';

/// Recovery strategy for network errors with exponential backoff
class NetworkRecoveryStrategy extends RecoveryStrategy
    with ExponentialBackoffMixin {
  const NetworkRecoveryStrategy();

  @override
  bool canHandle(AppError error) {
    return error is NetworkFailure;
  }

  @override
  Future<RecoveryResult> recover(AppError error) async {
    final networkError = error as NetworkFailure;
    try {
      final errorType = networkError.type;

      return await errorType.when(
        connection: () => _handleConnectionError(networkError),
        timeout: () => _handleTimeoutError(networkError),
        server: () => _handleServerError(networkError),
      );
    } catch (e) {
      return RecoveryResult.failure(reason: 'Network recovery failed: $e');
    }
  }

  Future<RecoveryResult> _handleConnectionError(NetworkFailure error) async {
    // Check if we should retry based on current attempt
    final currentAttempt = _getCurrentAttempt(error);

    if (currentAttempt >= retryPolicy.maxAttempts) {
      return RecoveryResult.failure(
        reason: 'Max retry attempts reached for connection error',
      );
    }

    // Check network connectivity
    final isConnected = await _checkNetworkConnectivity();
    if (!isConnected) {
      return RecoveryResult.failure(
        reason: 'No network connectivity available',
        retryAfter: const Duration(seconds: 5),
      );
    }

    // Retry with exponential backoff
    return createRetryResult(currentAttempt + 1);
  }

  Future<RecoveryResult> _handleTimeoutError(NetworkFailure error) async {
    final currentAttempt = _getCurrentAttempt(error);

    if (currentAttempt >= retryPolicy.maxAttempts) {
      return RecoveryResult.failure(
        reason: 'Max retry attempts reached for timeout error',
      );
    }

    // Retry with exponential backoff
    return createRetryResult(currentAttempt + 1);
  }

  Future<RecoveryResult> _handleServerError(NetworkFailure error) async {
    final currentAttempt = _getCurrentAttempt(error);

    // For server errors, we might want to retry fewer times
    final maxAttempts = retryPolicy.maxAttempts ~/ 2;

    if (currentAttempt >= maxAttempts) {
      return RecoveryResult.failure(
        reason: 'Max retry attempts reached for server error',
      );
    }

    // For server errors, wait longer before retrying
    final delay = calculateDelay(currentAttempt + 1) * 2;

    return RecoveryResult.retry(
      delay: delay,
      attempt: currentAttempt + 1,
      maxAttempts: maxAttempts,
    );
  }

  int _getCurrentAttempt(NetworkFailure error) {
    // TODO: Implement attempt tracking
    // This should be tracked in the error context or recovery manager
    // For now, return 0 as default
    return 0;
  }

  Future<bool> _checkNetworkConnectivity() async {
    // TODO: Implement network connectivity check
    // This should use connectivity_plus or similar package
    // For now, return true as default
    return true;
  }

  @override
  RetryPolicy get retryPolicy => const RetryPolicy(
    maxAttempts: 3,
    initialDelay: Duration(seconds: 1),
    backoffMultiplier: 2.0,
    maxDelay: Duration(seconds: 10),
  );

  @override
  int get priority => 2; // Medium priority for network errors
}

@riverpod
NetworkRecoveryStrategy networkRecoveryStrategy(Ref ref) {
  return const NetworkRecoveryStrategy();
}
