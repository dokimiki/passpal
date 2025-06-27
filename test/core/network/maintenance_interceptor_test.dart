import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:passpal/core/error/app_exception.dart';
import 'package:passpal/core/network/maintenance_interceptor.dart';

import 'maintenance_interceptor_test.mocks.dart';

@GenerateMocks([ErrorInterceptorHandler])
void main() {
  group('MaintenanceInterceptor', () {
    late MaintenanceInterceptor interceptor;
    late MockErrorInterceptorHandler mockHandler;

    setUp(() {
      interceptor = MaintenanceInterceptor();
      mockHandler = MockErrorInterceptorHandler();
    });

    test(
      'should detect maintenance response with 503 and maintenance keyword',
      () {
        // Arrange
        final response = Response<String>(
          data: '<html><body>System is under maintenance</body></html>',
          statusCode: 503,
          requestOptions: RequestOptions(path: '/test'),
        );
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/test'),
          response: response,
          type: DioExceptionType.badResponse,
        );

        // Act
        interceptor.onError(dioException, mockHandler);

        // Assert
        final calls = verify(mockHandler.reject(captureAny)).captured;
        expect(calls.length, 1);
        final captured = calls.first as DioException;
        expect(captured.error, isA<MaintenanceException>());
      },
    );

    test('should detect Japanese maintenance message', () {
      // Arrange
      final response = Response<String>(
        data: '<html><body>システムメンテナンス中です</body></html>',
        statusCode: 503,
        requestOptions: RequestOptions(path: '/test'),
      );
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: response,
        type: DioExceptionType.badResponse,
      );

      // Act
      interceptor.onError(dioException, mockHandler);

      // Assert
      final calls = verify(mockHandler.reject(captureAny)).captured;
      expect(calls.length, 1);
      final captured = calls.first as DioException;
      expect(captured.error, isA<MaintenanceException>());
      final maintenanceException = captured.error as MaintenanceException;
      expect(maintenanceException.message, contains('メンテナンス'));
    });

    test(
      'should not detect maintenance for 503 without maintenance keywords',
      () {
        // Arrange
        final response = Response<String>(
          data: '<html><body>Internal Server Error</body></html>',
          statusCode: 503,
          requestOptions: RequestOptions(path: '/test'),
        );
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/test'),
          response: response,
          type: DioExceptionType.badResponse,
        );

        // Act
        interceptor.onError(dioException, mockHandler);

        // Assert
        verify(mockHandler.next(dioException)).called(1);
        verifyNever(mockHandler.reject(any));
      },
    );

    test('should not detect maintenance for non-503 responses', () {
      // Arrange
      final response = Response<String>(
        data: '<html><body>System is under maintenance</body></html>',
        statusCode: 500,
        requestOptions: RequestOptions(path: '/test'),
      );
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: response,
        type: DioExceptionType.badResponse,
      );

      // Act
      interceptor.onError(dioException, mockHandler);

      // Assert
      verify(mockHandler.next(dioException)).called(1);
      verifyNever(mockHandler.reject(any));
    });

    test('should pass through errors without response', () {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );

      // Act
      interceptor.onError(dioException, mockHandler);

      // Assert
      verify(mockHandler.next(dioException)).called(1);
      verifyNever(mockHandler.reject(any));
    });
  });
}
