import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_error.dart';
import '../notifiers/error_notifier.dart';
import '../notifiers/error_state.dart';
import 'recovery_strategy.dart';
import 'auth_recovery.dart';
import 'network_recovery.dart';
import 'storage_recovery.dart';

part 'recovery_manager.g.dart';

/// Manages error recovery attempts and retry logic
class RecoveryManager {
  final List<RecoveryStrategy> _strategies;
  final Map<String, int> _attemptCounts = {};
  final Map<String, DateTime> _lastAttempts = {};

  RecoveryManager({required List<RecoveryStrategy> strategies})
    : _strategies = List.from(strategies)
        ..sort((a, b) => a.priority.compareTo(b.priority));

  /// Attempt to recover from the given error
  Future<RecoveryResult> attemptRecovery(AppError error) async {
    final strategy = _findStrategy(error);
    if (strategy == null) {
      return RecoveryResult.failure(
        reason:
            'No recovery strategy found for error type: ${error.runtimeType}',
      );
    }

    final errorKey = _getErrorKey(error);
    final currentAttempt = _attemptCounts[errorKey] ?? 0;

    // Check if we've exceeded max attempts
    if (currentAttempt >= strategy.retryPolicy.maxAttempts) {
      return RecoveryResult.failure(
        reason: 'Max recovery attempts exceeded for error: ${error.errorCode}',
      );
    }

    // Check if we need to wait before retrying
    final lastAttempt = _lastAttempts[errorKey];
    if (lastAttempt != null) {
      final timeSinceLastAttempt = DateTime.now().difference(lastAttempt);
      final retryPolicy = strategy.retryPolicy;
      final requiredDelay = _calculateDelay(currentAttempt, retryPolicy);

      if (timeSinceLastAttempt < requiredDelay) {
        final remainingDelay = requiredDelay - timeSinceLastAttempt;
        return RecoveryResult.retry(
          delay: remainingDelay,
          attempt: currentAttempt,
          maxAttempts: retryPolicy.maxAttempts,
        );
      }
    }

    // Update attempt tracking
    _attemptCounts[errorKey] = currentAttempt + 1;
    _lastAttempts[errorKey] = DateTime.now();

    try {
      final result = await strategy.recover(error);

      // If recovery succeeded, reset attempt count
      result.when(
        success: () {
          _attemptCounts.remove(errorKey);
          _lastAttempts.remove(errorKey);
        },
        failure: (_, _) {
          // Keep attempt count for potential future retries
        },
        retry: (_, _, _) {
          // Keep attempt count for retry logic
        },
      );

      return result;
    } catch (e) {
      return RecoveryResult.failure(reason: 'Recovery strategy failed: $e');
    }
  }

  /// Reset attempt count for a specific error
  void resetAttempts(AppError error) {
    final errorKey = _getErrorKey(error);
    _attemptCounts.remove(errorKey);
    _lastAttempts.remove(errorKey);
  }

  /// Reset all attempt counts
  void resetAllAttempts() {
    _attemptCounts.clear();
    _lastAttempts.clear();
  }

  /// Get current attempt count for an error
  int getAttemptCount(AppError error) {
    final errorKey = _getErrorKey(error);
    return _attemptCounts[errorKey] ?? 0;
  }

  /// Check if an error can be recovered
  bool canRecover(AppError error) {
    return _findStrategy(error) != null;
  }

  /// Get all registered strategies
  List<RecoveryStrategy> get strategies => List.unmodifiable(_strategies);

  RecoveryStrategy? _findStrategy(AppError error) {
    for (final strategy in _strategies) {
      if (strategy.canHandle(error)) {
        return strategy;
      }
    }
    return null;
  }

  String _getErrorKey(AppError error) {
    return '${error.runtimeType}_${error.errorCode}';
  }

  Duration _calculateDelay(int attempt, RetryPolicy policy) {
    final baseDelay = policy.initialDelay;
    final multiplier = policy.backoffMultiplier;
    final maxDelay = policy.maxDelay;

    final delay = Duration(
      milliseconds: (baseDelay.inMilliseconds * (multiplier * attempt).round())
          .clamp(baseDelay.inMilliseconds, maxDelay.inMilliseconds),
    );

    return delay;
  }
}

/// Provider for the recovery manager with default strategies
@riverpod
RecoveryManager recoveryManager(Ref ref) {
  final strategies = <RecoveryStrategy>[
    ref.watch(authRecoveryStrategyProvider) as RecoveryStrategy,
    ref.watch(networkRecoveryStrategyProvider) as RecoveryStrategy,
    ref.watch(storageRecoveryStrategyProvider) as RecoveryStrategy,
  ];

  return RecoveryManager(strategies: strategies);
}

/// Enhanced error notifier with recovery capabilities
class RecoveryErrorNotifier extends ErrorNotifier {
  final RecoveryManager _recoveryManager;

  RecoveryErrorNotifier(this._recoveryManager);

  @override
  Future<void> handleError(
    AppError error, {
    bool showToUser = true,
    Map<String, dynamic>? context,
  }) async {
    // First, handle the error normally
    await super.handleError(error, showToUser: showToUser, context: context);

    // Then attempt recovery if possible
    if (_recoveryManager.canRecover(error)) {
      await _attemptRecovery(error);
    }
  }

  Future<void> _attemptRecovery(AppError error) async {
    try {
      final result = await _recoveryManager.attemptRecovery(error);

      await result.when(
        success: () async {
          // Recovery succeeded, clear the error state
          state = const ErrorState();
        },
        failure: (reason, retryAfter) async {
          // Recovery failed, but we might retry later
          if (retryAfter != null) {
            await Future.delayed(retryAfter);
            await _attemptRecovery(error);
          }
        },
        retry: (delay, attempt, maxAttempts) async {
          // Schedule retry
          await Future.delayed(delay);
          await _attemptRecovery(error);
        },
      );
    } catch (e) {
      // Recovery attempt failed, log but don't crash
      // The original error is still in the state
    }
  }
}

@riverpod
RecoveryErrorNotifier recoveryErrorNotifier(Ref ref) {
  final recoveryManager = ref.watch(recoveryManagerProvider);
  return RecoveryErrorNotifier(recoveryManager);
}
