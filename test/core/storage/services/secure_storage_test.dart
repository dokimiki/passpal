import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:passpal/core/storage/testing/mock_secure_storage.dart';

void main() {
  group('SecureStorage', () {
    late InMemorySecureStorage storage;

    setUp(() {
      storage = InMemorySecureStorage();
    });

    group('read', () {
      test('should return value when key exists', () async {
        // Arrange
        const key = 'test_key';
        const value = 'test_value';
        storage = InMemorySecureStorage.withData({key: value});

        // Act
        final result = await storage.read(key);

        // Assert
        expect(result, isA<Right>());
        result.fold(
          (failure) => fail('Expected Right but got Left: $failure'),
          (actualValue) => expect(actualValue, equals(value)),
        );
      });

      test('should return null when key does not exist', () async {
        // Arrange
        const key = 'non_existent_key';

        // Act
        final result = await storage.read(key);

        // Assert
        expect(result, isA<Right>());
        result.fold(
          (failure) => fail('Expected Right but got Left: $failure'),
          (value) => expect(value, isNull),
        );
      });
    });

    group('write', () {
      test('should successfully write value', () async {
        // Arrange
        const key = 'test_key';
        const value = 'test_value';

        // Act
        final result = await storage.write(key, value);

        // Assert
        expect(result, isA<Right>());
        expect(storage.debugStorage[key], equals(value));
      });

      test('should overwrite existing value', () async {
        // Arrange
        const key = 'test_key';
        const oldValue = 'old_value';
        const newValue = 'new_value';
        storage = InMemorySecureStorage.withData({key: oldValue});

        // Act
        final result = await storage.write(key, newValue);

        // Assert
        expect(result, isA<Right>());
        expect(storage.debugStorage[key], equals(newValue));
      });
    });

    group('delete', () {
      test('should successfully delete existing key', () async {
        // Arrange
        const key = 'test_key';
        const value = 'test_value';
        storage = InMemorySecureStorage.withData({key: value});

        // Act
        final result = await storage.delete(key);

        // Assert
        expect(result, isA<Right>());
        expect(storage.debugStorage.containsKey(key), isFalse);
      });

      test('should not fail when deleting non-existent key', () async {
        // Arrange
        const key = 'non_existent_key';

        // Act
        final result = await storage.delete(key);

        // Assert
        expect(result, isA<Right>());
      });
    });

    group('containsKey', () {
      test('should return true when key exists', () async {
        // Arrange
        const key = 'test_key';
        const value = 'test_value';
        storage = InMemorySecureStorage.withData({key: value});

        // Act
        final result = await storage.containsKey(key);

        // Assert
        expect(result, isA<Right>());
        result.fold(
          (failure) => fail('Expected Right but got Left: $failure'),
          (exists) => expect(exists, isTrue),
        );
      });

      test('should return false when key does not exist', () async {
        // Arrange
        const key = 'non_existent_key';

        // Act
        final result = await storage.containsKey(key);

        // Assert
        expect(result, isA<Right>());
        result.fold(
          (failure) => fail('Expected Right but got Left: $failure'),
          (exists) => expect(exists, isFalse),
        );
      });
    });

    group('clear', () {
      test('should clear all stored data', () async {
        // Arrange
        storage = InMemorySecureStorage.withData({
          'key1': 'value1',
          'key2': 'value2',
          'key3': 'value3',
        });

        // Act
        final result = await storage.clear();

        // Assert
        expect(result, isA<Right>());
        expect(storage.isEmpty, isTrue);
      });

      test('should not fail when clearing empty storage', () async {
        // Arrange
        // storage is already empty

        // Act
        final result = await storage.clear();

        // Assert
        expect(result, isA<Right>());
        expect(storage.isEmpty, isTrue);
      });
    });

    group('getAllKeys', () {
      test('should return all stored keys', () async {
        // Arrange
        const expectedKeys = ['key1', 'key2', 'key3'];
        storage = InMemorySecureStorage.withData({
          'key1': 'value1',
          'key2': 'value2',
          'key3': 'value3',
        });

        // Act
        final result = await storage.getAllKeys();

        // Assert
        expect(result, isA<Right>());
        result.fold(
          (failure) => fail('Expected Right but got Left: $failure'),
          (keys) {
            expect(keys.length, equals(expectedKeys.length));
            for (final key in expectedKeys) {
              expect(keys.contains(key), isTrue);
            }
          },
        );
      });

      test('should return empty list when storage is empty', () async {
        // Arrange
        // storage is already empty

        // Act
        final result = await storage.getAllKeys();

        // Assert
        expect(result, isA<Right>());
        result.fold(
          (failure) => fail('Expected Right but got Left: $failure'),
          (keys) => expect(keys, isEmpty),
        );
      });
    });

    group('integration tests', () {
      test('should handle complete workflow', () async {
        // Write multiple values
        await storage.write('user_token', 'abc123');
        await storage.write('refresh_token', 'xyz789');
        await storage.write('api_key', 'secret123');

        // Verify all keys exist
        final keys = await storage.getAllKeys();
        expect(keys.isRight(), isTrue);
        keys.fold(
          (failure) => fail('Failed to get keys'),
          (keyList) => expect(keyList.length, equals(3)),
        );

        // Read and verify values
        final userToken = await storage.read('user_token');
        userToken.fold(
          (failure) => fail('Failed to read user_token'),
          (value) => expect(value, equals('abc123')),
        );

        // Delete one key
        await storage.delete('refresh_token');
        final containsRefresh = await storage.containsKey('refresh_token');
        containsRefresh.fold(
          (failure) => fail('Failed to check refresh_token'),
          (exists) => expect(exists, isFalse),
        );

        // Verify remaining keys
        final remainingKeys = await storage.getAllKeys();
        remainingKeys.fold(
          (failure) => fail('Failed to get remaining keys'),
          (keyList) => expect(keyList.length, equals(2)),
        );

        // Clear all
        await storage.clear();
        expect(storage.isEmpty, isTrue);
      });
    });
  });

  group('MockSecureStorage', () {
    late MockSecureStorage mockStorage;

    setUp(() {
      mockStorage = MockSecureStorage();
    });

    test('should be mockable', () {
      // Arrange
      when(
        () => mockStorage.read('test_key'),
      ).thenAnswer((_) async => const Right('test_value'));

      // Act & Assert
      expect(
        mockStorage.read('test_key'),
        completion(const Right('test_value')),
      );
      verify(() => mockStorage.read('test_key')).called(1);
    });
  });
}
