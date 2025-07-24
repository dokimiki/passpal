import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

import 'package:passpal/core/network/models/network_error_types.dart';

void main() {
  group('NetworkErrorClassifier', () {
    test('classifies connection timeout correctly', () {
      // Arrange
      final requestOptions = RequestOptions(path: '/test');
      final exception = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.connectionTimeout,
      );

      // Act
      final result = NetworkErrorClassifier.classifyDioException(exception);

      // Assert
      expect(result, isA<DetailedTimeoutError>());
      result.when(
        timeout: (duration, type, host) {
          expect(type, equals('connect'));
          expect(host, equals(requestOptions.uri.host));
        },
        connection: (_, _, _) => fail('Should be timeout error'),
        response: (_, _, _, _) => fail('Should be timeout error'),
        cancelled: (_, _) => fail('Should be timeout error'),
        badRequest: (_, _, _) => fail('Should be timeout error'),
        certificate: (_, _, _) => fail('Should be timeout error'),
        unknown: (_, _) => fail('Should be timeout error'),
      );
    });

    test('classifies send timeout correctly', () {
      // Arrange
      final requestOptions = RequestOptions(
        path: '/test',
        sendTimeout: Duration(seconds: 30),
      );
      final exception = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.sendTimeout,
      );

      // Act
      final result = NetworkErrorClassifier.classifyDioException(exception);

      // Assert
      expect(result, isA<DetailedTimeoutError>());
      result.when(
        timeout: (duration, type, host) {
          expect(type, equals('send'));
          expect(duration, equals(Duration(seconds: 30)));
        },
        connection: (_, _, _) => fail('Should be timeout error'),
        response: (_, _, _, _) => fail('Should be timeout error'),
        cancelled: (_, _) => fail('Should be timeout error'),
        badRequest: (_, _, _) => fail('Should be timeout error'),
        certificate: (_, _, _) => fail('Should be timeout error'),
        unknown: (_, _) => fail('Should be timeout error'),
      );
    });

    test('classifies bad response correctly', () {
      // Arrange
      final requestOptions = RequestOptions(path: '/test');
      final response = Response(
        requestOptions: requestOptions,
        statusCode: 404,
        statusMessage: 'Not Found',
        headers: Headers.fromMap({
          'content-type': ['application/json'],
        }),
      );
      final exception = DioException(
        requestOptions: requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );

      // Act
      final result = NetworkErrorClassifier.classifyDioException(exception);

      // Assert
      expect(result, isA<DetailedResponseError>());
      result.when(
        response: (statusCode, statusMessage, reasonPhrase, headers) {
          expect(statusCode, equals(404));
          expect(statusMessage, equals('Not Found'));
          expect(headers, isNotNull);
        },
        connection: (_, _, _) => fail('Should be response error'),
        timeout: (_, _, _) => fail('Should be response error'),
        cancelled: (_, _) => fail('Should be response error'),
        badRequest: (_, _, _) => fail('Should be response error'),
        certificate: (_, _, _) => fail('Should be response error'),
        unknown: (_, _) => fail('Should be response error'),
      );
    });

    test('classifies cancelled request correctly', () {
      // Arrange
      final requestOptions = RequestOptions(path: '/test');
      final exception = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.cancel,
        message: 'Request cancelled',
      );

      // Act
      final result = NetworkErrorClassifier.classifyDioException(exception);

      // Assert
      expect(result, isA<DetailedCancelledError>());
      result.when(
        cancelled: (reason, isManual) {
          expect(reason, equals('Request cancelled'));
          expect(isManual, isTrue);
        },
        connection: (_, _, _) => fail('Should be cancelled error'),
        timeout: (_, _, _) => fail('Should be cancelled error'),
        response: (_, _, _, _) => fail('Should be cancelled error'),
        badRequest: (_, _, _) => fail('Should be cancelled error'),
        certificate: (_, _, _) => fail('Should be cancelled error'),
        unknown: (_, _) => fail('Should be cancelled error'),
      );
    });

    test('classifies connection error correctly', () {
      // Arrange
      final requestOptions = RequestOptions(path: '/test');
      final exception = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.connectionError,
        message: 'Connection failed',
      );

      // Act
      final result = NetworkErrorClassifier.classifyDioException(exception);

      // Assert
      expect(result, isA<DetailedConnectionError>());
      result.when(
        connection: (reason, host, port) {
          expect(reason, equals('Connection failed'));
          expect(host, equals(requestOptions.uri.host));
          expect(port, equals(requestOptions.uri.port));
        },
        timeout: (_, _, _) => fail('Should be connection error'),
        response: (_, _, _, _) => fail('Should be connection error'),
        cancelled: (_, _) => fail('Should be connection error'),
        badRequest: (_, _, _) => fail('Should be connection error'),
        certificate: (_, _, _) => fail('Should be connection error'),
        unknown: (_, _) => fail('Should be connection error'),
      );
    });

    test('classifies certificate error correctly', () {
      // Arrange
      final requestOptions = RequestOptions(path: '/test');
      final exception = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.badCertificate,
        message: 'Certificate validation failed',
      );

      // Act
      final result = NetworkErrorClassifier.classifyDioException(exception);

      // Assert
      expect(result, isA<DetailedCertificateError>());
      result.when(
        certificate: (reason, host, certError) {
          expect(reason, equals('Certificate validation failed'));
          expect(host, equals(requestOptions.uri.host));
        },
        connection: (_, _, _) => fail('Should be certificate error'),
        timeout: (_, _, _) => fail('Should be certificate error'),
        response: (_, _, _, _) => fail('Should be certificate error'),
        cancelled: (_, _) => fail('Should be certificate error'),
        badRequest: (_, _, _) => fail('Should be certificate error'),
        unknown: (_, _) => fail('Should be certificate error'),
      );
    });

    test('classifies unknown error correctly', () {
      // Arrange
      final requestOptions = RequestOptions(path: '/test');
      final exception = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.unknown,
        message: 'Unknown error',
      );

      // Act
      final result = NetworkErrorClassifier.classifyDioException(exception);

      // Assert
      expect(result, isA<DetailedUnknownError>());
      result.when(
        unknown: (reason, originalType) {
          expect(reason, equals('Unknown error'));
        },
        connection: (_, _, _) => fail('Should be unknown error'),
        timeout: (_, _, _) => fail('Should be unknown error'),
        response: (_, _, _, _) => fail('Should be unknown error'),
        cancelled: (_, _) => fail('Should be unknown error'),
        badRequest: (_, _, _) => fail('Should be unknown error'),
        certificate: (_, _, _) => fail('Should be unknown error'),
      );
    });

    test('determines retryability correctly', () {
      // Test retryable errors
      expect(
        NetworkErrorClassifier.isRetryable(
          DetailedNetworkErrorType.connection(reason: 'Failed'),
        ),
        isTrue,
      );
      expect(
        NetworkErrorClassifier.isRetryable(
          DetailedNetworkErrorType.timeout(
            timeoutDuration: Duration(seconds: 30),
            timeoutType: 'receive',
          ),
        ),
        isTrue,
      );
      expect(
        NetworkErrorClassifier.isRetryable(
          DetailedNetworkErrorType.response(
            statusCode: 503,
            statusMessage: 'Service Unavailable',
          ),
        ),
        isTrue,
      );

      // Test non-retryable errors
      expect(
        NetworkErrorClassifier.isRetryable(
          DetailedNetworkErrorType.response(
            statusCode: 400,
            statusMessage: 'Bad Request',
          ),
        ),
        isFalse,
      );
      expect(
        NetworkErrorClassifier.isRetryable(
          DetailedNetworkErrorType.certificate(reason: 'Invalid cert'),
        ),
        isFalse,
      );
      expect(
        NetworkErrorClassifier.isRetryable(
          DetailedNetworkErrorType.badRequest(reason: 'Invalid request'),
        ),
        isFalse,
      );
    });

    test('suggests appropriate retry delays', () {
      // Connection error should have 2 second delay
      final connectionDelay = NetworkErrorClassifier.getSuggestedRetryDelay(
        DetailedNetworkErrorType.connection(reason: 'Failed'),
      );
      expect(connectionDelay, equals(Duration(seconds: 2)));

      // Timeout should have 3 second delay
      final timeoutDelay = NetworkErrorClassifier.getSuggestedRetryDelay(
        DetailedNetworkErrorType.timeout(
          timeoutDuration: Duration(seconds: 30),
          timeoutType: 'receive',
        ),
      );
      expect(timeoutDelay, equals(Duration(seconds: 3)));

      // 429 error should have longer delay
      final rateLimitDelay = NetworkErrorClassifier.getSuggestedRetryDelay(
        DetailedNetworkErrorType.response(
          statusCode: 429,
          statusMessage: 'Too Many Requests',
        ),
      );
      expect(rateLimitDelay, equals(Duration(seconds: 60)));

      // Bad request should have no retry delay
      final badRequestDelay = NetworkErrorClassifier.getSuggestedRetryDelay(
        DetailedNetworkErrorType.badRequest(reason: 'Invalid'),
      );
      expect(badRequestDelay, isNull);
    });

    test('gets correct HTTP status categories', () {
      expect(
        NetworkErrorClassifier.getStatusCategory(200),
        equals(HttpStatusCategory.success),
      );
      expect(
        NetworkErrorClassifier.getStatusCategory(404),
        equals(HttpStatusCategory.clientError),
      );
      expect(
        NetworkErrorClassifier.getStatusCategory(500),
        equals(HttpStatusCategory.serverError),
      );
      expect(
        NetworkErrorClassifier.getStatusCategory(302),
        equals(HttpStatusCategory.redirection),
      );
      expect(
        NetworkErrorClassifier.getStatusCategory(100),
        equals(HttpStatusCategory.informational),
      );
      expect(
        NetworkErrorClassifier.getStatusCategory(999),
        equals(HttpStatusCategory.unknown),
      );
    });

    test('extracts comprehensive error context', () {
      // Arrange
      final requestOptions = RequestOptions(
        path: '/test',
        method: 'POST',
        headers: {'Authorization': 'Bearer token'},
      );
      final exception = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.connectionError,
        message: 'Connection failed',
      );
      final errorType = NetworkErrorClassifier.classifyDioException(exception);

      // Act
      final context = NetworkErrorClassifier.extractErrorContext(
        exception,
        errorType,
      );

      // Assert
      expect(context['error_type'], isNotNull);
      expect(
        context['dio_exception_type'],
        equals('DioExceptionType.connectionError'),
      );
      expect(context['request_method'], equals('POST'));
      expect(context['request_uri'], contains('/test'));
      expect(context['request_headers'], isNotNull);
      expect(context['connection_reason'], equals('Connection failed'));
    });
  });

  group('NetworkErrorCodes', () {
    test('returns correct error codes for each error type', () {
      expect(
        NetworkErrorCodes.getErrorCode(
          DetailedNetworkErrorType.connection(reason: 'Failed'),
        ),
        equals(NetworkErrorCodes.connectionError),
      );

      expect(
        NetworkErrorCodes.getErrorCode(
          DetailedNetworkErrorType.timeout(
            timeoutDuration: Duration(seconds: 30),
            timeoutType: 'receive',
          ),
        ),
        equals(NetworkErrorCodes.timeoutError),
      );

      expect(
        NetworkErrorCodes.getErrorCode(
          DetailedNetworkErrorType.response(
            statusCode: 500,
            statusMessage: 'Internal Server Error',
          ),
        ),
        equals(NetworkErrorCodes.responseError),
      );

      expect(
        NetworkErrorCodes.getErrorCode(
          DetailedNetworkErrorType.cancelled(reason: 'Cancelled'),
        ),
        equals(NetworkErrorCodes.cancelledError),
      );

      expect(
        NetworkErrorCodes.getErrorCode(
          DetailedNetworkErrorType.badRequest(reason: 'Bad request'),
        ),
        equals(NetworkErrorCodes.badRequestError),
      );

      expect(
        NetworkErrorCodes.getErrorCode(
          DetailedNetworkErrorType.certificate(reason: 'Cert error'),
        ),
        equals(NetworkErrorCodes.certificateError),
      );

      expect(
        NetworkErrorCodes.getErrorCode(
          DetailedNetworkErrorType.unknown(reason: 'Unknown'),
        ),
        equals(NetworkErrorCodes.unknownError),
      );
    });
  });
}
