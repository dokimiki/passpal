import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/error/error_handler.dart';
import 'package:passpal/core/error/overlay_error_widget.dart';

void main() {
  group('ErrorHandler', () {
    late GlobalKey<NavigatorState> navigatorKey;
    late ErrorHandler errorHandler;

    setUp(() {
      navigatorKey = GlobalKey<NavigatorState>();
      errorHandler = ErrorHandler(navigatorKey);
    });
    testWidgets('handles DioException and shows overlay', (tester) async {
      // Arrange
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 503,
        ),
      );
      var retryCallCount = 0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navigatorKey,
          home: const Scaffold(body: Center(child: Text('Test App'))),
        ),
      );

      // Wait for widget tree to be built
      await tester.pumpAndSettle();

      final result = errorHandler.handleNetworkError(
        dioError,
        onRetry: () => retryCallCount++,
      );

      await tester.pumpAndSettle();

      // Assert
      expect(result, isTrue);
      expect(find.byType(OverlayErrorWidget), findsOneWidget);
      expect(find.byIcon(Icons.wifi_off), findsOneWidget);
      expect(find.text('通信に失敗しました (503)。再試行しますか？'), findsOneWidget);
    });
    testWidgets('handles SocketException and shows overlay', (tester) async {
      // Arrange
      final socketError = const SocketException('Network unreachable');
      var retryCallCount = 0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navigatorKey,
          home: const Scaffold(body: Center(child: Text('Test App'))),
        ),
      );

      // Wait for widget tree to be built
      await tester.pumpAndSettle();

      final result = errorHandler.handleNetworkError(
        socketError,
        onRetry: () => retryCallCount++,
      );

      await tester.pumpAndSettle();

      // Assert
      expect(result, isTrue);
      expect(find.byType(OverlayErrorWidget), findsOneWidget);
      expect(find.text('ネットワークエラーが発生しました。再試行しますか？'), findsOneWidget);
    });
    testWidgets('does not handle non-network errors', (tester) async {
      // Arrange
      final genericError = Exception('Generic error');
      var retryCallCount = 0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navigatorKey,
          home: const Scaffold(body: Center(child: Text('Test App'))),
        ),
      );

      // Wait for widget tree to be built
      await tester.pumpAndSettle();

      final result = errorHandler.handleNetworkError(
        genericError,
        onRetry: () => retryCallCount++,
      );

      await tester.pumpAndSettle();

      // Assert
      expect(result, isFalse);
      expect(find.byType(OverlayErrorWidget), findsNothing);
    });

    testWidgets('returns false when no context available', (tester) async {
      // Arrange
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
      );

      // Act - no widget tree pumped, so no context available
      final result = errorHandler.handleNetworkError(dioError, onRetry: () {});

      // Assert
      expect(result, isFalse);
    });

    test('handleGeneralError logs error without throwing', () {
      // Arrange
      final error = Exception('Test error');
      final stackTrace = StackTrace.current;

      // Act & Assert - should not throw
      expect(
        () => errorHandler.handleGeneralError(error, stackTrace: stackTrace),
        returnsNormally,
      );
    });
  });

  group('ErrorHandlingExtension', () {
    testWidgets('extension methods work with WidgetRef', (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      final errorHandler = ErrorHandler(navigatorKey);
      final container = ProviderContainer(
        overrides: [errorHandlerProvider.overrideWithValue(errorHandler)],
      );

      late WidgetRef ref;
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
      );

      // Act
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            navigatorKey: navigatorKey,
            home: Consumer(
              builder: (context, widgetRef, child) {
                ref = widgetRef;
                return const Scaffold(body: Center(child: Text('Test App')));
              },
            ),
          ),
        ),
      );

      // Wait for widget tree to be built
      await tester.pumpAndSettle();

      final result = ref.handleNetworkError(dioError, onRetry: () {});

      await tester.pumpAndSettle();

      // Assert
      expect(result, isTrue);
      expect(find.byType(OverlayErrorWidget), findsOneWidget);

      // Test general error handling
      expect(
        () => ref.handleGeneralError(Exception('Test error')),
        returnsNormally,
      );

      // Cleanup
      container.dispose();
    });
  });
}
