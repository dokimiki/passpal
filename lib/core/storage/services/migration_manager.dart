import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../core/error/models/failure.dart';
import '../interfaces/preference_storage_interface.dart';
import '../interfaces/secure_storage_interface.dart';
import '../interfaces/cache_storage_interface.dart';
import '../models/preference_types.dart';
import '../models/storage_exceptions.dart';
import '../models/storage_version.dart';

/// Manages storage schema migrations and version tracking
///
/// Provides a framework for handling storage schema changes,
/// data migrations, and backward compatibility.
class MigrationManager {
  MigrationManager({
    required SecureStorageInterface secureStorage,
    required CacheStorageInterface cacheStorage,
    required PreferenceStorageInterface preferenceStorage,
    this.currentVersion = 1,
  }) : _secureStorage = secureStorage,
       _cacheStorage = cacheStorage,
       _preferenceStorage = preferenceStorage;

  final SecureStorageInterface _secureStorage;
  final CacheStorageInterface _cacheStorage;
  final PreferenceStorageInterface _preferenceStorage;
  final int currentVersion;

  static const String _versionKey = 'storage_schema_version';
  static const String _migrationHistoryKey = 'migration_history';

  // Migration step registry
  final Map<String, MigrationFunction> _migrations = {};

  /// Gets the current storage schema version
  Future<Either<Failure, int>> getCurrentStorageVersion() async {
    final versionResult = await _preferenceStorage.get(
      PreferenceKey<int>(
        key: _versionKey,
        defaultValue: 0,
        serializer: (value) => value.toString(),
        deserializer: (value) => int.parse(value),
      ),
    );

    return versionResult.fold(
      (failure) => Left(failure),
      (version) => Right(version ?? 0),
    );
  }

  /// Sets the storage schema version
  Future<Either<Failure, void>> setStorageVersion(int version) async {
    final versionKey = PreferenceKey<int>(
      key: _versionKey,
      defaultValue: 0,
      serializer: (value) => value.toString(),
      deserializer: (value) => int.parse(value),
    );

    return await _preferenceStorage.set(versionKey, version);
  }

  /// Gets migration history
  Future<Either<Failure, List<StorageVersion>>> getMigrationHistory() async {
    final historyResult = await _preferenceStorage.get(
      PreferenceKey<String>(
        key: _migrationHistoryKey,
        defaultValue: '[]',
        serializer: (value) => value,
        deserializer: (value) => value,
      ),
    );

    return historyResult.fold((failure) => Left(failure), (historyJson) {
      try {
        final historyList = jsonDecode(historyJson ?? '[]') as List;
        final history = historyList
            .map(
              (item) => StorageVersion.fromJson(item as Map<String, dynamic>),
            )
            .toList();
        return Right(history);
      } catch (e) {
        return Left(
          StorageFailureFactory.serializationFailure(
            message: 'Failed to parse migration history',
            context: {'error': e.toString()},
          ),
        );
      }
    });
  }

  /// Registers a migration function
  void registerMigration(String id, MigrationFunction migration) {
    _migrations[id] = migration;
  }

  /// Checks if migration is needed and returns required migrations
  Future<Either<Failure, List<MigrationStep>>> checkMigrations() async {
    final currentVersionResult = await getCurrentStorageVersion();

    return currentVersionResult.fold((failure) => Left(failure), (
      storedVersion,
    ) {
      if (storedVersion >= currentVersion) {
        return const Right(<MigrationStep>[]);
      }

      // Find required migrations
      final requiredMigrations = <MigrationStep>[];
      for (
        int version = storedVersion + 1;
        version <= currentVersion;
        version++
      ) {
        final migrations = _getVersionMigrations(version);
        requiredMigrations.addAll(migrations);
      }

      return Right(requiredMigrations);
    });
  }

  /// Performs all pending migrations
  Future<Either<Failure, MigrationResult>> migrate() async {
    final migrationsResult = await checkMigrations();

    return migrationsResult.fold((failure) => Left(failure), (
      migrations,
    ) async {
      if (migrations.isEmpty) {
        final currentVersionResult = await getCurrentStorageVersion();
        return currentVersionResult.fold(
          (failure) => Left(failure),
          (version) => Right(
            MigrationResult(
              success: true,
              fromVersion: version,
              toVersion: version,
              appliedMigrations: [],
            ),
          ),
        );
      }

      final appliedMigrations = <String>[];
      final fromVersion = migrations.first.fromVersion;
      var lastVersion = fromVersion;

      for (final migration in migrations) {
        final result = await _executeMigration(migration);

        if (result.isLeft()) {
          return result.fold(
            (failure) => Left(failure),
            (_) => throw StateError('Unreachable'),
          );
        }

        appliedMigrations.add(migration.id);
        lastVersion = migration.toVersion;
      }

      // Update storage version
      final setVersionResult = await setStorageVersion(lastVersion);
      if (setVersionResult.isLeft()) {
        return setVersionResult.fold(
          (failure) => Left(failure),
          (_) => throw StateError('Unreachable'),
        );
      }

      // Update migration history
      await _updateMigrationHistory(
        appliedMigrations,
        fromVersion,
        lastVersion,
      );

      return Right(
        MigrationResult(
          success: true,
          fromVersion: fromVersion,
          toVersion: lastVersion,
          appliedMigrations: appliedMigrations,
        ),
      );
    });
  }

  /// Executes a single migration step
  Future<Either<Failure, void>> _executeMigration(
    MigrationStep migration,
  ) async {
    final migrationFunction = _migrations[migration.id];
    if (migrationFunction == null) {
      return Left(
        StorageFailureFactory.migrationFailure(
          message: 'Migration function not found: ${migration.id}',
          context: {'migrationId': migration.id},
        ),
      );
    }

    try {
      return await migrationFunction(
        _secureStorage,
        _cacheStorage,
        _preferenceStorage,
        migration.parameters,
      );
    } catch (e, stackTrace) {
      return Left(
        StorageFailureFactory.migrationFailure(
          message: 'Migration execution failed: ${migration.id}',
          context: {
            'migrationId': migration.id,
            'error': e.toString(),
            'stackTrace': stackTrace.toString(),
          },
        ),
      );
    }
  }

  /// Updates migration history
  Future<void> _updateMigrationHistory(
    List<String> appliedMigrations,
    int fromVersion,
    int toVersion,
  ) async {
    final historyResult = await getMigrationHistory();

    historyResult.fold(
      (failure) => debugPrint('Failed to get migration history: $failure'),
      (history) async {
        final newEntry = StorageVersion(
          version: toVersion,
          description: 'Migration from v$fromVersion to v$toVersion',
          createdAt: DateTime.now(),
          migrations: appliedMigrations,
        );

        final updatedHistory = [...history, newEntry];
        final historyJson = jsonEncode(
          updatedHistory.map((item) => item.toJson()).toList(),
        );

        final historyKey = PreferenceKey<String>(
          key: _migrationHistoryKey,
          defaultValue: '[]',
          serializer: (value) => value,
          deserializer: (value) => value,
        );

        await _preferenceStorage.set(historyKey, historyJson);
      },
    );
  }

  /// Gets migration steps for a specific version
  List<MigrationStep> _getVersionMigrations(int version) {
    // This would typically be populated from a migration registry
    // For now, return empty list - migrations will be registered externally
    return [];
  }
}

/// Function signature for migration operations
typedef MigrationFunction =
    Future<Either<Failure, void>> Function(
      SecureStorageInterface secureStorage,
      CacheStorageInterface cacheStorage,
      PreferenceStorageInterface preferenceStorage,
      Map<String, dynamic> parameters,
    );

/// Migration strategies for common operations
class MigrationStrategies {
  /// Renames a preference key
  static MigrationFunction renamePreferenceKey(String oldKey, String newKey) {
    return (secureStorage, cacheStorage, preferenceStorage, parameters) async {
      final oldPrefKey = PreferenceKey<String?>(
        key: oldKey,
        defaultValue: null,
        serializer: (value) => value ?? '',
        deserializer: (value) => value.isEmpty ? null : value,
      );

      final valueResult = await preferenceStorage.get(oldPrefKey);

      return valueResult.fold((failure) => Left(failure), (value) async {
        if (value == null) {
          return const Right(null);
        }

        final newPrefKey = PreferenceKey<String>(
          key: newKey,
          defaultValue: '',
          serializer: (value) => value,
          deserializer: (value) => value,
        );

        final setResult = await preferenceStorage.set(newPrefKey, value);
        if (setResult.isLeft()) {
          return setResult;
        }

        return await preferenceStorage.delete(oldPrefKey);
      });
    };
  }

  /// Migrates secure storage key
  static MigrationFunction renameSecureKey(String oldKey, String newKey) {
    return (secureStorage, cacheStorage, preferenceStorage, parameters) async {
      final valueResult = await secureStorage.read(oldKey);

      return valueResult.fold((failure) => Left(failure), (value) async {
        if (value == null) {
          return const Right(null);
        }

        final writeResult = await secureStorage.write(newKey, value);
        if (writeResult.isLeft()) {
          return writeResult;
        }

        return await secureStorage.delete(oldKey);
      });
    };
  }

  /// Transforms data structure
  static MigrationFunction transformData<T>(
    String key,
    T Function(T oldData) transformer, {
    required StorageType storageType,
  }) {
    return (secureStorage, cacheStorage, preferenceStorage, parameters) async {
      // Implementation would depend on storage type and data structure
      // This is a simplified example
      return const Right(null);
    };
  }
}

enum StorageType { secure, cache, preference }
