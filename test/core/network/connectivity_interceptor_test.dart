import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:passpal/core/error/app_exception.dart';
import 'package:passpal/core/network/connectivity_interceptor.dart';

import 'connectivity_interceptor_test.mocks.dart';

@GenerateMocks([Connectivity, RequestInterceptorHandler])
void main() {
  group('ConnectivityInterceptor', () {
    late ConnectivityInterceptor interceptor;
    late MockConnectivity mockConnectivity;
    late MockRequestInterceptorHandler mockHandler;
    late RequestOptions requestOptions;

    setUp(() {
      mockConnectivity = MockConnectivity();
      mockHandler = MockRequestInterceptorHandler();
      interceptor = ConnectivityInterceptor(mockConnectivity);
      requestOptions = RequestOptions(path: '/test');
    });

    test('should proceed when connectivity is available', () async {
      // Arrange
      when(
        mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);

      // Act
      interceptor.onRequest(requestOptions, mockHandler);

      // Assert
      await Future.delayed(Duration.zero); // Allow async operations to complete
      verify(mockHandler.next(requestOptions)).called(1);
      verifyNever(mockHandler.reject(any));
    });

    test(
      'should reject with NetworkFailure.offline when no connectivity',
      () async {
        // Arrange
        when(
          mockConnectivity.checkConnectivity(),
        ).thenAnswer((_) async => [ConnectivityResult.none]);

        // Act
        interceptor.onRequest(requestOptions, mockHandler);

        // Assert
        await Future.delayed(
          Duration.zero,
        ); // Allow async operations to complete
        final rejectedCalls = verify(mockHandler.reject(captureAny)).captured;
        expect(rejectedCalls.length, 1);
        verifyNever(mockHandler.next(any));

        final captured = rejectedCalls.first as DioException;
        expect(captured.error, isA<NetworkFailure>());
        expect(
          (captured.error as NetworkFailure).kind,
          NetworkFailureKind.offline,
        );
      },
    );

    test('should proceed when connectivity check throws exception', () async {
      // Arrange
      when(
        mockConnectivity.checkConnectivity(),
      ).thenThrow(Exception('Connectivity check failed'));

      // Act
      interceptor.onRequest(requestOptions, mockHandler);

      // Assert
      await Future.delayed(Duration.zero); // Allow async operations to complete
      verify(mockHandler.next(requestOptions)).called(1);
      verifyNever(mockHandler.reject(any));
    });

    test('should proceed when mobile connectivity is available', () async {
      // Arrange
      when(
        mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.mobile]);

      // Act
      interceptor.onRequest(requestOptions, mockHandler);

      // Assert
      await Future.delayed(Duration.zero); // Allow async operations to complete
      verify(mockHandler.next(requestOptions)).called(1);
      verifyNever(mockHandler.reject(any));
    });
  });
}
