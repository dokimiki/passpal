import 'package:flutter/material.dart';

/// Base interface for MotionTokens theme extension.
///
/// Provides type-safe access to consistent animation durations and curves throughout the app.
/// Based on Material 3 motion principles for smooth, purposeful animations.
///
/// This interface ensures consistent motion implementation across
/// different components and interaction patterns.
abstract class MotionExtension extends ThemeExtension<MotionExtension> {
  /// Instant transition (0ms).
  /// Used for immediate state changes without animation.
  Duration get instant;

  /// Fast animation (100ms).
  /// Used for micro-interactions and immediate feedback.
  Duration get fast;

  /// Normal animation (200ms).
  /// Used for standard transitions and component animations.
  Duration get normal;

  /// Slow animation (300ms).
  /// Used for complex transitions and page-level animations.
  Duration get slow;

  /// Extra slow animation (500ms).
  /// Used for dramatic transitions and attention-grabbing effects.
  Duration get extraSlow;

  /// Standard easing curve for most animations.
  /// Provides natural motion that feels responsive and smooth.
  Curve get standardCurve;

  /// Accelerate curve for entering animations.
  /// Elements appear to speed up as they enter the viewport.
  Curve get accelerateCurve;

  /// Decelerate curve for exiting animations.
  /// Elements appear to slow down as they exit the viewport.
  Curve get decelerateCurve;

  /// Emphasized curve for important transitions.
  /// Provides more pronounced easing for key interactions.
  Curve get emphasizedCurve;

  /// Bounce curve for playful interactions.
  /// Adds spring-like motion for engaging feedback.
  Curve get bounceCurve;

  /// Elastic curve for dynamic interactions.
  /// Creates stretchy, rubber-band-like motion.
  Curve get elasticCurve;

  /// AnimationController factory with motion tokens.
  /// Creates properly configured controllers for consistent timing.
  AnimationController createController({
    required TickerProvider vsync,
    Duration? duration,
    Duration? reverseDuration,
    String? debugLabel,
  });

  /// Tween animation with motion tokens.
  /// Simplifies creation of value-based animations.
  Animation<T> createTween<T>({
    required AnimationController controller,
    required T begin,
    required T end,
    Curve? curve,
  });

  /// Slide transition with motion tokens.
  /// Provides consistent slide animations for page transitions.
  Widget slideTransition({
    required Animation<double> animation,
    required Widget child,
    Offset begin = const Offset(1.0, 0.0),
    Offset end = Offset.zero,
    Curve? curve,
  });

  /// Fade transition with motion tokens.
  /// Provides consistent fade animations for component visibility.
  Widget fadeTransition({
    required Animation<double> animation,
    required Widget child,
    Curve? curve,
  });

  /// Scale transition with motion tokens.
  /// Provides consistent scale animations for emphasis and focus.
  Widget scaleTransition({
    required Animation<double> animation,
    required Widget child,
    Alignment alignment = Alignment.center,
    Curve? curve,
  });

  /// Combined transition with multiple effects.
  /// Allows composition of slide, fade, and scale for complex animations.
  Widget combinedTransition({
    required Animation<double> animation,
    required Widget child,
    Offset? slideBegin,
    Offset? slideEnd,
    double? fadeBegin,
    double? fadeEnd,
    double? scaleBegin,
    double? scaleEnd,
    Alignment scaleAlignment = Alignment.center,
    Curve? curve,
  });

  /// Creates a copy of this extension with given fields replaced.
  @override
  MotionExtension copyWith({
    Duration? instant,
    Duration? fast,
    Duration? normal,
    Duration? slow,
    Duration? extraSlow,
    Curve? standardCurve,
    Curve? accelerateCurve,
    Curve? decelerateCurve,
    Curve? emphasizedCurve,
    Curve? bounceCurve,
    Curve? elasticCurve,
  });

  /// Linearly interpolates between this and another [MotionExtension].
  ///
  /// Required for theme transitions and animations.
  @override
  MotionExtension lerp(ThemeExtension<MotionExtension>? other, double t);
}
