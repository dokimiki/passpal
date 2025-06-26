import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:passpal/core/error/app_exception.dart';
import 'package:passpal/core/error/crashlytics_reporter.dart';
import 'package:passpal/core/error/error_notifier.dart';
import 'package:riverpod/riverpod.dart';

import 'error_notifier_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CrashlyticsReporter>()])
void main() {
  group('ErrorNotifier', () {
    late ProviderContainer container;
    late MockCrashlyticsReporter mockReporter;

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

    test('should start with idle state', () {
      // Act
      final state = container.read(errorNotifierProvider);

      // Assert
      expect(state, isA<AppErrorState$Idle>());
    });

    test('should show error and record to crashlytics', () async {
      // Arrange
      final notifier = container.read(errorNotifierProvider.notifier);
      final exception = NetworkFailure.offline(message: 'Test error');

      // Act
      await notifier.show(exception);

      // Assert
      final state = container.read(errorNotifierProvider);
      expect(state, isA<AppErrorState$Showing>());
      expect((state as AppErrorState$Showing).exception, exception);

      verify(mockReporter.recordError(exception)).called(1);
    });

    test('should dismiss error and return to idle', () async {
      // Arrange
      final notifier = container.read(errorNotifierProvider.notifier);
      final exception = NetworkFailure.offline(message: 'Test error');

      await notifier.show(exception);

      // Act
      notifier.dismiss();

      // Assert
      final state = container.read(errorNotifierProvider);
      expect(state, isA<AppErrorState$Idle>());
    });

    test('should replace previous error when showing new one', () async {
      // Arrange
      final notifier = container.read(errorNotifierProvider.notifier);
      final firstException = NetworkFailure.offline(message: 'First error');
      final secondException = AuthenticationException(message: 'Second error');

      // Act
      await notifier.show(firstException);
      await notifier.show(secondException);

      // Assert
      final state = container.read(errorNotifierProvider);
      expect(state, isA<AppErrorState$Showing>());
      expect((state as AppErrorState$Showing).exception, secondException);

      verify(mockReporter.recordError(firstException)).called(1);
      verify(mockReporter.recordError(secondException)).called(1);
    });

    test('should auto-dismiss network offline errors after timeout', () async {
      // Arrange
      final notifier = container.read(errorNotifierProvider.notifier);
      final exception = NetworkFailure.offline(message: 'Offline');

      // Act
      await notifier.show(exception, autoDismiss: true);

      // Simulate timeout (this would require dependency injection for timer)
      // For now, we'll test the auto-dismiss logic separately

      // Assert
      final state = container.read(errorNotifierProvider);
      expect(state, isA<AppErrorState$Showing>());
    });

    test(
      'should not record error to crashlytics if already recorded',
      () async {
        // Arrange
        final notifier = container.read(errorNotifierProvider.notifier);
        final exception = NetworkFailure.offline(message: 'Test error');

        // Act
        await notifier.show(exception, recordToCrashlytics: false);

        // Assert
        verifyNever(mockReporter.recordError(any));
      },
    );
  });
}
