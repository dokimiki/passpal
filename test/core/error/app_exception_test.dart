import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/error/app_exception.dart';

void main() {
  group('AppException', () {
    group('NetworkFailure', () {
      test('should create offline network failure', () {
        // Arrange & Act
        final exception = NetworkFailure.offline(
          message: 'No internet connection',
          stack: StackTrace.current,
        );

        // Assert
        expect(exception.kind, NetworkFailureKind.offline);
        expect(exception.canRetry, true);
        expect(exception.isFatal, false);
        expect(exception.message, 'No internet connection');
      });

      test('should create server error with retry capability', () {
        // Arrange & Act
        final exception = NetworkFailure.server(
          message: 'Internal server error',
          canRetry: true,
        );

        // Assert
        expect(exception.kind, NetworkFailureKind.server5xx);
        expect(exception.canRetry, true);
        expect(exception.isFatal, false);
      });

      test('should create client error without retry', () {
        // Arrange & Act
        final exception = NetworkFailure.http(
          message: 'Bad request',
          statusCode: 400,
        );

        // Assert
        expect(exception.kind, NetworkFailureKind.http4xx);
        expect(exception.canRetry, false);
        expect(exception.statusCode, 400);
      });
    });

    group('AuthenticationException', () {
      test('should create authentication exception', () {
        // Arrange & Act
        final exception = AuthenticationException(
          message: 'Authentication failed',
        );

        // Assert
        expect(exception.isFatal, false);
        expect(exception.message, 'Authentication failed');
      });
    });

    group('MaintenanceException', () {
      test('should create maintenance exception', () {
        // Arrange & Act
        final exception = MaintenanceException(
          message: 'System is under maintenance',
          estimatedEndTime: DateTime(2025, 1, 1, 12, 0),
        );

        // Assert
        expect(exception.isFatal, false);
        expect(exception.message, 'System is under maintenance');
        expect(exception.estimatedEndTime, DateTime(2025, 1, 1, 12, 0));
      });
    });

    group('ParseFailure', () {
      test('should create parse failure with non-fatal flag', () {
        // Arrange & Act
        final exception = ParseFailure(
          message: 'Failed to parse HTML',
          source: '<html>invalid</html>',
        );

        // Assert
        expect(exception.isFatal, false);
        expect(exception.message, 'Failed to parse HTML');
        expect(exception.source, '<html>invalid</html>');
      });
    });

    group('UnknownException', () {
      test('should create unknown exception as fatal', () {
        // Arrange & Act
        final exception = UnknownException(
          message: 'Unexpected error occurred',
          originalException: Exception('Original'),
        );

        // Assert
        expect(exception.isFatal, true);
        expect(exception.message, 'Unexpected error occurred');
        expect(exception.originalException, isA<Exception>());
      });
    });
  });
}
