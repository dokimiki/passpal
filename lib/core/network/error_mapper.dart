import 'package:dio/dio.dart';
import '../error/app_exception.dart';

/// Utility class for mapping Dio exceptions to domain exceptions
class NetworkErrorMapper {
  /// Map a DioException to an appropriate AppException
  static AppException mapDioException(DioException error) {
    // If the error already contains a domain exception, return it
    if (error.error is AppException) {
      return error.error as AppException;
    }

    return switch (error.type) {
      DioExceptionType.connectionTimeout => const NetworkFailure.server(
          message: 'Connection timeout - please check your internet connection',
          canRetry: true,
        ),
      
      DioExceptionType.sendTimeout => const NetworkFailure.server(
          message: 'Request timeout - please try again',
          canRetry: true,
        ),
      
      DioExceptionType.receiveTimeout => const NetworkFailure.server(
          message: 'Response timeout - please try again',
          canRetry: true,
        ),
      
      DioExceptionType.connectionError => _mapConnectionError(error),
      
      DioExceptionType.badResponse => _mapHttpError(error),
      
      DioExceptionType.cancel => const NetworkFailure.http(
          message: 'Request was cancelled',
        ),
      
      DioExceptionType.unknown => _mapUnknownError(error),
      
      DioExceptionType.badCertificate => const NetworkFailure.http(
          message: 'SSL certificate error - unable to verify server identity',
        ),
    };
  }

  static NetworkFailure _mapConnectionError(DioException error) {
    final message = error.message?.toLowerCase() ?? '';
    
    if (message.contains('network is unreachable') || 
        message.contains('no internet') ||
        message.contains('connection failed')) {
      return const NetworkFailure.offline(
        message: 'No internet connection available',
      );
    }
    
    return const NetworkFailure.server(
      message: 'Unable to connect to server - please try again',
      canRetry: true,
    );
  }

  static AppException _mapHttpError(DioException error) {
    final statusCode = error.response?.statusCode;
    
    return switch (statusCode) {
      400 => NetworkFailure.http(
          message: 'Bad request - please check your input',
          statusCode: statusCode,
        ),
      
      401 => const AuthenticationException(
          message: 'Authentication failed - please log in again',
        ),
      
      403 => NetworkFailure.http(
          message: 'Access denied - insufficient permissions',
          statusCode: statusCode,
        ),
      
      404 => NetworkFailure.http(
          message: 'Requested resource not found',
          statusCode: statusCode,
        ),
      
      429 => NetworkFailure.http(
          message: 'Too many requests - please wait before trying again',
          statusCode: statusCode,
        ),
      
      500 => const NetworkFailure.server(
          message: 'Internal server error - please try again later',
          canRetry: true,
        ),
      
      502 => const NetworkFailure.server(
          message: 'Bad gateway - server is temporarily unavailable',
          canRetry: true,
        ),
      
      503 => const NetworkFailure.server(
          message: 'Service unavailable - please try again later',
          canRetry: true,
        ),
      
      504 => const NetworkFailure.server(
          message: 'Gateway timeout - please try again',
          canRetry: true,
        ),
      
      _ when statusCode != null && statusCode >= 400 && statusCode < 500 =>
        NetworkFailure.http(
          message: 'Client error occurred ($statusCode)',
          statusCode: statusCode,
        ),
      
      _ when statusCode != null && statusCode >= 500 =>
        NetworkFailure.server(
          message: 'Server error occurred ($statusCode)',
          canRetry: true,
        ),
      
      _ => NetworkFailure.http(
          message: 'HTTP error occurred: ${error.message}',
          statusCode: statusCode,
        ),
    };
  }

  static AppException _mapUnknownError(DioException error) {
    final originalError = error.error;
    
    if (originalError is AppException) {
      return originalError;
    }
    
    return UnknownException(
      message: 'An unexpected network error occurred: ${error.message}',
      originalException: originalError is Exception ? originalError : null,
      stack: error.stackTrace,
    );
  }
}
