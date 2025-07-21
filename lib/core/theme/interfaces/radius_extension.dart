import 'package:flutter/material.dart';

/// Base interface for RadiusTokens theme extension.
/// 
/// Provides type-safe access to consistent border radius values throughout the app.
/// Based on Material 3 design principles for modern, cohesive visual design.
/// 
/// This interface ensures consistent radius implementation across
/// different components and interaction states.
abstract class RadiusExtension extends ThemeExtension<RadiusExtension> {
  /// No radius (0px).
  /// Used for sharp, angular designs and full-bleed components.
  double get none;

  /// Extra small radius (4px).
  /// Used for small interactive elements and badges.
  double get xs;

  /// Small radius (8px).
  /// Used for buttons, chips, and small containers.
  double get sm;

  /// Medium radius (12px).
  /// Used for cards, inputs, and medium-sized components.
  double get md;

  /// Large radius (16px).
  /// Used for prominent cards, modals, and large containers.
  double get lg;

  /// Extra large radius (24px).
  /// Used for major layout elements and hero components.
  double get xl;

  /// Full radius (9999px).
  /// Creates fully rounded elements like circular buttons and avatars.
  double get full;

  /// BorderRadius utility for component styling.
  /// Returns BorderRadius.circular with the specified radius value.
  BorderRadius circular(double radius);

  /// BorderRadius utility for all corners.
  BorderRadius get circularXs => circular(xs);
  BorderRadius get circularSm => circular(sm);
  BorderRadius get circularMd => circular(md);
  BorderRadius get circularLg => circular(lg);
  BorderRadius get circularXl => circular(xl);
  BorderRadius get circularFull => circular(full);

  /// BorderRadius utility for only top corners.
  /// Used for bottom sheets, modals, and stacked components.
  BorderRadius topOnly(double radius);

  /// BorderRadius utility for only bottom corners.
  /// Used for dropdowns, tooltips, and floating elements.
  BorderRadius bottomOnly(double radius);

  /// BorderRadius utility for only left corners.
  /// Used for directional components and asymmetric designs.
  BorderRadius leftOnly(double radius);

  /// BorderRadius utility for only right corners.
  /// Used for directional components and asymmetric designs.
  BorderRadius rightOnly(double radius);

  /// Custom BorderRadius with different values for each corner.
  BorderRadius custom({
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  });

  /// Creates a copy of this extension with given fields replaced.
  @override
  RadiusExtension copyWith({
    double? none,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? full,
  });

  /// Linearly interpolates between this and another [RadiusExtension].
  /// 
  /// Required for theme transitions and animations.
  @override
  RadiusExtension lerp(ThemeExtension<RadiusExtension>? other, double t);
}