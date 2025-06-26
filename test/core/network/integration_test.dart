import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:passpal/core/network/network.dart';

void main() {
  group('Network Layer Integration', () {
    test('should create network client factory', () {
      // Arrange & Act
      final factory = NetworkClientFactory();
      
      // Assert
      expect(factory, isNotNull);
    });

    test('should create dio instance for each target', () {
      // Arrange
      final factory = NetworkClientFactory();
      
      // Act & Assert
      for (final target in NetworkTarget.values) {
        final dio = factory.create(target);
        expect(dio, isA<Dio>());
        expect(dio.options.baseUrl, target.baseUrl);
      }
    });

    test('should have correct interceptor chain order', () {
      // Arrange
      final factory = NetworkClientFactory();
      
      // Act
      final dio = factory.create(NetworkTarget.albo);
      
      // Assert
      expect(dio.interceptors.length, greaterThan(0));
      
      // Check that basic interceptors are present
      final interceptorTypes = dio.interceptors.map((i) => i.runtimeType.toString()).toList();
      expect(interceptorTypes, contains('ConnectivityInterceptor'));
      expect(interceptorTypes, contains('RetryInterceptor'));
      expect(interceptorTypes, contains('MaintenanceInterceptor'));
      expect(interceptorTypes, contains('LoggingInterceptor'));
    });

    test('should configure different headers for different targets', () {
      // Arrange
      final factory = NetworkClientFactory();
      
      // Act
      final alboClient = factory.create(NetworkTarget.albo);
      final palapiClient = factory.create(NetworkTarget.palapi);
      
      // Assert
      expect(alboClient.options.headers['Referer'], NetworkTarget.albo.baseUrl);
      expect(palapiClient.options.headers['Content-Type'], 'application/json');
    });
  });
}
