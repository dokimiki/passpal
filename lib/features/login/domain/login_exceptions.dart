import 'package:passpal/core/error/app_exception.dart';

/// Base class for login-specific exceptions
sealed class LoginException extends AppException {
  const LoginException({
    required super.message,
    super.stack,
    super.isFatal = false,
  });
}

/// Exception thrown when student ID format is invalid
class InvalidStudentIdException extends LoginException {
  const InvalidStudentIdException([String? providedId])
    : super(
        message: providedId != null
            ? 'Invalid student ID format: $providedId. Must match [a-zA-Z]\\d{6}'
            : 'Invalid student ID format. Must match [a-zA-Z]\\d{6}',
      );
}

/// Exception thrown when Google account email doesn't match expected domain
class AccountLinkException extends LoginException {
  const AccountLinkException({required String expected, required String actual})
    : super(message: 'Email mismatch: expected $expected, but got $actual');
}

/// Exception thrown when login step is invalid
class InvalidLoginStepException extends LoginException {
  const InvalidLoginStepException(String step)
    : super(message: 'Invalid login step: $step');
}
