import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'elevation_tokens.freezed.dart';

/// デザイントークンのエレベーション（影・深度）定義
///
/// Material 3デザインシステムに基づいたエレベーショントークンを定義します。
/// 一貫性のあるコンポーネント深度表現を提供します。
@freezed
abstract class ElevationTokens with _$ElevationTokens {
  const factory ElevationTokens({
    /// エレベーションなし
    required double level0,

    /// レベル1（わずかな浮き上がり）
    required double level1,

    /// レベル2（標準的な浮き上がり）
    required double level2,

    /// レベル3（明確な浮き上がり）
    required double level3,

    /// レベル4（強い浮き上がり）
    required double level4,

    /// レベル5（最大の浮き上がり）
    required double level5,
  }) = _ElevationTokens;

  /// 標準のエレベーショントークン
  static const standard = ElevationTokens(
    level0: 0.0,
    level1: 1.0,
    level2: 3.0,
    level3: 6.0,
    level4: 8.0,
    level5: 12.0,
  );
}

/// コンポーネント別のエレベーション定義
@freezed
abstract class ComponentElevationTokens with _$ComponentElevationTokens {
  const factory ComponentElevationTokens({
    /// サーフェス（背景）
    required double surface,

    /// カード
    required double card,

    /// ボタン（ElevatedButton）
    required double button,

    /// FAB（FloatingActionButton）
    required double fab,

    /// ナビゲーションバー
    required double navigationBar,

    /// アプリバー
    required double appBar,

    /// ドロワー
    required double drawer,

    /// モーダル・ダイアログ
    required double modal,

    /// メニュー・ドロップダウン
    required double menu,

    /// スナックバー
    required double snackbar,

    /// ツールチップ
    required double tooltip,

    /// ボトムシート
    required double bottomSheet,

    /// タブバー
    required double tabBar,

    /// チップ
    required double chip,
  }) = _ComponentElevationTokens;

  /// 標準のコンポーネントエレベーショントークン
  static const standard = ComponentElevationTokens(
    surface: 0.0, // level0
    card: 1.0, // level1
    button: 1.0, // level1
    fab: 6.0, // level3
    navigationBar: 3.0, // level2
    appBar: 0.0, // level0 (Material 3では平面的)
    drawer: 1.0, // level1
    modal: 6.0, // level3
    menu: 3.0, // level2
    snackbar: 6.0, // level3
    tooltip: 8.0, // level4
    bottomSheet: 1.0, // level1
    tabBar: 0.0, // level0
    chip: 0.0, // level0
  );

  /// 影の強いエレベーショントークン
  static const enhanced = ComponentElevationTokens(
    surface: 0.0, // level0
    card: 3.0, // level2
    button: 3.0, // level2
    fab: 8.0, // level4
    navigationBar: 6.0, // level3
    appBar: 3.0, // level2
    drawer: 3.0, // level2
    modal: 12.0, // level5
    menu: 6.0, // level3
    snackbar: 8.0, // level4
    tooltip: 12.0, // level5
    bottomSheet: 3.0, // level2
    tabBar: 1.0, // level1
    chip: 1.0, // level1
  );

  /// フラットなエレベーショントークン
  static const flat = ComponentElevationTokens(
    surface: 0.0, // level0
    card: 0.0, // level0
    button: 0.0, // level0
    fab: 3.0, // level2
    navigationBar: 0.0, // level0
    appBar: 0.0, // level0
    drawer: 0.0, // level0
    modal: 3.0, // level2
    menu: 1.0, // level1
    snackbar: 3.0, // level2
    tooltip: 6.0, // level3
    bottomSheet: 0.0, // level0
    tabBar: 0.0, // level0
    chip: 0.0, // level0
  );
}

/// シャドウの色定義
@freezed
abstract class ShadowTokens with _$ShadowTokens {
  const factory ShadowTokens({
    /// 基本シャドウ色
    required Color shadow,

    /// アンビエントシャドウ色
    required Color ambient,

    /// キーシャドウ色
    required Color key,

    /// サーフェスシャドウ色
    required Color surface,
  }) = _ShadowTokens;

  /// ライトモード用シャドウ色
  static const light = ShadowTokens(
    shadow: Color(0xFF000000),
    ambient: Color(0x1F000000), // 12% opacity
    key: Color(0x24000000), // 14% opacity
    surface: Color(0x0D000000), // 5% opacity
  );

  /// ダークモード用シャドウ色
  static const dark = ShadowTokens(
    shadow: Color(0xFF000000),
    ambient: Color(0x3D000000), // 24% opacity
    key: Color(0x52000000), // 32% opacity
    surface: Color(0x1F000000), // 12% opacity
  );
}

/// エレベーションユーティリティ
class ElevationUtils {
  /// Material 3のエレベーションからBoxShadowを生成
  static List<BoxShadow> getBoxShadow({
    required double elevation,
    required Color shadowColor,
    double? ambientOpacity,
    double? keyOpacity,
  }) {
    if (elevation <= 0) return [];

    final double ambientRadius = elevation * 0.8;
    final double keyRadius = elevation * 1.2;
    final double ambientOffset = elevation * 0.3;
    final double keyOffset = elevation * 0.6;

    return [
      // Ambient shadow (拡散光による影)
      BoxShadow(
        color: shadowColor.withValues(alpha: ambientOpacity ?? 0.12),
        blurRadius: ambientRadius,
        offset: Offset(0, ambientOffset),
      ),
      // Key shadow (直射光による影)
      BoxShadow(
        color: shadowColor.withValues(alpha: keyOpacity ?? 0.14),
        blurRadius: keyRadius,
        offset: Offset(0, keyOffset),
      ),
    ];
  }

  /// Material 3のサーフェスティントを計算
  static Color getSurfaceTint({
    required Color baseColor,
    required Color tintColor,
    required double elevation,
    double maxOpacity = 0.15,
  }) {
    if (elevation <= 0) return baseColor;

    // エレベーションに基づくティント不透明度の計算
    final double opacity = (elevation / 12.0).clamp(0.0, 1.0) * maxOpacity;

    return Color.lerp(baseColor, tintColor, opacity) ?? baseColor;
  }

  /// レスポンシブエレベーションを計算
  static double getResponsiveElevation({
    required double baseElevation,
    required double screenWidth,
    double minScale = 0.7,
    double maxScale = 1.3,
  }) {
    const double minWidth = 320.0;
    const double maxWidth = 768.0;

    if (screenWidth <= minWidth) {
      return baseElevation * minScale;
    } else if (screenWidth >= maxWidth) {
      return baseElevation * maxScale;
    } else {
      final double ratio = (screenWidth - minWidth) / (maxWidth - minWidth);
      final double scale = minScale + (maxScale - minScale) * ratio;
      return baseElevation * scale;
    }
  }

  /// エレベーションのアニメーション用補間
  static double lerpElevation(double a, double b, double t) {
    return a + (b - a) * t;
  }

  /// エレベーションステートの計算
  static double getElevationForState({
    required double baseElevation,
    bool isHovered = false,
    bool isFocused = false,
    bool isPressed = false,
    bool isDisabled = false,
  }) {
    if (isDisabled) {
      return 0.0;
    }

    if (isPressed) {
      return baseElevation + 2.0;
    }

    if (isHovered) {
      return baseElevation + 1.0;
    }

    if (isFocused) {
      return baseElevation + 1.0;
    }

    return baseElevation;
  }
}

/// Material 3エレベーション定数
class Material3Elevation {
  /// Surface (0dp)
  static const double surface = 0.0;

  /// Surface Container (1dp)
  static const double surfaceContainer = 1.0;

  /// Surface Container High (3dp)
  static const double surfaceContainerHigh = 3.0;

  /// Surface Container Highest (6dp)
  static const double surfaceContainerHighest = 6.0;

  /// App bars in scrolled state (3dp)
  static const double appBarScrolled = 3.0;

  /// Cards (1dp)
  static const double card = 1.0;

  /// Elevated buttons (1dp)
  static const double elevatedButton = 1.0;

  /// Floating action buttons (6dp)
  static const double fab = 6.0;

  /// Navigation drawers (1dp)
  static const double navigationDrawer = 1.0;

  /// Modal bottom sheets (1dp)
  static const double modalBottomSheet = 1.0;

  /// Standard bottom sheets (1dp)
  static const double standardBottomSheet = 1.0;

  /// Dialogs (6dp)
  static const double dialog = 6.0;

  /// Menus (3dp)
  static const double menu = 3.0;

  /// Search bars (6dp)
  static const double searchBar = 6.0;

  /// Snackbars (6dp)
  static const double snackbar = 6.0;

  /// Tooltips (8dp)
  static const double tooltip = 8.0;
}
