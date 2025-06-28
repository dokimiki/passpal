import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:passpal/core/network/network.dart';
import 'package:passpal/core/config/models/api_config.dart';

void main() {
  group('Network Layer Integration', () {
    late ApiConfig testConfig;

    setUp(() {
      testConfig = const ApiConfig(
        palapiBaseUrl: 'https://api.chukyo-passpal.app/v1',
        alboBaseUrl: 'https://albo.chukyonet.jp',
        manaboBaseUrl: 'https://manabo.chukyonet.jp',
        cubicsBaseUrl: 'https://cubics.chukyonet.jp',
        ssoBaseUrl: 'https://sso.chukyonet.jp',
      );
    });

    test('should create network client factory', () {
      // Arrange & Act
      final factory = NetworkClientFactory(apiConfig: testConfig);

      // Assert
      expect(factory, isNotNull);
    });

    test('should create dio instance for each target', () {
      // Arrange
      final factory = NetworkClientFactory(apiConfig: testConfig);

      // Act & Assert
      for (final target in NetworkTarget.values) {
        final dio = factory.create(target);
        expect(dio, isA<Dio>());
        expect(dio.options.baseUrl, target.getBaseUrl(testConfig));
      }
    });

    test('should have correct interceptor chain order', () {
      // Arrange
      final factory = NetworkClientFactory(apiConfig: testConfig);

      // Act
      final dio = factory.create(NetworkTarget.albo);

      // Assert
      expect(dio.interceptors.length, greaterThan(0));

      // Check that basic interceptors are present
      final interceptorTypes = dio.interceptors
          .map((i) => i.runtimeType.toString())
          .toList();
      expect(interceptorTypes, contains('ConnectivityInterceptor'));
      expect(interceptorTypes, contains('RetryInterceptor'));
      expect(interceptorTypes, contains('MaintenanceInterceptor'));
      expect(interceptorTypes, contains('LoggingInterceptor'));
    });

    test('should configure different headers for different targets', () {
      // Arrange
      final factory = NetworkClientFactory(apiConfig: testConfig);

      // Act
      final alboClient = factory.create(NetworkTarget.albo);
      final palapiClient = factory.create(NetworkTarget.palapi);

      // Assert
      expect(
        alboClient.options.headers['Referer'],
        NetworkTarget.albo.getBaseUrl(testConfig),
      );
      expect(palapiClient.options.headers['Content-Type'], 'application/json');
    });

    test('should support custom configuration URLs', () {
      // Arrange
      final customConfig = const ApiConfig(
        palapiBaseUrl: 'https://test-api.example.com',
        alboBaseUrl: 'https://test-albo.example.com',
        manaboBaseUrl: 'https://test-manabo.example.com',
        cubicsBaseUrl: 'https://test-cubics.example.com',
        ssoBaseUrl: 'https://test-sso.example.com',
      );
      final factory = NetworkClientFactory(apiConfig: customConfig);

      // Act
      final alboClient = factory.create(NetworkTarget.albo);
      final palapiClient = factory.create(NetworkTarget.palapi);

      // Assert
      expect(alboClient.options.baseUrl, 'https://test-albo.example.com');
      expect(palapiClient.options.baseUrl, 'https://test-api.example.com');
    });
  });
}
