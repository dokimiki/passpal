import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:passpal/core/storage/models/credentials.dart';
import 'package:passpal/core/storage/secure/credential_storage.dart';
import 'package:passpal/core/storage/errors/storage_exception.dart';

/// flutter_secure_storageを使用したCredentialStorageの実装
class FlutterSecureStorageCredentialStorage implements CredentialStorage {
  const FlutterSecureStorageCredentialStorage({
    this.storage = const FlutterSecureStorage(),
  });

  final FlutterSecureStorage storage;

  static const String _credentialsKey = 'passpal_credentials';

  @override
  Future<void> save(Credentials credentials) async {
    try {
      final json = credentials.toJson();
      final jsonString = jsonEncode(json);
      await storage.write(key: _credentialsKey, value: jsonString);
    } catch (e) {
      throw SecureIoException(
        operation: 'save',
        message: 'Failed to save credentials to secure storage',
        cause: e,
      );
    }
  }

  @override
  Future<Credentials?> read() async {
    try {
      final jsonString = await storage.read(key: _credentialsKey);
      if (jsonString == null) {
        return null;
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return Credentials.fromJson(json);
    } catch (e) {
      throw SecureIoException(
        operation: 'read',
        message: 'Failed to read credentials from secure storage',
        cause: e,
      );
    }
  }

  @override
  Future<void> purge() async {
    try {
      await storage.delete(key: _credentialsKey);
    } catch (e) {
      throw SecureIoException(
        operation: 'purge',
        message: 'Failed to purge credentials from secure storage',
        cause: e,
      );
    }
  }
}
