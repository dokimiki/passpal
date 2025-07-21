import 'package:flutter/material.dart';

/// Base interface for ElevationTokens theme extension.
///
/// Provides type-safe access to consistent elevation and shadow values throughout the app.
/// Based on Material 3 elevation system for proper visual hierarchy and depth perception.
///
/// This interface ensures consistent elevation implementation across
/// different components and interaction states.
abstract class ElevationExtension extends ThemeExtension<ElevationExtension> {
  /// No elevation (0dp).
  /// Used for flat surfaces and background elements.
  double get level0;

  /// Minimal elevation (1dp).
  /// Used for cards, chips, and subtle elevated elements.
  double get level1;

  /// Low elevation (3dp).
  /// Used for buttons, FABs, and interactive elements.
  double get level2;

  /// Medium elevation (6dp).
  /// Used for navigation elements, app bars, and prominent components.
  double get level3;

  /// High elevation (8dp).
  /// Used for modal bottom sheets, navigation drawers, and overlays.
  double get level4;

  /// Very high elevation (12dp).
  /// Used for modal dialogs, tooltips, and floating elements.
  double get level5;

  /// BoxShadow list for the given elevation level.
  /// Returns Material 3 compliant shadows for proper depth perception.
  List<BoxShadow> shadowForLevel(double elevation);

  /// Convenience getters for common shadow configurations.
  List<BoxShadow> get shadow0 => shadowForLevel(level0);
  List<BoxShadow> get shadow1 => shadowForLevel(level1);
  List<BoxShadow> get shadow2 => shadowForLevel(level2);
  List<BoxShadow> get shadow3 => shadowForLevel(level3);
  List<BoxShadow> get shadow4 => shadowForLevel(level4);
  List<BoxShadow> get shadow5 => shadowForLevel(level5);

  /// BoxDecoration with elevation shadow applied.
  /// Useful for custom containers that need elevation styling.
  BoxDecoration decorationWithElevation(
    double elevation, {
    Color? color,
    BorderRadius? borderRadius,
    Border? border,
  });

  /// Material widget configured with the specified elevation.
  /// Provides proper Material 3 elevation behavior and theming.
  Widget materialWithElevation(
    double elevation, {
    required Widget child,
    Color? color,
    BorderRadius? borderRadius,
    Clip clipBehavior = Clip.none,
  });

  /// Animated elevation that smoothly transitions between levels.
  /// Used for interactive elements with hover/press states.
  Widget animatedElevation({
    required double elevation,
    required Widget child,
    Duration duration = const Duration(milliseconds: 150),
    Curve curve = Curves.easeInOut,
    Color? color,
    BorderRadius? borderRadius,
  });

  /// Creates a copy of this extension with given fields replaced.
  @override
  ElevationExtension copyWith({
    double? level0,
    double? level1,
    double? level2,
    double? level3,
    double? level4,
    double? level5,
  });

  /// Linearly interpolates between this and another [ElevationExtension].
  ///
  /// Required for theme transitions and animations.
  @override
  ElevationExtension lerp(ThemeExtension<ElevationExtension>? other, double t);
}
