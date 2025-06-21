import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:passpal/core/storage/credential_store.dart';
import 'credential_store_test.mocks.dart';

void main() {
  group('CredentialStore Integration Tests', () {
    late MockFlutterSecureStorage mockStorage;
    late ProviderContainer container;

    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      container = ProviderContainer(
        overrides: [
          credentialStoreProvider.overrideWithValue(
            CredentialStore(mockStorage),
          ),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('provides CredentialStore instance through Riverpod', () {
      // Act
      final credentialStore = container.read(credentialStoreProvider);

      // Assert
      expect(credentialStore, isA<CredentialStore>());
    });

    test('complete credential workflow through provider', () async {
      // Arrange
      const userId = 'user123';
      const password = 'secure_password';

      when(
        mockStorage.write(key: anyNamed('key'), value: anyNamed('value')),
      ).thenAnswer((_) async => null);
      when(mockStorage.read(key: 'auth_id')).thenAnswer((_) async => userId);
      when(mockStorage.read(key: 'auth_pw')).thenAnswer((_) async => password);
      when(mockStorage.deleteAll()).thenAnswer((_) async => null);

      final credentialStore = container.read(credentialStoreProvider);

      // Act & Assert - Store credentials
      await credentialStore.write('auth_id', userId);
      await credentialStore.write('auth_pw', password);

      verify(mockStorage.write(key: 'auth_id', value: userId));
      verify(mockStorage.write(key: 'auth_pw', value: password));

      // Act & Assert - Retrieve credentials
      final retrievedUserId = await credentialStore.read('auth_id');
      final retrievedPassword = await credentialStore.read('auth_pw');

      expect(retrievedUserId, equals(userId));
      expect(retrievedPassword, equals(password));

      // Act & Assert - Clear all credentials
      await credentialStore.delete(all: true);
      verify(mockStorage.deleteAll());
    });

    test('handles missing credentials gracefully', () async {
      // Arrange
      when(
        mockStorage.read(key: 'nonexistent_key'),
      ).thenAnswer((_) async => null);

      final credentialStore = container.read(credentialStoreProvider);

      // Act
      final result = await credentialStore.read('nonexistent_key');

      // Assert
      expect(result, isNull);
      verify(mockStorage.read(key: 'nonexistent_key'));
    });
  });
}
