import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/network/models/network_request.dart';
import 'package:passpal/core/network/models/cache_strategy.dart';

void main() {
  group('HttpMethod', () {
    test('should have all expected values', () {
      expect(HttpMethod.values, hasLength(7));
      expect(HttpMethod.values, contains(HttpMethod.get));
      expect(HttpMethod.values, contains(HttpMethod.post));
      expect(HttpMethod.values, contains(HttpMethod.put));
      expect(HttpMethod.values, contains(HttpMethod.patch));
      expect(HttpMethod.values, contains(HttpMethod.delete));
      expect(HttpMethod.values, contains(HttpMethod.head));
      expect(HttpMethod.values, contains(HttpMethod.options));
    });
  });

  group('NetworkRequest', () {
    test('should create instance with required fields', () {
      const request = NetworkRequest(
        method: HttpMethod.get,
        url: 'https://example.com',
      );

      expect(request.method, equals(HttpMethod.get));
      expect(request.url, equals('https://example.com'));
      expect(request.headers, isEmpty);
      expect(request.queryParameters, isEmpty);
      expect(request.data, isNull);
      expect(request.cacheStrategy, equals(CacheStrategy.networkFirst));
      expect(request.followRedirects, isTrue);
      expect(request.maxRedirects, equals(5));
      expect(request.validateStatus, isTrue);
      expect(request.metadata, isEmpty);
    });

    test('should create instance with all fields', () {
      final request = NetworkRequest(
        method: HttpMethod.post,
        url: 'https://api.example.com/users',
        headers: const {'Authorization': 'Bearer token'},
        queryParameters: const {'page': 1},
        data: const {'name': 'John'},
        cacheStrategy: CacheStrategy.cacheFirst,
        timeoutMs: 5000,
        followRedirects: false,
        maxRedirects: 3,
        contentType: 'application/json',
        validateStatus: false,
        tag: 'create-user',
        metadata: const {'requestId': '123'},
      );

      expect(request.method, equals(HttpMethod.post));
      expect(request.url, equals('https://api.example.com/users'));
      expect(request.headers, equals({'Authorization': 'Bearer token'}));
      expect(request.queryParameters, equals({'page': 1}));
      expect(request.data, equals({'name': 'John'}));
      expect(request.cacheStrategy, equals(CacheStrategy.cacheFirst));
      expect(request.timeoutMs, equals(5000));
      expect(request.followRedirects, isFalse);
      expect(request.maxRedirects, equals(3));
      expect(request.contentType, equals('application/json'));
      expect(request.validateStatus, isFalse);
      expect(request.tag, equals('create-user'));
      expect(request.metadata, equals({'requestId': '123'}));
    });

    group('hasBody', () {
      test('should return false when data is null', () {
        const request = NetworkRequest(
          method: HttpMethod.get,
          url: 'https://example.com',
        );
        expect(request.hasBody, isFalse);
      });

      test('should return true when data is provided', () {
        const request = NetworkRequest(
          method: HttpMethod.post,
          url: 'https://example.com',
          data: {'key': 'value'},
        );
        expect(request.hasBody, isTrue);
      });
    });

    group('supportsCaching', () {
      test('should return true for GET requests', () {
        const request = NetworkRequest(
          method: HttpMethod.get,
          url: 'https://example.com',
        );
        expect(request.supportsCaching, isTrue);
      });

      test('should return false for non-GET requests', () {
        const postRequest = NetworkRequest(
          method: HttpMethod.post,
          url: 'https://example.com',
        );
        expect(postRequest.supportsCaching, isFalse);

        const putRequest = NetworkRequest(
          method: HttpMethod.put,
          url: 'https://example.com',
        );
        expect(putRequest.supportsCaching, isFalse);
      });
    });

    group('effectiveCacheStrategy', () {
      test('should return noCache for non-cacheable requests', () {
        const request = NetworkRequest(
          method: HttpMethod.post,
          url: 'https://example.com',
          cacheStrategy: CacheStrategy.cacheFirst,
        );
        expect(request.effectiveCacheStrategy, equals(CacheStrategy.noCache));
      });

      test('should return original strategy for cacheable requests', () {
        const request = NetworkRequest(
          method: HttpMethod.get,
          url: 'https://example.com',
          cacheStrategy: CacheStrategy.cacheFirst,
        );
        expect(
          request.effectiveCacheStrategy,
          equals(CacheStrategy.cacheFirst),
        );
      });
    });

    group('withHeaders', () {
      test('should add headers to existing ones', () {
        const originalRequest = NetworkRequest(
          method: HttpMethod.get,
          url: 'https://example.com',
          headers: {'Content-Type': 'application/json'},
        );

        final updatedRequest = originalRequest.withHeaders({
          'Authorization': 'Bearer token',
          'X-Custom': 'value',
        });

        expect(
          updatedRequest.headers,
          equals({
            'Content-Type': 'application/json',
            'Authorization': 'Bearer token',
            'X-Custom': 'value',
          }),
        );
      });

      test('should override existing headers', () {
        const originalRequest = NetworkRequest(
          method: HttpMethod.get,
          url: 'https://example.com',
          headers: {'Content-Type': 'application/json'},
        );

        final updatedRequest = originalRequest.withHeaders({
          'Content-Type': 'text/plain',
        });

        expect(updatedRequest.headers, equals({'Content-Type': 'text/plain'}));
      });
    });

    group('withQueryParameters', () {
      test('should add query parameters to existing ones', () {
        const originalRequest = NetworkRequest(
          method: HttpMethod.get,
          url: 'https://example.com',
          queryParameters: {'page': 1},
        );

        final updatedRequest = originalRequest.withQueryParameters({
          'limit': 10,
          'sort': 'name',
        });

        expect(
          updatedRequest.queryParameters,
          equals({'page': 1, 'limit': 10, 'sort': 'name'}),
        );
      });
    });

    group('withAuth', () {
      test('should add Bearer token by default', () {
        const originalRequest = NetworkRequest(
          method: HttpMethod.get,
          url: 'https://example.com',
        );

        final updatedRequest = originalRequest.withAuth('my-token');

        expect(
          updatedRequest.headers,
          equals({'Authorization': 'Bearer my-token'}),
        );
      });

      test('should use custom scheme', () {
        const originalRequest = NetworkRequest(
          method: HttpMethod.get,
          url: 'https://example.com',
        );

        final updatedRequest = originalRequest.withAuth(
          'my-token',
          scheme: 'Custom',
        );

        expect(
          updatedRequest.headers,
          equals({'Authorization': 'Custom my-token'}),
        );
      });
    });

    group('withContentType', () {
      test('should add content type header', () {
        const originalRequest = NetworkRequest(
          method: HttpMethod.post,
          url: 'https://example.com',
        );

        final updatedRequest = originalRequest.withContentType(
          'application/xml',
        );

        expect(
          updatedRequest.headers,
          equals({'Content-Type': 'application/xml'}),
        );
      });
    });
  });
}
