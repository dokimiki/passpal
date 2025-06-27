import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:passpal/core/error/app_exception.dart';
import 'package:passpal/core/error/crashlytics_reporter.dart';

import 'crashlytics_reporter_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FirebaseCrashlytics>()])
void main() {
  group('CrashlyticsReporter', () {
    late MockFirebaseCrashlytics mockCrashlytics;
    late CrashlyticsReporter reporter;

    setUp(() {
      mockCrashlytics = MockFirebaseCrashlytics();
      reporter = CrashlyticsReporter(mockCrashlytics);
    });

    test('should record network failure with correct parameters', () async {
      // Arrange
      final exception = NetworkFailure.offline(
        message: 'No internet connection',
      );

      // Act
      await reporter.recordError(exception);

      // Assert
      verify(
        mockCrashlytics.setCustomKey(
          'exception_type',
          '_NetworkFailureOffline',
        ),
      ).called(1);
      verify(
        mockCrashlytics.recordError(exception, null, fatal: false),
      ).called(1);
    });

    test('should record authentication exception as non-fatal', () async {
      // Arrange
      final exception = AuthenticationException(
        message: 'Authentication failed',
      );

      // Act
      await reporter.recordError(exception);

      // Assert
      verify(
        mockCrashlytics.setCustomKey(
          'exception_type',
          'AuthenticationException',
        ),
      ).called(1);
      verify(
        mockCrashlytics.setCustomKey('message', 'Authentication failed'),
      ).called(1);
      verify(
        mockCrashlytics.recordError(exception, null, fatal: false),
      ).called(1);
    });

    test('should record parse failure with source information', () async {
      // Arrange
      final exception = ParseFailure(
        message: 'Failed to parse HTML',
        source: '<html>invalid</html>',
      );

      // Act
      await reporter.recordError(exception);

      // Assert
      verify(
        mockCrashlytics.setCustomKey('exception_type', 'ParseFailure'),
      ).called(1);
      verify(mockCrashlytics.setCustomKey('source_length', '20')).called(1);
      verify(
        mockCrashlytics.recordError(exception, null, fatal: false),
      ).called(1);
    });

    test('should record unknown exception as fatal', () async {
      // Arrange
      final exception = UnknownException(
        message: 'Unexpected error',
        originalException: Exception('Original'),
      );

      // Act
      await reporter.recordError(exception);

      // Assert
      verify(
        mockCrashlytics.setCustomKey('exception_type', 'UnknownException'),
      ).called(1);
      verify(
        mockCrashlytics.recordError(exception, null, fatal: true),
      ).called(1);
    });

    test('should set user context before recording', () async {
      // Arrange
      final exception = NetworkFailure.offline(message: 'Test');
      const userId = 'user123';

      // Act
      await reporter.setUserContext(userId: userId);
      await reporter.recordError(exception);

      // Assert
      verify(mockCrashlytics.setUserIdentifier(userId)).called(1);
    });

    test('should handle crashlytics errors gracefully', () async {
      // Arrange
      final exception = NetworkFailure.offline(message: 'Test');
      when(
        mockCrashlytics.recordError(any, any, fatal: anyNamed('fatal')),
      ).thenThrow(Exception('Crashlytics error'));

      // Act & Assert - should not throw
      expect(
        () async => await reporter.recordError(exception),
        returnsNormally,
      );
    });
  });
}
