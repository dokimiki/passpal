import 'package:freezed_annotation/freezed_annotation.dart';
import 'app_error.dart';

part 'app_exception.freezed.dart';

@freezed
sealed class AppException with _$AppException {
  const factory AppException.authentication({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    required DateTime timestamp,
    Map<String, dynamic>? context,
  }) = AuthenticationException;

  const factory AppException.maintenance({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    required DateTime timestamp,
    Map<String, dynamic>? context,
  }) = MaintenanceException;

  const factory AppException.updateRequired({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    required DateTime timestamp,
    Map<String, dynamic>? context,
  }) = UpdateRequiredException;

  const factory AppException.storage({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    required DateTime timestamp,
    Map<String, dynamic>? context,
  }) = StorageException;

  const AppException._();

  factory AppException.authenticationNow({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) => AppException.authentication(
    message: message,
    errorCode: errorCode,
    stackTrace: stackTrace,
    timestamp: DateTime.now(),
    context: context,
  );

  factory AppException.maintenanceNow({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) => AppException.maintenance(
    message: message,
    errorCode: errorCode,
    stackTrace: stackTrace,
    timestamp: DateTime.now(),
    context: context,
  );

  factory AppException.updateRequiredNow({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) => AppException.updateRequired(
    message: message,
    errorCode: errorCode,
    stackTrace: stackTrace,
    timestamp: DateTime.now(),
    context: context,
  );

  factory AppException.storageNow({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) => AppException.storage(
    message: message,
    errorCode: errorCode,
    stackTrace: stackTrace,
    timestamp: DateTime.now(),
    context: context,
  );

  AppError get asAppError => when(
    authentication: (message, errorCode, stackTrace, timestamp, context) =>
        AppError(
          message: message,
          errorCode: errorCode,
          stackTrace: stackTrace,
          timestamp: timestamp,
          isRecoverable: false,
          context: context,
        ),
    maintenance: (message, errorCode, stackTrace, timestamp, context) =>
        AppError(
          message: message,
          errorCode: errorCode,
          stackTrace: stackTrace,
          timestamp: timestamp,
          isRecoverable: false,
          context: context,
        ),
    updateRequired: (message, errorCode, stackTrace, timestamp, context) =>
        AppError(
          message: message,
          errorCode: errorCode,
          stackTrace: stackTrace,
          timestamp: timestamp,
          isRecoverable: false,
          context: context,
        ),
    storage: (message, errorCode, stackTrace, timestamp, context) => AppError(
      message: message,
      errorCode: errorCode,
      stackTrace: stackTrace,
      timestamp: timestamp,
      isRecoverable: false,
      context: context,
    ),
  );

  String get logMessage => '$errorCode: $message';
}
