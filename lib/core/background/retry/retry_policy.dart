import 'dart:math';

import 'retry_config.dart';
import '../../error/app_exception.dart';

/// Retry policy with exponential backoff and jitter
class RetryPolicy {
  const RetryPolicy(this._config);

  final RetryConfig _config;
  static final _random = Random();

  /// Calculate delay for given attempt number (0-based)
  Duration calculateDelay(int attemptNumber) {
    if (attemptNumber >= _config.maxAttempts) {
      return Duration.zero;
    }

    // Exponential backoff: baseDelay * multiplier^attemptNumber
    final baseDelayMs = _config.baseDelay.inMilliseconds;
    final exponentialDelay =
        baseDelayMs * pow(_config.multiplier, attemptNumber);

    // Cap at maxDelay
    final cappedDelay = min(
      exponentialDelay,
      _config.maxDelay.inMilliseconds.toDouble(),
    );

    // Add jitter: ±30% randomness
    final jitterRange = cappedDelay * _config.jitterFactor;
    final jitter = (_random.nextDouble() - 0.5) * 2 * jitterRange;
    final finalDelay = cappedDelay + jitter;

    return Duration(milliseconds: max(0, finalDelay.round()));
  }

  /// Check if error should trigger retry
  bool shouldRetry(Object error, int attemptNumber) {
    // Never retry if we've exceeded max attempts
    if (attemptNumber >= _config.maxAttempts) {
      return false;
    }

    // Give up immediately on certain exceptions
    if (error is AuthenticationException || error is MaintenanceException) {
      return false;
    }

    // Retry on network failures and other recoverable errors
    if (error is NetworkFailure ||
        error is BackgroundTaskException ||
        error is ParseFailure) {
      return true;
    }

    // Don't retry unknown exceptions
    return false;
  }

  /// Get retry attempt schedule as list of delays
  List<Duration> getRetrySchedule() {
    return List.generate(_config.maxAttempts, (index) => calculateDelay(index));
  }
}
