import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/error/models/failure.dart';
import '../interfaces/secure_storage_interface.dart';
import '../models/storage_exceptions.dart';

/// Implementation of [SecureStorageInterface] using flutter_secure_storage
///
/// Provides secure storage for sensitive data using platform-specific
/// secure storage mechanisms:
/// - iOS: Keychain Services
/// - Android: EncryptedSharedPreferences with Android Keystore
///
/// All data is encrypted using AES-256 encryption.
class SecureStorage implements SecureStorageInterface {
  static const _instance = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      // Use AES-256 encryption
      keyCipherAlgorithm:
          KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
    iOptions: IOSOptions(
      // Use iOS Keychain
      accessibility: KeychainAccessibility.first_unlock_this_device,
      // Synchronize across devices for same Apple ID
      synchronizable: false,
    ),
    lOptions: LinuxOptions(),
    webOptions: WebOptions(),
    mOptions: MacOsOptions(),
    wOptions: WindowsOptions(),
  );

  const SecureStorage();

  @override
  Future<Either<Failure, String?>> read(String key) async {
    try {
      final value = await _instance.read(key: key);
      return Right(value);
    } on PlatformException catch (e, stackTrace) {
      return Left(_handlePlatformException(e, stackTrace, 'read', key));
    } catch (e, stackTrace) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed to read from secure storage: $e',
          stackTrace: stackTrace,
          context: {'key': key, 'operation': 'read'},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> write(String key, String value) async {
    try {
      await _instance.write(key: key, value: value);
      return const Right(unit);
    } on PlatformException catch (e, stackTrace) {
      return Left(_handlePlatformException(e, stackTrace, 'write', key));
    } catch (e, stackTrace) {
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Failed to write to secure storage: $e',
          stackTrace: stackTrace,
          context: {'key': key, 'operation': 'write'},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> delete(String key) async {
    try {
      await _instance.delete(key: key);
      return const Right(unit);
    } on PlatformException catch (e, stackTrace) {
      return Left(_handlePlatformException(e, stackTrace, 'delete', key));
    } catch (e, stackTrace) {
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Failed to delete from secure storage: $e',
          stackTrace: stackTrace,
          context: {'key': key, 'operation': 'delete'},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> containsKey(String key) async {
    try {
      final containsKey = await _instance.containsKey(key: key);
      return Right(containsKey);
    } on PlatformException catch (e, stackTrace) {
      return Left(_handlePlatformException(e, stackTrace, 'containsKey', key));
    } catch (e, stackTrace) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed to check key existence in secure storage: $e',
          stackTrace: stackTrace,
          context: {'key': key, 'operation': 'containsKey'},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> clear() async {
    try {
      await _instance.deleteAll();
      return const Right(unit);
    } on PlatformException catch (e, stackTrace) {
      return Left(_handlePlatformException(e, stackTrace, 'clear', null));
    } catch (e, stackTrace) {
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Failed to clear secure storage: $e',
          stackTrace: stackTrace,
          context: {'operation': 'clear'},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllKeys() async {
    try {
      final allKeys = await _instance.readAll();
      return Right(allKeys.keys.toList());
    } on PlatformException catch (e, stackTrace) {
      return Left(_handlePlatformException(e, stackTrace, 'getAllKeys', null));
    } catch (e, stackTrace) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed to get all keys from secure storage: $e',
          stackTrace: stackTrace,
          context: {'operation': 'getAllKeys'},
        ),
      );
    }
  }

  /// Handle platform-specific exceptions and map them to appropriate failures
  Failure _handlePlatformException(
    PlatformException exception,
    StackTrace stackTrace,
    String operation,
    String? key,
  ) {
    final context = <String, dynamic>{
      'operation': operation,
      'platformException': exception.code,
      'platformMessage': exception.message,
      if (key != null) 'key': key,
    };

    switch (exception.code) {
      case 'UserCancel':
      case 'UserFallback':
      case 'BiometryNotAvailable':
      case 'BiometryNotEnrolled':
      case 'BiometryLockout':
        return StorageFailureFactory.accessDeniedFailure(
          message: 'Access to secure storage was denied: ${exception.message}',
          stackTrace: stackTrace,
          context: context,
        );

      case 'ItemNotFound':
        return StorageFailureFactory.keyNotFoundFailure(
          message: 'Key not found in secure storage: ${exception.message}',
          stackTrace: stackTrace,
          context: context,
        );

      case 'OperationNotAllowed':
        return StorageFailureFactory.accessDeniedFailure(
          message:
              'Operation not allowed on secure storage: ${exception.message}',
          stackTrace: stackTrace,
          context: context,
        );

      case 'DataCorrupted':
        return StorageFailureFactory.corruptionFailure(
          message: 'Secure storage data is corrupted: ${exception.message}',
          stackTrace: stackTrace,
          context: context,
        );

      default:
        // For read operations, return read failure
        if (operation == 'read' ||
            operation == 'containsKey' ||
            operation == 'getAllKeys') {
          return StorageFailureFactory.readFailure(
            message:
                'Platform error during secure storage $operation: ${exception.message}',
            stackTrace: stackTrace,
            context: context,
          );
        } else {
          return StorageFailureFactory.writeFailure(
            message:
                'Platform error during secure storage $operation: ${exception.message}',
            stackTrace: stackTrace,
            context: context,
          );
        }
    }
  }
}
