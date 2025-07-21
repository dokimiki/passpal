import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import '../interfaces/motion_extension.dart';
import '../models/motion_tokens.dart';

/// MotionTokens theme extension implementation.
///
/// Provides concrete implementation of consistent animation durations and curves
/// with responsive behavior and Material 3 integration.
///
/// This extension integrates with MotionTokens from the model layer
/// and provides utilities for consistent motion throughout the app.
class MotionTokensExtension extends MotionExtension {
  /// Creates a MotionTokens theme extension.
  MotionTokensExtension({
    required this.instant,
    required this.fast,
    required this.normal,
    required this.slow,
    required this.extraSlow,
    required this.standardCurve,
    required this.accelerateCurve,
    required this.decelerateCurve,
    required this.emphasizedCurve,
    required this.bounceCurve,
    required this.elasticCurve,
    required this.motionTokens,
    required this.animationLevel,
  });

  /// Standard motion extension using Material 3 specifications.
  static final standard = MotionTokensExtension(
    instant: const Duration(milliseconds: 0),
    fast: const Duration(milliseconds: 100),
    normal: const Duration(milliseconds: 200),
    slow: const Duration(milliseconds: 300),
    extraSlow: const Duration(milliseconds: 500),
    standardCurve: Curves.easeInOut,
    accelerateCurve: Curves.easeIn,
    decelerateCurve: Curves.easeOut,
    emphasizedCurve: Curves.easeInOutCubic,
    bounceCurve: Curves.bounceOut,
    elasticCurve: Curves.elasticOut,
    motionTokens: MotionTokens.standardEase,
    animationLevel: AnimationLevel.standard,
  );

  /// Speedy motion extension for faster animations.
  static final speedy = MotionTokensExtension(
    instant: const Duration(milliseconds: 0),
    fast: const Duration(milliseconds: 50),
    normal: const Duration(milliseconds: 100),
    slow: const Duration(milliseconds: 150),
    extraSlow: const Duration(milliseconds: 250),
    standardCurve: Curves.easeInOut,
    accelerateCurve: Curves.easeIn,
    decelerateCurve: Curves.easeOut,
    emphasizedCurve: Curves.easeInOutCubic,
    bounceCurve: Curves.bounceOut,
    elasticCurve: Curves.elasticOut,
    motionTokens: MotionTokens.standardEase,
    animationLevel: AnimationLevel.minimal,
  );

  /// Relaxed motion extension for slower animations.
  static final relaxed = MotionTokensExtension(
    instant: const Duration(milliseconds: 0),
    fast: const Duration(milliseconds: 150),
    normal: const Duration(milliseconds: 300),
    slow: const Duration(milliseconds: 450),
    extraSlow: const Duration(milliseconds: 750),
    standardCurve: Curves.easeInOut,
    accelerateCurve: Curves.easeIn,
    decelerateCurve: Curves.easeOut,
    emphasizedCurve: Curves.easeInOutCubic,
    bounceCurve: Curves.bounceOut,
    elasticCurve: Curves.elasticOut,
    motionTokens: MotionTokens.standardEase,
    animationLevel: AnimationLevel.rich,
  );

  /// Disabled motion extension with no animations.
  static final disabled = MotionTokensExtension(
    instant: Duration.zero,
    fast: Duration.zero,
    normal: Duration.zero,
    slow: Duration.zero,
    extraSlow: Duration.zero,
    standardCurve: Curves.linear,
    accelerateCurve: Curves.linear,
    decelerateCurve: Curves.linear,
    emphasizedCurve: Curves.linear,
    bounceCurve: Curves.linear,
    elasticCurve: Curves.linear,
    motionTokens: MotionTokens.standardEase,
    animationLevel: AnimationLevel.disabled,
  );

  @override
  final Duration instant;

  @override
  final Duration fast;

  @override
  final Duration normal;

  @override
  final Duration slow;

  @override
  final Duration extraSlow;

  @override
  final Curve standardCurve;

  @override
  final Curve accelerateCurve;

  @override
  final Curve decelerateCurve;

  @override
  final Curve emphasizedCurve;

  @override
  final Curve bounceCurve;

  @override
  final Curve elasticCurve;

  /// Underlying motion tokens model.
  final MotionTokens motionTokens;

  /// Animation execution level.
  final AnimationLevel animationLevel;

  @override
  AnimationController createController({
    required TickerProvider vsync,
    Duration? duration,
    Duration? reverseDuration,
    String? debugLabel,
  }) {
    final effectiveDuration = _adjustDuration(duration ?? normal);
    final effectiveReverseDuration = reverseDuration != null
        ? _adjustDuration(reverseDuration)
        : null;

    return AnimationController(
      duration: effectiveDuration,
      reverseDuration: effectiveReverseDuration,
      vsync: vsync,
      debugLabel: debugLabel,
    );
  }

  @override
  Animation<T> createTween<T>({
    required AnimationController controller,
    required T begin,
    required T end,
    Curve? curve,
  }) {
    final tween = Tween<T>(begin: begin, end: end);
    final effectiveCurve = curve ?? standardCurve;

    return tween.animate(
      CurvedAnimation(parent: controller, curve: effectiveCurve),
    );
  }

  @override
  Widget slideTransition({
    required Animation<double> animation,
    required Widget child,
    Offset begin = const Offset(1.0, 0.0),
    Offset end = Offset.zero,
    Curve? curve,
  }) {
    final effectiveCurve = curve ?? standardCurve;
    final offsetAnimation = Tween<Offset>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(parent: animation, curve: effectiveCurve));

    return SlideTransition(position: offsetAnimation, child: child);
  }

  @override
  Widget fadeTransition({
    required Animation<double> animation,
    required Widget child,
    Curve? curve,
  }) {
    final effectiveCurve = curve ?? standardCurve;
    final opacityAnimation = CurvedAnimation(
      parent: animation,
      curve: effectiveCurve,
    );

    return FadeTransition(opacity: opacityAnimation, child: child);
  }

  @override
  Widget scaleTransition({
    required Animation<double> animation,
    required Widget child,
    Alignment alignment = Alignment.center,
    Curve? curve,
  }) {
    final effectiveCurve = curve ?? standardCurve;
    final scaleAnimation = CurvedAnimation(
      parent: animation,
      curve: effectiveCurve,
    );

    return ScaleTransition(
      scale: scaleAnimation,
      alignment: alignment,
      child: child,
    );
  }

  @override
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
  }) {
    final effectiveCurve = curve ?? standardCurve;
    Widget result = child;

    // Apply scale transition if specified
    if (scaleBegin != null || scaleEnd != null) {
      final scaleAnimation = Tween<double>(
        begin: scaleBegin ?? 1.0,
        end: scaleEnd ?? 1.0,
      ).animate(CurvedAnimation(parent: animation, curve: effectiveCurve));

      result = ScaleTransition(
        scale: scaleAnimation,
        alignment: scaleAlignment,
        child: result,
      );
    }

    // Apply slide transition if specified
    if (slideBegin != null || slideEnd != null) {
      final slideAnimation = Tween<Offset>(
        begin: slideBegin ?? Offset.zero,
        end: slideEnd ?? Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: effectiveCurve));

      result = SlideTransition(position: slideAnimation, child: result);
    }

    // Apply fade transition if specified
    if (fadeBegin != null || fadeEnd != null) {
      final fadeAnimation = Tween<double>(
        begin: fadeBegin ?? 1.0,
        end: fadeEnd ?? 1.0,
      ).animate(CurvedAnimation(parent: animation, curve: effectiveCurve));

      result = FadeTransition(opacity: fadeAnimation, child: result);
    }

    return result;
  }

  // Component-specific duration getters

  /// Button animation duration.
  Duration get buttonDuration => _adjustDuration(fast);

  /// Card animation duration.
  Duration get cardDuration => _adjustDuration(normal);

  /// FAB animation duration.
  Duration get fabDuration => _adjustDuration(normal);

  /// List item animation duration.
  Duration get listItemDuration => _adjustDuration(fast);

  /// Navigation animation duration.
  Duration get navigationDuration => _adjustDuration(slow);

  /// Modal animation duration.
  Duration get modalDuration => _adjustDuration(slow);

  /// Tooltip animation duration.
  Duration get tooltipDuration => _adjustDuration(fast);

  /// Snackbar animation duration.
  Duration get snackbarDuration => _adjustDuration(normal);

  // Utility methods

  /// Gets responsive duration based on screen width.
  Duration getResponsiveDuration({
    required Duration baseDuration,
    required double screenWidth,
    double minScale = 0.7,
    double maxScale = 1.3,
  }) {
    final adjustedDuration = _adjustDuration(baseDuration);
    return MotionUtils.getResponsiveDuration(
      baseDuration: adjustedDuration,
      screenWidth: screenWidth,
      minScale: minScale,
      maxScale: maxScale,
    );
  }

  /// Adjusts duration for accessibility settings.
  Duration adjustForAccessibility({
    required Duration baseDuration,
    bool reduceMotion = false,
    bool slowAnimations = false,
  }) {
    final adjustedDuration = _adjustDuration(baseDuration);
    return MotionUtils.adjustForAccessibility(
      baseDuration: adjustedDuration,
      reduceMotion: reduceMotion,
      slowAnimations: slowAnimations,
    );
  }

  /// Creates a container transform transition.
  Widget buildContainerTransform({
    required Widget child,
    required Animation<double> animation,
    double? elevation,
  }) {
    return MotionUtils.buildContainerTransform(
      child: child,
      animation: animation,
      elevation: elevation,
    );
  }

  /// Creates a shared axis transition.
  Widget buildSharedAxisTransition({
    required Widget child,
    required Animation<double> animation,
    SharedAxisTransitionType transitionType =
        SharedAxisTransitionType.horizontal,
  }) {
    return MotionUtils.buildSharedAxisTransition(
      child: child,
      animation: animation,
      transitionType: transitionType,
    );
  }

  /// Adjusts duration based on animation level.
  Duration _adjustDuration(Duration baseDuration) {
    return MotionUtils.adjustDurationForLevel(
      baseDuration: baseDuration,
      level: animationLevel,
    );
  }

  @override
  MotionTokensExtension copyWith({
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
    MotionTokens? motionTokens,
    AnimationLevel? animationLevel,
  }) {
    return MotionTokensExtension(
      instant: instant ?? this.instant,
      fast: fast ?? this.fast,
      normal: normal ?? this.normal,
      slow: slow ?? this.slow,
      extraSlow: extraSlow ?? this.extraSlow,
      standardCurve: standardCurve ?? this.standardCurve,
      accelerateCurve: accelerateCurve ?? this.accelerateCurve,
      decelerateCurve: decelerateCurve ?? this.decelerateCurve,
      emphasizedCurve: emphasizedCurve ?? this.emphasizedCurve,
      bounceCurve: bounceCurve ?? this.bounceCurve,
      elasticCurve: elasticCurve ?? this.elasticCurve,
      motionTokens: motionTokens ?? this.motionTokens,
      animationLevel: animationLevel ?? this.animationLevel,
    );
  }

  @override
  MotionTokensExtension lerp(ThemeExtension<MotionExtension>? other, double t) {
    if (other is! MotionTokensExtension) {
      return this;
    }

    return MotionTokensExtension(
      instant: _lerpDuration(instant, other.instant, t),
      fast: _lerpDuration(fast, other.fast, t),
      normal: _lerpDuration(normal, other.normal, t),
      slow: _lerpDuration(slow, other.slow, t),
      extraSlow: _lerpDuration(extraSlow, other.extraSlow, t),
      standardCurve: standardCurve, // Don't interpolate curves
      accelerateCurve: accelerateCurve,
      decelerateCurve: decelerateCurve,
      emphasizedCurve: emphasizedCurve,
      bounceCurve: bounceCurve,
      elasticCurve: elasticCurve,
      motionTokens: motionTokens, // Don't interpolate complex objects
      animationLevel: animationLevel,
    );
  }

  /// Helper method to interpolate durations.
  Duration _lerpDuration(Duration a, Duration b, double t) {
    final lerpedMs = lerpDouble(
      a.inMilliseconds.toDouble(),
      b.inMilliseconds.toDouble(),
      t,
    );
    return Duration(
      milliseconds: (lerpedMs ?? a.inMilliseconds.toDouble()).round(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MotionTokensExtension &&
        other.instant == instant &&
        other.fast == fast &&
        other.normal == normal &&
        other.slow == slow &&
        other.extraSlow == extraSlow &&
        other.standardCurve == standardCurve &&
        other.accelerateCurve == accelerateCurve &&
        other.decelerateCurve == decelerateCurve &&
        other.emphasizedCurve == emphasizedCurve &&
        other.bounceCurve == bounceCurve &&
        other.elasticCurve == elasticCurve &&
        other.motionTokens == motionTokens &&
        other.animationLevel == animationLevel;
  }

  @override
  int get hashCode {
    return Object.hash(
      instant,
      fast,
      normal,
      slow,
      extraSlow,
      standardCurve,
      accelerateCurve,
      decelerateCurve,
      emphasizedCurve,
      bounceCurve,
      elasticCurve,
      motionTokens,
      animationLevel,
    );
  }

  @override
  String toString() {
    return 'MotionTokensExtension('
        'instant: $instant, '
        'fast: $fast, '
        'normal: $normal, '
        'slow: $slow, '
        'extraSlow: $extraSlow, '
        'animationLevel: $animationLevel)';
  }
}

/// Extension on [BuildContext] for easy access to motion tokens.
extension MotionTokensContext on BuildContext {
  /// Gets the current [MotionTokensExtension] from the theme.
  MotionTokensExtension? get motion {
    return Theme.of(this).extension<MotionTokensExtension>();
  }
}

/// Extension on [ThemeData] for adding motion tokens.
extension MotionTokensTheme on ThemeData {
  /// Gets the [MotionTokensExtension] from this theme.
  MotionTokensExtension? get motion {
    return extension<MotionTokensExtension>();
  }

  /// Creates a copy of this theme with the given [MotionTokensExtension].
  ThemeData withMotionTokens(MotionTokensExtension motionTokens) {
    return copyWith(
      extensions: [
        ...extensions.values.where((ext) => ext is! MotionTokensExtension),
        motionTokens,
      ],
    );
  }
}
