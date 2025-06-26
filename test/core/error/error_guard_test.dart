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

    test('should handle zone errors correctly', () async {
      // Arrange
      final exception = NetworkFailure.offline(message: 'Zone error');

      // Act
      ErrorGuard.handleZoneError(container, exception, StackTrace.current);

      // Allow async operations to complete
      await Future.delayed(Duration.zero);

      // Assert
      verify(mockReporter.recordError(exception)).called(1);

      // Check that error was shown in UI
      final errorState = container.read(errorNotifierProvider);
      expect(errorState, isA<AppErrorState$Showing>());

      final showingState = errorState as AppErrorState$Showing;
      expect(showingState.exception, equals(exception));
    });

    test(
      'should handle non-AppException by wrapping in UnknownException',
      () async {
        // Arrange
        final originalException = Exception('Regular exception');

        // Act
        ErrorGuard.handleZoneError(
          container,
          originalException,
          StackTrace.current,
        );

        // Allow async operations to complete
        await Future.delayed(Duration.zero);

        // Assert
        verify(
          mockReporter.recordError(argThat(isA<UnknownException>())),
        ).called(1);

        // Check that wrapped error was shown in UI
        final errorState = container.read(errorNotifierProvider);
        expect(errorState, isA<AppErrorState$Showing>());

        final showingState = errorState as AppErrorState$Showing;
        expect(showingState.exception, isA<UnknownException>());
      },
    );

    test('should handle flutter framework errors', () async {
      // Arrange
      final flutterError = FlutterErrorDetails(
        exception: Exception('Flutter error'),
        library: 'test',
      );

      // Act
      ErrorGuard.handleFlutterError(container, flutterError);

      // Allow async operations to complete
      await Future.delayed(Duration.zero);

      // Assert
      verify(
        mockReporter.recordError(argThat(isA<UnknownException>())),
      ).called(1);
    });

    test('should not show UI error for background exceptions', () async {
      // Arrange
      final exception = ParseFailure(
        message: 'Background parse error',
        source: 'background_task',
      );

      // Act
      ErrorGuard.handleZoneError(
        container,
        exception,
        StackTrace.current,
        isBackground: true,
      );

      // Allow async operations to complete
      await Future.delayed(Duration.zero);

      // Assert
      verify(mockReporter.recordError(exception)).called(1);

      // Verify that ErrorNotifier.show was not called by checking the state
      final errorState = container.read(errorNotifierProvider);
      expect(errorState, isA<AppErrorState$Idle>());
    });

    test('should handle fatal exceptions correctly', () async {
      // Arrange
      final exception = UnknownException(
        message: 'Fatal error',
        originalException: Exception('Critical failure'),
      );

      // Act
      ErrorGuard.handleZoneError(container, exception, StackTrace.current);

      // Allow async operations to complete
      await Future.delayed(Duration.zero);

      // Assert
      verify(mockReporter.recordError(exception)).called(1);

      // Check that fatal error was shown in UI
      final errorState = container.read(errorNotifierProvider);
      expect(errorState, isA<AppErrorState$Showing>());

      final showingState = errorState as AppErrorState$Showing;
      expect(showingState.exception.isFatal, isTrue);
    });

    test('should initialize error handlers correctly', () {
      // Act
      ErrorGuard.initialize(container);

      // Assert - Verify that error handlers are set
      expect(FlutterError.onError, isNotNull);
      expect(PlatformDispatcher.instance.onError, isNotNull);
    });

    test('should handle platform errors correctly', () async {
      // Arrange
      final error = Exception('Platform error');
      final stack = StackTrace.current;

      // Act
      final result = ErrorGuard.handlePlatformError(container, error, stack);

      // Allow async operations to complete
      await Future.delayed(Duration.zero);

      // Assert
      expect(result, isTrue);
      verify(
        mockReporter.recordError(argThat(isA<UnknownException>())),
      ).called(1);
    });

    test(
      'should convert various error types to appropriate AppExceptions',
      () async {
        // Test String error
        ErrorGuard.handleZoneError(
          container,
          'String error',
          StackTrace.current,
        );
        await Future.delayed(Duration.zero);
        verify(
          mockReporter.recordError(argThat(isA<UnknownException>())),
        ).called(1);

        reset(mockReporter);

        // Test generic Exception
        ErrorGuard.handleZoneError(
          container,
          Exception('Generic exception'),
          StackTrace.current,
        );
        await Future.delayed(Duration.zero);
        verify(
          mockReporter.recordError(argThat(isA<UnknownException>())),
        ).called(1);

        reset(mockReporter);

        // Test AppException (should pass through)
        final appException = AuthenticationException(message: 'Auth error');
        ErrorGuard.handleZoneError(container, appException, StackTrace.current);
        await Future.delayed(Duration.zero);
        verify(mockReporter.recordError(appException)).called(1);
      },
    );
  });
}
