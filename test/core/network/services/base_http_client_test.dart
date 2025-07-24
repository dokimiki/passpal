import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';

import 'package:passpal/core/error/providers.dart';
import 'package:passpal/core/network/models/network_request.dart';
import 'package:passpal/core/network/models/network_response.dart';
import 'package:passpal/core/network/services/base_http_client.dart';

class MockAppLogger extends Mock implements AppLogger {}

void main() {
  group('BaseHttpClient', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late BaseHttpClient client;
    late MockAppLogger mockLogger;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      mockLogger = MockAppLogger();
      client = BaseHttpClient(dio: dio, logger: mockLogger);
    });

    tearDown(() {
      dioAdapter.close();
    });

    group('execute()', () {
      test('should execute GET request successfully', () async {
        // Arrange
        const url = 'https://api.example.com/data';
        const responseData = {
          'message': 'success',
          'data': [1, 2, 3],
        };

        dioAdapter.onGet(url, (server) => server.reply(200, responseData));

        final request = NetworkRequest(method: HttpMethod.get, url: url);

        // Act
        final response = await client.execute<Map<String, dynamic>>(
          request,
          fromJson: (data) => data as Map<String, dynamic>,
        );

        // Assert
        expect(response.statusCode, equals(200));
        expect(response.data, equals(responseData));
        expect(response.isSuccess, isTrue);
        expect(response.requestUrl, equals(url));
        verify(() => mockLogger.debug('GET request to: $url')).called(1);
      });

      test('should execute POST request with body successfully', () async {
        // Arrange
        const url = 'https://api.example.com/create';
        const requestBody = {'name': 'test', 'value': 123};
        const responseData = {'id': 1, 'created': true};

        dioAdapter.onPost(
          url,
          data: requestBody,
          (server) => server.reply(201, responseData),
        );

        final request = NetworkRequest(
          method: HttpMethod.post,
          url: url,
          data: requestBody,
        );

        // Act
        final response = await client.execute<Map<String, dynamic>>(
          request,
          fromJson: (data) => data as Map<String, dynamic>,
        );

        // Assert
        expect(response.statusCode, equals(201));
        expect(response.data, equals(responseData));
        expect(response.isSuccess, isTrue);
        verify(() => mockLogger.debug('POST request to: $url')).called(1);
      });

      test('should handle HTTP error responses', () async {
        // Arrange
        const url = 'https://api.example.com/error';
        const errorResponse = {'error': 'Not found', 'code': 404};

        dioAdapter.onGet(url, (server) => server.reply(404, errorResponse));

        final request = NetworkRequest(method: HttpMethod.get, url: url);

        // Act
        final response = await client.execute<Map<String, dynamic>>(
          request,
          fromJson: (data) => data as Map<String, dynamic>,
        );

        // Assert
        expect(response.statusCode, equals(404));
        expect(response.isError, isTrue);
        expect(response.isClientError, isTrue);
        expect(response.requestUrl, equals(url));
      });

      test('should handle network timeout errors', () async {
        // Arrange
        const url = 'https://api.example.com/timeout';

        dioAdapter.onGet(
          url,
          (server) => server.throws(
            408,
            DioException.connectionTimeout(
              timeout: const Duration(seconds: 5),
              requestOptions: RequestOptions(path: url),
            ),
          ),
        );

        final request = NetworkRequest(method: HttpMethod.get, url: url);

        // Act
        final response = await client.execute<Map<String, dynamic>>(request);

        // Assert
        expect(
          response.statusCode,
          equals(0),
        ); // DioException maps to 0 when no response
        expect(response.data, isNull);
        expect(response.metadata['error'], contains('Connection timeout'));
        verify(
          () => mockLogger.error(any(that: contains('GET request failed'))),
        ).called(1);
      });

      test('should pass query parameters correctly', () async {
        // Arrange
        const baseUrl = 'https://api.example.com/search';
        const queryParams = {'q': 'flutter', 'limit': 10};
        const responseData = {'results': []};

        dioAdapter.onGet(
          baseUrl,
          queryParameters: queryParams,
          (server) => server.reply(200, responseData),
        );

        final request = NetworkRequest(
          method: HttpMethod.get,
          url: baseUrl,
          queryParameters: queryParams,
        );

        // Act
        final response = await client.execute<Map<String, dynamic>>(
          request,
          fromJson: (data) => data as Map<String, dynamic>,
        );

        // Assert
        expect(response.statusCode, equals(200));
        expect(response.data, equals(responseData));
      });

      test('should include custom headers in request', () async {
        // Arrange
        const url = 'https://api.example.com/protected';
        const headers = {
          'Authorization': 'Bearer token123',
          'Custom-Header': 'value',
        };
        const responseData = {'authenticated': true};

        dioAdapter.onGet(
          url,
          headers: headers,
          (server) => server.reply(200, responseData),
        );

        final request = NetworkRequest(
          method: HttpMethod.get,
          url: url,
          headers: headers,
        );

        // Act
        final response = await client.execute<Map<String, dynamic>>(
          request,
          fromJson: (data) => data as Map<String, dynamic>,
        );

        // Assert
        expect(response.statusCode, equals(200));
        expect(response.data, equals(responseData));
      });

      test('should handle different HTTP methods', () async {
        // Arrange
        const url = 'https://api.example.com/resource/1';
        const requestData = {'name': 'updated'};
        const responseData = {'updated': true};

        // Test PUT
        dioAdapter.onPut(
          url,
          data: requestData,
          (server) => server.reply(200, responseData),
        );

        final putRequest = NetworkRequest(
          method: HttpMethod.put,
          url: url,
          data: requestData,
        );

        // Act
        final putResponse = await client.execute<Map<String, dynamic>>(
          putRequest,
          fromJson: (data) => data as Map<String, dynamic>,
        );

        // Assert
        expect(putResponse.statusCode, equals(200));
        expect(putResponse.data, equals(responseData));
        verify(() => mockLogger.debug('PUT request to: $url')).called(1);
      });

      test('should handle JSON parsing errors gracefully', () async {
        // Arrange
        const url = 'https://api.example.com/invalid';
        const invalidJson = '{"invalid": json}'; // Invalid JSON

        dioAdapter.onGet(url, (server) => server.reply(200, invalidJson));

        final request = NetworkRequest(method: HttpMethod.get, url: url);

        // Act
        final response = await client.execute<Map<String, dynamic>>(
          request,
          fromJson: (data) {
            if (data is String && data.contains('invalid')) {
              throw const FormatException('Invalid JSON');
            }
            return data as Map<String, dynamic>;
          },
        );

        // Assert
        expect(response.statusCode, equals(200));
        expect(response.data, isNull); // Should be null due to parsing error
        verify(
          () => mockLogger.error(
            any(that: contains('Failed to parse response data')),
          ),
        ).called(1);
      });
    });

    group('interface methods', () {
      test('executeBatch should execute multiple requests', () async {
        // Arrange
        const url1 = 'https://api.example.com/data1';
        const url2 = 'https://api.example.com/data2';
        const response1 = {'data': 'first'};
        const response2 = {'data': 'second'};

        dioAdapter.onGet(url1, (server) => server.reply(200, response1));
        dioAdapter.onGet(url2, (server) => server.reply(200, response2));

        final requests = [
          const NetworkRequest(method: HttpMethod.get, url: url1),
          const NetworkRequest(method: HttpMethod.get, url: url2),
        ];

        // Act
        final responses = await client.executeBatch(requests);

        // Assert
        expect(responses, hasLength(2));
        expect(responses[0].statusCode, equals(200));
        expect(responses[1].statusCode, equals(200));
      });

      test('isReachable should check URL accessibility', () async {
        // Arrange
        const url = 'https://api.example.com/health';
        dioAdapter.onHead(url, (server) => server.reply(200, ''));

        // Act
        final isReachable = await client.isReachable(url);

        // Assert
        expect(isReachable, isTrue);
      });

      test('isReachable should return false for unreachable URL', () async {
        // Arrange
        const url = 'https://api.example.com/unreachable';
        dioAdapter.onHead(
          url,
          (server) => server.throws(
            500,
            DioException.connectionError(
              reason: 'Connection failed',
              requestOptions: RequestOptions(path: url),
            ),
          ),
        );

        // Act
        final isReachable = await client.isReachable(url);

        // Assert
        expect(isReachable, isFalse);
      });

      test('should manage global headers', () {
        // Act
        client.setGlobalHeaders({'Global-Header': 'value'});

        // Assert
        final headers = client.getGlobalHeaders();
        expect(headers['Global-Header'], equals('value'));

        // Act
        client.removeGlobalHeaders(['Global-Header']);

        // Assert
        final updatedHeaders = client.getGlobalHeaders();
        expect(updatedHeaders.containsKey('Global-Header'), isFalse);
      });
    });
  });
}
