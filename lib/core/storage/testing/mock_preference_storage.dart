import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../core/error/models/failure.dart';
import '../interfaces/preference_storage_interface.dart';
import '../models/preference_types.dart';
import '../models/storage_exceptions.dart';

/// Mock implementation of PreferenceStorageInterface for testing
///
/// Provides an in-memory implementation that simulates the behavior
/// of the real preference storage without requiring SharedPreferences.
/// Useful for unit testing and widget testing.
class MockPreferenceStorage implements PreferenceStorageInterface {
  MockPreferenceStorage({
    Map<String, String>? initialData,
    this.simulateErrors = false,
    this.errorProbability = 0.0,
  }) : _data = Map.from(initialData ?? {});

  final Map<String, String> _data;
  final bool simulateErrors;
  final double errorProbability;

  // Stream controllers for testing reactive behavior
  final StreamController<PreferenceEvent> _eventController =
      StreamController<PreferenceEvent>.broadcast();
  final Map<String, StreamController<dynamic>> _watchControllers = {};

  @override
  Stream<PreferenceEvent> get changes => _eventController.stream;

  @override
  Future<Either<Failure, T?>> get<T>(PreferenceKey<T> key) async {
    if (_shouldSimulateError()) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Simulated read error for ${key.key}',
          context: {'key': key.key, 'simulated': true},
        ),
      );
    }

    if (!_data.containsKey(key.key)) {
      return Right(key.defaultValue);
    }

    final stringValue = _data[key.key]!;
    try {
      final value = key.deserializer(stringValue);
      return Right(value);
    } on Exception catch (e) {
      return Left(
        StorageFailureFactory.serializationFailure(
          message: 'Failed to deserialize preference ${key.key}',
          context: {'key': key.key, 'error': e.toString()},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> set<T>(PreferenceKey<T> key, T value) async {
    if (_shouldSimulateError()) {
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Simulated write error for ${key.key}',
          context: {'key': key.key, 'simulated': true},
        ),
      );
    }

    try {
      final serializedValue = key.serializer(value);
      _data[key.key] = serializedValue;

      // Emit change event
      _eventController.add(PreferenceChanged(key.key, value));

      // Emit to specific watchers
      _emitToWatcher(key.key, value);

      return const Right(unit);
    } on Exception catch (e) {
      return Left(
        StorageFailureFactory.serializationFailure(
          message: 'Failed to serialize preference ${key.key}',
          context: {'key': key.key, 'error': e.toString()},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> delete<T>(PreferenceKey<T> key) async {
    if (_shouldSimulateError()) {
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Simulated delete error for ${key.key}',
          context: {'key': key.key, 'simulated': true},
        ),
      );
    }

    _data.remove(key.key);

    // Emit removal event
    _eventController.add(PreferenceRemoved(key.key));

    // Emit default value to watchers
    _emitToWatcher(key.key, key.defaultValue);

    return const Right(unit);
  }

  @override
  Future<Either<Failure, bool>> containsKey<T>(PreferenceKey<T> key) async {
    if (_shouldSimulateError()) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Simulated containsKey error for ${key.key}',
          context: {'key': key.key, 'simulated': true},
        ),
      );
    }

    return Right(_data.containsKey(key.key));
  }

  @override
  Future<Either<Failure, Unit>> clear() async {
    if (_shouldSimulateError()) {
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Simulated clear error',
          context: {'simulated': true},
        ),
      );
    }

    final keys = _data.keys.toList();
    _data.clear();

    // Emit removal events for all cleared preferences
    for (final key in keys) {
      _eventController.add(PreferenceRemoved(key));
      _emitToWatcher(key, null);
    }

    return const Right(unit);
  }

  @override
  Future<Either<Failure, List<String>>> getAllKeys() async {
    if (_shouldSimulateError()) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Simulated getAllKeys error',
          context: {'simulated': true},
        ),
      );
    }

    return Right(_data.keys.toList());
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
        (failure) => {}, // Ignore errors in initial emit
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

  /// Determine if an error should be simulated based on probability
  bool _shouldSimulateError() {
    if (!simulateErrors) return false;

    // Simple probability check
    final random = DateTime.now().millisecondsSinceEpoch % 100;
    return random < (errorProbability * 100);
  }

  /// Get current data state for testing inspection
  Map<String, String> get currentData => Map.unmodifiable(_data);

  /// Reset the mock to initial state
  void reset({Map<String, String>? initialData}) {
    _data.clear();
    if (initialData != null) {
      _data.addAll(initialData);
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
