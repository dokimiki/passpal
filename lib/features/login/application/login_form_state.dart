import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passpal/features/login/domain/student_id.dart';

part 'login_form_state.freezed.dart';

/// Enum representing the current step in the login flow
enum LoginStep { studentId, google, cuId }

/// State for the login form flow
@freezed
abstract class LoginFormState with _$LoginFormState {
  const factory LoginFormState({
    /// Current student ID entered by user
    StudentId? studentId,

    /// Whether any async operation is in progress
    @Default(false) bool isLoading,

    /// Error message to display to user
    String? errorMessage,

    /// Current step in the login flow
    @Default(LoginStep.studentId) LoginStep currentStep,

    /// Whether Google sign-in has been completed
    @Default(false) bool isGoogleSignedIn,
  }) = _LoginFormState;
}

/// Extension methods for LoginFormState
extension LoginFormStateExtension on LoginFormState {
  /// Whether the current state has a valid student ID
  bool get hasValidStudentId => studentId != null;

  /// Whether we can proceed to the next step
  bool get canProceed {
    switch (currentStep) {
      case LoginStep.studentId:
        return hasValidStudentId && !isLoading;
      case LoginStep.google:
        return isGoogleSignedIn && !isLoading;
      case LoginStep.cuId:
        return hasValidStudentId && isGoogleSignedIn && !isLoading;
    }
  }

  /// Clear any error message
  LoginFormState clearError() => copyWith(errorMessage: null);
}
