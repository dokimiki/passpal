import 'package:flutter/material.dart';

/// Base interface for SpacingTokens theme extension.
/// 
/// Provides type-safe access to consistent spacing values throughout the app.
/// Based on an 8px grid system for improved visual consistency and rhythm.
/// 
/// This interface ensures consistent spacing implementation across
/// different screen sizes and density factors.
abstract class SpacingExtension extends ThemeExtension<SpacingExtension> {
  /// Extra small spacing (4px).
  /// Used for tight spacing between related elements.
  double get xs;

  /// Small spacing (8px).
  /// Base unit for spacing system. Used for minimal separation.
  double get sm;

  /// Medium spacing (16px).
  /// Standard spacing for component internal padding and margins.
  double get md;

  /// Large spacing (24px).
  /// Used for section spacing and component external margins.
  double get lg;

  /// Extra large spacing (32px).
  /// Used for layout-level spacing and major section separation.
  double get xl;

  /// Extra extra large spacing (48px).
  /// Used for page-level spacing and major layout elements.
  double get xxl;

  /// Responsive spacing that adapts to screen size.
  /// Returns appropriate spacing based on current screen width.
  double responsiveSpacing(BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  });

  /// Vertical spacing widget for consistent gap between elements.
  /// Uses [height] from the spacing scale.
  Widget verticalSpace(double height);

  /// Horizontal spacing widget for consistent gap between elements.
  /// Uses [width] from the spacing scale.
  Widget horizontalSpace(double width);

  /// Padding utility that returns EdgeInsets with spacing scale values.
  EdgeInsets padding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  });

  /// Margin utility that returns EdgeInsets with spacing scale values.
  EdgeInsets margin({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  });

  /// Creates a copy of this extension with given fields replaced.
  @override
  SpacingExtension copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  });

  /// Linearly interpolates between this and another [SpacingExtension].
  /// 
  /// Required for theme transitions and animations.
  @override
  SpacingExtension lerp(ThemeExtension<SpacingExtension>? other, double t);
}