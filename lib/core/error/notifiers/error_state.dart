import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/app_error.dart';

part 'error_state.freezed.dart';

@freezed
abstract class ErrorState with _$ErrorState {
  const factory ErrorState({
    @Default([]) List<AppError> errors,
    @Default([]) List<String> dismissedErrorIds,
    AppError? lastError,
    @Default(false) bool isHandlingError,
  }) = _ErrorState;

  const ErrorState._();

  bool hasActiveErrors() => errors.isNotEmpty;

  List<AppError> get activeErrors => errors
      .where((error) => !dismissedErrorIds.contains(error.errorCode))
      .toList();

  bool isErrorDismissed(String errorCode) =>
      dismissedErrorIds.contains(errorCode);

  bool hasErrorOfType(Type errorType) =>
      errors.any((e) => e.runtimeType == errorType);

  AppError? getLatestErrorOfType(Type errorType) {
    final filteredErrors = errors
        .where((e) => e.runtimeType == errorType)
        .toList();
    return filteredErrors.isNotEmpty ? filteredErrors.last : null;
  }

  int get errorCount => activeErrors.length;

  List<AppError> get recoverableErrors =>
      activeErrors.where((e) => e.isRecoverable).toList();

  List<AppError> get criticalErrors =>
      activeErrors.where((e) => !e.isRecoverable).toList();
}
