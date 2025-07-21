import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'radius_tokens.freezed.dart';

/// デザイントークンの角丸定義
///
/// Material 3デザインシステムに基づいた角丸トークンを定義します。
/// 一貫性のあるコンポーネント角丸を提供します。
@freezed
abstract class RadiusTokens with _$RadiusTokens {
  const factory RadiusTokens({
    /// 角丸なし
    required double none,

    /// 極小角丸（2px）
    required double xs,

    /// 小角丸（4px）
    required double sm,

    /// 標準角丸（8px）
    required double md,

    /// 大角丸（12px）
    required double lg,

    /// 特大角丸（16px）
    required double xl,

    /// 超大角丸（20px）
    required double xxl,

    /// 巨大角丸（28px）
    required double xxxl,

    /// 円形（50%）
    required double full,
  }) = _RadiusTokens;

  /// 標準の角丸トークン
  static const standard = RadiusTokens(
    none: 0.0,
    xs: 2.0,
    sm: 4.0,
    md: 8.0,
    lg: 12.0,
    xl: 16.0,
    xxl: 20.0,
    xxxl: 28.0,
    full: 9999.0, // 実質的な円形
  );
}

/// コンポーネント別の角丸定義
@freezed
abstract class ComponentRadiusTokens with _$ComponentRadiusTokens {
  const factory ComponentRadiusTokens({
    /// ボタンの角丸
    required BorderRadius button,

    /// カードの角丸
    required BorderRadius card,

    /// チップの角丸
    required BorderRadius chip,

    /// インプットフィールドの角丸
    required BorderRadius input,

    /// モーダル・ダイアログの角丸
    required BorderRadius modal,

    /// ボトムシートの角丸
    required BorderRadius bottomSheet,

    /// FABの角丸
    required BorderRadius fab,

    /// アバターの角丸
    required BorderRadius avatar,

    /// イメージの角丸
    required BorderRadius image,

    /// ナビゲーションの角丸
    required BorderRadius navigation,

    /// バッジの角丸
    required BorderRadius badge,

    /// プログレスインジケータの角丸
    required BorderRadius progress,
  }) = _ComponentRadiusTokens;

  /// 標準のコンポーネント角丸トークン
  static const standard = ComponentRadiusTokens(
    button: BorderRadius.all(Radius.circular(12.0)), // lg
    card: BorderRadius.all(Radius.circular(16.0)), // xl
    chip: BorderRadius.all(Radius.circular(8.0)), // md
    input: BorderRadius.all(Radius.circular(8.0)), // md
    modal: BorderRadius.vertical(
      // カスタム
      top: Radius.circular(28.0), // xxxl
    ),
    bottomSheet: BorderRadius.vertical(
      // カスタム
      top: Radius.circular(28.0), // xxxl
    ),
    fab: BorderRadius.all(Radius.circular(16.0)), // xl
    avatar: BorderRadius.all(Radius.circular(9999.0)), // full
    image: BorderRadius.all(Radius.circular(8.0)), // md
    navigation: BorderRadius.all(Radius.circular(12.0)), // lg
    badge: BorderRadius.all(Radius.circular(9999.0)), // full
    progress: BorderRadius.all(Radius.circular(9999.0)), // full
  );

  /// コンパクトなコンポーネント角丸トークン
  static const compact = ComponentRadiusTokens(
    button: BorderRadius.all(Radius.circular(8.0)), // md
    card: BorderRadius.all(Radius.circular(12.0)), // lg
    chip: BorderRadius.all(Radius.circular(6.0)), // sm+
    input: BorderRadius.all(Radius.circular(6.0)), // sm+
    modal: BorderRadius.vertical(
      top: Radius.circular(20.0), // xxl
    ),
    bottomSheet: BorderRadius.vertical(
      top: Radius.circular(20.0), // xxl
    ),
    fab: BorderRadius.all(Radius.circular(12.0)), // lg
    avatar: BorderRadius.all(Radius.circular(9999.0)), // full
    image: BorderRadius.all(Radius.circular(6.0)), // sm+
    navigation: BorderRadius.all(Radius.circular(8.0)), // md
    badge: BorderRadius.all(Radius.circular(9999.0)), // full
    progress: BorderRadius.all(Radius.circular(9999.0)), // full
  );

  /// 角丸の強いコンポーネント角丸トークン
  static const rounded = ComponentRadiusTokens(
    button: BorderRadius.all(Radius.circular(20.0)), // xxl
    card: BorderRadius.all(Radius.circular(24.0)), // custom
    chip: BorderRadius.all(Radius.circular(16.0)), // xl
    input: BorderRadius.all(Radius.circular(16.0)), // xl
    modal: BorderRadius.vertical(
      top: Radius.circular(32.0), // custom
    ),
    bottomSheet: BorderRadius.vertical(
      top: Radius.circular(32.0), // custom
    ),
    fab: BorderRadius.all(Radius.circular(24.0)), // custom
    avatar: BorderRadius.all(Radius.circular(9999.0)), // full
    image: BorderRadius.all(Radius.circular(16.0)), // xl
    navigation: BorderRadius.all(Radius.circular(20.0)), // xxl
    badge: BorderRadius.all(Radius.circular(9999.0)), // full
    progress: BorderRadius.all(Radius.circular(9999.0)), // full
  );
}

/// 角丸ユーティリティ
class RadiusUtils {
  /// レスポンシブ角丸値を計算
  static double getResponsiveRadius({
    required double baseRadius,
    required double screenWidth,
    double minScale = 0.7,
    double maxScale = 1.3,
  }) {
    const double minWidth = 320.0;
    const double maxWidth = 768.0;

    if (screenWidth <= minWidth) {
      return baseRadius * minScale;
    } else if (screenWidth >= maxWidth) {
      return baseRadius * maxScale;
    } else {
      final double ratio = (screenWidth - minWidth) / (maxWidth - minWidth);
      final double scale = minScale + (maxScale - minScale) * ratio;
      return baseRadius * scale;
    }
  }

  /// 角丸を画面サイズに応じて調整
  static BorderRadius getResponsiveBorderRadius({
    required BorderRadius baseBorderRadius,
    required double screenWidth,
    double minScale = 0.7,
    double maxScale = 1.3,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(
        getResponsiveRadius(
          baseRadius: baseBorderRadius.topLeft.x,
          screenWidth: screenWidth,
          minScale: minScale,
          maxScale: maxScale,
        ),
      ),
      topRight: Radius.circular(
        getResponsiveRadius(
          baseRadius: baseBorderRadius.topRight.x,
          screenWidth: screenWidth,
          minScale: minScale,
          maxScale: maxScale,
        ),
      ),
      bottomLeft: Radius.circular(
        getResponsiveRadius(
          baseRadius: baseBorderRadius.bottomLeft.x,
          screenWidth: screenWidth,
          minScale: minScale,
          maxScale: maxScale,
        ),
      ),
      bottomRight: Radius.circular(
        getResponsiveRadius(
          baseRadius: baseBorderRadius.bottomRight.x,
          screenWidth: screenWidth,
          minScale: minScale,
          maxScale: maxScale,
        ),
      ),
    );
  }

  /// カスタム角丸を作成
  static BorderRadius custom({
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
    double? all,
  }) {
    if (all != null) {
      return BorderRadius.all(Radius.circular(all));
    }

    return BorderRadius.only(
      topLeft: Radius.circular(topLeft ?? 0.0),
      topRight: Radius.circular(topRight ?? 0.0),
      bottomLeft: Radius.circular(bottomLeft ?? 0.0),
      bottomRight: Radius.circular(bottomRight ?? 0.0),
    );
  }

  /// 部分的な角丸を作成
  static BorderRadius partial({
    bool top = false,
    bool bottom = false,
    bool left = false,
    bool right = false,
    required double radius,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular((top && left) ? radius : 0.0),
      topRight: Radius.circular((top && right) ? radius : 0.0),
      bottomLeft: Radius.circular((bottom && left) ? radius : 0.0),
      bottomRight: Radius.circular((bottom && right) ? radius : 0.0),
    );
  }
}

/// BorderRadius拡張
extension BorderRadiusExtensions on BorderRadius {
  /// スケール調整
  BorderRadius scale(double factor) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft.x * factor),
      topRight: Radius.circular(topRight.x * factor),
      bottomLeft: Radius.circular(bottomLeft.x * factor),
      bottomRight: Radius.circular(bottomRight.x * factor),
    );
  }

  /// 最大値を適用
  BorderRadius clamp(double maxRadius) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft.x.clamp(0.0, maxRadius)),
      topRight: Radius.circular(topRight.x.clamp(0.0, maxRadius)),
      bottomLeft: Radius.circular(bottomLeft.x.clamp(0.0, maxRadius)),
      bottomRight: Radius.circular(bottomRight.x.clamp(0.0, maxRadius)),
    );
  }

  /// 角丸を反転
  BorderRadius flip() {
    return BorderRadius.only(
      topLeft: bottomRight,
      topRight: bottomLeft,
      bottomLeft: topRight,
      bottomRight: topLeft,
    );
  }
}
