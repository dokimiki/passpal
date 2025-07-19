import 'package:dartz/dartz.dart';

import '../../../core/error/models/failure.dart';

/// Interface for secure storage operations using platform keychain/keystore
///
/// Provides secure storage for sensitive data like authentication tokens,
/// API keys, and user credentials. All data is encrypted using AES-256
/// and stored in iOS Keychain or Android Keystore.
abstract interface class SecureStorageInterface {
  /// Read a value from secure storage
  ///
  /// Returns [Right] with the stored value or [Left] with [Failure] if
  /// the key doesn't exist or an error occurs during reading.
  Future<Either<Failure, String?>> read(String key);

  /// Write a value to secure storage
  ///
  /// Stores the [value] with the given [key] in encrypted form.
  /// Returns [Right] with [Unit] on success or [Left] with [Failure] on error.
  Future<Either<Failure, Unit>> write(String key, String value);

  /// Delete a value from secure storage
  ///
  /// Removes the entry with the given [key] from secure storage.
  /// Returns [Right] with [Unit] on success or [Left] with [Failure] on error.
  /// Does not fail if the key doesn't exist.
  Future<Either<Failure, Unit>> delete(String key);

  /// Check if a key exists in secure storage
  ///
  /// Returns [Right] with true if the key exists, false otherwise.
  /// Returns [Left] with [Failure] if an error occurs during the check.
  Future<Either<Failure, bool>> containsKey(String key);

  /// Clear all entries from secure storage
  ///
  /// Removes all stored entries. Use with caution as this cannot be undone.
  /// Returns [Right] with [Unit] on success or [Left] with [Failure] on error.
  Future<Either<Failure, Unit>> clear();

  /// Get all stored keys
  ///
  /// Returns a list of all keys currently stored in secure storage.
  /// Useful for debugging and migration purposes.
  Future<Either<Failure, List<String>>> getAllKeys();
}
