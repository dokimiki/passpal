import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A secure credential storage wrapper around FlutterSecureStorage.
///
/// Provides a simple interface for storing, retrieving, and deleting
/// credentials using the platform's secure storage mechanisms.
/// On iOS, credentials are stored in the Keychain with hardware encryption.
/// On Android, credentials are stored using EncryptedSharedPreferences.
class CredentialStore {
  /// Creates a new CredentialStore instance.
  ///
  /// [_storage] The FlutterSecureStorage instance to use for secure operations.
  const CredentialStore(this._storage);

  final FlutterSecureStorage _storage;

  /// Securely stores a key-value pair.
  ///
  /// [key] The unique identifier for the credential.
  /// [value] The credential value to store.
  ///
  /// Example:
  /// ```dart
  /// await credentialStore.write('auth_id', 'user123');
  /// await credentialStore.write('auth_pw', 'password123');
  /// ```
  ///
  /// Throws [PlatformException] if the operation fails.
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Retrieves a stored credential value by key.
  ///
  /// [key] The unique identifier for the credential.
  ///
  /// Returns the stored value, or `null` if the key doesn't exist.
  ///
  /// Example:
  /// ```dart
  /// final userId = await credentialStore.read('auth_id');
  /// if (userId != null) {
  ///   // Use the retrieved user ID
  /// }
  /// ```
  ///
  /// Throws [PlatformException] if the operation fails.
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Deletes stored credentials.
  ///
  /// [key] The specific key to delete. If null and [all] is true,
  /// all stored credentials will be deleted.
  /// [all] If true, deletes all stored credentials. Defaults to false.
  ///
  /// Examples:
  /// ```dart
  /// // Delete a specific credential
  /// await credentialStore.delete(key: 'auth_id');
  ///
  /// // Delete all credentials
  /// await credentialStore.delete(all: true);
  /// ```
  ///
  /// Throws [ArgumentError] if both [key] is null and [all] is false.
  /// Throws [PlatformException] if the operation fails.
  Future<void> delete({String? key, bool all = false}) async {
    if (all) {
      await _storage.deleteAll();
    } else if (key != null) {
      await _storage.delete(key: key);
    } else {
      throw ArgumentError('Either key must be provided or all must be true');
    }
  }
}

/// Riverpod provider for CredentialStore.
///
/// Provides a CredentialStore instance configured with secure storage options:
/// - iOS: Uses Keychain with first_unlock_this_device accessibility
/// - Android: Uses EncryptedSharedPreferences for hardware-backed encryption
final credentialStoreProvider = Provider<CredentialStore>((ref) {
  const secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  return CredentialStore(secureStorage);
});
