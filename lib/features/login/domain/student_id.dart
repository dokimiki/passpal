import 'package:passpal/core/config/models/auth_config.dart';

/// Student ID value object with validation
class StudentId {
  /// Regex pattern for valid student ID: letter followed by 6 digits
  static final _regex = RegExp(r'^[a-zA-Z]\d{6}$');

  const StudentId._(this.value, this.authConfig);

  /// Create a StudentId from a raw string
  factory StudentId(String raw, AuthConfig authConfig) {
    final trimmed = raw.trim();
    if (!_regex.hasMatch(trimmed)) {
      throw ArgumentError('Student ID must match pattern [a-zA-Z]\\d{6}');
    }
    return StudentId._(trimmed.toLowerCase(), authConfig);
  }

  final String value;
  final AuthConfig authConfig;

  /// Generate expected email address for this student ID
  String get expectedEmail => '$value${authConfig.allowedMailDomain}';

  /// Check if a string is a valid student ID format
  static bool isValid(String raw) {
    return _regex.hasMatch(raw.trim());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StudentId &&
        other.value == value &&
        other.authConfig == authConfig;
  }

  @override
  int get hashCode => Object.hash(value, authConfig);

  @override
  String toString() => 'StudentId($value)';
}
