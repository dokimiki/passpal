import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'spacing_tokens.freezed.dart';

/// デザイントークンのスペーシング定義
///
/// 8pxベースの一貫したスペーシングシステムを提供します。
/// Material 3デザインシステムのスペーシングガイドラインに準拠しています。
@freezed
abstract class SpacingTokens with _$SpacingTokens {
  const factory SpacingTokens({
    /// 基本スペーシング値（8px）
    required double baseUnit,

    /// 微小スペース（2px）
    required double space025,

    /// 極小スペース（4px）
    required double space05,

    /// 小スペース（8px = 1 unit）
    required double space1,

    /// 標準スペース（12px = 1.5 units）
    required double space15,

    /// 中スペース（16px = 2 units）
    required double space2,

    /// 中大スペース（20px = 2.5 units）
    required double space25,

    /// 大スペース（24px = 3 units）
    required double space3,

    /// 特大スペース（32px = 4 units）
    required double space4,

    /// 超大スペース（40px = 5 units）
    required double space5,

    /// 巨大スペース（48px = 6 units）
    required double space6,

    /// 最大スペース（64px = 8 units）
    required double space8,
  }) = _SpacingTokens;

  /// 標準のスペーシングトークン
  static const standard = SpacingTokens(
    baseUnit: 8.0,
    space025: 2.0, // 0.25 * 8
    space05: 4.0, // 0.5 * 8
    space1: 8.0, // 1 * 8
    space15: 12.0, // 1.5 * 8
    space2: 16.0, // 2 * 8
    space25: 20.0, // 2.5 * 8
    space3: 24.0, // 3 * 8
    space4: 32.0, // 4 * 8
    space5: 40.0, // 5 * 8
    space6: 48.0, // 6 * 8
    space8: 64.0, // 8 * 8
  );

  /// コンパクトなスペーシングトークン（小さな画面用）
  static const compact = SpacingTokens(
    baseUnit: 6.0,
    space025: 1.5, // 0.25 * 6
    space05: 3.0, // 0.5 * 6
    space1: 6.0, // 1 * 6
    space15: 9.0, // 1.5 * 6
    space2: 12.0, // 2 * 6
    space25: 15.0, // 2.5 * 6
    space3: 18.0, // 3 * 6
    space4: 24.0, // 4 * 6
    space5: 30.0, // 5 * 6
    space6: 36.0, // 6 * 6
    space8: 48.0, // 8 * 6
  );

  /// 広いスペーシングトークン（大きな画面用）
  static const expanded = SpacingTokens(
    baseUnit: 10.0,
    space025: 2.5, // 0.25 * 10
    space05: 5.0, // 0.5 * 10
    space1: 10.0, // 1 * 10
    space15: 15.0, // 1.5 * 10
    space2: 20.0, // 2 * 10
    space25: 25.0, // 2.5 * 10
    space3: 30.0, // 3 * 10
    space4: 40.0, // 4 * 10
    space5: 50.0, // 5 * 10
    space6: 60.0, // 6 * 10
    space8: 80.0, // 8 * 10
  );
}

/// インセット（padding/margin）用のスペーシング定義
@freezed
abstract class InsetTokens with _$InsetTokens {
  const factory InsetTokens({
    /// 極小インセット（垂直方向）
    required EdgeInsets none,

    /// 極小インセット（垂直方向）
    required EdgeInsets xs,

    /// 小インセット
    required EdgeInsets sm,

    /// 標準インセット
    required EdgeInsets md,

    /// 大インセット
    required EdgeInsets lg,

    /// 特大インセット
    required EdgeInsets xl,

    /// 超大インセット
    required EdgeInsets xxl,

    /// ページレベルのインセット
    required EdgeInsets page,

    /// カードのインセット
    required EdgeInsets card,

    /// ボタンのインセット
    required EdgeInsets button,

    /// リストアイテムのインセット
    required EdgeInsets listItem,

    /// セクション間のインセット
    required EdgeInsets section,
  }) = _InsetTokens;

  /// 標準のインセットトークン
  static const standard = InsetTokens(
    none: EdgeInsets.zero,
    xs: EdgeInsets.all(4.0), // space05
    sm: EdgeInsets.all(8.0), // space1
    md: EdgeInsets.all(16.0), // space2
    lg: EdgeInsets.all(24.0), // space3
    xl: EdgeInsets.all(32.0), // space4
    xxl: EdgeInsets.all(48.0), // space6
    page: EdgeInsets.all(16.0), // space2
    card: EdgeInsets.all(16.0), // space2
    button: EdgeInsets.symmetric(
      // カスタム
      horizontal: 24.0, // space3
      vertical: 12.0, // space15
    ),
    listItem: EdgeInsets.symmetric(
      // カスタム
      horizontal: 16.0, // space2
      vertical: 12.0, // space15
    ),
    section: EdgeInsets.symmetric(
      // カスタム
      vertical: 32.0, // space4
    ),
  );

  /// コンパクトなインセットトークン
  static const compact = InsetTokens(
    none: EdgeInsets.zero,
    xs: EdgeInsets.all(3.0), // compact space05
    sm: EdgeInsets.all(6.0), // compact space1
    md: EdgeInsets.all(12.0), // compact space2
    lg: EdgeInsets.all(18.0), // compact space3
    xl: EdgeInsets.all(24.0), // compact space4
    xxl: EdgeInsets.all(36.0), // compact space6
    page: EdgeInsets.all(12.0), // compact space2
    card: EdgeInsets.all(12.0), // compact space2
    button: EdgeInsets.symmetric(
      horizontal: 18.0, // compact space3
      vertical: 9.0, // compact space15
    ),
    listItem: EdgeInsets.symmetric(
      horizontal: 12.0, // compact space2
      vertical: 9.0, // compact space15
    ),
    section: EdgeInsets.symmetric(
      vertical: 24.0, // compact space4
    ),
  );

  /// 広いインセットトークン
  static const expanded = InsetTokens(
    none: EdgeInsets.zero,
    xs: EdgeInsets.all(5.0), // expanded space05
    sm: EdgeInsets.all(10.0), // expanded space1
    md: EdgeInsets.all(20.0), // expanded space2
    lg: EdgeInsets.all(30.0), // expanded space3
    xl: EdgeInsets.all(40.0), // expanded space4
    xxl: EdgeInsets.all(60.0), // expanded space6
    page: EdgeInsets.all(20.0), // expanded space2
    card: EdgeInsets.all(20.0), // expanded space2
    button: EdgeInsets.symmetric(
      horizontal: 30.0, // expanded space3
      vertical: 15.0, // expanded space15
    ),
    listItem: EdgeInsets.symmetric(
      horizontal: 20.0, // expanded space2
      vertical: 15.0, // expanded space15
    ),
    section: EdgeInsets.symmetric(
      vertical: 40.0, // expanded space4
    ),
  );
}

/// グリッドとレイアウト用のスペーシング定義
@freezed
abstract class GridTokens with _$GridTokens {
  const factory GridTokens({
    /// グリッドの基本単位
    required double gridUnit,

    /// カラム間のガター
    required double columnGap,

    /// 行間のガター
    required double rowGap,

    /// コンテナの最大幅
    required double maxContentWidth,

    /// ナビゲーションバーの高さ
    required double navBarHeight,

    /// ツールバーの高さ
    required double toolbarHeight,

    /// フッターの高さ
    required double footerHeight,

    /// サイドバーの幅
    required double sidebarWidth,
  }) = _GridTokens;

  /// 標準のグリッドトークン
  static const standard = GridTokens(
    gridUnit: 8.0,
    columnGap: 16.0, // space2
    rowGap: 16.0, // space2
    maxContentWidth: 1200.0,
    navBarHeight: 56.0, // Material 3 standard
    toolbarHeight: 56.0, // Material 3 standard
    footerHeight: 72.0, // space8 + space1
    sidebarWidth: 280.0, // 35 * gridUnit
  );

  /// モバイル用のグリッドトークン
  static const mobile = GridTokens(
    gridUnit: 6.0,
    columnGap: 12.0, // compact space2
    rowGap: 12.0, // compact space2
    maxContentWidth: 600.0,
    navBarHeight: 56.0, // Material 3 standard
    toolbarHeight: 56.0, // Material 3 standard
    footerHeight: 64.0, // compact space8
    sidebarWidth: 240.0, // 40 * gridUnit
  );

  /// タブレット用のグリッドトークン
  static const tablet = GridTokens(
    gridUnit: 10.0,
    columnGap: 20.0, // expanded space2
    rowGap: 20.0, // expanded space2
    maxContentWidth: 900.0,
    navBarHeight: 64.0, // expanded
    toolbarHeight: 64.0, // expanded
    footerHeight: 80.0, // expanded space8
    sidebarWidth: 320.0, // 32 * gridUnit
  );
}

/// レスポンシブスペーシングユーティリティ
class ResponsiveSpacing {
  /// 画面幅に基づいてスペーシングトークンを選択
  static SpacingTokens getSpacingTokens(double screenWidth) {
    if (screenWidth < 600) {
      return SpacingTokens.compact;
    } else if (screenWidth > 1024) {
      return SpacingTokens.expanded;
    } else {
      return SpacingTokens.standard;
    }
  }

  /// 画面幅に基づいてインセットトークンを選択
  static InsetTokens getInsetTokens(double screenWidth) {
    if (screenWidth < 600) {
      return InsetTokens.compact;
    } else if (screenWidth > 1024) {
      return InsetTokens.expanded;
    } else {
      return InsetTokens.standard;
    }
  }

  /// 画面幅に基づいてグリッドトークンを選択
  static GridTokens getGridTokens(double screenWidth) {
    if (screenWidth < 600) {
      return GridTokens.mobile;
    } else if (screenWidth > 1024) {
      return GridTokens.tablet;
    } else {
      return GridTokens.standard;
    }
  }

  /// カスタムスペース値を計算
  static double calculateSpace({
    required double baseUnit,
    required double multiplier,
    double min = 0.0,
    double max = double.infinity,
  }) {
    final double value = baseUnit * multiplier;
    return value.clamp(min, max);
  }
}

/// スペーシングユーティリティ拡張
extension SpacingExtensions on SpacingTokens {
  /// カスタム倍数でスペースを計算
  double custom(double multiplier) {
    return baseUnit * multiplier;
  }

  /// 最小値を適用
  double withMin(double value, double min) {
    return math.max(value, min);
  }

  /// 最大値を適用
  double withMax(double value, double max) {
    return math.min(value, max);
  }

  /// 範囲内に制限
  double clamp(double value, double min, double max) {
    return value.clamp(min, max);
  }
}
