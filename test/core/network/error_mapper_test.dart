import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/error/app_exception.dart';
import 'package:passpal/core/network/error_mapper.dart';

void main() {
  group('NetworkErrorMapper', () {
    test('should map connection timeout to server failure', () {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );

      // Act
      final result = NetworkErrorMapper.mapDioException(dioException);

      // Assert
      expect(result, isA<NetworkFailure>());
      final failure = result as NetworkFailure;
      expect(failure.kind, NetworkFailureKind.server5xx);
      expect(failure.canRetry, true);
    });

    test('should map 401 response to AuthenticationException', () {
      // Arrange
      final response = Response<String>(
        statusCode: 401,
        requestOptions: RequestOptions(path: '/test'),
      );
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: response,
        type: DioExceptionType.badResponse,
      );

      // Act
      final result = NetworkErrorMapper.mapDioException(dioException);

      // Assert
      expect(result, isA<AuthenticationException>());
    });

    test('should map 404 response to HTTP failure', () {
      // Arrange
      final response = Response<String>(
        statusCode: 404,
        requestOptions: RequestOptions(path: '/test'),
      );
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: response,
        type: DioExceptionType.badResponse,
      );

      // Act
      final result = NetworkErrorMapper.mapDioException(dioException);

      // Assert
      expect(result, isA<NetworkFailure>());
      final failure = result as NetworkFailure;
      expect(failure.kind, NetworkFailureKind.http4xx);
      expect(failure.statusCode, 404);
      expect(failure.canRetry, false);
    });

    test('should map 500 response to server failure with retry', () {
      // Arrange
      final response = Response<String>(
        statusCode: 500,
        requestOptions: RequestOptions(path: '/test'),
      );
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: response,
        type: DioExceptionType.badResponse,
      );

      // Act
      final result = NetworkErrorMapper.mapDioException(dioException);

      // Assert
      expect(result, isA<NetworkFailure>());
      final failure = result as NetworkFailure;
      expect(failure.kind, NetworkFailureKind.server5xx);
      expect(failure.canRetry, true);
    });

    test('should return existing AppException if already mapped', () {
      // Arrange
      const originalException = NetworkFailure.offline(message: 'Already mapped');
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        error: originalException,
        type: DioExceptionType.connectionError,
      );

      // Act
      final result = NetworkErrorMapper.mapDioException(dioException);

      // Assert
      expect(result, same(originalException));
    });

    test('should map connection error with network unreachable to offline', () {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        message: 'Network is unreachable',
        type: DioExceptionType.connectionError,
      );

      // Act
      final result = NetworkErrorMapper.mapDioException(dioException);

      // Assert
      expect(result, isA<NetworkFailure>());
      final failure = result as NetworkFailure;
      expect(failure.kind, NetworkFailureKind.offline);
    });

    test('should map unknown error to UnknownException', () {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        error: Exception('Some unknown error'),
        type: DioExceptionType.unknown,
      );

      // Act
      final result = NetworkErrorMapper.mapDioException(dioException);

      // Assert
      expect(result, isA<UnknownException>());
      final unknownException = result as UnknownException;
      expect(unknownException.originalException, isA<Exception>());
    });
  });
}
