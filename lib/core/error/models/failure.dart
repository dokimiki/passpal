import 'package:freezed_annotation/freezed_annotation.dart';
import 'app_error.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.network({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    required DateTime timestamp,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) = NetworkFailure;

  const factory Failure.parse({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    required DateTime timestamp,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) = ParseFailure;

  const factory Failure.configSource({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    required DateTime timestamp,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) = ConfigSourceFailure;

  const factory Failure.configParse({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    required DateTime timestamp,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) = ConfigParseFailure;

  const factory Failure.storageRead({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    required DateTime timestamp,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) = StorageReadFailure;

  const factory Failure.storageWrite({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    required DateTime timestamp,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) = StorageWriteFailure;

  const factory Failure.storageSerialization({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    required DateTime timestamp,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) = StorageSerializationFailure;

  const factory Failure.storageCapacity({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    required DateTime timestamp,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) = StorageCapacityFailure;

  const Failure._();

  factory Failure.networkNow({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.network(
    message: message,
    errorCode: errorCode,
    stackTrace: stackTrace,
    timestamp: DateTime.now(),
    retryDelay: retryDelay,
    context: context,
  );

  factory Failure.parseNow({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.parse(
    message: message,
    errorCode: errorCode,
    stackTrace: stackTrace,
    timestamp: DateTime.now(),
    retryDelay: retryDelay,
    context: context,
  );

  factory Failure.configSourceNow({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.configSource(
    message: message,
    errorCode: errorCode,
    stackTrace: stackTrace,
    timestamp: DateTime.now(),
    retryDelay: retryDelay,
    context: context,
  );

  factory Failure.configParseNow({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.configParse(
    message: message,
    errorCode: errorCode,
    stackTrace: stackTrace,
    timestamp: DateTime.now(),
    retryDelay: retryDelay,
    context: context,
  );

  factory Failure.storageReadNow({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.storageRead(
    message: message,
    errorCode: errorCode,
    stackTrace: stackTrace,
    timestamp: DateTime.now(),
    retryDelay: retryDelay,
    context: context,
  );

  factory Failure.storageWriteNow({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.storageWrite(
    message: message,
    errorCode: errorCode,
    stackTrace: stackTrace,
    timestamp: DateTime.now(),
    retryDelay: retryDelay,
    context: context,
  );

  factory Failure.storageSerializationNow({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.storageSerialization(
    message: message,
    errorCode: errorCode,
    stackTrace: stackTrace,
    timestamp: DateTime.now(),
    retryDelay: retryDelay,
    context: context,
  );

  factory Failure.storageCapacityNow({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => Failure.storageCapacity(
    message: message,
    errorCode: errorCode,
    stackTrace: stackTrace,
    timestamp: DateTime.now(),
    retryDelay: retryDelay,
    context: context,
  );

  AppError get asAppError => when(
    network: (message, errorCode, stackTrace, timestamp, retryDelay, context) =>
        AppError(
          message: message,
          errorCode: errorCode,
          stackTrace: stackTrace,
          timestamp: timestamp,
          isRecoverable: true,
          retryDelay: retryDelay,
          context: context,
        ),
    parse: (message, errorCode, stackTrace, timestamp, retryDelay, context) =>
        AppError(
          message: message,
          errorCode: errorCode,
          stackTrace: stackTrace,
          timestamp: timestamp,
          isRecoverable: true,
          retryDelay: retryDelay,
          context: context,
        ),
    configSource:
        (message, errorCode, stackTrace, timestamp, retryDelay, context) =>
            AppError(
              message: message,
              errorCode: errorCode,
              stackTrace: stackTrace,
              timestamp: timestamp,
              isRecoverable: true,
              retryDelay: retryDelay,
              context: context,
            ),
    configParse:
        (message, errorCode, stackTrace, timestamp, retryDelay, context) =>
            AppError(
              message: message,
              errorCode: errorCode,
              stackTrace: stackTrace,
              timestamp: timestamp,
              isRecoverable: true,
              retryDelay: retryDelay,
              context: context,
            ),
    storageRead:
        (message, errorCode, stackTrace, timestamp, retryDelay, context) =>
            AppError(
              message: message,
              errorCode: errorCode,
              stackTrace: stackTrace,
              timestamp: timestamp,
              isRecoverable: true,
              retryDelay: retryDelay,
              context: context,
            ),
    storageWrite:
        (message, errorCode, stackTrace, timestamp, retryDelay, context) =>
            AppError(
              message: message,
              errorCode: errorCode,
              stackTrace: stackTrace,
              timestamp: timestamp,
              isRecoverable: true,
              retryDelay: retryDelay,
              context: context,
            ),
    storageSerialization:
        (message, errorCode, stackTrace, timestamp, retryDelay, context) =>
            AppError(
              message: message,
              errorCode: errorCode,
              stackTrace: stackTrace,
              timestamp: timestamp,
              isRecoverable: false,
              retryDelay: retryDelay,
              context: context,
            ),
    storageCapacity:
        (message, errorCode, stackTrace, timestamp, retryDelay, context) =>
            AppError(
              message: message,
              errorCode: errorCode,
              stackTrace: stackTrace,
              timestamp: timestamp,
              isRecoverable: false,
              retryDelay: retryDelay,
              context: context,
            ),
  );

  bool get canRetry => retryDelay != null;

  String get logMessage => '$errorCode: $message';
}
