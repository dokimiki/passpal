import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../core/error/models/failure.dart';
import '../interfaces/secure_storage_interface.dart';
import '../models/storage_exceptions.dart';

/// Credential types supported by the PassPal application
enum CredentialType {
  /// MaNaBo portal credentials (username/password)
  manabo('manabo'),

  /// ALBO portal credentials (username/password)
  albo('albo'),

  /// CUBICS portal credentials (username/password)
  cubics('cubics'),

  /// Google OAuth tokens for SSO
  googleOauth('google_oauth'),

  /// Shibboleth SSO session tokens
  shibboleth('shibboleth'),

  /// Firebase authentication tokens
  firebase('firebase'),

  /// API keys for external services
  apiKey('api_key'),

  /// Session cookies for web scraping
  sessionCookie('session_cookie');

  const CredentialType(this.value);
  final String value;

  static CredentialType? fromString(String value) {
    for (final type in CredentialType.values) {
      if (type.value == value) {
        return type;
      }
    }
    return null;
  }
}

/// Represents a stored credential with metadata
class StoredCredential {
  final String identifier;
  final String value;
  final CredentialType type;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final Map<String, String> metadata;

  const StoredCredential({
    required this.identifier,
    required this.value,
    required this.type,
    required this.createdAt,
    this.expiresAt,
    this.metadata = const {},
  });

  factory StoredCredential.fromJson(Map<String, dynamic> json) {
    return StoredCredential(
      identifier: json['identifier'] as String,
      value: json['value'] as String,
      type:
          CredentialType.fromString(json['type'] as String) ??
          CredentialType.apiKey,
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'] as String)
          : null,
      metadata: Map<String, String>.from(json['metadata'] as Map? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'value': value,
      'type': type.value,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'metadata': metadata,
    };
  }

  /// Check if the credential has expired
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  StoredCredential copyWith({
    String? identifier,
    String? value,
    CredentialType? type,
    DateTime? createdAt,
    DateTime? expiresAt,
    Map<String, String>? metadata,
  }) {
    return StoredCredential(
      identifier: identifier ?? this.identifier,
      value: value ?? this.value,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      metadata: metadata ?? this.metadata,
    );
  }
}

/// Specialized credential management service with auto-invalidation
///
/// This service provides a higher-level API for credential management
/// specifically designed for PassPal's authentication needs. It builds
/// on top of SecureStorage to provide:
/// - Type-safe credential operations
/// - Automatic invalidation of stale credentials
/// - Integration with auth core patterns
/// - Comprehensive error handling
class CredentialManager {
  final SecureStorageInterface _secureStorage;
  static const String _keyPrefix = 'credential_';
  static const String _metadataPrefix = 'credential_meta_';

  const CredentialManager(this._secureStorage);

  /// Store a credential securely with auto-invalidation metadata
  ///
  /// [identifier] - Unique identifier for the credential (e.g., user ID)
  /// [value] - The credential value (token, password, etc.)
  /// [type] - Type of credential being stored
  /// [expiresAt] - Optional expiration time for automatic invalidation
  /// [metadata] - Additional metadata to store with the credential
  Future<Either<Failure, Unit>> storeCredential({
    required String identifier,
    required String value,
    required CredentialType type,
    DateTime? expiresAt,
    Map<String, String> metadata = const {},
  }) async {
    try {
      final credential = StoredCredential(
        identifier: identifier,
        value: value,
        type: type,
        createdAt: DateTime.now(),
        expiresAt: expiresAt,
        metadata: metadata,
      );

      final credentialKey = _getCredentialKey(type, identifier);
      final metadataKey = _getMetadataKey(type, identifier);

      // Store the credential value
      final storeResult = await _secureStorage.write(credentialKey, value);
      if (storeResult.isLeft()) {
        return storeResult;
      }

      // Store the metadata
      final metadataJson = jsonEncode(credential.toJson());
      final metadataResult = await _secureStorage.write(
        metadataKey,
        metadataJson,
      );
      if (metadataResult.isLeft()) {
        // Clean up credential if metadata storage fails
        await _secureStorage.delete(credentialKey);
        return metadataResult;
      }

      return const Right(unit);
    } catch (e, stackTrace) {
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Failed to store credential: $e',
          stackTrace: stackTrace,
          context: {
            'type': type.value,
            'identifier': identifier,
            'operation': 'storeCredential',
          },
        ),
      );
    }
  }

  /// Retrieve a credential with automatic expiration checking
  ///
  /// Returns the credential if it exists and hasn't expired.
  /// Automatically removes expired credentials.
  Future<Either<Failure, StoredCredential?>> getCredential({
    required CredentialType type,
    required String identifier,
  }) async {
    try {
      final credentialKey = _getCredentialKey(type, identifier);
      final metadataKey = _getMetadataKey(type, identifier);

      // Check if metadata exists
      final metadataExists = await _secureStorage.containsKey(metadataKey);
      if (metadataExists.isLeft()) {
        return metadataExists.fold(
          (failure) => Left(failure),
          (_) => const Right(null),
        );
      }

      if (!metadataExists.getOrElse(() => false)) {
        return const Right(null);
      }

      // Read metadata
      final metadataResult = await _secureStorage.read(metadataKey);
      if (metadataResult.isLeft()) {
        return metadataResult.fold(
          (failure) => Left(failure),
          (_) => const Right(null),
        );
      }

      final metadataJson = metadataResult.getOrElse(() => null);
      if (metadataJson == null) {
        return const Right(null);
      }

      // Parse metadata
      final metadata = jsonDecode(metadataJson) as Map<String, dynamic>;
      final credential = StoredCredential.fromJson(metadata);

      // Check if credential has expired
      if (credential.isExpired) {
        // Auto-invalidate expired credential
        await _removeCredential(type, identifier);
        return const Right(null);
      }

      // Read the actual credential value
      final credentialResult = await _secureStorage.read(credentialKey);
      if (credentialResult.isLeft()) {
        return credentialResult.fold(
          (failure) => Left(failure),
          (_) => const Right(null),
        );
      }

      final credentialValue = credentialResult.getOrElse(() => null);
      if (credentialValue == null) {
        // Credential missing but metadata exists - clean up metadata
        await _secureStorage.delete(metadataKey);
        return const Right(null);
      }

      // Return credential with actual value
      return Right(credential.copyWith(value: credentialValue));
    } catch (e, stackTrace) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed to get credential: $e',
          stackTrace: stackTrace,
          context: {
            'type': type.value,
            'identifier': identifier,
            'operation': 'getCredential',
          },
        ),
      );
    }
  }

  /// Remove a specific credential
  ///
  /// Removes both the credential value and its metadata.
  /// Does not fail if the credential doesn't exist.
  Future<Either<Failure, Unit>> removeCredential({
    required CredentialType type,
    required String identifier,
  }) async {
    return _removeCredential(type, identifier);
  }

  /// Check if a credential exists and is valid (not expired)
  Future<Either<Failure, bool>> hasValidCredential({
    required CredentialType type,
    required String identifier,
  }) async {
    final result = await getCredential(type: type, identifier: identifier);
    return result.fold(
      (failure) => Left(failure),
      (credential) => Right(credential != null),
    );
  }

  /// Get all stored credentials for a specific type
  ///
  /// Automatically filters out expired credentials and removes them.
  Future<Either<Failure, List<StoredCredential>>> getCredentialsByType(
    CredentialType type,
  ) async {
    try {
      final allKeysResult = await _secureStorage.getAllKeys();
      if (allKeysResult.isLeft()) {
        return allKeysResult.fold(
          (failure) => Left(failure),
          (_) => const Right([]),
        );
      }

      final allKeys = allKeysResult.getOrElse(() => []);
      final metadataPrefix = '$_metadataPrefix${type.value}_';
      final metadataKeys = allKeys
          .where((key) => key.startsWith(metadataPrefix))
          .toList();

      final credentials = <StoredCredential>[];

      for (final metadataKey in metadataKeys) {
        final identifier = metadataKey.substring(metadataPrefix.length);
        final credentialResult = await getCredential(
          type: type,
          identifier: identifier,
        );

        credentialResult.fold(
          (failure) => null, // Skip failed credentials
          (credential) {
            if (credential != null) {
              credentials.add(credential);
            }
          },
        );
      }

      return Right(credentials);
    } catch (e, stackTrace) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed to get credentials by type: $e',
          stackTrace: stackTrace,
          context: {'type': type.value, 'operation': 'getCredentialsByType'},
        ),
      );
    }
  }

  /// Clear all credentials for a specific type
  ///
  /// Useful for logout scenarios or when switching accounts.
  Future<Either<Failure, Unit>> clearCredentialsByType(
    CredentialType type,
  ) async {
    try {
      final credentialsResult = await getCredentialsByType(type);
      if (credentialsResult.isLeft()) {
        return credentialsResult.fold(
          (failure) => Left(failure),
          (_) => const Right(unit),
        );
      }

      final credentials = credentialsResult.getOrElse(() => []);

      for (final credential in credentials) {
        await _removeCredential(type, credential.identifier);
      }

      return const Right(unit);
    } catch (e, stackTrace) {
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Failed to clear credentials by type: $e',
          stackTrace: stackTrace,
          context: {'type': type.value, 'operation': 'clearCredentialsByType'},
        ),
      );
    }
  }

  /// Clear all stored credentials
  ///
  /// Nuclear option - removes all credentials from secure storage.
  /// Use with extreme caution.
  Future<Either<Failure, Unit>> clearAllCredentials() async {
    try {
      final allKeysResult = await _secureStorage.getAllKeys();
      if (allKeysResult.isLeft()) {
        return allKeysResult.fold(
          (failure) => Left(failure),
          (_) => const Right(unit),
        );
      }

      final allKeys = allKeysResult.getOrElse(() => []);
      final credentialKeys = allKeys
          .where(
            (key) =>
                key.startsWith(_keyPrefix) || key.startsWith(_metadataPrefix),
          )
          .toList();

      for (final key in credentialKeys) {
        await _secureStorage.delete(key);
      }

      return const Right(unit);
    } catch (e, stackTrace) {
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Failed to clear all credentials: $e',
          stackTrace: stackTrace,
          context: {'operation': 'clearAllCredentials'},
        ),
      );
    }
  }

  /// Update credential metadata without changing the value
  ///
  /// Useful for updating expiration times or adding metadata.
  Future<Either<Failure, Unit>> updateCredentialMetadata({
    required CredentialType type,
    required String identifier,
    DateTime? expiresAt,
    Map<String, String>? metadata,
  }) async {
    final existingResult = await getCredential(
      type: type,
      identifier: identifier,
    );

    if (existingResult.isLeft()) {
      return existingResult.fold(
        (failure) => Left(failure),
        (_) => Left(
          StorageFailureFactory.keyNotFoundFailure(
            message: 'Credential not found for metadata update',
            context: {
              'type': type.value,
              'identifier': identifier,
              'operation': 'updateCredentialMetadata',
            },
          ),
        ),
      );
    }

    final existing = existingResult.getOrElse(() => null);
    if (existing == null) {
      return Left(
        StorageFailureFactory.keyNotFoundFailure(
          message: 'Credential not found for metadata update',
          context: {
            'type': type.value,
            'identifier': identifier,
            'operation': 'updateCredentialMetadata',
          },
        ),
      );
    }

    // Store updated credential with new metadata
    return storeCredential(
      identifier: identifier,
      value: existing.value,
      type: type,
      expiresAt: expiresAt ?? existing.expiresAt,
      metadata: metadata ?? existing.metadata,
    );
  }

  /// Internal helper to remove credential and metadata
  Future<Either<Failure, Unit>> _removeCredential(
    CredentialType type,
    String identifier,
  ) async {
    try {
      final credentialKey = _getCredentialKey(type, identifier);
      final metadataKey = _getMetadataKey(type, identifier);

      // Remove both credential and metadata
      // Continue even if one fails to ensure cleanup
      await _secureStorage.delete(credentialKey);
      await _secureStorage.delete(metadataKey);

      return const Right(unit);
    } catch (e, stackTrace) {
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Failed to remove credential: $e',
          stackTrace: stackTrace,
          context: {
            'type': type.value,
            'identifier': identifier,
            'operation': '_removeCredential',
          },
        ),
      );
    }
  }

  /// Generate secure storage key for credential value
  String _getCredentialKey(CredentialType type, String identifier) {
    return '$_keyPrefix${type.value}_$identifier';
  }

  /// Generate secure storage key for credential metadata
  String _getMetadataKey(CredentialType type, String identifier) {
    return '$_metadataPrefix${type.value}_$identifier';
  }
}
