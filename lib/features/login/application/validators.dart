import 'package:passpal/features/login/domain/student_id.dart';
import 'package:passpal/core/config/models/auth_config.dart';

/// Validator functions for login forms
class LoginValidators {
  LoginValidators._();

  /// Validate student ID input
  static String? validateStudentId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Student ID is required';
    }

    if (!StudentId.isValid(value)) {
      return 'Student ID must be a letter followed by 6 digits (e.g., A123456)';
    }

    return null;
  }

  /// Validate password input
  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }

    if (value.length < 4) {
      return 'Password must be at least 4 characters';
    }

    return null;
  }

  /// Check if email matches expected student email format
  static bool isValidStudentEmail(
    String email,
    String studentId,
    AuthConfig authConfig,
  ) {
    final expectedEmail = '$studentId${authConfig.allowedMailDomain}';
    return email.toLowerCase() == expectedEmail.toLowerCase();
  }
}
