import '../../../core/error/models/failure.dart';

/// Storage-specific error codes for consistent error handling
abstract class StorageErrorCodes {
  static const String readFailed = 'STORAGE_READ_FAILED';
  static const String writeFailed = 'STORAGE_WRITE_FAILED';
  static const String serializationFailed = 'STORAGE_SERIALIZATION_FAILED';
  static const String capacityExceeded = 'STORAGE_CAPACITY_EXCEEDED';
  static const String accessDenied = 'STORAGE_ACCESS_DENIED';
  static const String corruptionDetected = 'STORAGE_CORRUPTION_DETECTED';
  static const String keyNotFound = 'STORAGE_KEY_NOT_FOUND';
  static const String encryptionFailed = 'STORAGE_ENCRYPTION_FAILED';
  static const String decryptionFailed = 'STORAGE_DECRYPTION_FAILED';
  static const String migrationFailed = 'STORAGE_MIGRATION_FAILED';
}

/// Factory for creating storage-specific failures with proper typing
abstract class StorageFailureFactory {
  /// Create a storage read failure
  static Failure readFailure({
    required String message,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.storageReadNow(
    message: message,
    errorCode: StorageErrorCodes.readFailed,
    stackTrace: stackTrace,
    retryDelay: retryDelay,
    context: context,
  );

  /// Create a storage write failure
  static Failure writeFailure({
    required String message,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.storageWriteNow(
    message: message,
    errorCode: StorageErrorCodes.writeFailed,
    stackTrace: stackTrace,
    retryDelay: retryDelay,
    context: context,
  );

  /// Create a serialization failure
  static Failure serializationFailure({
    required String message,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.storageSerializationNow(
    message: message,
    errorCode: StorageErrorCodes.serializationFailed,
    stackTrace: stackTrace,
    retryDelay: retryDelay,
    context: context,
  );

  /// Create a capacity exceeded failure
  static Failure capacityExceededFailure({
    required String message,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.storageCapacityNow(
    message: message,
    errorCode: StorageErrorCodes.capacityExceeded,
    stackTrace: stackTrace,
    retryDelay: retryDelay,
    context: context,
  );

  /// Create an access denied failure
  static Failure accessDeniedFailure({
    required String message,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.storageReadNow(
    message: message,
    errorCode: StorageErrorCodes.accessDenied,
    stackTrace: stackTrace,
    retryDelay: retryDelay,
    context: context,
  );

  /// Create a corruption detected failure
  static Failure corruptionFailure({
    required String message,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.storageReadNow(
    message: message,
    errorCode: StorageErrorCodes.corruptionDetected,
    stackTrace: stackTrace,
    retryDelay: retryDelay,
    context: context,
  );

  /// Create a key not found failure
  static Failure keyNotFoundFailure({
    required String message,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.storageReadNow(
    message: message,
    errorCode: StorageErrorCodes.keyNotFound,
    stackTrace: stackTrace,
    retryDelay: retryDelay,
    context: context,
  );

  /// Create an encryption failure
  static Failure encryptionFailure({
    required String message,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.storageSerializationNow(
    message: message,
    errorCode: StorageErrorCodes.encryptionFailed,
    stackTrace: stackTrace,
    retryDelay: retryDelay,
    context: context,
  );

  /// Create a decryption failure
  static Failure decryptionFailure({
    required String message,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.storageSerializationNow(
    message: message,
    errorCode: StorageErrorCodes.decryptionFailed,
    stackTrace: stackTrace,
    retryDelay: retryDelay,
    context: context,
  );

  /// Create a migration failure
  static Failure migrationFailure({
    required String message,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.storageWriteNow(
    message: message,
    errorCode: StorageErrorCodes.migrationFailed,
    stackTrace: stackTrace,
    retryDelay: retryDelay,
    context: context,
  );
}
