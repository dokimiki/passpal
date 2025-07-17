import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';

@freezed
abstract class AppError with _$AppError {
  const factory AppError({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    required DateTime timestamp,
    required bool isRecoverable,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) = _AppError;

  const AppError._();

  factory AppError.now({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    required bool isRecoverable,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) => AppError(
    message: message,
    errorCode: errorCode,
    stackTrace: stackTrace,
    timestamp: DateTime.now(),
    isRecoverable: isRecoverable,
    retryDelay: retryDelay,
    context: context,
  );

  bool get canRetry => isRecoverable && retryDelay != null;

  String get logMessage => '$errorCode: $message';
}
