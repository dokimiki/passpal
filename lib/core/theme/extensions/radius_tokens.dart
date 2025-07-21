import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import '../models/radius_tokens.dart';

/// RadiusTokens theme extension implementation.
///
/// Provides concrete implementation of consistent border radius values
/// with responsive behavior and Material 3 integration.
///
/// This extension integrates with RadiusTokens from the model layer
/// and provides utilities for consistent border radius throughout the app.
class RadiusTokensExtension extends ThemeExtension<RadiusTokensExtension> {
  /// Creates a RadiusTokens theme extension.
  RadiusTokensExtension({
    required this.none,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.full,
    required this.radiusTokens,
    required this.componentRadiusTokens,
  });

  /// Standard radius extension using Material 3 specifications.
  static final standard = RadiusTokensExtension(
    none: 0.0,
    xs: 4.0,
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
    xl: 24.0,
    full: 9999.0,
    radiusTokens: RadiusTokens.standard,
    componentRadiusTokens: ComponentRadiusTokens.standard,
  );

  /// Compact radius extension for smaller screens.
  static final compact = RadiusTokensExtension(
    none: 0.0,
    xs: 2.0,
    sm: 6.0,
    md: 8.0,
    lg: 12.0,
    xl: 20.0,
    full: 9999.0,
    radiusTokens: RadiusTokens.standard,
    componentRadiusTokens: ComponentRadiusTokens.compact,
  );

  /// Rounded radius extension for enhanced visual appeal.
  static final rounded = RadiusTokensExtension(
    none: 0.0,
    xs: 6.0,
    sm: 12.0,
    md: 16.0,
    lg: 24.0,
    xl: 32.0,
    full: 9999.0,
    radiusTokens: RadiusTokens.standard,
    componentRadiusTokens: ComponentRadiusTokens.rounded,
  );

  final double none;

  final double xs;

  final double sm;

  final double md;

  final double lg;

  final double xl;

  final double full;

  /// Underlying radius tokens model.
  final RadiusTokens radiusTokens;

  /// Component-specific radius tokens.
  final ComponentRadiusTokens componentRadiusTokens;

  // Convenience getters for BorderRadius utilities
  BorderRadius get circularXs => circular(xs);
  BorderRadius get circularSm => circular(sm);
  BorderRadius get circularMd => circular(md);
  BorderRadius get circularLg => circular(lg);
  BorderRadius get circularXl => circular(xl);
  BorderRadius get circularFull => circular(full);

  BorderRadius circular(double radius) {
    return BorderRadius.circular(radius);
  }

  BorderRadius topOnly(double radius) {
    return BorderRadius.vertical(top: Radius.circular(radius));
  }

  BorderRadius bottomOnly(double radius) {
    return BorderRadius.vertical(bottom: Radius.circular(radius));
  }

  BorderRadius leftOnly(double radius) {
    return BorderRadius.horizontal(left: Radius.circular(radius));
  }

  BorderRadius rightOnly(double radius) {
    return BorderRadius.horizontal(right: Radius.circular(radius));
  }

  BorderRadius custom({
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft ?? 0.0),
      topRight: Radius.circular(topRight ?? 0.0),
      bottomLeft: Radius.circular(bottomLeft ?? 0.0),
      bottomRight: Radius.circular(bottomRight ?? 0.0),
    );
  }

  // Component-specific radius getters

  /// Button radius for elevated, outlined, and text buttons.
  BorderRadius get button => componentRadiusTokens.button;

  /// Card radius for container components.
  BorderRadius get card => componentRadiusTokens.card;

  /// Chip radius for small interactive elements.
  BorderRadius get chip => componentRadiusTokens.chip;

  /// Input field radius for text fields and form elements.
  BorderRadius get input => componentRadiusTokens.input;

  /// Modal radius for dialogs and overlays.
  BorderRadius get modal => componentRadiusTokens.modal;

  /// Bottom sheet radius for sliding panels.
  BorderRadius get bottomSheet => componentRadiusTokens.bottomSheet;

  /// FAB radius for floating action buttons.
  BorderRadius get fab => componentRadiusTokens.fab;

  /// Avatar radius for profile images and user avatars.
  BorderRadius get avatar => componentRadiusTokens.avatar;

  /// Image radius for general image components.
  BorderRadius get image => componentRadiusTokens.image;

  /// Navigation radius for nav bars and drawers.
  BorderRadius get navigation => componentRadiusTokens.navigation;

  /// Badge radius for status indicators and counts.
  BorderRadius get badge => componentRadiusTokens.badge;

  /// Progress radius for progress indicators and loading bars.
  BorderRadius get progress => componentRadiusTokens.progress;

  // Utility methods

  /// Creates responsive radius based on screen width.
  double getResponsiveRadius({
    required double baseRadius,
    required double screenWidth,
    double minScale = 0.7,
    double maxScale = 1.3,
  }) {
    return RadiusUtils.getResponsiveRadius(
      baseRadius: baseRadius,
      screenWidth: screenWidth,
      minScale: minScale,
      maxScale: maxScale,
    );
  }

  /// Creates responsive BorderRadius based on screen width.
  BorderRadius getResponsiveBorderRadius({
    required BorderRadius baseBorderRadius,
    required double screenWidth,
    double minScale = 0.7,
    double maxScale = 1.3,
  }) {
    return RadiusUtils.getResponsiveBorderRadius(
      baseBorderRadius: baseBorderRadius,
      screenWidth: screenWidth,
      minScale: minScale,
      maxScale: maxScale,
    );
  }

  /// Creates partial radius for specific sides.
  BorderRadius partial({
    bool top = false,
    bool bottom = false,
    bool left = false,
    bool right = false,
    required double radius,
  }) {
    return RadiusUtils.partial(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      radius: radius,
    );
  }

  @override
  RadiusTokensExtension copyWith({
    double? none,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? full,
    RadiusTokens? radiusTokens,
    ComponentRadiusTokens? componentRadiusTokens,
  }) {
    return RadiusTokensExtension(
      none: none ?? this.none,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      full: full ?? this.full,
      radiusTokens: radiusTokens ?? this.radiusTokens,
      componentRadiusTokens:
          componentRadiusTokens ?? this.componentRadiusTokens,
    );
  }

  @override
  RadiusTokensExtension lerp(
    ThemeExtension<RadiusTokensExtension>? other,
    double t,
  ) {
    if (other is! RadiusTokensExtension) {
      return this;
    }

    return RadiusTokensExtension(
      none: lerpDouble(none, other.none, t) ?? none,
      xs: lerpDouble(xs, other.xs, t) ?? xs,
      sm: lerpDouble(sm, other.sm, t) ?? sm,
      md: lerpDouble(md, other.md, t) ?? md,
      lg: lerpDouble(lg, other.lg, t) ?? lg,
      xl: lerpDouble(xl, other.xl, t) ?? xl,
      full: lerpDouble(full, other.full, t) ?? full,
      radiusTokens: radiusTokens, // Don't interpolate complex objects
      componentRadiusTokens: componentRadiusTokens,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RadiusTokensExtension &&
        other.none == none &&
        other.xs == xs &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg &&
        other.xl == xl &&
        other.full == full &&
        other.radiusTokens == radiusTokens &&
        other.componentRadiusTokens == componentRadiusTokens;
  }

  @override
  int get hashCode {
    return Object.hash(
      none,
      xs,
      sm,
      md,
      lg,
      xl,
      full,
      radiusTokens,
      componentRadiusTokens,
    );
  }

  @override
  String toString() {
    return 'RadiusTokensExtension('
        'none: $none, '
        'xs: $xs, '
        'sm: $sm, '
        'md: $md, '
        'lg: $lg, '
        'xl: $xl, '
        'full: $full)';
  }
}

/// Extension on [BuildContext] for easy access to radius tokens.
extension RadiusTokensContext on BuildContext {
  /// Gets the current [RadiusTokensExtension] from the theme.
  RadiusTokensExtension? get radius {
    return Theme.of(this).extension<RadiusTokensExtension>();
  }
}

/// Extension on [ThemeData] for adding radius tokens.
extension RadiusTokensTheme on ThemeData {
  /// Gets the [RadiusTokensExtension] from this theme.
  RadiusTokensExtension? get radius {
    return extension<RadiusTokensExtension>();
  }

  /// Creates a copy of this theme with the given [RadiusTokensExtension].
  ThemeData withRadiusTokens(RadiusTokensExtension radiusTokens) {
    return copyWith(
      extensions: [
        ...extensions.values.where((ext) => ext is! RadiusTokensExtension),
        radiusTokens,
      ],
    );
  }
}
