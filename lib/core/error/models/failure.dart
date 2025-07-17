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
  );

  bool get canRetry => retryDelay != null;

  String get logMessage => '$errorCode: $message';
}
