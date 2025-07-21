import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'color_tokens.freezed.dart';

/// デザイントークンのカラー定義
///
/// Material 3デザインシステムに基づいたカラートークンを定義します。
/// ライトモードとダークモードの両方をサポートし、アクセシビリティ要件（WCAG 2.2 AA）を満たします。
@freezed
abstract class ColorTokens with _$ColorTokens {
  const factory ColorTokens({
    /// プライマリカラー系統
    required PrimaryColors primary,

    /// ステータスカラー系統
    required StatusColors status,

    /// ニュートラルカラー系統
    required NeutralColors neutral,

    /// 背景・サーフェスカラー系統
    required SurfaceColors surface,
  }) = _ColorTokens;

  /// ライトモード用カラートークン
  static const light = ColorTokens(
    primary: PrimaryColors.light,
    status: StatusColors.light,
    neutral: NeutralColors.light,
    surface: SurfaceColors.light,
  );

  /// ダークモード用カラートークン
  static const dark = ColorTokens(
    primary: PrimaryColors.dark,
    status: StatusColors.dark,
    neutral: NeutralColors.dark,
    surface: SurfaceColors.dark,
  );
}

/// プライマリカラー系統
@freezed
abstract class PrimaryColors with _$PrimaryColors {
  const factory PrimaryColors({
    /// メインプライマリカラー（#B1BCD9 ベース）
    required Color primary,

    /// プライマリカラーのバリエーション
    required Color primary50,
    required Color primary100,
    required Color primary200,
    required Color primary300,
    required Color primary400,
    required Color primary500,
    required Color primary600,
    required Color primary700,
    required Color primary800,
    required Color primary900,

    /// プライマリカラーのオンカラー
    required Color onPrimary,
    required Color onPrimaryContainer,

    /// プライマリコンテナ
    required Color primaryContainer,
  }) = _PrimaryColors;

  /// ライトモード用プライマリカラー
  static const light = PrimaryColors(
    primary: Color(0xFFB1BCD9),
    primary50: Color(0xFFF7F8FB),
    primary100: Color(0xFFECEEF4),
    primary200: Color(0xFFD5DCE8),
    primary300: Color(0xFFB1BCD9),
    primary400: Color(0xFF8E9CC4),
    primary500: Color(0xFF6B7CAF),
    primary600: Color(0xFF5A6A96),
    primary700: Color(0xFF495575),
    primary800: Color(0xFF384054),
    primary900: Color(0xFF272B33),
    onPrimary: Color(0xFFFFFFFF),
    onPrimaryContainer: Color(0xFF101418),
    primaryContainer: Color(0xFFE8ECFF),
  );

  /// ダークモード用プライマリカラー
  static const dark = PrimaryColors(
    primary: Color(0xFF8E9CC4),
    primary50: Color(0xFF272B33),
    primary100: Color(0xFF384054),
    primary200: Color(0xFF495575),
    primary300: Color(0xFF5A6A96),
    primary400: Color(0xFF6B7CAF),
    primary500: Color(0xFF8E9CC4),
    primary600: Color(0xFFB1BCD9),
    primary700: Color(0xFFD5DCE8),
    primary800: Color(0xFFECEEF4),
    primary900: Color(0xFFF7F8FB),
    onPrimary: Color(0xFF272B33),
    onPrimaryContainer: Color(0xFFE8ECFF),
    primaryContainer: Color(0xFF495575),
  );
}

/// ステータスカラー系統
@freezed
abstract class StatusColors with _$StatusColors {
  const factory StatusColors({
    /// 成功状態
    required Color success,
    required Color onSuccess,
    required Color successContainer,
    required Color onSuccessContainer,

    /// 警告状態
    required Color warning,
    required Color onWarning,
    required Color warningContainer,
    required Color onWarningContainer,

    /// エラー状態
    required Color error,
    required Color onError,
    required Color errorContainer,
    required Color onErrorContainer,

    /// 情報状態
    required Color info,
    required Color onInfo,
    required Color infoContainer,
    required Color onInfoContainer,
  }) = _StatusColors;

  /// ライトモード用ステータスカラー
  static const light = StatusColors(
    success: Color(0xFF2E7D32),
    onSuccess: Color(0xFFFFFFFF),
    successContainer: Color(0xFFC8E6C9),
    onSuccessContainer: Color(0xFF1B5E20),
    warning: Color(0xFFF57C00),
    onWarning: Color(0xFFFFFFFF),
    warningContainer: Color(0xFFFFE0B2),
    onWarningContainer: Color(0xFFE65100),
    error: Color(0xFFD32F2F),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFCDD2),
    onErrorContainer: Color(0xFFB71C1C),
    info: Color(0xFF1976D2),
    onInfo: Color(0xFFFFFFFF),
    infoContainer: Color(0xFFBBDEFB),
    onInfoContainer: Color(0xFF0D47A1),
  );

  /// ダークモード用ステータスカラー
  static const dark = StatusColors(
    success: Color(0xFF66BB6A),
    onSuccess: Color(0xFF1B5E20),
    successContainer: Color(0xFF2E7D32),
    onSuccessContainer: Color(0xFFC8E6C9),
    warning: Color(0xFFFFB74D),
    onWarning: Color(0xFFE65100),
    warningContainer: Color(0xFFF57C00),
    onWarningContainer: Color(0xFFFFE0B2),
    error: Color(0xFFEF5350),
    onError: Color(0xFFB71C1C),
    errorContainer: Color(0xFFD32F2F),
    onErrorContainer: Color(0xFFFFCDD2),
    info: Color(0xFF42A5F5),
    onInfo: Color(0xFF0D47A1),
    infoContainer: Color(0xFF1976D2),
    onInfoContainer: Color(0xFFBBDEFB),
  );
}

/// ニュートラルカラー系統
@freezed
abstract class NeutralColors with _$NeutralColors {
  const factory NeutralColors({
    /// ニュートラルカラー段階
    required Color neutral0, // 純白/純黒
    required Color neutral10,
    required Color neutral20,
    required Color neutral30,
    required Color neutral40,
    required Color neutral50,
    required Color neutral60,
    required Color neutral70,
    required Color neutral80,
    required Color neutral90,
    required Color neutral95,
    required Color neutral99,
    required Color neutral100, // 純黒/純白
    /// アウトライン用
    required Color outline,
    required Color outlineVariant,
  }) = _NeutralColors;

  /// ライトモード用ニュートラルカラー
  static const light = NeutralColors(
    neutral0: Color(0xFFFFFFFF),
    neutral10: Color(0xFFF7F8FB),
    neutral20: Color(0xFFEEF0F4),
    neutral30: Color(0xFFE4E7ED),
    neutral40: Color(0xFFD1D5DC),
    neutral50: Color(0xFFBDC2CB),
    neutral60: Color(0xFFA8AFBA),
    neutral70: Color(0xFF949CA9),
    neutral80: Color(0xFF7F8998),
    neutral90: Color(0xFF6B7687),
    neutral95: Color(0xFF586376),
    neutral99: Color(0xFF1A1C20),
    neutral100: Color(0xFF000000),
    outline: Color(0xFF79747E),
    outlineVariant: Color(0xFFCAC4D0),
  );

  /// ダークモード用ニュートラルカラー
  static const dark = NeutralColors(
    neutral0: Color(0xFF000000),
    neutral10: Color(0xFF1A1C20),
    neutral20: Color(0xFF2F3135),
    neutral30: Color(0xFF45464A),
    neutral40: Color(0xFF5C5B5F),
    neutral50: Color(0xFF737074),
    neutral60: Color(0xFF8A8589),
    neutral70: Color(0xFFA19A9E),
    neutral80: Color(0xFFB8AFB3),
    neutral90: Color(0xFFCFC4C8),
    neutral95: Color(0xFFE6D9DD),
    neutral99: Color(0xFFF7F8FB),
    neutral100: Color(0xFFFFFFFF),
    outline: Color(0xFF938F99),
    outlineVariant: Color(0xFF49454F),
  );
}

/// サーフェス・背景カラー系統
@freezed
abstract class SurfaceColors with _$SurfaceColors {
  const factory SurfaceColors({
    /// 背景色
    required Color background,
    required Color onBackground,

    /// サーフェス色
    required Color surface,
    required Color onSurface,
    required Color surfaceVariant,
    required Color onSurfaceVariant,

    /// サーフェス段階
    required Color surfaceDim,
    required Color surfaceBright,
    required Color surfaceContainerLowest,
    required Color surfaceContainerLow,
    required Color surfaceContainer,
    required Color surfaceContainerHigh,
    required Color surfaceContainerHighest,

    /// インバースサーフェス
    required Color inverseSurface,
    required Color onInverseSurface,
    required Color inversePrimary,

    /// シャドウとスクリム
    required Color shadow,
    required Color scrim,
  }) = _SurfaceColors;

  /// ライトモード用サーフェスカラー
  static const light = SurfaceColors(
    background: Color(0xFFFEFBFF),
    onBackground: Color(0xFF1C1B1F),
    surface: Color(0xFFFEFBFF),
    onSurface: Color(0xFF1C1B1F),
    surfaceVariant: Color(0xFFE7E0EC),
    onSurfaceVariant: Color(0xFF49454F),
    surfaceDim: Color(0xFFDDD8E1),
    surfaceBright: Color(0xFFFEFBFF),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF7F2FA),
    surfaceContainer: Color(0xFFF3EDF7),
    surfaceContainerHigh: Color(0xFFECE6F0),
    surfaceContainerHighest: Color(0xFFE6E0E9),
    inverseSurface: Color(0xFF313033),
    onInverseSurface: Color(0xFFF4EFF4),
    inversePrimary: Color(0xFFD0BCFF),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );

  /// ダークモード用サーフェスカラー
  static const dark = SurfaceColors(
    background: Color(0xFF141218),
    onBackground: Color(0xFFE6E0E9),
    surface: Color(0xFF141218),
    onSurface: Color(0xFFE6E0E9),
    surfaceVariant: Color(0xFF49454F),
    onSurfaceVariant: Color(0xFFCAC4D0),
    surfaceDim: Color(0xFF141218),
    surfaceBright: Color(0xFF3B383E),
    surfaceContainerLowest: Color(0xFF0F0D13),
    surfaceContainerLow: Color(0xFF1D1B20),
    surfaceContainer: Color(0xFF211F26),
    surfaceContainerHigh: Color(0xFF2B2930),
    surfaceContainerHighest: Color(0xFF36343B),
    inverseSurface: Color(0xFFE6E0E9),
    onInverseSurface: Color(0xFF313033),
    inversePrimary: Color(0xFF6750A4),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );
}
