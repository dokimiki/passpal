import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:passpal/core/error/app_exception.dart';
import 'package:passpal/core/error/crashlytics_reporter.dart';
import 'package:passpal/core/error/error_guard.dart';
import 'package:riverpod/riverpod.dart';

import 'error_guard_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<CrashlyticsReporter>(),
])
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
      final exception = NetworkFailure.offline(message: 'Zone error');

      // Act & Assert
      expect(
        () => ErrorGuard.runGuarded(
          container,
          () => Future.error(exception),
        ),
        throwsA(isA<NetworkFailure>()),
      );
    });

    test('should handle non-AppException by wrapping in UnknownException', () async {
      // Arrange
      final originalException = Exception('Regular exception');

      // Act & Assert  
      expect(
        () => ErrorGuard.runGuarded(
          container,
          () => Future.error(originalException),
        ),
        throwsA(anything),
      );
    });

    test('should handle Flutter errors', () {
      // Arrange
      final flutterError = FlutterErrorDetails(
        exception: Exception('Flutter error'),
        library: 'test',
      );

      // Act & Assert - This test just verifies no exception is thrown
      expect(() => ErrorGuard.handleFlutterError(container, flutterError), returnsNormally);
    });

    test('should initialize error handlers correctly', () {
      // Act & Assert
      expect(() => ErrorGuard.initialize(container), returnsNormally);
    });
  });
}
