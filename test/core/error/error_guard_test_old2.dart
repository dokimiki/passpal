import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:passpal/core/error/app_exception.dart';
import 'package:passpal/core/error/crashlytics_reporter.dart';
import 'package:passpal/core/error/error_guard.dart';
import 'package:passpal/core/error/error_notifier.dart';
import 'package:riverpod/riverpod.dart';

import 'error_guard_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CrashlyticsReporter>()])
void main() {
  group('ErrorGuard', () {
    late MockCrashlyticsReporter mockReporter;
    late ProviderContainer container;

    setUp(() {
      mockReporter = MockCrashlyticsReporter();

      container = ProviderContainer(
        overrides: [
          crashlyticsReporterProvider.overrideWithValue(mockReporter),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('should catch and handle AppException in runGuarded', () async {
      // Arrange
      final completer = Completer<void>();
      final exception = NetworkFailure.offline(message: 'Zone error');

      // Act
      ErrorGuard.runGuarded(container, () {
        throw exception;
      }, onError: (_) => completer.complete());

      await completer.future;

      // Assert
      verify(mockReporter.recordError(exception)).called(1);
    });

    test(
      'should handle non-AppException by wrapping in UnknownException',
      () async {
        // Arrange
        final completer = Completer<void>();
        final originalException = Exception('Regular exception');

        // Act
        ErrorGuard.runGuarded(container, () {
          throw originalException;
        }, onError: (_) => completer.complete());

        await completer.future;

        // Assert
        verify(
          mockReporter.recordError(argThat(isA<UnknownException>())),
        ).called(1);
      },
    );

    test('should handle flutter framework errors', () async {
      // Arrange
      final completer = Completer<void>();
      final flutterError = FlutterErrorDetails(
        exception: Exception('Flutter error'),
        library: 'test',
      );

      // Act
      ErrorGuard.runGuarded(container, () async {
        FlutterError.onError!(flutterError);
        return Future.value(null);
      }, onError: (_) => completer.complete());

      await completer.future;

      // Assert
      verify(
        mockReporter.recordError(argThat(isA<UnknownException>())),
      ).called(1);
    });

    test('should not show UI error for background exceptions', () async {
      // Arrange
      final completer = Completer<void>();
      final exception = ParseFailure(
        message: 'Background parse error',
        source: 'background_task',
      );

      // Act
      ErrorGuard.runGuarded(
        container,
        () {
          throw exception;
        },
        isBackground: true,
        onError: (_) => completer.complete(),
      );

      await completer.future;

      // Assert
      verify(mockReporter.recordError(exception)).called(1);
      // Verify that ErrorNotifier.show was not called by checking the state
      container.read(errorNotifierProvider.notifier);
      final errorState = container.read(errorNotifierProvider);
      expect(errorState, isA<AppErrorState$Idle>());
    });

    test('should handle fatal exceptions differently', () async {
      // Arrange
      final completer = Completer<void>();
      final exception = UnknownException(
        message: 'Fatal error',
        originalException: Exception('Critical failure'),
      );

      // Act
      ErrorGuard.runGuarded(container, () {
        throw exception;
      }, onError: (_) => completer.complete());

      await completer.future;

      // Assert
      verify(mockReporter.recordError(exception)).called(1);
    });

    test('should initialize error handlers correctly', () {
      // Act
      ErrorGuard.initialize(container);

      // Assert - Verify that error handlers are set
      expect(FlutterError.onError, isNotNull);
      expect(PlatformDispatcher.instance.onError, isNotNull);
    });

    test('should handle errors from async operations', () async {
      // Arrange
      final exception = NetworkFailure.server(message: 'Async error');

      // Act & Assert
      await expectLater(
        () => ErrorGuard.runGuarded(container, () => Future.error(exception)),
        throwsA(isA<NetworkFailure>()),
      );

      verify(mockReporter.recordError(exception)).called(1);
    });
  });
}
