import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:passpal/core/error/models/failure.dart';
import 'package:passpal/core/storage/interfaces/cache_storage_interface.dart';
import 'package:passpal/core/storage/interfaces/preference_storage_interface.dart';
import 'package:passpal/core/storage/interfaces/secure_storage_interface.dart';
import 'package:passpal/core/storage/services/migration_manager.dart';

import 'migration_manager_test.mocks.dart';

@GenerateMocks([
  SecureStorageInterface,
  CacheStorageInterface,
  PreferenceStorageInterface,
])
void main() {
  group('MigrationManager', () {
    late MigrationManager migrationManager;
    late MockSecureStorageInterface mockSecureStorage;
    late MockCacheStorageInterface mockCacheStorage;
    late MockPreferenceStorageInterface mockPreferenceStorage;

    setUp(() {
      mockSecureStorage = MockSecureStorageInterface();
      mockCacheStorage = MockCacheStorageInterface();
      mockPreferenceStorage = MockPreferenceStorageInterface();

      migrationManager = MigrationManager(
        secureStorage: mockSecureStorage,
        cacheStorage: mockCacheStorage,
        preferenceStorage: mockPreferenceStorage,
        currentVersion: 3,
      );
    });

    group('getCurrentStorageVersion', () {
      test('returns current version when exists', () async {
        when(
          mockPreferenceStorage.get<int>(any),
        ).thenAnswer((_) async => const Right<Failure, int?>(2));

        final result = await migrationManager.getCurrentStorageVersion();

        expect(result, const Right(2));
      });

      test('returns 0 when version does not exist', () async {
        when(
          mockPreferenceStorage.get<int>(any),
        ).thenAnswer((_) async => const Right<Failure, int?>(null));

        final result = await migrationManager.getCurrentStorageVersion();

        expect(result, const Right(0));
      });

      test('returns failure when preference read fails', () async {
        final failure = Failure.storageReadNow(
          message: 'Read failed',
          errorCode: 'READ_ERROR',
        );
        when(
          mockPreferenceStorage.get<int>(any),
        ).thenAnswer((_) async => Left<Failure, int?>(failure));

        final result = await migrationManager.getCurrentStorageVersion();

        expect(result, Left(failure));
      });
    });

    group('setStorageVersion', () {
      test('sets version successfully', () async {
        when(
          mockPreferenceStorage.set<int>(any, any),
        ).thenAnswer((_) async => const Right<Failure, Unit>(unit));

        final result = await migrationManager.setStorageVersion(2);

        expect(result, const Right(unit));
        verify(mockPreferenceStorage.set(any, 2)).called(1);
      });

      test('returns failure when preference write fails', () async {
        final failure = Failure.storageWriteNow(
          message: 'Write failed',
          errorCode: 'WRITE_ERROR',
        );
        when(
          mockPreferenceStorage.set<int>(any, any),
        ).thenAnswer((_) async => Left<Failure, Unit>(failure));

        final result = await migrationManager.setStorageVersion(2);

        expect(result, Left(failure));
      });
    });

    group('getMigrationHistory', () {
      test('returns empty list when no history exists', () async {
        when(
          mockPreferenceStorage.get<String>(any),
        ).thenAnswer((_) async => const Right<Failure, String?>('[]'));

        final result = await migrationManager.getMigrationHistory();

        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not fail'),
          (history) => expect(history, isEmpty),
        );
      });

      test('returns parsed history when valid JSON exists', () async {
        final historyJson = '''[
          {
            "version": 1,
            "description": "Initial version",
            "createdAt": "2023-01-01T00:00:00.000Z",
            "migrations": ["init"]
          }
        ]''';

        when(
          mockPreferenceStorage.get<String>(any),
        ).thenAnswer((_) async => Right<Failure, String?>(historyJson));

        final result = await migrationManager.getMigrationHistory();

        expect(result.isRight(), true);
        result.fold((failure) => fail('Should not fail'), (history) {
          expect(history, hasLength(1));
          expect(history.first.version, 1);
          expect(history.first.description, 'Initial version');
        });
      });

      test('returns failure when JSON is invalid', () async {
        when(mockPreferenceStorage.get<String>(any)).thenAnswer(
          (_) async => const Right<Failure, String?>('invalid json'),
        );

        final result = await migrationManager.getMigrationHistory();

        expect(result.isLeft(), true);
      });
    });

    group('checkMigrations', () {
      test('returns empty list when no migration needed', () async {
        when(mockPreferenceStorage.get<int>(any)).thenAnswer(
          (_) async => const Right<Failure, int?>(3),
        ); // Same as current version

        final result = await migrationManager.checkMigrations();

        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not fail'),
          (migrations) => expect(migrations, isEmpty),
        );
      });

      test('returns empty list when storage version is higher', () async {
        when(mockPreferenceStorage.get(any)).thenAnswer(
          (_) async => const Right<Failure, int?>(4),
        ); // Higher than current

        final result = await migrationManager.checkMigrations();

        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not fail'),
          (migrations) => expect(migrations, isEmpty),
        );
      });

      test('returns failure when getCurrentStorageVersion fails', () async {
        final failure = Failure.storageReadNow(
          message: 'Read failed',
          errorCode: 'READ_ERROR',
        );
        when(
          mockPreferenceStorage.get<int>(any),
        ).thenAnswer((_) async => Left<Failure, int?>(failure));

        final result = await migrationManager.checkMigrations();

        expect(result, Left(failure));
      });
    });

    group('registerMigration', () {
      test('registers migration function successfully', () {
        Future<Either<Failure, void>> migrationFunction(
          SecureStorageInterface secureStorage,
          CacheStorageInterface cacheStorage,
          PreferenceStorageInterface preferenceStorage,
          Map<String, dynamic> parameters,
        ) async => const Right(null);

        expect(
          () => migrationManager.registerMigration(
            'test_migration',
            migrationFunction,
          ),
          returnsNormally,
        );
      });
    });

    group('migrate', () {
      test('returns success result when no migrations needed', () async {
        when(mockPreferenceStorage.get<int>(any)).thenAnswer(
          (_) async => const Right<Failure, int?>(3),
        ); // Current version

        final result = await migrationManager.migrate();

        expect(result.isRight(), true);
        result.fold((failure) => fail('Should not fail'), (migrationResult) {
          expect(migrationResult.success, true);
          expect(migrationResult.fromVersion, 3);
          expect(migrationResult.toVersion, 3);
          expect(migrationResult.appliedMigrations, isEmpty);
        });
      });

      test('returns failure when checkMigrations fails', () async {
        final failure = Failure.storageReadNow(
          message: 'Read failed',
          errorCode: 'READ_ERROR',
        );
        when(
          mockPreferenceStorage.get<int>(any),
        ).thenAnswer((_) async => Left<Failure, int?>(failure));

        final result = await migrationManager.migrate();

        expect(result, Left(failure));
      });
    });
  });

  group('MigrationStrategies', () {
    late MockSecureStorageInterface mockSecureStorage;
    late MockCacheStorageInterface mockCacheStorage;
    late MockPreferenceStorageInterface mockPreferenceStorage;

    setUp(() {
      mockSecureStorage = MockSecureStorageInterface();
      mockCacheStorage = MockCacheStorageInterface();
      mockPreferenceStorage = MockPreferenceStorageInterface();
    });

    group('renamePreferenceKey', () {
      test('successfully renames existing preference key', () async {
        const oldKey = 'old_preference';
        const newKey = 'new_preference';
        const value = 'test_value';

        when(
          mockPreferenceStorage.get<String?>(any),
        ).thenAnswer((_) async => const Right<Failure, String?>(value));
        when(
          mockPreferenceStorage.set<String>(any, any),
        ).thenAnswer((_) async => const Right<Failure, Unit>(unit));
        when(
          mockPreferenceStorage.delete<String?>(any),
        ).thenAnswer((_) async => const Right<Failure, Unit>(unit));

        final migrationFunction = MigrationStrategies.renamePreferenceKey(
          oldKey,
          newKey,
        );

        final result = await migrationFunction(
          mockSecureStorage,
          mockCacheStorage,
          mockPreferenceStorage,
          {},
        );

        expect(result.isRight(), true);
        verify(mockPreferenceStorage.get(any)).called(1);
        verify(mockPreferenceStorage.set(any, value)).called(1);
        verify(mockPreferenceStorage.delete(any)).called(1);
      });

      test('handles non-existent preference key gracefully', () async {
        const oldKey = 'non_existent_key';
        const newKey = 'new_preference';

        when(
          mockPreferenceStorage.get<String?>(any),
        ).thenAnswer((_) async => const Right<Failure, String?>(null));

        final migrationFunction = MigrationStrategies.renamePreferenceKey(
          oldKey,
          newKey,
        );

        final result = await migrationFunction(
          mockSecureStorage,
          mockCacheStorage,
          mockPreferenceStorage,
          {},
        );

        expect(result.isRight(), true);
        verify(mockPreferenceStorage.get(any)).called(1);
        verifyNever(mockPreferenceStorage.set(any, any));
        verifyNever(mockPreferenceStorage.delete(any));
      });
    });

    group('renameSecureKey', () {
      test('successfully renames existing secure key', () async {
        const oldKey = 'old_secure_key';
        const newKey = 'new_secure_key';
        const value = 'secure_value';

        when(
          mockSecureStorage.read(oldKey),
        ).thenAnswer((_) async => const Right<Failure, String?>(value));
        when(
          mockSecureStorage.write(newKey, value),
        ).thenAnswer((_) async => const Right<Failure, Unit>(unit));
        when(
          mockSecureStorage.delete(oldKey),
        ).thenAnswer((_) async => const Right<Failure, Unit>(unit));

        final migrationFunction = MigrationStrategies.renameSecureKey(
          oldKey,
          newKey,
        );

        final result = await migrationFunction(
          mockSecureStorage,
          mockCacheStorage,
          mockPreferenceStorage,
          {},
        );

        expect(result.isRight(), true);
        verify(mockSecureStorage.read(oldKey)).called(1);
        verify(mockSecureStorage.write(newKey, value)).called(1);
        verify(mockSecureStorage.delete(oldKey)).called(1);
      });

      test('handles non-existent secure key gracefully', () async {
        const oldKey = 'non_existent_secure_key';
        const newKey = 'new_secure_key';

        when(
          mockSecureStorage.read(oldKey),
        ).thenAnswer((_) async => const Right(null));

        final migrationFunction = MigrationStrategies.renameSecureKey(
          oldKey,
          newKey,
        );

        final result = await migrationFunction(
          mockSecureStorage,
          mockCacheStorage,
          mockPreferenceStorage,
          {},
        );

        expect(result.isRight(), true);
        verify(mockSecureStorage.read(oldKey)).called(1);
        verifyNever(mockSecureStorage.write(any, any));
        verifyNever(mockSecureStorage.delete(any));
      });
    });
  });
}
