import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_error.dart';
import 'recovery_strategy.dart';

part 'storage_recovery.g.dart';

/// Recovery strategy for storage errors
class StorageRecoveryStrategy extends RecoveryStrategy
    with ExponentialBackoffMixin {
  const StorageRecoveryStrategy();

  @override
  bool canHandle(AppError error) {
    return error.errorCode.startsWith('STORAGE_');
  }

  @override
  Future<RecoveryResult> recover(AppError error) async {
    try {
      final errorCode = error.errorCode;

      switch (errorCode) {
        case 'STORAGE_READ_FAILED':
          return await _handleReadFailure(error);
        case 'STORAGE_WRITE_FAILED':
          return await _handleWriteFailure(error);
        case 'STORAGE_CAPACITY_EXCEEDED':
          return await _handleCapacityExceeded(error);
        default:
          return await _handleReadFailure(
            error,
          ); // Default to read failure handling
      }
    } catch (e) {
      return RecoveryResult.failure(reason: 'Storage recovery failed: $e');
    }
  }

  Future<RecoveryResult> _handleReadFailure(AppError error) async {
    final currentAttempt = _getCurrentAttempt(error);

    if (currentAttempt >= retryPolicy.maxAttempts) {
      return RecoveryResult.failure(
        reason: 'Max retry attempts reached for read failure',
      );
    }

    // Check storage availability
    final isAvailable = await _checkStorageAvailability();
    if (!isAvailable) {
      return RecoveryResult.failure(
        reason: 'Storage is not available',
        retryAfter: const Duration(seconds: 5),
      );
    }

    // Retry with exponential backoff
    return createRetryResult(currentAttempt + 1);
  }

  Future<RecoveryResult> _handleWriteFailure(AppError error) async {
    final currentAttempt = _getCurrentAttempt(error);

    if (currentAttempt >= retryPolicy.maxAttempts) {
      return RecoveryResult.failure(
        reason: 'Max retry attempts reached for write failure',
      );
    }

    // Check available space
    final hasSpace = await _checkAvailableSpace();
    if (!hasSpace) {
      // Try to clear some cache
      await _clearTemporaryFiles();

      // Check again after clearing
      final hasSpaceAfterClear = await _checkAvailableSpace();
      if (!hasSpaceAfterClear) {
        return RecoveryResult.failure(reason: 'Insufficient storage space');
      }
    }

    // Retry with exponential backoff
    return createRetryResult(currentAttempt + 1);
  }

  Future<RecoveryResult> _handleCapacityExceeded(AppError error) async {
    // Try to clear cache and temporary files
    await _clearTemporaryFiles();
    await _clearCacheFiles();

    // Check if we now have enough space
    final hasSpace = await _checkAvailableSpace();
    if (!hasSpace) {
      return RecoveryResult.failure(
        reason: 'Storage capacity exceeded and cannot be recovered',
      );
    }

    // If we have space now, we can retry
    return const RecoveryResult.success();
  }

  int _getCurrentAttempt(AppError error) {
    // TODO: Implement attempt tracking
    // This should be tracked in the error context or recovery manager
    // For now, return 0 as default
    return 0;
  }

  Future<bool> _checkStorageAvailability() async {
    // TODO: Implement storage availability check
    // This should check if the storage system is accessible
    // For now, return true as default
    return true;
  }

  Future<bool> _checkAvailableSpace() async {
    // TODO: Implement available space check
    // This should check if there's enough space for operations
    // For now, return true as default
    return true;
  }

  Future<void> _clearTemporaryFiles() async {
    // TODO: Implement temporary file clearing
    // This should interact with the storage core module
    // For now, just a placeholder
  }

  Future<void> _clearCacheFiles() async {
    // TODO: Implement cache file clearing
    // This should interact with the storage core module
    // For now, just a placeholder
  }

  @override
  RetryPolicy get retryPolicy => const RetryPolicy(
    maxAttempts: 3,
    initialDelay: Duration(milliseconds: 500),
    backoffMultiplier: 1.5,
    maxDelay: Duration(seconds: 5),
  );

  @override
  int get priority => 3; // Lower priority for storage errors
}

@riverpod
StorageRecoveryStrategy storageRecoveryStrategy(Ref ref) {
  return const StorageRecoveryStrategy();
}
