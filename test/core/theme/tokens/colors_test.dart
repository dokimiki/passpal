import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/theme/tokens/colors.dart';
import 'package:flutter/material.dart';

void main() {
  group('ColorTokens', () {
    test('should define brand primary color', () {
      expect(ColorTokens.brand.primary, equals(const Color(0xFF0057D9)));
    });

    test('should define semantic colors', () {
      expect(ColorTokens.semantic.success, isA<Color>());
      expect(ColorTokens.semantic.warning, isA<Color>());
      expect(ColorTokens.semantic.error, isA<Color>());
      expect(ColorTokens.semantic.info, isA<Color>());
    });

    test('should define surface colors', () {
      expect(ColorTokens.surface.surface1, isA<Color>());
      expect(ColorTokens.surface.surface2, isA<Color>());
      expect(ColorTokens.surface.surface3, isA<Color>());
      expect(ColorTokens.surface.surface4, isA<Color>());
      expect(ColorTokens.surface.surface5, isA<Color>());
    });

    test('brand primary should meet accessibility requirements', () {
      const primaryColor = Color(0xFF0057D9);
      const whiteColor = Color(0xFFFFFFFF);

      // Calculate contrast ratio (simplified)
      final contrast = _calculateContrastRatio(primaryColor, whiteColor);
      expect(
        contrast,
        greaterThanOrEqualTo(3.0),
        reason:
            'Brand primary should provide reasonable contrast (actual: ${contrast.toStringAsFixed(2)})',
      );
    });
  });
}

/// Simplified contrast ratio calculation for testing
double _calculateContrastRatio(Color color1, Color color2) {
  final luminance1 = _calculateRelativeLuminance(color1);
  final luminance2 = _calculateRelativeLuminance(color2);

  final lighter = luminance1 > luminance2 ? luminance1 : luminance2;
  final darker = luminance1 > luminance2 ? luminance2 : luminance1;

  return (lighter + 0.05) / (darker + 0.05);
}

double _calculateRelativeLuminance(Color color) {
final r = _sRGBToLinear(color.r / 255.0);
final g = _sRGBToLinear(color.g / 255.0);
final b = _sRGBToLinear(color.b / 255.0);

  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

double _sRGBToLinear(double colorChannel) {
  if (colorChannel <= 0.03928) {
    return colorChannel / 12.92;
  } else {
    return math.pow((colorChannel + 0.055) / 1.055, 2.4).toDouble();
  }
}
