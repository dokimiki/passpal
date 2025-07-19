import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/models/failure.dart';
import '../interfaces/preference_storage_interface.dart';
import '../models/preference_types.dart';
import '../models/storage_exceptions.dart';

/// SharedPreferences-based implementation of PreferenceStorageInterface
///
/// Provides type-safe preference storage using SharedPreferences
/// with reactive updates and automatic serialization/deserialization.
class PreferenceStorage implements PreferenceStorageInterface {
  PreferenceStorage({
    required SharedPreferences sharedPreferences,
    this.keyPrefix = 'pref_',
  }) : _prefs = sharedPreferences;

  final SharedPreferences _prefs;
  final String keyPrefix;

  // Stream controller for preference change events
  final StreamController<PreferenceEvent> _eventController =
      StreamController<PreferenceEvent>.broadcast();

  // Stream controllers for watching specific preferences
  final Map<String, StreamController<dynamic>> _watchControllers = {};

  @override
  Stream<PreferenceEvent> get changes => _eventController.stream;

  @override
  Future<Either<Failure, T?>> get<T>(PreferenceKey<T> key) async {
    try {
      final fullKey = '$keyPrefix${key.key}';

      if (!_prefs.containsKey(fullKey)) {
        // Return default value if key doesn't exist
        return Right(key.defaultValue);
      }

      final stringValue = _prefs.getString(fullKey);
      if (stringValue == null) {
        return Right(key.defaultValue);
      }

      try {
        final value = key.deserializer(stringValue);
        return Right(value);
      } on Exception catch (e) {
        debugPrint('Failed to deserialize preference ${key.key}: $e');
        return Left(
          StorageFailureFactory.serializationFailure(
            message: 'Failed to deserialize preference ${key.key}',
            context: {'key': key.key, 'error': e.toString()},
          ),
        );
      }
    } on Exception catch (e) {
      debugPrint('Failed to read preference ${key.key}: $e');
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed to read preference ${key.key}',
          context: {'key': key.key, 'error': e.toString()},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> set<T>(PreferenceKey<T> key, T value) async {
    try {
      final fullKey = '$keyPrefix${key.key}';

      String serializedValue;
      try {
        serializedValue = key.serializer(value);
      } on Exception catch (e) {
        debugPrint('Failed to serialize preference ${key.key}: $e');
        return Left(
          StorageFailureFactory.serializationFailure(
            message: 'Failed to serialize preference ${key.key}',
            context: {'key': key.key, 'error': e.toString()},
          ),
        );
      }

      final success = await _prefs.setString(fullKey, serializedValue);
      if (!success) {
        return Left(
          StorageFailureFactory.writeFailure(
            message: 'Failed to write preference ${key.key}',
            context: {'key': key.key},
          ),
        );
      }

      // Emit change event
      _eventController.add(PreferenceChanged(key.key, value));

      // Emit to specific watchers
      _emitToWatcher(key.key, value);

      return const Right(unit);
    } on Exception catch (e) {
      debugPrint('Failed to set preference ${key.key}: $e');
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Failed to set preference ${key.key}',
          context: {'key': key.key, 'error': e.toString()},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> delete<T>(PreferenceKey<T> key) async {
    try {
      final fullKey = '$keyPrefix${key.key}';

      final success = await _prefs.remove(fullKey);
      if (!success) {
        return Left(
          StorageFailureFactory.writeFailure(
            message: 'Failed to delete preference ${key.key}',
            context: {'key': key.key},
          ),
        );
      }

      // Emit removal event
      _eventController.add(PreferenceRemoved(key.key));

      // Emit default value to watchers
      _emitToWatcher(key.key, key.defaultValue);

      return const Right(unit);
    } on Exception catch (e) {
      debugPrint('Failed to delete preference ${key.key}: $e');
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Failed to delete preference ${key.key}',
          context: {'key': key.key, 'error': e.toString()},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> containsKey<T>(PreferenceKey<T> key) async {
    try {
      final fullKey = '$keyPrefix${key.key}';
      final exists = _prefs.containsKey(fullKey);
      return Right(exists);
    } on Exception catch (e) {
      debugPrint('Failed to check preference ${key.key}: $e');
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed to check preference ${key.key}',
          context: {'key': key.key, 'error': e.toString()},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> clear() async {
    try {
      final keys = _prefs
          .getKeys()
          .where((key) => key.startsWith(keyPrefix))
          .toList();

      for (final key in keys) {
        await _prefs.remove(key);
      }

      // Emit removal events for all cleared preferences
      for (final key in keys) {
        final prefKey = key.substring(keyPrefix.length);
        _eventController.add(PreferenceRemoved(prefKey));
        _emitToWatcher(prefKey, null);
      }

      return const Right(unit);
    } on Exception catch (e) {
      debugPrint('Failed to clear preferences: $e');
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Failed to clear preferences',
          context: {'error': e.toString()},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllKeys() async {
    try {
      final keys = _prefs
          .getKeys()
          .where((key) => key.startsWith(keyPrefix))
          .map((key) => key.substring(keyPrefix.length))
          .toList();

      return Right(keys);
    } on Exception catch (e) {
      debugPrint('Failed to get all preference keys: $e');
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed to get all preference keys',
          context: {'error': e.toString()},
        ),
      );
    }
  }

  @override
  Stream<T?> watch<T>(PreferenceKey<T> key) {
    final controller =
        _watchControllers.putIfAbsent(
              key.key,
              () => StreamController<T?>.broadcast(),
            )
            as StreamController<T?>;

    // Emit current value immediately
    get(key).then((result) {
      result.fold(
        (failure) => debugPrint('Failed to get initial value for ${key.key}'),
        (value) => controller.add(value),
      );
    });

    return controller.stream;
  }

  /// Emit value change to specific preference watchers
  void _emitToWatcher<T>(String keyName, T? value) {
    final controller = _watchControllers[keyName];
    if (controller != null) {
      controller.add(value);
    }
  }

  /// Dispose all stream controllers
  void dispose() {
    _eventController.close();
    for (final controller in _watchControllers.values) {
      controller.close();
    }
    _watchControllers.clear();
  }
}
