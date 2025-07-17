import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/app_error.dart';

part 'recovery_strategy.freezed.dart';

/// Result of a recovery attempt
@freezed
sealed class RecoveryResult with _$RecoveryResult {
  const factory RecoveryResult.success() = _Success;
  const factory RecoveryResult.failure({
    required String reason,
    Duration? retryAfter,
  }) = _Failure;
  const factory RecoveryResult.retry({
    required Duration delay,
    required int attempt,
    int? maxAttempts,
  }) = _Retry;
}

/// Configuration for retry policies
@freezed
abstract class RetryPolicy with _$RetryPolicy {
  const factory RetryPolicy({
    @Default(3) int maxAttempts,
    @Default(Duration(seconds: 1)) Duration initialDelay,
    @Default(2.0) double backoffMultiplier,
    @Default(Duration(seconds: 30)) Duration maxDelay,
  }) = _RetryPolicy;
}

/// Abstract base class for recovery strategies
abstract class RecoveryStrategy {
  const RecoveryStrategy();

  /// Determine if this strategy can handle the given error
  bool canHandle(AppError error);

  /// Attempt to recover from the error
  Future<RecoveryResult> recover(AppError error);

  /// Get the retry policy for this strategy
  RetryPolicy get retryPolicy;

  /// Get the priority of this strategy (lower number = higher priority)
  int get priority;
}

/// Mixin for strategies that support exponential backoff
mixin ExponentialBackoffMixin on RecoveryStrategy {
  /// Calculate delay for the given attempt using exponential backoff
  Duration calculateDelay(int attempt) {
    final baseDelay = retryPolicy.initialDelay;
    final multiplier = retryPolicy.backoffMultiplier;
    final maxDelay = retryPolicy.maxDelay;

    final delay = Duration(
      milliseconds:
          (baseDelay.inMilliseconds * (multiplier * (attempt - 1)).round())
              .clamp(baseDelay.inMilliseconds, maxDelay.inMilliseconds),
    );

    return delay;
  }

  /// Create a retry result with exponential backoff
  RecoveryResult createRetryResult(int attempt) {
    final delay = calculateDelay(attempt);
    return RecoveryResult.retry(
      delay: delay,
      attempt: attempt,
      maxAttempts: retryPolicy.maxAttempts,
    );
  }
}

/// Mixin for strategies that require user interaction
mixin UserInteractionMixin on RecoveryStrategy {
  /// Show a dialog or notification to the user
  Future<void> showUserNotification(String message);

  /// Redirect the user to a specific screen
  Future<void> redirectToScreen(String route);
}
