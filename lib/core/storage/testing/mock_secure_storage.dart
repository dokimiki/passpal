import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core/error/models/failure.dart';
import '../interfaces/secure_storage_interface.dart';

/// Mock implementation of [SecureStorageInterface] for testing
class MockSecureStorage extends Mock implements SecureStorageInterface {}

/// In-memory implementation of [SecureStorageInterface] for testing
///
/// Provides a simple in-memory storage that mimics the behavior
/// of the real secure storage without any actual encryption.
/// Useful for unit tests that don't require platform-specific behavior.
class InMemorySecureStorage implements SecureStorageInterface {
  final Map<String, String> _storage;

  /// Create a new in-memory secure storage
  InMemorySecureStorage() : _storage = <String, String>{};

  /// Create an in-memory secure storage with pre-populated data
  InMemorySecureStorage.withData(Map<String, String> initialData)
    : _storage = Map.from(initialData);

  @override
  Future<Either<Failure, String?>> read(String key) async {
    try {
      final value = _storage[key];
      return Right(value);
    } catch (e, stackTrace) {
      return Left(
        Failure.storageReadNow(
          message: 'Failed to read from in-memory storage: $e',
          errorCode: 'STORAGE_READ_FAILED',
          stackTrace: stackTrace,
          context: {'key': key},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> write(String key, String value) async {
    try {
      _storage[key] = value;
      return const Right(unit);
    } catch (e, stackTrace) {
      return Left(
        Failure.storageWriteNow(
          message: 'Failed to write to in-memory storage: $e',
          errorCode: 'STORAGE_WRITE_FAILED',
          stackTrace: stackTrace,
          context: {'key': key},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> delete(String key) async {
    try {
      _storage.remove(key);
      return const Right(unit);
    } catch (e, stackTrace) {
      return Left(
        Failure.storageWriteNow(
          message: 'Failed to delete from in-memory storage: $e',
          errorCode: 'STORAGE_WRITE_FAILED',
          stackTrace: stackTrace,
          context: {'key': key},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> containsKey(String key) async {
    try {
      return Right(_storage.containsKey(key));
    } catch (e, stackTrace) {
      return Left(
        Failure.storageReadNow(
          message: 'Failed to check key existence in in-memory storage: $e',
          errorCode: 'STORAGE_READ_FAILED',
          stackTrace: stackTrace,
          context: {'key': key},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> clear() async {
    try {
      _storage.clear();
      return const Right(unit);
    } catch (e, stackTrace) {
      return Left(
        Failure.storageWriteNow(
          message: 'Failed to clear in-memory storage: $e',
          errorCode: 'STORAGE_WRITE_FAILED',
          stackTrace: stackTrace,
          context: {},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllKeys() async {
    try {
      return Right(_storage.keys.toList());
    } catch (e, stackTrace) {
      return Left(
        Failure.storageReadNow(
          message: 'Failed to get all keys from in-memory storage: $e',
          errorCode: 'STORAGE_READ_FAILED',
          stackTrace: stackTrace,
          context: {},
        ),
      );
    }
  }

  /// Get the current storage state for debugging
  Map<String, String> get debugStorage => Map.from(_storage);

  /// Get the number of stored entries
  int get length => _storage.length;

  /// Check if the storage is empty
  bool get isEmpty => _storage.isEmpty;
}
