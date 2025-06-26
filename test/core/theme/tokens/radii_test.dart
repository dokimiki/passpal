import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/theme/tokens/radii.dart';

void main() {
  group('RadiusTokens', () {
    test('should define border radius values', () {
      expect(RadiusTokens.card, equals(16.0));
      expect(RadiusTokens.button, equals(12.0));
      expect(RadiusTokens.overlay, equals(28.0));
    });

    test('all radius values should be positive', () {
      expect(RadiusTokens.card, greaterThan(0));
      expect(RadiusTokens.button, greaterThan(0));
      expect(RadiusTokens.overlay, greaterThan(0));
    });

    test('overlay radius should be larger than card radius', () {
      expect(RadiusTokens.overlay, greaterThan(RadiusTokens.card));
    });
  });
}
