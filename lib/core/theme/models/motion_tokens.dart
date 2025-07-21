import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'motion_tokens.freezed.dart';

/// デザイントークンのモーション（アニメーション）定義
///
/// Material 3デザインシステムに基づいたモーショントークンを定義します。
/// 一貫性のあるアニメーション体験を提供します。
@freezed
abstract class MotionTokens with _$MotionTokens {
  const factory MotionTokens({
    /// デュレーション（持続時間）
    required DurationTokens duration,

    /// イージング（加速曲線）
    required EasingTokens easing,

    /// スタンダードトランジション
    required StandardTransitions standard,
  }) = _MotionTokens;

  /// 標準のモーショントークン
  static const standardEase = MotionTokens(
    duration: DurationTokens.standard,
    easing: EasingTokens.standardEase,
    standard: StandardTransitions.standard,
  );
}

/// アニメーション持続時間の定義
@freezed
abstract class DurationTokens with _$DurationTokens {
  const factory DurationTokens({
    /// 瞬時（50ms）
    required Duration instant,

    /// 極短（100ms）
    required Duration quick,

    /// 短い（150ms）
    required Duration fast,

    /// 標準（200ms）
    required Duration normal,

    /// やや長い（250ms）
    required Duration medium,

    /// 長い（300ms）
    required Duration slow,

    /// 極長（400ms）
    required Duration slower,

    /// 最長（500ms）
    required Duration slowest,

    /// 特別長い（1秒）
    required Duration extended,
  }) = _DurationTokens;

  /// 標準の持続時間トークン
  static const standard = DurationTokens(
    instant: Duration(milliseconds: 50),
    quick: Duration(milliseconds: 100),
    fast: Duration(milliseconds: 150),
    normal: Duration(milliseconds: 200),
    medium: Duration(milliseconds: 250),
    slow: Duration(milliseconds: 300),
    slower: Duration(milliseconds: 400),
    slowest: Duration(milliseconds: 500),
    extended: Duration(milliseconds: 1000),
  );

  /// 高速アニメーション用の持続時間トークン
  static const speedy = DurationTokens(
    instant: Duration(milliseconds: 25),
    quick: Duration(milliseconds: 50),
    fast: Duration(milliseconds: 75),
    normal: Duration(milliseconds: 100),
    medium: Duration(milliseconds: 125),
    slow: Duration(milliseconds: 150),
    slower: Duration(milliseconds: 200),
    slowest: Duration(milliseconds: 250),
    extended: Duration(milliseconds: 500),
  );

  /// ゆっくりアニメーション用の持続時間トークン
  static const relaxed = DurationTokens(
    instant: Duration(milliseconds: 75),
    quick: Duration(milliseconds: 150),
    fast: Duration(milliseconds: 225),
    normal: Duration(milliseconds: 300),
    medium: Duration(milliseconds: 375),
    slow: Duration(milliseconds: 450),
    slower: Duration(milliseconds: 600),
    slowest: Duration(milliseconds: 750),
    extended: Duration(milliseconds: 1500),
  );
}

/// イージング曲線の定義
@freezed
abstract class EasingTokens with _$EasingTokens {
  const factory EasingTokens({
    /// 線形（一定速度）
    required Curve linear,

    /// 標準イージング
    required Curve standard,

    /// 加速（開始が遅く、終了が速い）
    required Curve accelerate,

    /// 減速（開始が速く、終了が遅い）
    required Curve decelerate,

    /// 強調イージング
    required Curve emphasized,

    /// 入場イージング
    required Curve enter,

    /// 退場イージング
    required Curve exit,

    /// バウンス
    required Curve bounce,

    /// 弾性
    required Curve elastic,
  }) = _EasingTokens;

  /// 標準のイージングトークン
  static const standardEase = EasingTokens(
    linear: Curves.linear,
    standard: Curves.easeInOut,
    accelerate: Curves.easeIn,
    decelerate: Curves.easeOut,
    emphasized: Curves.easeInOutCubic,
    enter: Curves.easeOut,
    exit: Curves.easeIn,
    bounce: Curves.bounceOut,
    elastic: Curves.elasticOut,
  );
}

/// スタンダードトランジション定義
@freezed
abstract class StandardTransitions with _$StandardTransitions {
  const factory StandardTransitions({
    /// フェードイン・アウト
    required TransitionConfig fade,

    /// スライド（水平）
    required TransitionConfig slideHorizontal,

    /// スライド（垂直）
    required TransitionConfig slideVertical,

    /// スケール（拡大縮小）
    required TransitionConfig scale,

    /// 回転
    required TransitionConfig rotation,

    /// コンテナトランスフォーム
    required TransitionConfig containerTransform,

    /// シェアードアクシス
    required TransitionConfig sharedAxis,

    /// FABトランジション
    required TransitionConfig fabTransition,

    /// ボトムシート
    required TransitionConfig bottomSheet,

    /// モーダル
    required TransitionConfig modal,
  }) = _StandardTransitions;

  /// 標準のトランジション設定
  static const standard = StandardTransitions(
    fade: TransitionConfig(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    ),
    slideHorizontal: TransitionConfig(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    ),
    slideVertical: TransitionConfig(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    ),
    scale: TransitionConfig(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    ),
    rotation: TransitionConfig(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    ),
    containerTransform: TransitionConfig(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    ),
    sharedAxis: TransitionConfig(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    ),
    fabTransition: TransitionConfig(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    ),
    bottomSheet: TransitionConfig(
      duration: Duration(milliseconds: 250),
      curve: Curves.easeOut,
    ),
    modal: TransitionConfig(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    ),
  );
}

/// トランジション設定
@freezed
abstract class TransitionConfig with _$TransitionConfig {
  const factory TransitionConfig({
    required Duration duration,
    required Curve curve,
    Duration? reverseDuration,
    Curve? reverseCurve,
  }) = _TransitionConfig;
}

/// アニメーション実行レベル定義
enum AnimationLevel {
  /// アニメーション無効
  disabled,

  /// 最小限のアニメーション
  minimal,

  /// 標準アニメーション
  standard,

  /// リッチアニメーション
  rich,
}

/// モーションユーティリティ
class MotionUtils {
  /// アニメーション実行レベルに基づく持続時間調整
  static Duration adjustDurationForLevel({
    required Duration baseDuration,
    required AnimationLevel level,
  }) {
    switch (level) {
      case AnimationLevel.disabled:
        return Duration.zero;
      case AnimationLevel.minimal:
        return Duration(
          milliseconds: (baseDuration.inMilliseconds * 0.5).round(),
        );
      case AnimationLevel.standard:
        return baseDuration;
      case AnimationLevel.rich:
        return Duration(
          milliseconds: (baseDuration.inMilliseconds * 1.5).round(),
        );
    }
  }

  /// レスポンシブな持続時間調整
  static Duration getResponsiveDuration({
    required Duration baseDuration,
    required double screenWidth,
    double minScale = 0.7,
    double maxScale = 1.3,
  }) {
    const double minWidth = 320.0;
    const double maxWidth = 768.0;

    double scale;
    if (screenWidth <= minWidth) {
      scale = minScale;
    } else if (screenWidth >= maxWidth) {
      scale = maxScale;
    } else {
      final double ratio = (screenWidth - minWidth) / (maxWidth - minWidth);
      scale = minScale + (maxScale - minScale) * ratio;
    }

    return Duration(
      milliseconds: (baseDuration.inMilliseconds * scale).round(),
    );
  }

  /// アクセシビリティ設定に基づく調整
  static Duration adjustForAccessibility({
    required Duration baseDuration,
    bool reduceMotion = false,
    bool slowAnimations = false,
  }) {
    if (reduceMotion) {
      return Duration.zero;
    }

    if (slowAnimations) {
      return Duration(
        milliseconds: (baseDuration.inMilliseconds * 2.0).round(),
      );
    }

    return baseDuration;
  }

  /// Material 3のコンテナトランスフォーム
  static Widget buildContainerTransform({
    required Widget child,
    required Animation<double> animation,
    double? elevation,
  }) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 0.8,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
        child: child,
      ),
    );
  }

  /// Material 3のシェアードアクシストランジション
  static Widget buildSharedAxisTransition({
    required Widget child,
    required Animation<double> animation,
    SharedAxisTransitionType transitionType =
        SharedAxisTransitionType.horizontal,
  }) {
    final Offset beginOffset;
    final Offset endOffset;

    switch (transitionType) {
      case SharedAxisTransitionType.horizontal:
        beginOffset = const Offset(1.0, 0.0);
        endOffset = Offset.zero;
        break;
      case SharedAxisTransitionType.vertical:
        beginOffset = const Offset(0.0, 1.0);
        endOffset = Offset.zero;
        break;
      case SharedAxisTransitionType.scaled:
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(opacity: animation, child: child),
        );
    }

    return SlideTransition(
      position: Tween<Offset>(
        begin: beginOffset,
        end: endOffset,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
      child: FadeTransition(opacity: animation, child: child),
    );
  }
}

/// シェアードアクシストランジションタイプ
enum SharedAxisTransitionType { horizontal, vertical, scaled }

/// コンポーネント別モーション設定
class ComponentMotions {
  /// ボタンのホバー・タップアニメーション
  static const button = TransitionConfig(
    duration: Duration(milliseconds: 150),
    curve: Curves.easeInOut,
  );

  /// カードのホバー・タップアニメーション
  static const card = TransitionConfig(
    duration: Duration(milliseconds: 200),
    curve: Curves.easeInOut,
  );

  /// FABのアニメーション
  static const fab = TransitionConfig(
    duration: Duration(milliseconds: 200),
    curve: Curves.easeInOut,
  );

  /// リストアイテムのアニメーション
  static const listItem = TransitionConfig(
    duration: Duration(milliseconds: 100),
    curve: Curves.easeInOut,
  );

  /// ナビゲーションのアニメーション
  static const navigation = TransitionConfig(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );

  /// モーダルのアニメーション
  static const modal = TransitionConfig(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );

  /// ツールチップのアニメーション
  static const tooltip = TransitionConfig(
    duration: Duration(milliseconds: 150),
    curve: Curves.easeInOut,
  );

  /// スナックバーのアニメーション
  static const snackbar = TransitionConfig(
    duration: Duration(milliseconds: 250),
    curve: Curves.easeOut,
  );
}
