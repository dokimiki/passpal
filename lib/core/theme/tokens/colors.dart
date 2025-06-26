import 'package:flutter/material.dart';

/// Design tokens for colors used throughout the app
class ColorTokens {
  const ColorTokens._();

  /// Brand colors
  static const brand = BrandColors();

  /// Semantic colors for status indication
  static const semantic = SemanticColors();

  /// Surface colors for different elevation levels
  static const surface = SurfaceColors();
}

class BrandColors {
  const BrandColors();

  /// Primary brand color (Chukyo University brand color)
  /// Updated to meet WCAG accessibility contrast requirements
  Color get primary => const Color(0xFF0D47A1);
}

class SemanticColors {
  const SemanticColors();

  /// Success state color
  Color get success => const Color(0xFF4CAF50);

  /// Warning state color
  Color get warning => const Color(0xFFFF9800);

  /// Error state color
  Color get error => const Color(0xFFF44336);

  /// Info state color
  Color get info => const Color(0xFF2196F3);
}

class SurfaceColors {
  const SurfaceColors();

  /// Surface elevation level 1
  Color get surface1 => const Color(0xFFFEFBFF);

  /// Surface elevation level 2
  Color get surface2 => const Color(0xFFF7F2FA);

  /// Surface elevation level 3
  Color get surface3 => const Color(0xFFF2EDF7);

  /// Surface elevation level 4
  Color get surface4 => const Color(0xFFECE6F0);

  /// Surface elevation level 5
  Color get surface5 => const Color(0xFFE6E0E9);
}
