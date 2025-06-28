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

      // Setup mock behavior
      when(mockReporter.recordError(any)).thenAnswer((_) async {
        return;
      });

      container = ProviderContainer(
        overrides: [
          crashlyticsReporterProvider.overrideWithValue(mockReporter),
          errorNotifierProvider.overrideWith(() => _TestErrorNotifier()),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('should handle AppException correctly', () async {
      // Arrange
      final exception = NetworkFailure.offline(message: 'Test error');

      // Act - Test error handling directly through zone error handler
      ErrorGuard.handleZoneError(container, exception, StackTrace.current);

      // Give time for async operations to complete
      await Future.delayed(Duration(milliseconds: 50));

      // Assert
      verify(mockReporter.recordError(any)).called(1);
    });

    test('should handle Flutter errors', () async {
      // Arrange
      final flutterError = FlutterErrorDetails(
        exception: Exception('Flutter error'),
        library: 'test',
      );

      // Act
      ErrorGuard.handleFlutterError(container, flutterError);

      // Give time for async operations to complete
      await Future.delayed(Duration(milliseconds: 50));

      // Assert
      verify(mockReporter.recordError(any)).called(1);
    });

    test('should initialize correctly', () {
      // Act & Assert
      expect(() => ErrorGuard.initialize(container), returnsNormally);
    });
  });
}

/// Test implementation of ErrorNotifier
class _TestErrorNotifier extends ErrorNotifier {
  @override
  AppErrorState build() {
    return const AppErrorState$Idle();
  }

  @override
  Future<void> show(
    AppException exception, {
    bool recordToCrashlytics = true,
    bool autoDismiss = false,
  }) async {
    // Test implementation - just update state without actual Crashlytics call
    state = AppErrorState$Showing(
      exception: exception,
      showTime: DateTime.now(),
    );
  }
}
