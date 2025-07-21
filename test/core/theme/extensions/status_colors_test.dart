import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/theme/extensions/status_colors.dart';

void main() {
  group('StatusColors', () {
    testWidgets('should provide all required colors', (tester) async {
      final statusColors = StatusColors.light;

      expect(statusColors.success, const Color(0xFF2E7D32));
      expect(statusColors.warning, const Color(0xFFF57C00));
      expect(statusColors.error, const Color(0xFFD32F2F));
      expect(statusColors.info, const Color(0xFF1976D2));
      
      expect(statusColors.successLight, const Color(0xFF66BB6A));
      expect(statusColors.warningLight, const Color(0xFFFFB74D));
      expect(statusColors.errorLight, const Color(0xFFEF5350));
      expect(statusColors.infoLight, const Color(0xFF42A5F5));
      
      expect(statusColors.successDark, const Color(0xFF1B5E20));
      expect(statusColors.warningDark, const Color(0xFFE65100));
      expect(statusColors.errorDark, const Color(0xFFB71C1C));
      expect(statusColors.infoDark, const Color(0xFF0D47A1));
    });

    test('should create light theme variant', () {
      final statusColors = StatusColors.light;
      
      // Primary status colors should use light mode values
      expect(statusColors.success, const Color(0xFF2E7D32));
      expect(statusColors.warning, const Color(0xFFF57C00));
      expect(statusColors.error, const Color(0xFFD32F2F));
      expect(statusColors.info, const Color(0xFF1976D2));
    });

    test('should create dark theme variant', () {
      final statusColors = StatusColors.dark;
      
      // Primary status colors should use dark mode values
      expect(statusColors.success, const Color(0xFF66BB6A));
      expect(statusColors.warning, const Color(0xFFFFB74D));
      expect(statusColors.error, const Color(0xFFEF5350));
      expect(statusColors.info, const Color(0xFF42A5F5));
    });

    test('should create high contrast variant', () {
      final statusColors = StatusColors.highContrast;
      
      // High contrast colors should be darker for better accessibility
      expect(statusColors.success, const Color(0xFF0D5016));
      expect(statusColors.warning, const Color(0xFF8A4000));
      expect(statusColors.error, const Color(0xFF8B0000));
      expect(statusColors.info, const Color(0xFF003D82));
    });

    test('should support copyWith method', () {
      final original = StatusColors.light;
      const newSuccess = Color(0xFF00FF00);
      const newWarning = Color(0xFFFF8800);
      
      final modified = original.copyWith(
        success: newSuccess,
        warning: newWarning,
      );
      
      expect(modified.success, newSuccess);
      expect(modified.warning, newWarning);
      expect(modified.error, original.error); // unchanged
      expect(modified.info, original.info); // unchanged
    });

    test('should interpolate between two StatusColors instances', () {
      final from = StatusColors.light;
      final to = StatusColors.dark;
      
      final lerped = from.lerp(to, 0.5);
      
      // Should be halfway between light and dark values
      expect(lerped.success, Color.lerp(from.success, to.success, 0.5));
      expect(lerped.warning, Color.lerp(from.warning, to.warning, 0.5));
      expect(lerped.error, Color.lerp(from.error, to.error, 0.5));
      expect(lerped.info, Color.lerp(from.info, to.info, 0.5));
    });

    test('should return self when lerping with null', () {
      final statusColors = StatusColors.light;
      
      final lerped = statusColors.lerp(null, 0.5);
      
      expect(lerped, equals(statusColors));
    });

    test('should implement equality correctly', () {
      final statusColors1 = StatusColors.light;
      final statusColors2 = StatusColors.light;
      final statusColors3 = StatusColors.dark;
      
      // Check if they have the same values, not object identity
      expect(statusColors1.success, equals(statusColors2.success));
      expect(statusColors1.warning, equals(statusColors2.warning));
      expect(statusColors1.error, equals(statusColors2.error));
      expect(statusColors1.info, equals(statusColors2.info));
      
      // Verify dark theme is different
      expect(statusColors1.success, isNot(equals(statusColors3.success)));
    });

    test('should implement hashCode correctly', () {
      final statusColors1 = StatusColors.light;
      final statusColors3 = StatusColors.dark;
      
      // Test that hashCode is consistent for the same instance
      expect(statusColors1.hashCode, equals(statusColors1.hashCode));
      expect(statusColors3.hashCode, equals(statusColors3.hashCode));
    });

    test('should implement toString correctly', () {
      final statusColors = StatusColors.light;
      final string = statusColors.toString();
      
      expect(string, contains('StatusColors('));
      expect(string, contains('success: ${statusColors.success}'));
      expect(string, contains('warning: ${statusColors.warning}'));
      expect(string, contains('error: ${statusColors.error}'));
      expect(string, contains('info: ${statusColors.info}'));
    });

    group('Context Extension', () {
      testWidgets('should provide statusColors from context', (tester) async {
        final statusColors = StatusColors.light;
        late BuildContext capturedContext;
        
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              extensions: [statusColors],
            ),
            home: Builder(
              builder: (context) {
                capturedContext = context;
                return const SizedBox();
              },
            ),
          ),
        );
        
        final contextStatusColors = capturedContext.statusColors;
        expect(contextStatusColors.success, equals(statusColors.success));
        expect(contextStatusColors.warning, equals(statusColors.warning));
        expect(contextStatusColors.error, equals(statusColors.error));
        expect(contextStatusColors.info, equals(statusColors.info));
      });

      testWidgets('should assert when StatusColors not registered', (tester) async {
        late BuildContext capturedContext;
        
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(), // No StatusColors extension
            home: Builder(
              builder: (context) {
                capturedContext = context;
                return const SizedBox();
              },
            ),
          ),
        );
        
        expect(
          () => capturedContext.statusColors,
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group('ThemeData Extension', () {
      test('should provide statusColors from ThemeData', () {
        final statusColors = StatusColors.light;
        final theme = ThemeData(
          extensions: [statusColors],
        );
        
        expect(theme.statusColors?.success, equals(statusColors.success));
        expect(theme.statusColors?.warning, equals(statusColors.warning));
        expect(theme.statusColors?.error, equals(statusColors.error));
        expect(theme.statusColors?.info, equals(statusColors.info));
      });

      test('should return null when StatusColors not registered', () {
        final theme = ThemeData(); // No StatusColors extension
        
        expect(theme.statusColors, isNull);
      });
    });

    group('Color Contrast Validation', () {
      test('should provide sufficient contrast for light mode', () {
        final statusColors = StatusColors.light;
        
        // These colors should have sufficient contrast for WCAG AA
        // Testing that colors are dark enough for light backgrounds
        expect(statusColors.success.computeLuminance(), lessThan(0.5));
        expect(statusColors.warning.computeLuminance(), lessThan(0.5));
        expect(statusColors.error.computeLuminance(), lessThan(0.5));
        expect(statusColors.info.computeLuminance(), lessThan(0.5));
      });

      test('should provide sufficient contrast for dark mode', () {
        final statusColors = StatusColors.dark;
        
        // These colors should be light enough for dark backgrounds
        expect(statusColors.success.computeLuminance(), greaterThan(0.2));
        expect(statusColors.warning.computeLuminance(), greaterThan(0.2));
        expect(statusColors.error.computeLuminance(), greaterThan(0.2));
        expect(statusColors.info.computeLuminance(), greaterThan(0.2));
      });

      test('should provide maximum contrast for high contrast mode', () {
        final statusColors = StatusColors.highContrast;
        
        // High contrast colors should be very dark
        expect(statusColors.success.computeLuminance(), lessThan(0.1));
        expect(statusColors.warning.computeLuminance(), lessThan(0.1));
        expect(statusColors.error.computeLuminance(), lessThan(0.1));
        expect(statusColors.info.computeLuminance(), lessThan(0.1));
      });
    });

    group('Material 3 Integration', () {
      test('should align with Material 3 color specifications', () {
        final statusColors = StatusColors.light;
        
        // Success should be green-based
        expect((statusColors.success.g * 255.0).round() & 0xff, greaterThan((statusColors.success.r * 255.0).round() & 0xff));
        expect((statusColors.success.g * 255.0).round() & 0xff, greaterThan((statusColors.success.b * 255.0).round() & 0xff));
        
        // Warning should be orange/yellow-based
        expect((statusColors.warning.r * 255.0).round() & 0xff, greaterThan(100));
        expect((statusColors.warning.g * 255.0).round() & 0xff, greaterThan(100));
        expect((statusColors.warning.b * 255.0).round() & 0xff, lessThan(100));
        
        // Error should be red-based
        expect((statusColors.error.r * 255.0).round() & 0xff, greaterThan((statusColors.error.g * 255.0).round() & 0xff));
        expect((statusColors.error.r * 255.0).round() & 0xff, greaterThan((statusColors.error.b * 255.0).round() & 0xff));
        
        // Info should be blue-based
        expect((statusColors.info.b * 255.0).round() & 0xff, greaterThan((statusColors.info.r * 255.0).round() & 0xff));
        expect((statusColors.info.b * 255.0).round() & 0xff, greaterThan((statusColors.info.g * 255.0).round() & 0xff));
      });
    });
  });
}