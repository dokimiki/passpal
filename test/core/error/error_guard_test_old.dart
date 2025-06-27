import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:passpal/core/error/app_exception.dart';
import 'package:passpal/core/error/crashlytics_reporter.dart';
import 'package:passpal/core/error/error_guard.dart';
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

    test('should handle AppException correctly', () async {
      // Arrange
      final exception = NetworkFailure.offline(message: 'Test error');

      // Act & Assert
      expect(
        () => ErrorGuard.runGuarded(container, () => Future.error(exception)),
        throwsA(isA<NetworkFailure>()),
      );
    });

    test('should handle Flutter errors', () {
      // Arrange
      final flutterError = FlutterErrorDetails(
        exception: Exception('Flutter error'),
        library: 'test',
      );

      // Act & Assert
      expect(
        () => ErrorGuard.handleFlutterError(container, flutterError),
        returnsNormally,
      );
    });

    test('should initialize correctly', () {
      // Act & Assert
      expect(() => ErrorGuard.initialize(container), returnsNormally);
    });
  });
}
