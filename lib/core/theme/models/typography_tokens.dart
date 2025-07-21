import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'typography_tokens.freezed.dart';

/// デザイントークンのタイポグラフィ定義
///
/// Material 3デザインシステムに基づいたタイポグラフィトークンを定義します。
/// Inter フォントを使用し、階層的なテキストスタイルを提供します。
@freezed
abstract class TypographyTokens with _$TypographyTokens {
  const factory TypographyTokens({
    /// ディスプレイ系統（最大サイズ）
    required DisplayTokens display,

    /// ヘッドライン系統
    required HeadlineTokens headline,

    /// タイトル系統
    required TitleTokens title,

    /// ラベル系統
    required LabelTokens label,

    /// ボディ系統
    required BodyTokens body,
  }) = _TypographyTokens;

  /// デフォルトタイポグラフィトークン
  static const standard = TypographyTokens(
    display: DisplayTokens.standard,
    headline: HeadlineTokens.standard,
    title: TitleTokens.standard,
    label: LabelTokens.standard,
    body: BodyTokens.standard,
  );
}

/// ディスプレイレベルのタイポグラフィ
@freezed
abstract class DisplayTokens with _$DisplayTokens {
  const factory DisplayTokens({
    /// Display Large (最大サイズ、ランディングページなど)
    required TextStyle displayLarge,

    /// Display Medium
    required TextStyle displayMedium,

    /// Display Small
    required TextStyle displaySmall,
  }) = _DisplayTokens;

  /// 標準のディスプレイトークン
  static const standard = DisplayTokens(
    displayLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 57.0,
      fontWeight: FontWeight.w400,
      height: 1.12, // 64sp line height
      letterSpacing: -0.25,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 45.0,
      fontWeight: FontWeight.w400,
      height: 1.16, // 52sp line height
      letterSpacing: 0.0,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 36.0,
      fontWeight: FontWeight.w400,
      height: 1.22, // 44sp line height
      letterSpacing: 0.0,
    ),
  );
}

/// ヘッドラインレベルのタイポグラフィ
@freezed
abstract class HeadlineTokens with _$HeadlineTokens {
  const factory HeadlineTokens({
    /// Headline Large (主要見出し)
    required TextStyle headlineLarge,

    /// Headline Medium (セクション見出し)
    required TextStyle headlineMedium,

    /// Headline Small (サブセクション見出し)
    required TextStyle headlineSmall,
  }) = _HeadlineTokens;

  /// 標準のヘッドライントークン
  static const standard = HeadlineTokens(
    headlineLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 32.0,
      fontWeight: FontWeight.w400,
      height: 1.25, // 40sp line height
      letterSpacing: 0.0,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 28.0,
      fontWeight: FontWeight.w400,
      height: 1.29, // 36sp line height
      letterSpacing: 0.0,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
      height: 1.33, // 32sp line height
      letterSpacing: 0.0,
    ),
  );
}

/// タイトルレベルのタイポグラフィ
@freezed
abstract class TitleTokens with _$TitleTokens {
  const factory TitleTokens({
    /// Title Large (ページタイトル、ダイアログタイトル)
    required TextStyle titleLarge,

    /// Title Medium (カードタイトル、リストヘッダー)
    required TextStyle titleMedium,

    /// Title Small (サブタイトル、カテゴリラベル)
    required TextStyle titleSmall,
  }) = _TitleTokens;

  /// 標準のタイトルトークン
  static const standard = TitleTokens(
    titleLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 22.0,
      fontWeight: FontWeight.w400,
      height: 1.27, // 28sp line height
      letterSpacing: 0.0,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      height: 1.50, // 24sp line height
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      height: 1.43, // 20sp line height
      letterSpacing: 0.1,
    ),
  );
}

/// ラベルレベルのタイポグラフィ
@freezed
abstract class LabelTokens with _$LabelTokens {
  const factory LabelTokens({
    /// Label Large (ボタンテキスト、タブラベル)
    required TextStyle labelLarge,

    /// Label Medium (チップ、バッジ)
    required TextStyle labelMedium,

    /// Label Small (補助ラベル、ヒント)
    required TextStyle labelSmall,
  }) = _LabelTokens;

  /// 標準のラベルトークン
  static const standard = LabelTokens(
    labelLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      height: 1.43, // 20sp line height
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      height: 1.33, // 16sp line height
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      height: 1.45, // 16sp line height
      letterSpacing: 0.5,
    ),
  );
}

/// ボディレベルのタイポグラフィ
@freezed
abstract class BodyTokens with _$BodyTokens {
  const factory BodyTokens({
    /// Body Large (本文テキスト、段落)
    required TextStyle bodyLarge,

    /// Body Medium (リストアイテム、説明テキスト)
    required TextStyle bodyMedium,

    /// Body Small (キャプション、補足テキスト)
    required TextStyle bodySmall,
  }) = _BodyTokens;

  /// 標準のボディトークン
  static const standard = BodyTokens(
    bodyLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 1.50, // 24sp line height
      letterSpacing: 0.15,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      height: 1.43, // 20sp line height
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      height: 1.33, // 16sp line height
      letterSpacing: 0.4,
    ),
  );
}

/// フォントウェイト定数
class FontWeights {
  /// Thin (100)
  static const FontWeight thin = FontWeight.w100;

  /// ExtraLight (200)
  static const FontWeight extraLight = FontWeight.w200;

  /// Light (300)
  static const FontWeight light = FontWeight.w300;

  /// Regular (400) - デフォルト
  static const FontWeight regular = FontWeight.w400;

  /// Medium (500) - 強調
  static const FontWeight medium = FontWeight.w500;

  /// SemiBold (600)
  static const FontWeight semiBold = FontWeight.w600;

  /// Bold (700) - 太字
  static const FontWeight bold = FontWeight.w700;

  /// ExtraBold (800)
  static const FontWeight extraBold = FontWeight.w800;

  /// Black (900)
  static const FontWeight black = FontWeight.w900;
}

/// レスポンシブタイポグラフィユーティリティ
class ResponsiveTypography {
  /// 画面サイズに応じてフォントサイズを調整
  static double getResponsiveFontSize({
    required double baseFontSize,
    required double screenWidth,
    double minScale = 0.8,
    double maxScale = 1.2,
  }) {
    // 320px (最小) から 768px (タブレット) の範囲でスケール
    const double minWidth = 320.0;
    const double maxWidth = 768.0;

    if (screenWidth <= minWidth) {
      return baseFontSize * minScale;
    } else if (screenWidth >= maxWidth) {
      return baseFontSize * maxScale;
    } else {
      final double ratio = (screenWidth - minWidth) / (maxWidth - minWidth);
      final double scale = minScale + (maxScale - minScale) * ratio;
      return baseFontSize * scale;
    }
  }

  /// 行間を動的に調整
  static double getResponsiveLineHeight({
    required double baseLineHeight,
    required double fontSize,
    double minLineHeight = 1.2,
    double maxLineHeight = 1.8,
  }) {
    // フォントサイズに応じて行間を調整
    if (fontSize <= 12.0) {
      return maxLineHeight;
    } else if (fontSize >= 24.0) {
      return minLineHeight;
    } else {
      final double ratio = (fontSize - 12.0) / (24.0 - 12.0);
      return maxLineHeight - (maxLineHeight - minLineHeight) * ratio;
    }
  }
}

/// タイポグラフィユーティリティ関数
extension TypographyExtensions on TextStyle {
  /// フォントサイズを画面幅に応じて調整
  TextStyle responsive({
    required double screenWidth,
    double minScale = 0.8,
    double maxScale = 1.2,
  }) {
    final double responsiveFontSize =
        ResponsiveTypography.getResponsiveFontSize(
          baseFontSize: fontSize ?? 14.0,
          screenWidth: screenWidth,
          minScale: minScale,
          maxScale: maxScale,
        );

    final double responsiveLineHeight =
        ResponsiveTypography.getResponsiveLineHeight(
          baseLineHeight: height ?? 1.4,
          fontSize: responsiveFontSize,
        );

    return copyWith(fontSize: responsiveFontSize, height: responsiveLineHeight);
  }

  /// アクセシビリティ用の調整
  TextStyle accessible({
    double fontSizeScale = 1.0,
    double lineHeightScale = 1.0,
    FontWeight? accessibilityWeight,
  }) {
    return copyWith(
      fontSize: (fontSize ?? 14.0) * fontSizeScale,
      height: (height ?? 1.4) * lineHeightScale,
      fontWeight: accessibilityWeight ?? fontWeight,
    );
  }

  /// 日本語テキスト用の調整
  TextStyle japanese() {
    return copyWith(
      // 日本語フォントでは少し行間を広めに取る
      height: (height ?? 1.4) * 1.1,
      // 文字間隔を若干調整
      letterSpacing: (letterSpacing ?? 0.0) * 0.8,
    );
  }
}
