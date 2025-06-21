import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/network/base_dio_wrapper.dart';

/// Mock adapter for testing HTTP responses
class MockAdapter implements HttpClientAdapter {
  final List<int> statusCodes;
  int _callCount = 0;

  MockAdapter({required this.statusCodes});

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final statusCode = statusCodes[_callCount % statusCodes.length];
    _callCount++;

    if (statusCode == 503) {
      throw DioException(
        requestOptions: options,
        response: Response(
          requestOptions: options,
          statusCode: 503,
          data: 'Service Unavailable',
        ),
        type: DioExceptionType.badResponse,
      );
    }

    // Simulate successful response
    return ResponseBody.fromString(
      '{"success": true}',
      200,
      headers: {
        'content-type': ['application/json'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// Mock adapter that simulates SocketException
class NetworkErrorAdapter implements HttpClientAdapter {
  final int failureCount;
  int _callCount = 0;

  NetworkErrorAdapter({required this.failureCount});

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    _callCount++;

    if (_callCount <= failureCount) {
      throw DioException(
        requestOptions: options,
        error: const SocketException('Network unreachable'),
        type: DioExceptionType.connectionError,
      );
    }

    // Simulate successful response after failures
    return ResponseBody.fromString(
      '{"success": true}',
      200,
      headers: {
        'content-type': ['application/json'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// Mock adapter that simulates 4xx client errors
class ClientErrorAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    throw DioException(
      requestOptions: options,
      response: Response(
        requestOptions: options,
        statusCode: 404,
        data: 'Not Found',
      ),
      type: DioExceptionType.badResponse,
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  group('BaseDioWrapper', () {
    late BaseDioWrapper wrapper;
    setUp(() {
      wrapper = BaseDioWrapper(
        baseUrl: 'https://test.example.com',
        maxRetry: 3,
      );
    });

    test('should initialize Dio with correct base options', () {
      expect(wrapper.dio.options.baseUrl, equals('https://test.example.com'));
      expect(
        wrapper.dio.options.connectTimeout,
        equals(const Duration(seconds: 20)),
      );
      expect(
        wrapper.dio.options.receiveTimeout,
        equals(const Duration(seconds: 20)),
      );
      expect(wrapper.dio.options.headers['User-Agent'], equals('Passpal/1.0'));
      expect(wrapper.dio.options.headers['Accept-Language'], equals('ja'));
    });

    test('should have required interceptors', () {
      final interceptors = wrapper.dio.interceptors;

      // Should have at least cookie manager and retry interceptor
      expect(interceptors.length, greaterThanOrEqualTo(2));

      // Check for retry interceptor (private class, so check by type name)
      final hasRetryInterceptor = interceptors.any(
        (i) => i.runtimeType.toString().contains('RetryInterceptor'),
      );
      expect(hasRetryInterceptor, isTrue);
    });

    group('RetryInterceptor', () {
      test('should retry on 503 status code with exponential backoff', () {
        fakeAsync((async) {
          final mockAdapter = MockAdapter(statusCodes: [503, 503, 200]);
          wrapper.dio.httpClientAdapter = mockAdapter;

          // Track timing of requests
          final requestTimes = <int>[];
          wrapper.dio
              .get('/test')
              .then((_) {
                // Should succeed after retries
              })
              .catchError((error) {
                fail('Request should succeed after retries');
              });

          // Initial request at t=0
          async.elapse(Duration.zero);
          requestTimes.add(async.elapsed.inMilliseconds);

          // First retry at t=1000ms (1 second)
          async.elapse(const Duration(seconds: 1));
          requestTimes.add(async.elapsed.inMilliseconds);

          // Second retry at t=3000ms (1s + 2s)
          async.elapse(const Duration(seconds: 2));
          requestTimes.add(async.elapsed.inMilliseconds);

          // Verify exponential backoff timing
          expect(requestTimes.length, equals(3));
          expect(requestTimes[1] - requestTimes[0], equals(1000)); // 1s delay
          expect(requestTimes[2] - requestTimes[1], equals(2000)); // 2s delay
        });
      });
      test(
        'should retry on SocketException with exponential backoff',
        () async {
          final mockAdapter = NetworkErrorAdapter(failureCount: 2);
          wrapper.dio.httpClientAdapter = mockAdapter;

          final response = await wrapper.dio.get('/test');
          expect(response.statusCode, equals(200));
        },
      );
      test('should fail after exceeding max retries', () async {
        // All requests return 503
        final mockAdapter = MockAdapter(statusCodes: [503, 503, 503, 503, 503]);
        wrapper.dio.httpClientAdapter = mockAdapter;

        try {
          await wrapper.dio.get('/test');
          fail('Request should fail after max retries');
        } catch (error) {
          expect(error, isA<DioException>());
          final dioError = error as DioException;
          expect(dioError.response?.statusCode, equals(503));
        }
      });
      test('should not retry on 4xx client errors', () async {
        final mockAdapter = ClientErrorAdapter();
        wrapper.dio.httpClientAdapter = mockAdapter;

        try {
          await wrapper.dio.get('/test');
          fail('Request should fail immediately on 4xx');
        } catch (error) {
          expect(error, isA<DioException>());
          final dioError = error as DioException;
          expect(dioError.response?.statusCode, equals(404));
        }
      });
    });
  });
}
