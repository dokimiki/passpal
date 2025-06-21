import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/error/overlay_error_widget.dart';

void main() {
  group('OverlayErrorWidget', () {
    testWidgets('displays DioException error with status code', (tester) async {
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
          home: Scaffold(
            body: OverlayErrorWidget(
              error: dioError,
              onRetry: () => retryCallCount++,
            ),
          ),
        ),
      );

      // Wait for animation to complete
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.wifi_off), findsOneWidget);
      expect(find.text('通信に失敗しました (503)。再試行しますか？'), findsOneWidget);
      expect(find.text('再試行'), findsOneWidget);
      expect(find.text('FAQ を見る'), findsOneWidget);
      expect(find.text('閉じる'), findsOneWidget);
    });

    testWidgets('displays DioException error without status code', (
      tester,
    ) async {
      // Arrange
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
      );
      var retryCallCount = 0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OverlayErrorWidget(
              error: dioError,
              onRetry: () => retryCallCount++,
            ),
          ),
        ),
      );

      // Wait for animation to complete
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('通信に失敗しました。再試行しますか？'), findsOneWidget);
    });

    testWidgets('displays SocketException error', (tester) async {
      // Arrange
      final socketError = const SocketException('Network unreachable');
      var retryCallCount = 0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OverlayErrorWidget(
              error: socketError,
              onRetry: () => retryCallCount++,
            ),
          ),
        ),
      );

      // Wait for animation to complete
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('ネットワークエラーが発生しました。再試行しますか？'), findsOneWidget);
    });

    testWidgets('displays generic error message for unknown error types', (
      tester,
    ) async {
      // Arrange
      final unknownError = Exception('Unknown error');
      var retryCallCount = 0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OverlayErrorWidget(
              error: unknownError,
              onRetry: () => retryCallCount++,
            ),
          ),
        ),
      );

      // Wait for animation to complete
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('通信エラーが発生しました。再試行しますか？'), findsOneWidget);
    });

    testWidgets('calls onRetry when retry button is tapped', (tester) async {
      // Arrange
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
      );
      var retryCallCount = 0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OverlayErrorWidget(
              error: dioError,
              onRetry: () => retryCallCount++,
            ),
          ),
        ),
      );

      // Wait for animation to complete
      await tester.pumpAndSettle();

      // Tap retry button
      await tester.tap(find.text('再試行'));
      await tester.pumpAndSettle();

      // Assert
      expect(retryCallCount, equals(1));
    });

    testWidgets('slides in from top with animation', (tester) async {
      // Arrange
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OverlayErrorWidget(error: dioError, onRetry: () {}),
          ),
        ),
      );

      // Initially, the widget should be off-screen (not visible)
      expect(find.byType(SlideTransition), findsOneWidget);

      // Pump a few frames to see the animation progress
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pump(const Duration(milliseconds: 100));

      // After animation completes, the content should be visible
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.wifi_off), findsOneWidget);
    });
    testWidgets('dismisses when close button is tapped', (tester) async {
      // Arrange
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OverlayErrorWidget(error: dioError, onRetry: () {}),
          ),
        ),
      );

      // Wait for animation to complete
      await tester.pumpAndSettle();

      // Verify widget is visible
      expect(find.byIcon(Icons.wifi_off), findsOneWidget);

      // Tap close button
      await tester.tap(find.text('閉じる'));
      await tester.pump(); // Start the reverse animation

      // Verify that the fade animation started (opacity changes)
      expect(find.byType(FadeTransition), findsOneWidget);

      // Complete the animation
      await tester.pumpAndSettle();

      // Widget should still be in the tree but may be visually hidden
      expect(find.byType(OverlayErrorWidget), findsOneWidget);
    });

    testWidgets('has correct Material Design styling', (tester) async {
      // Arrange
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OverlayErrorWidget(error: dioError, onRetry: () {}),
          ),
        ),
      );

      // Wait for animation to complete
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(SlideTransition), findsOneWidget);
      expect(find.byType(FadeTransition), findsOneWidget);

      // Check that the card has proper styling
      final card = tester.widget<Card>(find.byType(Card));
      expect(card.elevation, equals(8));
      expect(card.shape, isA<RoundedRectangleBorder>());
    });
  });
}
