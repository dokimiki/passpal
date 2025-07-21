import 'package:flutter/material.dart';
import '../models/spacing_tokens.dart';

/// SpacingTokens theme extension implementation.
///
/// Provides concrete implementation of consistent spacing values
/// with responsive behavior and Material 3 integration.
///
/// This extension integrates with SpacingTokens from the model layer
/// and provides utilities for consistent spacing throughout the app.
class SpacingTokensExtension extends ThemeExtension<SpacingTokensExtension> {
  /// Creates a SpacingTokens theme extension.
  SpacingTokensExtension({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.spacingTokens,
    required this.insetTokens,
    required this.gridTokens,
  });

  /// Standard spacing extension using 8px grid system.
  static final standard = SpacingTokensExtension(
    xs: 4.0, // space05
    sm: 8.0, // space1
    md: 16.0, // space2
    lg: 24.0, // space3
    xl: 32.0, // space4
    xxl: 48.0, // space6
    spacingTokens: SpacingTokens.standard,
    insetTokens: InsetTokens.standard,
    gridTokens: GridTokens.standard,
  );

  /// Compact spacing extension for smaller screens.
  static final compact = SpacingTokensExtension(
    xs: 3.0, // compact space05
    sm: 6.0, // compact space1
    md: 12.0, // compact space2
    lg: 18.0, // compact space3
    xl: 24.0, // compact space4
    xxl: 36.0, // compact space6
    spacingTokens: SpacingTokens.compact,
    insetTokens: InsetTokens.compact,
    gridTokens: GridTokens.mobile,
  );

  /// Expanded spacing extension for larger screens.
  static final expanded = SpacingTokensExtension(
    xs: 5.0, // expanded space05
    sm: 10.0, // expanded space1
    md: 20.0, // expanded space2
    lg: 30.0, // expanded space3
    xl: 40.0, // expanded space4
    xxl: 60.0, // expanded space6
    spacingTokens: SpacingTokens.expanded,
    insetTokens: InsetTokens.expanded,
    gridTokens: GridTokens.tablet,
  );

  /// Extra small spacing (4px).
  /// Used for tight spacing between related elements.
  final double xs;

  /// Small spacing (8px).
  /// Base unit for spacing system. Used for minimal separation.
  final double sm;

  /// Medium spacing (16px).
  /// Standard spacing for component internal padding and margins.
  final double md;

  /// Large spacing (24px).
  /// Used for section spacing and component external margins.
  final double lg;

  /// Extra large spacing (32px).
  /// Used for layout-level spacing and major section separation.
  final double xl;

  /// Extra extra large spacing (48px).
  /// Used for page-level spacing and major layout elements.
  final double xxl;

  /// Complete spacing tokens model for advanced spacing needs.
  final SpacingTokens spacingTokens;

  /// Inset tokens for padding and margin utilities.
  final InsetTokens insetTokens;

  /// Grid tokens for layout and grid spacing.
  final GridTokens gridTokens;

  double responsiveSpacing(
    BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return mobile ?? sm;
    } else if (screenWidth > 1024) {
      return desktop ?? xl;
    } else {
      return tablet ?? md;
    }
  }

  Widget verticalSpace(double height) {
    return SizedBox(height: height);
  }

  Widget horizontalSpace(double width) {
    return SizedBox(width: width);
  }

  EdgeInsets padding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    if (all != null) {
      return EdgeInsets.all(all);
    }

    return EdgeInsets.only(
      top: top ?? vertical ?? 0.0,
      bottom: bottom ?? vertical ?? 0.0,
      left: left ?? horizontal ?? 0.0,
      right: right ?? horizontal ?? 0.0,
    );
  }

  EdgeInsets margin({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    if (all != null) {
      return EdgeInsets.all(all);
    }

    return EdgeInsets.only(
      top: top ?? vertical ?? 0.0,
      bottom: bottom ?? vertical ?? 0.0,
      left: left ?? horizontal ?? 0.0,
      right: right ?? horizontal ?? 0.0,
    );
  }

  @override
  SpacingTokensExtension copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    SpacingTokens? spacingTokens,
    InsetTokens? insetTokens,
    GridTokens? gridTokens,
  }) {
    return SpacingTokensExtension(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      spacingTokens: spacingTokens ?? this.spacingTokens,
      insetTokens: insetTokens ?? this.insetTokens,
      gridTokens: gridTokens ?? this.gridTokens,
    );
  }

  @override
  SpacingTokensExtension lerp(
    ThemeExtension<SpacingTokensExtension>? other,
    double t,
  ) {
    if (other is! SpacingTokensExtension) {
      return this;
    }

    return SpacingTokensExtension(
      xs: lerpDouble(xs, other.xs, t) ?? xs,
      sm: lerpDouble(sm, other.sm, t) ?? sm,
      md: lerpDouble(md, other.md, t) ?? md,
      lg: lerpDouble(lg, other.lg, t) ?? lg,
      xl: lerpDouble(xl, other.xl, t) ?? xl,
      xxl: lerpDouble(xxl, other.xxl, t) ?? xxl,
      spacingTokens: t < 0.5 ? spacingTokens : other.spacingTokens,
      insetTokens: t < 0.5 ? insetTokens : other.insetTokens,
      gridTokens: t < 0.5 ? gridTokens : other.gridTokens,
    );
  }

  /// Utility method to interpolate double values safely.
  static double? lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SpacingTokensExtension &&
        other.xs == xs &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg &&
        other.xl == xl &&
        other.xxl == xxl &&
        other.spacingTokens == spacingTokens &&
        other.insetTokens == insetTokens &&
        other.gridTokens == gridTokens;
  }

  @override
  int get hashCode {
    return Object.hash(
      xs,
      sm,
      md,
      lg,
      xl,
      xxl,
      spacingTokens,
      insetTokens,
      gridTokens,
    );
  }

  @override
  String toString() {
    return 'SpacingTokensExtension('
        'xs: $xs, '
        'sm: $sm, '
        'md: $md, '
        'lg: $lg, '
        'xl: $xl, '
        'xxl: $xxl, '
        'spacingTokens: $spacingTokens, '
        'insetTokens: $insetTokens, '
        'gridTokens: $gridTokens'
        ')';
  }
}

/// Extension methods for easy access to spacing tokens in BuildContext.
extension SpacingTokensContext on BuildContext {
  /// Gets the current [SpacingTokensExtension] from the theme.
  SpacingTokensExtension get spacing {
    final spacing = Theme.of(this).extension<SpacingTokensExtension>();
    assert(
      spacing != null,
      'SpacingTokensExtension is not registered in the current theme',
    );
    return spacing!;
  }

  /// Creates vertical spacing using the current theme's spacing values.
  Widget get spacingXS => SizedBox(height: spacing.xs);
  Widget get spacingSM => SizedBox(height: spacing.sm);
  Widget get spacingMD => SizedBox(height: spacing.md);
  Widget get spacingLG => SizedBox(height: spacing.lg);
  Widget get spacingXL => SizedBox(height: spacing.xl);
  Widget get spacingXXL => SizedBox(height: spacing.xxl);

  /// Creates horizontal spacing using the current theme's spacing values.
  Widget get hSpacingXS => SizedBox(width: spacing.xs);
  Widget get hSpacingSM => SizedBox(width: spacing.sm);
  Widget get hSpacingMD => SizedBox(width: spacing.md);
  Widget get hSpacingLG => SizedBox(width: spacing.lg);
  Widget get hSpacingXL => SizedBox(width: spacing.xl);
  Widget get hSpacingXXL => SizedBox(width: spacing.xxl);

  /// Common padding presets using theme spacing.
  EdgeInsets get paddingXS => EdgeInsets.all(spacing.xs);
  EdgeInsets get paddingSM => EdgeInsets.all(spacing.sm);
  EdgeInsets get paddingMD => EdgeInsets.all(spacing.md);
  EdgeInsets get paddingLG => EdgeInsets.all(spacing.lg);
  EdgeInsets get paddingXL => EdgeInsets.all(spacing.xl);
  EdgeInsets get paddingXXL => EdgeInsets.all(spacing.xxl);

  /// Responsive padding that adapts to screen size.
  EdgeInsets responsivePadding({
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final value = spacing.responsiveSpacing(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
    return EdgeInsets.all(value);
  }
}

/// Extension methods for easy access to spacing tokens in ThemeData.
extension SpacingTokensTheme on ThemeData {
  /// Gets the [SpacingTokensExtension] from this theme.
  SpacingTokensExtension? get spacing => extension<SpacingTokensExtension>();
}
