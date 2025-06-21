/// Sealed class representing authentication failures
sealed class AuthFailure {
  const AuthFailure();
}

/// Network connection error
class NetworkError extends AuthFailure {
  const NetworkError({required this.message, this.originalException});

  final String message;
  final Exception? originalException;

  @override
  String toString() => 'NetworkError: $message';
}

/// Service unavailable (503 error)
class ServiceUnavailable extends AuthFailure {
  const ServiceUnavailable({required this.serviceName, this.message});

  final String serviceName;
  final String? message;

  @override
  String toString() =>
      'ServiceUnavailable: $serviceName${message != null ? ' - $message' : ''}';
}

/// Invalid credentials
class InvalidCredentials extends AuthFailure {
  const InvalidCredentials({this.message});

  final String? message;

  @override
  String toString() =>
      'InvalidCredentials${message != null ? ': $message' : ''}';
}

/// SAML request failed
class SamlRequestFailed extends AuthFailure {
  const SamlRequestFailed({required this.step, this.message});

  final String step;
  final String? message;

  @override
  String toString() =>
      'SamlRequestFailed at $step${message != null ? ': $message' : ''}';
}

/// Cookie extraction failed
class CookieExtractionFailed extends AuthFailure {
  const CookieExtractionFailed({required this.cookieName, this.message});

  final String cookieName;
  final String? message;

  @override
  String toString() =>
      'CookieExtractionFailed for $cookieName${message != null ? ': $message' : ''}';
}

/// Session refresh failed
class SessionRefreshFailed extends AuthFailure {
  const SessionRefreshFailed({this.message});

  final String? message;

  @override
  String toString() =>
      'SessionRefreshFailed${message != null ? ': $message' : ''}';
}

/// Unexpected error
class UnexpectedError extends AuthFailure {
  const UnexpectedError({required this.message, this.originalException});

  final String message;
  final Exception? originalException;

  @override
  String toString() => 'UnexpectedError: $message';
}
