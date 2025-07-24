import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../error/providers.dart';
import '../models/network_error_types.dart';

part 'error_interceptor.g.dart';

/// Dio interceptor that converts DioException to unified AppError format
///
/// This interceptor handles all network errors and transforms them into
/// structured AppError/Failure objects that can be processed by the error core.
/// It enriches errors with context information and determines retry strategies.
class ErrorInterceptor extends Interceptor {
  final AppLogger _logger;
  final ErrorNotifier _errorNotifier;

  ErrorInterceptor({
    required AppLogger logger,
    required ErrorNotifier errorNotifier,
  }) : _logger = logger,
       _errorNotifier = errorNotifier;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Classify the Dio exception into our detailed error types
    final detailedErrorType = NetworkErrorClassifier.classifyDioException(err);

    // Extract comprehensive error context
    final errorContext = NetworkErrorClassifier.extractErrorContext(
      err,
      detailedErrorType,
    );

    // Get appropriate error code for Error Core
    final errorCode = NetworkErrorCodes.getErrorCode(detailedErrorType);

    // Generate human-readable error message
    final errorMessage = _generateErrorMessage(detailedErrorType, err);

    // Determine if this error is retryable and get retry delay
    final isRetryable = NetworkErrorClassifier.isRetryable(detailedErrorType);
    final retryDelay = NetworkErrorClassifier.getSuggestedRetryDelay(
      detailedErrorType,
    );

    // Create NetworkFailure object
    final failure = Failure.networkNow(
      message: errorMessage,
      errorCode: errorCode,
      stackTrace: err.stackTrace,
      retryDelay: isRetryable ? retryDelay : null,
      context: errorContext,
    );

    // Convert to AppError for unified error handling
    final appError = failure.asAppError;

    // Log the error with appropriate level
    _logError(detailedErrorType, appError, err);

    // Report to error notifier for global error handling
    _errorNotifier.handleError(appError);

    // Create a new DioException with enriched error context
    final enrichedError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: failure, // Replace original error with our structured failure
      message: errorMessage,
      stackTrace: err.stackTrace,
    );

    // Continue with the error
    handler.next(enrichedError);
  }

  /// Generate human-readable error message based on error type
  String _generateErrorMessage(
    DetailedNetworkErrorType errorType,
    DioException originalError,
  ) {
    return errorType.when(
      connection: (reason, host, port) {
        final hostInfo = host != null
            ? ' to $host${port != null ? ':$port' : ''}'
            : '';
        return 'ネットワーク接続に失敗しました$hostInfo: $reason';
      },
      timeout: (duration, type, host) {
        final timeoutTypeJa = _getTimeoutTypeJapanese(type);
        final hostInfo = host != null ? ' ($host)' : '';
        return '$timeoutTypeJaがタイムアウトしました$hostInfo (${duration.inSeconds}秒)';
      },
      response: (statusCode, statusMessage, reasonPhrase, headers) {
        final category = NetworkErrorClassifier.getStatusCategory(statusCode);
        return _getResponseErrorMessage(statusCode, statusMessage, category);
      },
      cancelled: (reason, isManual) {
        return isManual
            ? 'リクエストがキャンセルされました: $reason'
            : 'リクエストが自動的にキャンセルされました: $reason';
      },
      badRequest: (reason, path, data) {
        final pathInfo = path != null ? ' ($path)' : '';
        return 'リクエストが無効です$pathInfo: $reason';
      },
      certificate: (reason, host, certError) {
        final hostInfo = host != null ? ' ($host)' : '';
        return '証明書エラーが発生しました$hostInfo: $reason';
      },
      unknown: (reason, originalType) {
        return '不明なネットワークエラーが発生しました: $reason';
      },
    );
  }

  /// Get Japanese translation for timeout types
  String _getTimeoutTypeJapanese(String type) {
    switch (type) {
      case 'connect':
        return '接続';
      case 'send':
        return '送信';
      case 'receive':
        return '受信';
      default:
        return type;
    }
  }

  /// Generate response error message based on status code
  String _getResponseErrorMessage(
    int statusCode,
    String statusMessage,
    HttpStatusCategory category,
  ) {
    // Common status codes with specific Japanese messages
    switch (statusCode) {
      case 400:
        return 'リクエストが不正です (400 Bad Request)';
      case 401:
        return '認証が必要です (401 Unauthorized)';
      case 403:
        return 'アクセスが拒否されました (403 Forbidden)';
      case 404:
        return 'リソースが見つかりません (404 Not Found)';
      case 408:
        return 'リクエストがタイムアウトしました (408 Request Timeout)';
      case 409:
        return 'リクエストが競合しています (409 Conflict)';
      case 429:
        return 'リクエスト数が制限を超えています (429 Too Many Requests)';
      case 500:
        return 'サーバー内部エラーが発生しました (500 Internal Server Error)';
      case 502:
        return 'ゲートウェイエラーが発生しました (502 Bad Gateway)';
      case 503:
        return 'サービスが利用できません (503 Service Unavailable)';
      case 504:
        return 'ゲートウェイがタイムアウトしました (504 Gateway Timeout)';
      default:
        // Fallback to category-based messages
        switch (category) {
          case HttpStatusCategory.clientError:
            return 'クライアントエラーが発生しました ($statusCode $statusMessage)';
          case HttpStatusCategory.serverError:
            return 'サーバーエラーが発生しました ($statusCode $statusMessage)';
          case HttpStatusCategory.redirection:
            return 'リダイレクトエラーが発生しました ($statusCode $statusMessage)';
          default:
            return 'HTTPエラーが発生しました ($statusCode $statusMessage)';
        }
    }
  }

  /// Log error with appropriate level based on error type
  void _logError(
    DetailedNetworkErrorType errorType,
    AppError appError,
    DioException originalError,
  ) {
    final logContext = {
      'error_code': appError.errorCode,
      'error_message': appError.message,
      'request_method': originalError.requestOptions.method,
      'request_uri': originalError.requestOptions.uri.toString(),
      'is_recoverable': appError.isRecoverable,
      'can_retry': appError.canRetry,
      ...?appError.context,
    };

    // Determine log level based on error type
    final shouldLogAsError = errorType.when(
      connection: (reason, host, port) => true,
      timeout: (duration, type, host) => true,
      response: (statusCode, statusMessage, reasonPhrase, headers) {
        // Log 5xx as errors, 4xx as warnings (except 401/403 which might be normal)
        final category = NetworkErrorClassifier.getStatusCategory(statusCode);
        return category == HttpStatusCategory.serverError ||
            (category == HttpStatusCategory.clientError &&
                statusCode != 401 &&
                statusCode != 403);
      },
      cancelled: (reason, isManual) =>
          !isManual, // Only log auto-cancellations as errors
      badRequest: (reason, path, data) => false, // Log as warning
      certificate: (reason, host, certError) => true,
      unknown: (reason, originalType) => true,
    );

    if (shouldLogAsError) {
      _logger.error(
        'Network error occurred: ${appError.logMessage}',
        attributes: logContext,
        stackTrace: originalError.stackTrace,
      );
    } else {
      _logger.warning(
        'Network warning: ${appError.logMessage}',
        attributes: logContext,
      );
    }
  }
}

/// Provider for the error interceptor
@riverpod
ErrorInterceptor errorInterceptor(Ref ref) {
  final logger = ref.watch(loggerForTagProvider('Network'));
  final errorNotifier = ref.watch(errorNotifierProvider.notifier);

  return ErrorInterceptor(logger: logger, errorNotifier: errorNotifier);
}

/// Provider family for creating error interceptors with custom tags
@riverpod
ErrorInterceptor errorInterceptorForService(Ref ref, String serviceName) {
  final logger = ref.watch(loggerForTagProvider('Network:$serviceName'));
  final errorNotifier = ref.watch(errorNotifierProvider.notifier);

  return ErrorInterceptor(logger: logger, errorNotifier: errorNotifier);
}

/// Extension to add error context to DioException
extension DioExceptionErrorContext on DioException {
  /// Check if this DioException has been processed by ErrorInterceptor
  bool get hasStructuredError => error is Failure;

  /// Get the structured failure if available
  Failure? get structuredFailure =>
      hasStructuredError ? error as Failure : null;

  /// Get the structured AppError if available
  AppError? get structuredAppError => structuredFailure?.asAppError;
}

/// Utility class for error interceptor configuration
class ErrorInterceptorConfig {
  /// Whether to log all errors (including client errors like 4xx)
  final bool logAllErrors;

  /// Whether to report errors to global error notifier
  final bool reportToNotifier;

  /// Custom error message formatter
  final String Function(DetailedNetworkErrorType, DioException)?
  messageFormatter;

  /// Custom context extractor
  final Map<String, dynamic> Function(DetailedNetworkErrorType, DioException)?
  contextExtractor;

  const ErrorInterceptorConfig({
    this.logAllErrors = false,
    this.reportToNotifier = true,
    this.messageFormatter,
    this.contextExtractor,
  });

  /// Default configuration for production
  static const ErrorInterceptorConfig production = ErrorInterceptorConfig(
    logAllErrors: false,
    reportToNotifier: true,
  );

  /// Configuration for development/debugging
  static const ErrorInterceptorConfig development = ErrorInterceptorConfig(
    logAllErrors: true,
    reportToNotifier: true,
  );
}
