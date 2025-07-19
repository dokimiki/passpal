import 'package:dartz/dartz.dart';

import '../../../core/error/models/failure.dart';
import '../models/preference_types.dart';

/// Interface for application preference storage
///
/// Provides type-safe storage for user preferences including theme,
/// campus selection, notification settings, and other app configurations.
/// Supports reactive updates for real-time UI changes.
abstract interface class PreferenceStorageInterface {
  /// Read a preference value by key
  ///
  /// Returns [Right] with the preference value or [Left] with [Failure] if
  /// the key doesn't exist or an error occurs during reading.
  Future<Either<Failure, T?>> get<T>(PreferenceKey<T> key);

  /// Write a preference value
  ///
  /// Stores the [value] for the given [key].
  /// Returns [Right] with [Unit] on success or [Left] with [Failure] on error.
  Future<Either<Failure, Unit>> set<T>(PreferenceKey<T> key, T value);

  /// Delete a preference
  ///
  /// Removes the preference with the given [key].
  /// Returns [Right] with [Unit] on success or [Left] with [Failure] on error.
  /// Does not fail if the key doesn't exist.
  Future<Either<Failure, Unit>> delete<T>(PreferenceKey<T> key);

  /// Check if a preference exists
  ///
  /// Returns [Right] with true if the preference exists, false otherwise.
  /// Returns [Left] with [Failure] if an error occurs during the check.
  Future<Either<Failure, bool>> containsKey<T>(PreferenceKey<T> key);

  /// Clear all preferences
  ///
  /// Removes all stored preferences. Use with caution.
  /// Returns [Right] with [Unit] on success or [Left] with [Failure] on error.
  Future<Either<Failure, Unit>> clear();

  /// Get all preference keys
  ///
  /// Returns a list of all preference keys currently stored.
  Future<Either<Failure, List<String>>> getAllKeys();

  /// Stream of preference changes
  ///
  /// Emits preference events when values are changed, added, or removed.
  /// Useful for reactive UI updates based on preference changes.
  Stream<PreferenceEvent> get changes;

  /// Watch a specific preference for changes
  ///
  /// Returns a stream that emits the current value whenever the preference changes.
  Stream<T?> watch<T>(PreferenceKey<T> key);
}

/// Preference change event for reactive updates
sealed class PreferenceEvent {
  const PreferenceEvent(this.keyName);
  final String keyName;
}

class PreferenceChanged<T> extends PreferenceEvent {
  const PreferenceChanged(super.keyName, this.value);
  final T value;
}

class PreferenceRemoved extends PreferenceEvent {
  const PreferenceRemoved(super.keyName);
}
