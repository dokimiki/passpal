import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/typography_tokens.dart';

class TypographyGenerator {
  const TypographyGenerator._();

  /// Google Fonts を使用して Inter フォントベースの TextTheme を生成
  static TextTheme generateTextTheme({
    required Brightness brightness,
    Color? textColor,
    TypographyTokens? customTokens,
  }) {
    final tokens = customTokens ?? TypographyTokens.standard;
    
    // Inter フォントを使用したベーステーマを生成
    final interTheme = GoogleFonts.interTextTheme();
    
    // デザイントークンの設定を適用してカスタマイズ
    return interTheme.copyWith(
      // Display styles
      displayLarge: _applyTokenStyle(
        interTheme.displayLarge,
        tokens.display.displayLarge,
        textColor,
      ),
      displayMedium: _applyTokenStyle(
        interTheme.displayMedium,
        tokens.display.displayMedium,
        textColor,
      ),
      displaySmall: _applyTokenStyle(
        interTheme.displaySmall,
        tokens.display.displaySmall,
        textColor,
      ),
      
      // Headline styles
      headlineLarge: _applyTokenStyle(
        interTheme.headlineLarge,
        tokens.headline.headlineLarge,
        textColor,
      ),
      headlineMedium: _applyTokenStyle(
        interTheme.headlineMedium,
        tokens.headline.headlineMedium,
        textColor,
      ),
      headlineSmall: _applyTokenStyle(
        interTheme.headlineSmall,
        tokens.headline.headlineSmall,
        textColor,
      ),
      
      // Title styles
      titleLarge: _applyTokenStyle(
        interTheme.titleLarge,
        tokens.title.titleLarge,
        textColor,
      ),
      titleMedium: _applyTokenStyle(
        interTheme.titleMedium,
        tokens.title.titleMedium,
        textColor,
      ),
      titleSmall: _applyTokenStyle(
        interTheme.titleSmall,
        tokens.title.titleSmall,
        textColor,
      ),
      
      // Label styles
      labelLarge: _applyTokenStyle(
        interTheme.labelLarge,
        tokens.label.labelLarge,
        textColor,
      ),
      labelMedium: _applyTokenStyle(
        interTheme.labelMedium,
        tokens.label.labelMedium,
        textColor,
      ),
      labelSmall: _applyTokenStyle(
        interTheme.labelSmall,
        tokens.label.labelSmall,
        textColor,
      ),
      
      // Body styles
      bodyLarge: _applyTokenStyle(
        interTheme.bodyLarge,
        tokens.body.bodyLarge,
        textColor,
      ),
      bodyMedium: _applyTokenStyle(
        interTheme.bodyMedium,
        tokens.body.bodyMedium,
        textColor,
      ),
      bodySmall: _applyTokenStyle(
        interTheme.bodySmall,
        tokens.body.bodySmall,
        textColor,
      ),
    );
  }

  /// レスポンシブ対応のTextThemeを生成
  static TextTheme generateResponsiveTextTheme({
    required Brightness brightness,
    required double screenWidth,
    Color? textColor,
    TypographyTokens? customTokens,
    double minScale = 0.8,
    double maxScale = 1.2,
  }) {
    final baseTheme = generateTextTheme(
      brightness: brightness,
      textColor: textColor,
      customTokens: customTokens,
    );

    return TextTheme(
      // Display styles
      displayLarge: baseTheme.displayLarge?.responsive(
        screenWidth: screenWidth,
        minScale: minScale,
        maxScale: maxScale,
      ),
      displayMedium: baseTheme.displayMedium?.responsive(
        screenWidth: screenWidth,
        minScale: minScale,
        maxScale: maxScale,
      ),
      displaySmall: baseTheme.displaySmall?.responsive(
        screenWidth: screenWidth,
        minScale: minScale,
        maxScale: maxScale,
      ),
      
      // Headline styles
      headlineLarge: baseTheme.headlineLarge?.responsive(
        screenWidth: screenWidth,
        minScale: minScale,
        maxScale: maxScale,
      ),
      headlineMedium: baseTheme.headlineMedium?.responsive(
        screenWidth: screenWidth,
        minScale: minScale,
        maxScale: maxScale,
      ),
      headlineSmall: baseTheme.headlineSmall?.responsive(
        screenWidth: screenWidth,
        minScale: minScale,
        maxScale: maxScale,
      ),
      
      // Title styles
      titleLarge: baseTheme.titleLarge?.responsive(
        screenWidth: screenWidth,
        minScale: minScale,
        maxScale: maxScale,
      ),
      titleMedium: baseTheme.titleMedium?.responsive(
        screenWidth: screenWidth,
        minScale: minScale,
        maxScale: maxScale,
      ),
      titleSmall: baseTheme.titleSmall?.responsive(
        screenWidth: screenWidth,
        minScale: minScale,
        maxScale: maxScale,
      ),
      
      // Label styles
      labelLarge: baseTheme.labelLarge?.responsive(
        screenWidth: screenWidth,
        minScale: minScale,
        maxScale: maxScale,
      ),
      labelMedium: baseTheme.labelMedium?.responsive(
        screenWidth: screenWidth,
        minScale: minScale,
        maxScale: maxScale,
      ),
      labelSmall: baseTheme.labelSmall?.responsive(
        screenWidth: screenWidth,
        minScale: minScale,
        maxScale: maxScale,
      ),
      
      // Body styles
      bodyLarge: baseTheme.bodyLarge?.responsive(
        screenWidth: screenWidth,
        minScale: minScale,
        maxScale: maxScale,
      ),
      bodyMedium: baseTheme.bodyMedium?.responsive(
        screenWidth: screenWidth,
        minScale: minScale,
        maxScale: maxScale,
      ),
      bodySmall: baseTheme.bodySmall?.responsive(
        screenWidth: screenWidth,
        minScale: minScale,
        maxScale: maxScale,
      ),
    );
  }

  /// アクセシビリティ対応のTextThemeを生成
  static TextTheme generateAccessibleTextTheme({
    required Brightness brightness,
    Color? textColor,
    TypographyTokens? customTokens,
    double fontSizeScale = 1.0,
    double lineHeightScale = 1.0,
    FontWeight? accessibilityWeight,
  }) {
    final baseTheme = generateTextTheme(
      brightness: brightness,
      textColor: textColor,
      customTokens: customTokens,
    );

    return TextTheme(
      // Display styles
      displayLarge: baseTheme.displayLarge?.accessible(
        fontSizeScale: fontSizeScale,
        lineHeightScale: lineHeightScale,
        accessibilityWeight: accessibilityWeight,
      ),
      displayMedium: baseTheme.displayMedium?.accessible(
        fontSizeScale: fontSizeScale,
        lineHeightScale: lineHeightScale,
        accessibilityWeight: accessibilityWeight,
      ),
      displaySmall: baseTheme.displaySmall?.accessible(
        fontSizeScale: fontSizeScale,
        lineHeightScale: lineHeightScale,
        accessibilityWeight: accessibilityWeight,
      ),
      
      // Headline styles
      headlineLarge: baseTheme.headlineLarge?.accessible(
        fontSizeScale: fontSizeScale,
        lineHeightScale: lineHeightScale,
        accessibilityWeight: accessibilityWeight,
      ),
      headlineMedium: baseTheme.headlineMedium?.accessible(
        fontSizeScale: fontSizeScale,
        lineHeightScale: lineHeightScale,
        accessibilityWeight: accessibilityWeight,
      ),
      headlineSmall: baseTheme.headlineSmall?.accessible(
        fontSizeScale: fontSizeScale,
        lineHeightScale: lineHeightScale,
        accessibilityWeight: accessibilityWeight,
      ),
      
      // Title styles
      titleLarge: baseTheme.titleLarge?.accessible(
        fontSizeScale: fontSizeScale,
        lineHeightScale: lineHeightScale,
        accessibilityWeight: accessibilityWeight,
      ),
      titleMedium: baseTheme.titleMedium?.accessible(
        fontSizeScale: fontSizeScale,
        lineHeightScale: lineHeightScale,
        accessibilityWeight: accessibilityWeight,
      ),
      titleSmall: baseTheme.titleSmall?.accessible(
        fontSizeScale: fontSizeScale,
        lineHeightScale: lineHeightScale,
        accessibilityWeight: accessibilityWeight,
      ),
      
      // Label styles
      labelLarge: baseTheme.labelLarge?.accessible(
        fontSizeScale: fontSizeScale,
        lineHeightScale: lineHeightScale,
        accessibilityWeight: accessibilityWeight,
      ),
      labelMedium: baseTheme.labelMedium?.accessible(
        fontSizeScale: fontSizeScale,
        lineHeightScale: lineHeightScale,
        accessibilityWeight: accessibilityWeight,
      ),
      labelSmall: baseTheme.labelSmall?.accessible(
        fontSizeScale: fontSizeScale,
        lineHeightScale: lineHeightScale,
        accessibilityWeight: accessibilityWeight,
      ),
      
      // Body styles
      bodyLarge: baseTheme.bodyLarge?.accessible(
        fontSizeScale: fontSizeScale,
        lineHeightScale: lineHeightScale,
        accessibilityWeight: accessibilityWeight,
      ),
      bodyMedium: baseTheme.bodyMedium?.accessible(
        fontSizeScale: fontSizeScale,
        lineHeightScale: lineHeightScale,
        accessibilityWeight: accessibilityWeight,
      ),
      bodySmall: baseTheme.bodySmall?.accessible(
        fontSizeScale: fontSizeScale,
        lineHeightScale: lineHeightScale,
        accessibilityWeight: accessibilityWeight,
      ),
    );
  }

  /// 日本語テキスト向けに最適化されたTextThemeを生成
  static TextTheme generateJapaneseTextTheme({
    required Brightness brightness,
    Color? textColor,
    TypographyTokens? customTokens,
  }) {
    final baseTheme = generateTextTheme(
      brightness: brightness,
      textColor: textColor,
      customTokens: customTokens,
    );

    return TextTheme(
      // Display styles
      displayLarge: baseTheme.displayLarge?.japanese(),
      displayMedium: baseTheme.displayMedium?.japanese(),
      displaySmall: baseTheme.displaySmall?.japanese(),
      
      // Headline styles
      headlineLarge: baseTheme.headlineLarge?.japanese(),
      headlineMedium: baseTheme.headlineMedium?.japanese(),
      headlineSmall: baseTheme.headlineSmall?.japanese(),
      
      // Title styles
      titleLarge: baseTheme.titleLarge?.japanese(),
      titleMedium: baseTheme.titleMedium?.japanese(),
      titleSmall: baseTheme.titleSmall?.japanese(),
      
      // Label styles
      labelLarge: baseTheme.labelLarge?.japanese(),
      labelMedium: baseTheme.labelMedium?.japanese(),
      labelSmall: baseTheme.labelSmall?.japanese(),
      
      // Body styles
      bodyLarge: baseTheme.bodyLarge?.japanese(),
      bodyMedium: baseTheme.bodyMedium?.japanese(),
      bodySmall: baseTheme.bodySmall?.japanese(),
    );
  }

  /// フォントフォールバック処理
  static TextTheme generateWithFallback({
    required Brightness brightness,
    Color? textColor,
    TypographyTokens? customTokens,
    List<String>? fallbackFonts,
  }) {
    try {
      // 通常のInter フォントテーマを生成
      return generateTextTheme(
        brightness: brightness,
        textColor: textColor,
        customTokens: customTokens,
      );
    } catch (e) {
      // フォント読み込みに失敗した場合はフォールバックを使用
      debugPrint('Inter font loading failed, using fallback: $e');
      
      final tokens = customTokens ?? TypographyTokens.standard;
      final fallbackTheme = ThemeData(brightness: brightness).textTheme;
      
      return TextTheme(
        displayLarge: _applyTokenStyleWithFallback(
          fallbackTheme.displayLarge,
          tokens.display.displayLarge,
          textColor,
          fallbackFonts,
        ),
        displayMedium: _applyTokenStyleWithFallback(
          fallbackTheme.displayMedium,
          tokens.display.displayMedium,
          textColor,
          fallbackFonts,
        ),
        displaySmall: _applyTokenStyleWithFallback(
          fallbackTheme.displaySmall,
          tokens.display.displaySmall,
          textColor,
          fallbackFonts,
        ),
        headlineLarge: _applyTokenStyleWithFallback(
          fallbackTheme.headlineLarge,
          tokens.headline.headlineLarge,
          textColor,
          fallbackFonts,
        ),
        headlineMedium: _applyTokenStyleWithFallback(
          fallbackTheme.headlineMedium,
          tokens.headline.headlineMedium,
          textColor,
          fallbackFonts,
        ),
        headlineSmall: _applyTokenStyleWithFallback(
          fallbackTheme.headlineSmall,
          tokens.headline.headlineSmall,
          textColor,
          fallbackFonts,
        ),
        titleLarge: _applyTokenStyleWithFallback(
          fallbackTheme.titleLarge,
          tokens.title.titleLarge,
          textColor,
          fallbackFonts,
        ),
        titleMedium: _applyTokenStyleWithFallback(
          fallbackTheme.titleMedium,
          tokens.title.titleMedium,
          textColor,
          fallbackFonts,
        ),
        titleSmall: _applyTokenStyleWithFallback(
          fallbackTheme.titleSmall,
          tokens.title.titleSmall,
          textColor,
          fallbackFonts,
        ),
        labelLarge: _applyTokenStyleWithFallback(
          fallbackTheme.labelLarge,
          tokens.label.labelLarge,
          textColor,
          fallbackFonts,
        ),
        labelMedium: _applyTokenStyleWithFallback(
          fallbackTheme.labelMedium,
          tokens.label.labelMedium,
          textColor,
          fallbackFonts,
        ),
        labelSmall: _applyTokenStyleWithFallback(
          fallbackTheme.labelSmall,
          tokens.label.labelSmall,
          textColor,
          fallbackFonts,
        ),
        bodyLarge: _applyTokenStyleWithFallback(
          fallbackTheme.bodyLarge,
          tokens.body.bodyLarge,
          textColor,
          fallbackFonts,
        ),
        bodyMedium: _applyTokenStyleWithFallback(
          fallbackTheme.bodyMedium,
          tokens.body.bodyMedium,
          textColor,
          fallbackFonts,
        ),
        bodySmall: _applyTokenStyleWithFallback(
          fallbackTheme.bodySmall,
          tokens.body.bodySmall,
          textColor,
          fallbackFonts,
        ),
      );
    }
  }

  /// ベーススタイルにデザイントークンの設定を適用
  static TextStyle? _applyTokenStyle(
    TextStyle? baseStyle,
    TextStyle tokenStyle,
    Color? textColor,
  ) {
    if (baseStyle == null) return null;

    return baseStyle.copyWith(
      fontSize: tokenStyle.fontSize,
      fontWeight: tokenStyle.fontWeight,
      height: tokenStyle.height,
      letterSpacing: tokenStyle.letterSpacing,
      color: textColor,
    );
  }

  /// フォールバック対応でスタイルを適用
  static TextStyle? _applyTokenStyleWithFallback(
    TextStyle? baseStyle,
    TextStyle tokenStyle,
    Color? textColor,
    List<String>? fallbackFonts,
  ) {
    if (baseStyle == null) return null;

    return baseStyle.copyWith(
      fontFamily: fallbackFonts?.isNotEmpty == true 
          ? fallbackFonts!.first 
          : baseStyle.fontFamily,
      fontSize: tokenStyle.fontSize,
      fontWeight: tokenStyle.fontWeight,
      height: tokenStyle.height,
      letterSpacing: tokenStyle.letterSpacing,
      color: textColor,
      fontFamilyFallback: fallbackFonts,
    );
  }
}

/// TextTheme の便利なextension
extension TypographyThemeExtension on TextTheme {
  /// レスポンシブ対応のTextThemeを生成
  TextTheme responsive({
    required double screenWidth,
    double minScale = 0.8,
    double maxScale = 1.2,
  }) {
    return TypographyGenerator.generateResponsiveTextTheme(
      brightness: Brightness.light, // このcontextでは不明なので一旦light
      screenWidth: screenWidth,
      minScale: minScale,
      maxScale: maxScale,
    );
  }

  /// アクセシビリティ対応のTextThemeを生成
  TextTheme accessible({
    double fontSizeScale = 1.0,
    double lineHeightScale = 1.0,
    FontWeight? accessibilityWeight,
  }) {
    return TypographyGenerator.generateAccessibleTextTheme(
      brightness: Brightness.light, // このcontextでは不明なので一旦light
      fontSizeScale: fontSizeScale,
      lineHeightScale: lineHeightScale,
      accessibilityWeight: accessibilityWeight,
    );
  }

  /// 日本語最適化版のTextThemeを生成
  TextTheme japanese() {
    return TypographyGenerator.generateJapaneseTextTheme(
      brightness: Brightness.light, // このcontextでは不明なので一旦light
    );
  }
}