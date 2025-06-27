/// Base class for all application exceptions
abstract class AppException implements Exception {
  const AppException({
    required this.message,
    this.stack,
    required this.isFatal,
  });

  final String message;
  final StackTrace? stack;
  final bool isFatal;

  @override
  String toString() => 'AppException: $message';
}

/// Network-related failures
sealed class NetworkFailure extends AppException {
  const NetworkFailure({
    required super.message,
    super.stack,
    super.isFatal = false,
  });

  /// Create an offline network failure
  const factory NetworkFailure.offline({
    required String message,
    StackTrace? stack,
  }) = _NetworkFailureOffline;

  /// Create a server error (5xx)
  const factory NetworkFailure.server({
    required String message,
    StackTrace? stack,
    bool canRetry,
  }) = _NetworkFailureServer;

  /// Create a client error (4xx)
  const factory NetworkFailure.http({
    required String message,
    StackTrace? stack,
    int? statusCode,
  }) = _NetworkFailureHttp;

  NetworkFailureKind get kind {
    return switch (this) {
      _NetworkFailureOffline() => NetworkFailureKind.offline,
      _NetworkFailureServer() => NetworkFailureKind.server5xx,
      _NetworkFailureHttp() => NetworkFailureKind.http4xx,
    };
  }

  bool get canRetry {
    return switch (this) {
      _NetworkFailureOffline() => true,
      _NetworkFailureServer(canRetry: final canRetry) => canRetry,
      _NetworkFailureHttp() => false,
    };
  }

  int? get statusCode {
    return switch (this) {
      _NetworkFailureHttp(statusCode: final code) => code,
      _ => null,
    };
  }
}

final class _NetworkFailureOffline extends NetworkFailure {
  const _NetworkFailureOffline({required super.message, super.stack});
}

final class _NetworkFailureServer extends NetworkFailure {
  const _NetworkFailureServer({
    required super.message,
    super.stack,
    this.canRetry = true,
  });

  @override
  final bool canRetry;
}

final class _NetworkFailureHttp extends NetworkFailure {
  const _NetworkFailureHttp({
    required super.message,
    super.stack,
    this.statusCode,
  });

  @override
  final int? statusCode;
}

enum NetworkFailureKind { offline, http4xx, server5xx }

/// Authentication-related exceptions
class AuthenticationException extends AppException {
  const AuthenticationException({required super.message, super.stack})
    : super(isFatal: false);
}

/// System maintenance exceptions
class MaintenanceException extends AppException {
  const MaintenanceException({
    required super.message,
    super.stack,
    this.estimatedEndTime,
  }) : super(isFatal: false);

  final DateTime? estimatedEndTime;
}

/// Data parsing failures
class ParseFailure extends AppException {
  const ParseFailure({required super.message, super.stack, this.source})
    : super(isFatal: false);

  final String? source;
}

/// Unknown or unexpected exceptions
class UnknownException extends AppException {
  const UnknownException({
    required super.message,
    super.stack,
    this.originalException,
  }) : super(isFatal: true);

  final Exception? originalException;
}

/// Route parsing exceptions
class RouteParsingException extends AppException {
  const RouteParsingException({
    required super.message,
    super.stack,
    this.originalUri,
    this.routePath,
  }) : super(isFatal: false);

  final Uri? originalUri;
  final String? routePath;
}

/// Force update exception (renamed from UpdateRequiredException)
class ForceUpdateException extends AppException {
  const ForceUpdateException({
    required super.message,
    super.stack,
    required this.currentVersion,
    required this.minimumVersion,
  }) : super(isFatal: true);

  final String currentVersion;
  final String minimumVersion;
}

/// Background task related exceptions
sealed class BackgroundTaskException extends AppException {
  const BackgroundTaskException({
    required super.message,
    super.stack,
    super.isFatal = false,
    required this.taskId,
  });

  final String taskId;

  /// Task execution timeout
  const factory BackgroundTaskException.timeout({
    required String taskId,
    required String message,
    StackTrace? stack,
  }) = _BackgroundTaskTimeoutException;

  /// Task scheduling failure
  const factory BackgroundTaskException.schedulingFailed({
    required String taskId,
    required String message,
    StackTrace? stack,
  }) = _BackgroundTaskSchedulingException;

  /// Task handler not found
  const factory BackgroundTaskException.handlerNotFound({
    required String taskId,
    required String message,
    StackTrace? stack,
  }) = _BackgroundTaskHandlerNotFoundException;

  /// Task cancelled due to unrecoverable error
  const factory BackgroundTaskException.cancelled({
    required String taskId,
    required String message,
    StackTrace? stack,
  }) = _BackgroundTaskCancelledException;
}

/// Background task timeout exception
class _BackgroundTaskTimeoutException extends BackgroundTaskException {
  const _BackgroundTaskTimeoutException({
    required super.taskId,
    required super.message,
    super.stack,
  });
}

/// Background task scheduling exception
class _BackgroundTaskSchedulingException extends BackgroundTaskException {
  const _BackgroundTaskSchedulingException({
    required super.taskId,
    required super.message,
    super.stack,
  });
}

/// Background task handler not found exception
class _BackgroundTaskHandlerNotFoundException extends BackgroundTaskException {
  const _BackgroundTaskHandlerNotFoundException({
    required super.taskId,
    required super.message,
    super.stack,
  });
}

/// Background task cancelled exception
class _BackgroundTaskCancelledException extends BackgroundTaskException {
  const _BackgroundTaskCancelledException({
    required super.taskId,
    required super.message,
    super.stack,
  });
}
