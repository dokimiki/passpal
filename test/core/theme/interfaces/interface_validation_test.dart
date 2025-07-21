import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/theme/interfaces/interfaces.dart';

void main() {
  group('Theme Extension Interfaces', () {
    group('StatusColorsExtension', () {
      test('should be a valid type', () {
        expect(StatusColorsExtension, isA<Type>());
      });
    });

    group('SpacingExtension', () {
      test('should be a valid type', () {
        expect(SpacingExtension, isA<Type>());
      });
    });

    group('RadiusExtension', () {
      test('should be a valid type', () {
        expect(RadiusExtension, isA<Type>());
      });
    });

    group('ElevationExtension', () {
      test('should be a valid type', () {
        expect(ElevationExtension, isA<Type>());
      });
    });

    group('MotionExtension', () {
      test('should be a valid type', () {
        expect(MotionExtension, isA<Type>());
      });
    });
  });

  group('Interface Exports', () {
    test('all interfaces should be exported and accessible', () {
      // Verify that all interfaces are properly exported from the barrel file
      expect(StatusColorsExtension, isNotNull);
      expect(SpacingExtension, isNotNull);
      expect(RadiusExtension, isNotNull);
      expect(ElevationExtension, isNotNull);
      expect(MotionExtension, isNotNull);
    });
  });
}
