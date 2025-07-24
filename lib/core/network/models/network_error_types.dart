import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';

part 'network_error_types.freezed.dart';

/// Network-specific error type definitions that extend the base NetworkErrorType
/// from Error Core with detailed network error classification
@freezed
sealed class DetailedNetworkErrorType with _$DetailedNetworkErrorType {
  /// Connection-related errors
  const factory DetailedNetworkErrorType.connection({
    required String reason,
    String? host,
    int? port,
  }) = DetailedConnectionError;

  /// Timeout-related errors
  const factory DetailedNetworkErrorType.timeout({
    required Duration timeoutDuration,
    required String timeoutType, // 'connect', 'send', 'receive'
    String? host,
  }) = DetailedTimeoutError;

  /// HTTP response errors (4xx, 5xx)
  const factory DetailedNetworkErrorType.response({
    required int statusCode,
    required String statusMessage,
    String? reasonPhrase,
    Map<String, dynamic>? responseHeaders,
  }) = DetailedResponseError;

  /// Request cancellation errors
  const factory DetailedNetworkErrorType.cancelled({
    required String reason,
    @Default(false) bool isManual,
  }) = DetailedCancelledError;

  /// Request format/validation errors
  const factory DetailedNetworkErrorType.badRequest({
    required String reason,
    String? requestPath,
    Map<String, dynamic>? requestData,
  }) = DetailedBadRequestError;

  /// SSL/Certificate errors
  const factory DetailedNetworkErrorType.certificate({
    required String reason,
    String? host,
    String? certificateError,
  }) = DetailedCertificateError;

  /// Unknown/Other network errors
  const factory DetailedNetworkErrorType.unknown({
    required String reason,
    String? originalErrorType,
  }) = DetailedUnknownError;
}

/// HTTP status code category classification
enum HttpStatusCategory {
  informational, // 1xx
  success, // 2xx
  redirection, // 3xx
  clientError, // 4xx
  serverError, // 5xx
  unknown, // Outside 100-599
}

/// Network error classification and context extraction utilities
class NetworkErrorClassifier {
  /// Classify a DioException into a DetailedNetworkErrorType
  static DetailedNetworkErrorType classifyDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return DetailedNetworkErrorType.timeout(
          timeoutDuration: Duration.zero, // Will be filled from request options
          timeoutType: 'connect',
          host: exception.requestOptions.uri.host,
        );

      case DioExceptionType.sendTimeout:
        return DetailedNetworkErrorType.timeout(
          timeoutDuration:
              exception.requestOptions.sendTimeout ?? Duration.zero,
          timeoutType: 'send',
          host: exception.requestOptions.uri.host,
        );

      case DioExceptionType.receiveTimeout:
        return DetailedNetworkErrorType.timeout(
          timeoutDuration:
              exception.requestOptions.receiveTimeout ?? Duration.zero,
          timeoutType: 'receive',
          host: exception.requestOptions.uri.host,
        );

      case DioExceptionType.badResponse:
        final response = exception.response;
        return DetailedNetworkErrorType.response(
          statusCode: response?.statusCode ?? 0,
          statusMessage: response?.statusMessage ?? 'Unknown',
          reasonPhrase: response?.statusMessage,
          responseHeaders: response?.headers.map,
        );

      case DioExceptionType.cancel:
        return DetailedNetworkErrorType.cancelled(
          reason: exception.message ?? 'Request was cancelled',
          isManual: true,
        );

      case DioExceptionType.connectionError:
        return DetailedNetworkErrorType.connection(
          reason: exception.message ?? 'Connection failed',
          host: exception.requestOptions.uri.host,
          port: exception.requestOptions.uri.port,
        );

      case DioExceptionType.badCertificate:
        return DetailedNetworkErrorType.certificate(
          reason: exception.message ?? 'Certificate validation failed',
          host: exception.requestOptions.uri.host,
          certificateError: exception.error?.toString(),
        );

      case DioExceptionType.unknown:
        return DetailedNetworkErrorType.unknown(
          reason: exception.message ?? 'Unknown network error',
          originalErrorType: exception.error?.runtimeType.toString(),
        );
    }
  }

  /// Get HTTP status category from status code
  static HttpStatusCategory getStatusCategory(int statusCode) {
    if (statusCode >= 100 && statusCode < 200) {
      return HttpStatusCategory.informational;
    } else if (statusCode >= 200 && statusCode < 300) {
      return HttpStatusCategory.success;
    } else if (statusCode >= 300 && statusCode < 400) {
      return HttpStatusCategory.redirection;
    } else if (statusCode >= 400 && statusCode < 500) {
      return HttpStatusCategory.clientError;
    } else if (statusCode >= 500 && statusCode < 600) {
      return HttpStatusCategory.serverError;
    } else {
      return HttpStatusCategory.unknown;
    }
  }

  /// Check if error is retryable based on error type and status code
  static bool isRetryable(DetailedNetworkErrorType errorType) {
    return errorType.when(
      connection: (reason, host, port) =>
          true, // Connection issues are generally retryable
      timeout: (duration, type, host) => true, // Timeouts are retryable
      response: (statusCode, statusMessage, reasonPhrase, headers) {
        // Only certain HTTP status codes are retryable
        return statusCode == 408 || // Request Timeout
            statusCode == 429 || // Too Many Requests
            statusCode == 502 || // Bad Gateway
            statusCode == 503 || // Service Unavailable
            statusCode == 504; // Gateway Timeout
      },
      cancelled: (reason, isManual) =>
          !isManual, // Only auto-cancelled requests are retryable
      badRequest: (reason, path, data) =>
          false, // Bad requests are not retryable
      certificate: (reason, host, certError) =>
          false, // Certificate errors are not retryable
      unknown: (reason, originalType) =>
          false, // Unknown errors are not retryable by default
    );
  }

  /// Get suggested retry delay based on error type
  static Duration? getSuggestedRetryDelay(DetailedNetworkErrorType errorType) {
    return errorType.when(
      connection: (reason, host, port) => const Duration(seconds: 2),
      timeout: (duration, type, host) => const Duration(seconds: 3),
      response: (statusCode, statusMessage, reasonPhrase, headers) {
        switch (statusCode) {
          case 408:
            return const Duration(seconds: 1); // Request Timeout
          case 429:
            return const Duration(
              seconds: 60,
            ); // Too Many Requests - longer delay
          case 502:
            return const Duration(seconds: 5); // Bad Gateway
          case 503:
            return const Duration(seconds: 10); // Service Unavailable
          case 504:
            return const Duration(seconds: 5); // Gateway Timeout
          default:
            return null;
        }
      },
      cancelled: (reason, isManual) =>
          isManual ? null : const Duration(seconds: 1),
      badRequest: (reason, path, data) => null,
      certificate: (reason, host, certError) => null,
      unknown: (reason, originalType) => null,
    );
  }

  /// Extract error context for logging and debugging
  static Map<String, dynamic> extractErrorContext(
    DioException exception,
    DetailedNetworkErrorType errorType,
  ) {
    final context = <String, dynamic>{
      'error_type': errorType.runtimeType.toString(),
      'dio_exception_type': exception.type.toString(),
      'request_method': exception.requestOptions.method,
      'request_uri': exception.requestOptions.uri.toString(),
      'request_headers': exception.requestOptions.headers,
    };

    // Add error-specific context
    errorType.when(
      connection: (reason, host, port) {
        context['connection_reason'] = reason;
        if (host != null) context['host'] = host;
        if (port != null) context['port'] = port;
      },
      timeout: (duration, type, host) {
        context['timeout_duration_ms'] = duration.inMilliseconds;
        context['timeout_type'] = type;
        if (host != null) context['host'] = host;
      },
      response: (statusCode, statusMessage, reasonPhrase, headers) {
        context['status_code'] = statusCode;
        context['status_message'] = statusMessage;
        context['status_category'] = getStatusCategory(statusCode).toString();
        if (reasonPhrase != null) context['reason_phrase'] = reasonPhrase;
        if (headers != null) context['response_headers'] = headers;
      },
      cancelled: (reason, isManual) {
        context['cancel_reason'] = reason;
        context['is_manual_cancellation'] = isManual;
      },
      badRequest: (reason, path, data) {
        context['bad_request_reason'] = reason;
        if (path != null) context['request_path'] = path;
        if (data != null) context['request_data'] = data;
      },
      certificate: (reason, host, certError) {
        context['certificate_reason'] = reason;
        if (host != null) context['host'] = host;
        if (certError != null) context['certificate_error'] = certError;
      },
      unknown: (reason, originalType) {
        context['unknown_reason'] = reason;
        if (originalType != null) context['original_error_type'] = originalType;
      },
    );

    // Add response body if available and not too large
    if (exception.response?.data != null) {
      final responseData = exception.response!.data;
      if (responseData is String && responseData.length < 1000) {
        context['response_body'] = responseData;
      } else if (responseData is Map<String, dynamic>) {
        context['response_body'] = responseData;
      }
    }

    return context;
  }
}

/// Network error code constants for Error Core integration
class NetworkErrorCodes {
  static const String connectionError = 'NETWORK_CONNECTION_ERROR';
  static const String timeoutError = 'NETWORK_TIMEOUT_ERROR';
  static const String responseError = 'NETWORK_RESPONSE_ERROR';
  static const String cancelledError = 'NETWORK_CANCELLED_ERROR';
  static const String badRequestError = 'NETWORK_BAD_REQUEST_ERROR';
  static const String certificateError = 'NETWORK_CERTIFICATE_ERROR';
  static const String unknownError = 'NETWORK_UNKNOWN_ERROR';

  /// Get error code for a specific DetailedNetworkErrorType
  static String getErrorCode(DetailedNetworkErrorType errorType) {
    return errorType.when(
      connection: (reason, host, port) => connectionError,
      timeout: (duration, type, host) => timeoutError,
      response: (statusCode, statusMessage, reasonPhrase, headers) =>
          responseError,
      cancelled: (reason, isManual) => cancelledError,
      badRequest: (reason, path, data) => badRequestError,
      certificate: (reason, host, certError) => certificateError,
      unknown: (reason, originalType) => unknownError,
    );
  }
}
