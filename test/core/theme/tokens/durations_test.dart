import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/theme/tokens/durations.dart';

void main() {
  group('DurationTokens', () {
    test('should define animation durations', () {
      expect(DurationTokens.fast, equals(const Duration(milliseconds: 150)));
      expect(DurationTokens.normal, equals(const Duration(milliseconds: 250)));
      expect(DurationTokens.slow, equals(const Duration(milliseconds: 400)));
    });

    test('duration values should be increasingly longer', () {
      expect(
        DurationTokens.normal.inMilliseconds,
        greaterThan(DurationTokens.fast.inMilliseconds),
      );
      expect(
        DurationTokens.slow.inMilliseconds,
        greaterThan(DurationTokens.normal.inMilliseconds),
      );
    });

    test('all durations should be positive', () {
      expect(DurationTokens.fast.inMilliseconds, greaterThan(0));
      expect(DurationTokens.normal.inMilliseconds, greaterThan(0));
      expect(DurationTokens.slow.inMilliseconds, greaterThan(0));
    });
  });
}
