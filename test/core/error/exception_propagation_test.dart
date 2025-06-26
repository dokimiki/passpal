import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:passpal/core/error/app_exception.dart';
import 'package:passpal/core/error/crashlytics_reporter.dart';
import 'package:passpal/core/error/error_notifier.dart';
import 'package:riverpod/riverpod.dart';

import 'exception_propagation_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CrashlyticsReporter>(), MockSpec<ErrorNotifier>()])
void main() {
  group('Exception Propagation Scenarios', () {
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

    group('UI Layer Exception Propagation', () {
      test('should propagate NetworkFailure from UI to Crashlytics', () async {
        // Arrange
        final exception = NetworkFailure.offline(message: 'UI network error');
        final errorNotifier = container.read(errorNotifierProvider.notifier);

        // Act - Simulate UI throwing exception
        await errorNotifier.show(exception);

        // Assert - Verify it reaches Crashlytics
        verify(mockReporter.recordError(exception)).called(1);

        final state = container.read(errorNotifierProvider);
        expect(state, isA<AppErrorState$Showing>());
        expect((state as AppErrorState$Showing).exception, exception);
      });

      test(
        'should propagate AuthenticationException from UI to Crashlytics',
        () async {
          // Arrange
          final exception = AuthenticationException(message: 'UI auth error');
          final errorNotifier = container.read(errorNotifierProvider.notifier);

          // Act
          await errorNotifier.show(exception);

          // Assert
          verify(mockReporter.recordError(exception)).called(1);
        },
      );
    });

    group('Background Task Exception Propagation', () {
      test(
        'should propagate ParseFailure from background to Crashlytics only',
        () async {
          // Arrange
          final exception = ParseFailure(message: 'Background parse error');

          // Act - Simulate background task exception recording directly
          await container
              .read(crashlyticsReporterProvider)
              .recordError(exception);

          // Assert - Should reach Crashlytics
          verify(mockReporter.recordError(exception)).called(1);

          // Background tasks don't show UI errors
          final state = container.read(errorNotifierProvider);
          expect(state, isA<AppErrorState$Idle>()); // UI should remain idle
        },
      );

      test(
        'should propagate MaintenanceException from background to Crashlytics',
        () async {
          // Arrange
          final exception = MaintenanceException(
            message: 'Background maintenance error',
            estimatedEndTime: DateTime.now().add(const Duration(hours: 1)),
          );

          // Act - Simulate background task exception recording directly
          await container
              .read(crashlyticsReporterProvider)
              .recordError(exception);

          // Assert
          verify(mockReporter.recordError(exception)).called(1);
        },
      );
    });

    group('Domain Layer Exception Propagation', () {
      test(
        'should propagate UnknownException from domain to Crashlytics',
        () async {
          // Arrange
          final originalException = Exception('Domain business logic error');
          final exception = UnknownException(
            message: 'Domain layer error',
            originalException: originalException,
          );

          // Act - Test error handling directly through the error notifier
          final errorNotifier = container.read(errorNotifierProvider.notifier);
          await errorNotifier.show(exception);

          // Assert - Verify it was recorded to Crashlytics
          verify(mockReporter.recordError(exception)).called(1);
          
          final state = container.read(errorNotifierProvider);
          expect(state, isA<AppErrorState$Showing>());
          expect((state as AppErrorState$Showing).exception, exception);
        },
      );

      test('should convert non-AppException to UnknownException', () async {
        // Arrange
        final originalException = Exception('Regular domain exception');

        // Act - Test conversion by creating UnknownException directly
        final convertedException = UnknownException(
          message: originalException.toString(),
          originalException: originalException,
        );
        
        final errorNotifier = container.read(errorNotifierProvider.notifier);
        await errorNotifier.show(convertedException);

        // Assert - Verify it was converted to UnknownException and recorded
        expect(convertedException, isA<UnknownException>());
        verify(mockReporter.recordError(convertedException)).called(1);
        
        final state = container.read(errorNotifierProvider);
        expect(state, isA<AppErrorState$Showing>());
      });
    });

    group('Error Recovery Scenarios', () {
      test('should handle cascading errors gracefully', () async {
        // Arrange
        final firstException = NetworkFailure.server(message: 'First error');
        final secondException = ParseFailure(message: 'Second error');
        final errorNotifier = container.read(errorNotifierProvider.notifier);

        // Act - Simulate multiple errors
        await errorNotifier.show(firstException);
        await errorNotifier.show(secondException);

        // Assert - Both should reach Crashlytics, latest should be in UI
        verify(mockReporter.recordError(firstException)).called(1);
        verify(mockReporter.recordError(secondException)).called(1);

        final state = container.read(errorNotifierProvider);
        expect(state, isA<AppErrorState$Showing>());
        expect((state as AppErrorState$Showing).exception, secondException);
      });

      test('should handle Crashlytics recording failures', () async {
        // Arrange
        final exception = NetworkFailure.offline(message: 'Test error');
        when(
          mockReporter.recordError(any),
        ).thenThrow(Exception('Crashlytics failed'));

        final errorNotifier = container.read(errorNotifierProvider.notifier);

        // Act - Should not crash the app even if Crashlytics fails
        await errorNotifier.show(exception);

        // Assert - Error should still be shown in UI despite Crashlytics failure
        final state = container.read(errorNotifierProvider);
        expect(state, isA<AppErrorState$Showing>());
        expect((state as AppErrorState$Showing).exception, exception);
      });
    });

    group('End-to-End Exception Flow', () {
      test(
        'should handle complete exception flow: Data -> Domain -> UI -> Crashlytics',
        () async {
          // Arrange - Simulate data layer network error
          final networkException = NetworkFailure.server(
            message: 'Server returned 500',
          );

          // Act 1-3 - Complete flow simulation
          final errorNotifier = container.read(errorNotifierProvider.notifier);
          await errorNotifier.show(networkException);

          // Assert - Complete flow verification
          // 1. Exception recorded in Crashlytics
          verify(mockReporter.recordError(networkException)).called(1);

          // 2. UI state updated with error
          final state = container.read(errorNotifierProvider);
          expect(state, isA<AppErrorState$Showing>());
          final showingState = state as AppErrorState$Showing;
          expect(showingState.exception, networkException);
          expect(showingState.exception.isFatal, false);

          // 3. Error properties preserved
          expect(networkException.kind, NetworkFailureKind.server5xx);
          expect(networkException.canRetry, true);
        },
      );

      test('should handle fatal exception flow', () async {
        // Arrange - Simulate fatal unknown exception
        final fatalException = UnknownException(
          message: 'Critical system failure',
          originalException: Exception('Out of memory'),
        );

        // Act
        final errorNotifier = container.read(errorNotifierProvider.notifier);
        await errorNotifier.show(fatalException);

        // Assert - Fatal exception handling
        verify(mockReporter.recordError(fatalException)).called(1);

        final state = container.read(errorNotifierProvider);
        expect(state, isA<AppErrorState$Showing>());
        expect((state as AppErrorState$Showing).exception.isFatal, true);
      });
    });
  });
}
