import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';

void main() {
  group('SpaceTokens', () {
    test('should define spacing values as powers of 2', () {
      expect(SpaceTokens.xxs, equals(2.0));
      expect(SpaceTokens.xs, equals(4.0));
      expect(SpaceTokens.sm, equals(8.0));
      expect(SpaceTokens.md, equals(16.0));
      expect(SpaceTokens.lg, equals(32.0));
      expect(SpaceTokens.xl, equals(64.0));
    });

    test('spacing values should be consistently increasing', () {
      expect(SpaceTokens.xs, greaterThan(SpaceTokens.xxs));
      expect(SpaceTokens.sm, greaterThan(SpaceTokens.xs));
      expect(SpaceTokens.md, greaterThan(SpaceTokens.sm));
      expect(SpaceTokens.lg, greaterThan(SpaceTokens.md));
      expect(SpaceTokens.xl, greaterThan(SpaceTokens.lg));
    });

    test('each spacing value should be double the previous', () {
      expect(SpaceTokens.xs, equals(SpaceTokens.xxs * 2));
      expect(SpaceTokens.sm, equals(SpaceTokens.xs * 2));
      expect(SpaceTokens.md, equals(SpaceTokens.sm * 2));
      expect(SpaceTokens.lg, equals(SpaceTokens.md * 2));
      expect(SpaceTokens.xl, equals(SpaceTokens.lg * 2));
    });
  });
}
