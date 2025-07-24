# Theme Core Module

Material 3対応の統一テーマシステム。ライト/ダークモード、アクセシビリティサポート、デザイントークンを提供。

## Overview

PassPalアプリのためのテーマシステムです：

- **Material 3デザイン**: 最新のデザイン仕様に完全対応
- **アクセシビリティファースト**: 色覚支援、ハイコントラスト、WCAG 2.2準拠
- **デザイントークン**: 一貫性のある色、タイポグラフィ、スペーシング
- **Riverpod統合**: リアクティブなテーマ管理

## Quick Start

### 基本セットアップ

```dart
import 'package:passpal/core/theme/providers.dart';

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(currentThemeDataProvider);
    
    return MaterialApp(
      theme: themeData.when(
        data: (theme) => theme,
        loading: () => ThemeData.light(),
        error: (_, __) => ThemeData.light(),
      ),
      home: HomeScreen(),
    );
  }
}
```

### テーマモード変更

```dart
// ライト/ダーク/システム切り替え
ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.dark);

// 現在のテーマモード確認
final isDark = ref.watch(isDarkModeProvider);
```

## Design Tokens

### Colors

```dart
// ステータスカラー
final colors = Theme.of(context).extension<StatusColors>()!;
Container(
  color: colors.success,  // #4CAF50
  child: Text('成功'),
);

// カラースキーム
final colorScheme = Theme.of(context).colorScheme;
Card(
  color: colorScheme.surface,
  child: Text('カード'),
);
```

### Typography

```dart
// Material 3 タイポグラフィ（Inter font）
Text(
  '見出し',
  style: Theme.of(context).textTheme.headlineMedium,
);

// レスポンシブテキスト
Text(
  'レスポンシブ',
  style: Theme.of(context).textTheme.responsive(),
);

// 日本語最適化
Text(
  'にほんご',
  style: Theme.of(context).textTheme.japanese(),
);
```

### Spacing

```dart
// 8pxベーススケール
final spacing = Theme.of(context).extension<SpacingTokensExtension>()!;

Padding(
  padding: spacing.all.md,    // 16px
  child: Column(
    children: [
      Text('タイトル'),
      spacing.vertical.sm,      // SizedBox(height: 8)
      Text('本文'),
    ],
  ),
);

// レスポンシブスペーシング
Container(
  margin: spacing.responsive.horizontal,
  child: Content(),
);
```

### Border Radius

```dart
// Material 3 角丸
final radius = Theme.of(context).extension<RadiusTokensExtension>()!;

Container(
  decoration: BoxDecoration(
    borderRadius: radius.component.card,  // BorderRadius.circular(12)
    color: Theme.of(context).colorScheme.surface,
  ),
  child: Content(),
);

// カスタム角丸
Card(
  shape: radius.component.ratingCard(),
  child: RatingStars(),
);
```

### Elevation & Shadows

```dart
// Material 3 エレベーション
final elevation = Theme.of(context).extension<ElevationTokensExtension>()!;

Material(
  elevation: elevation.level.dp4,
  shadowColor: elevation.shadow.medium,
  child: Card(),
);

// インタラクティブエレベーション
Material(
  elevation: elevation.interactive.resting,
  child: InkWell(
    onTap: () => setState(() => elevation.interactive.pressed),
    child: Button(),
  ),
);
```

### Motion & Animation

```dart
// アニメーション時間とカーブ
final motion = Theme.of(context).extension<MotionTokensExtension>()!;

AnimatedContainer(
  duration: motion.duration.medium,     // 300ms
  curve: motion.easing.standard,        // Curves.easeInOut
  color: isSelected ? selectedColor : normalColor,
);

// アクセシビリティ対応アニメーション
AnimatedSwitcher(
  duration: motion.accessible.duration,
  child: content,
);
```

## Accessibility

### High Contrast Theme

```dart
// ハイコントラストテーマ自動適用
class AccessibleApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(accessibilityAwareThemeProvider);
    
    return MaterialApp(
      theme: themeData,
      home: HomeScreen(),
    );
  }
}
```

### Color Blindness Support

```dart
// 色覚支援テーマ
final colorBlindTheme = ref.watch(colorBlindFriendlyThemeProvider(
  ColorBlindType.deuteranopia,
));

// カラーコントラスト検証
final generator = ColorSchemeGenerator();
final contrast = generator.calculateContrast(
  foreground: Colors.black,
  background: Colors.white,
); // 21.0（AAA準拠）
```

### Motion Preferences

```dart
// モーション削減対応
final motion = ref.watch(accessibilityAwareMotionProvider);

AnimatedContainer(
  duration: motion.duration.short,  // システム設定に応じて調整
  curve: motion.easing.standard,
  child: content,
);
```

## Advanced Usage

### Custom Theme Extensions

```dart
// カスタム拡張作成
class CustomColorsExtension extends ThemeExtension<CustomColorsExtension> {
  const CustomColorsExtension({required this.accent});
  
  final Color accent;
  
  @override
  CustomColorsExtension copyWith({Color? accent}) =>
      CustomColorsExtension(accent: accent ?? this.accent);
      
  @override
  CustomColorsExtension lerp(ThemeExtension<CustomColorsExtension>? other, double t) {
    if (other is! CustomColorsExtension) return this;
    return CustomColorsExtension(
      accent: Color.lerp(accent, other.accent, t)!,
    );
  }
}

// テーマに追加
final customTheme = baseTheme.copyWith(
  extensions: [
    ...baseTheme.extensions.values,
    CustomColorsExtension(accent: Colors.purple),
  ],
);
```

### Dynamic Theme Updates

```dart
// 動的テーマ変更
class DynamicThemeNotifier extends StateNotifier<ThemeData> {
  DynamicThemeNotifier() : super(ThemeData.light());
  
  void updateAccentColor(Color color) {
    final newColorScheme = ColorScheme.fromSeed(seedColor: color);
    state = state.copyWith(colorScheme: newColorScheme);
  }
}

final dynamicThemeProvider = StateNotifierProvider<DynamicThemeNotifier, ThemeData>(
  (ref) => DynamicThemeNotifier(),
);
```

### Performance Optimization

```dart
// テーマキャッシング
final cachedThemeProvider = Provider.family<ThemeData, String>((ref, cacheKey) {
  return ref.watch(themeDataCacheProvider)[cacheKey] ?? 
         ref.watch(currentThemeDataProvider);
});

// 最小限のリビルド
class OptimizedWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 必要な部分のみ監視
    final colorScheme = ref.watch(themeColorSchemeProvider);
    final spacing = ref.watch(spacingProvider);
    
    return Container(
      color: colorScheme.surface,
      padding: spacing.all.md,
      child: content,
    );
  }
}
```

## Migration Guide

### From Theme v1

```dart
// 旧版
Container(
  color: AppColors.primary,
  padding: EdgeInsets.all(16),
);

// 新版
Container(
  color: Theme.of(context).colorScheme.primary,
  padding: context.spacing.all.md,
);
```

### Custom Extensions Migration

```dart
// 旧版のカスタムカラー
class OldColors {
  static const success = Color(0xFF4CAF50);
}

// 新版のステータスカラー
final colors = Theme.of(context).extension<StatusColors>()!;
Container(color: colors.success);
```

## Best Practices

### 1. Provider Usage

```dart
// ✅ 良い例：必要な部分のみ監視
final colorScheme = ref.watch(themeColorSchemeProvider);

// ❌ 悪い例：全テーマデータ監視
final theme = ref.watch(currentThemeDataProvider);
```

### 2. Extension Access

```dart
// ✅ 良い例：null安全アクセス
final spacing = Theme.of(context).extension<SpacingTokensExtension>();
if (spacing != null) {
  padding = spacing.all.md;
}

// ✅ より良い例：Provider経由
final spacing = ref.watch(spacingProvider);
padding = spacing.all.md;
```

### 3. Responsive Design

```dart
// ✅ 良い例：レスポンシブスペーシング
Container(
  padding: spacing.responsive.all,
  child: content,
);

// ✅ 良い例：アクセシビリティ対応
AnimatedContainer(
  duration: motion.accessible.duration,
  child: content,
);
```

### 4. Performance

```dart
// ✅ 良い例：キャッシュされたテーマ使用
class ThemeAwareWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentThemeDataProvider).when(
      data: (theme) => MaterialApp(theme: theme),
      loading: () => LoadingApp(),
      error: (_, __) => ErrorApp(),
    );
  }
}
```

## API Reference

### Core Providers

| Provider | Description | Return Type |
|----------|-------------|-------------|
| `currentThemeDataProvider` | 現在のテーマデータ | `AsyncValue<ThemeData>` |
| `themeModeProvider` | テーマモード管理 | `ThemeMode` |
| `isDarkModeProvider` | ダークモード判定 | `bool` |
| `statusColorsProvider` | ステータスカラー | `StatusColors` |
| `spacingProvider` | スペーシングトークン | `SpacingTokensExtension` |

### Extension Types

| Extension | Purpose | Key Methods |
|-----------|---------|-------------|
| `StatusColors` | 成功/警告/エラー色 | `success`, `warning`, `error`, `info` |
| `SpacingTokensExtension` | 8pxベーススケール | `all`, `horizontal`, `vertical`, `responsive` |
| `RadiusTokensExtension` | Material 3角丸 | `component`, `surface`, `interactive` |
| `ElevationTokensExtension` | 影とエレベーション | `level`, `shadow`, `interactive` |
| `MotionTokensExtension` | アニメーション | `duration`, `easing`, `accessible` |

### Accessibility Providers

| Provider | Description | Return Type |
|----------|-------------|-------------|
| `accessibilitySettingsProvider` | アクセシビリティ設定 | `AccessibilitySettings` |
| `accessibilityAwareThemeProvider` | アクセシビリティ対応テーマ | `ThemeData` |
| `colorBlindFriendlyThemeProvider` | 色覚支援テーマ | `ThemeData` |
| `highContrastThemeProvider` | ハイコントラストテーマ | `ThemeData` |

## Troubleshooting

### Common Issues

**1. Extension not found**
```dart
// 問題：Extension が null
final spacing = Theme.of(context).extension<SpacingTokensExtension>();

// 解決：Provider経由でアクセス
final spacing = ref.watch(spacingProvider);
```

**2. Theme not updating**
```dart
// 問題：テーマが更新されない
ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.dark);

// 解決：プロバイダーの依存関係確認
debugPrint(ref.read(currentThemeDataProvider).toString());
```

**3. Performance issues**
```dart
// 問題：全テーマ監視による過度なリビルド
final theme = ref.watch(currentThemeDataProvider);

// 解決：必要な部分のみ監視
final colorScheme = ref.watch(themeColorSchemeProvider);
final spacing = ref.watch(spacingProvider);
```

### Debug Utilities

```dart
// テーマ状態デバッグ
void debugThemeState(WidgetRef ref) {
  final themeMode = ref.read(themeModeProvider);
  final isDark = ref.read(isDarkModeProvider);
  final accessibility = ref.read(accessibilitySettingsProvider);
  
  print('Theme Mode: $themeMode');
  print('Is Dark: $isDark');
  print('Accessibility: $accessibility');
}
```

## Contributing

テーマシステムの改善にご協力ください：

1. **Issue報告**: バグや改善提案をGitHub Issueに報告
2. **Pull Request**: 新機能や修正のPR作成
3. **テスト**: 新機能には必ずテストを追加
4. **ドキュメント**: API変更時はドキュメント更新

### Development Setup

```bash
# 依存関係インストール
flutter pub get

# コード生成
dart run build_runner build --delete-conflicting-outputs

# テスト実行
flutter test test/core/theme/

# Golden テスト更新
flutter test --update-goldens
```

---

PassPal Theme Core Module - Material 3デザインとアクセシビリティを重視した統一テーマシステム
