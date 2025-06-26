# コアテーマ・アーキテクチャ

* Status: accepted
* Deciders: [開発チーム]
* Date: 2025-06-26
* Template used: [MADR 3.0.0](https://adr.github.io/madr/)

Technical Story: Material Design 3対応テーマシステムの実装

## Context and Problem Statement

Passpalアプリでは、一貫したブランディングとアクセシビリティを確保するため、統一されたテーマシステムが必要です。Light/Darkモード、高コントラスト、Dynamic Colorに対応し、WCAG 2.2の4.5:1コントラスト比を満たすテーマアーキテクチャを設計する必要があります。

## Decision Drivers

* Clean Architecture原則に従い、`core/theme`でテーマロジックを集約
* Material Design 3ガイドラインへの準拠
* アクセシビリティ対応（WCAG 2.2）
* Dynamic Color対応（Android 12+）
* テーマ状態の永続化
* テスト可能性の確保

## Considered Options

* Option 1: Flutter標準のThemeDataのみを使用
* Option 2: Custom theme management system
* Option 3: Material Design 3 + ThemeExtensionによるハイブリッド設計

## Decision Outcome

Chosen option: "Option 3: Material Design 3 + ThemeExtensionによるハイブリッド設計"

### Positive Consequences

* Material Design 3の利点を最大活用
* Custom色の柔軟な管理
* テスト・デバッグの容易さ
* 高いアクセシビリティ水準

### Negative Consequences

* 実装コストの増加
* 学習コストの発生

## Implementation Details

### 1. Directory Structure

```text
lib/core/theme/
 ├─ tokens/
 │   ├─ colors.dart        # ブランド色・ステータス色定義
 │   ├─ spacing.dart       # Spacing tokens (powers of 2)
 │   ├─ radii.dart         # Border radius tokens
 │   └─ durations.dart     # Animation duration tokens
 ├─ builders/
 │   └─ app_theme.dart     # ThemeData生成ロジック
 ├─ extensions/
 │   └─ passpal_theme_ext.dart  # カスタムテーマ拡張
 └─ providers/
     └─ theme_mode_provider.dart  # テーマ状態管理
```

### 2. Design Tokens

#### 色設計

* **Seed Color**: `#0057D9` (Chukyo University brand color)
* **Dynamic Color**: Remote Config経由で有効/無効切り替え
* **Status Colors**: success, warning, error, info
* **Surface Colors**: surface1-surface5 (elevation-based)

#### Spacing (powers of 2)

* xxs: 2px, xs: 4px, sm: 8px, md: 16px, lg: 32px, xl: 64px

#### Border Radius

* card: 16px, button: 12px, overlay: 28px

#### Motion

* fast: 150ms, normal: 250ms, slow: 400ms

### 3. ThemeData Generation

```dart
class AppTheme {
  static ThemeData light(Color seed) => _base(seed, Brightness.light);
  static ThemeData dark(Color seed) => _base(seed, Brightness.dark);
  
  static ThemeData _base(Color seed, Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seed, 
      brightness: brightness
    );
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      extensions: [PasspalThemeExt.fromColorScheme(scheme)],
    );
  }
}
```

### 4. State Management

RiverpodのNotifierProviderを使用してテーマ状態を管理：

```dart
final themeModeProvider = 
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);
```

SharedPreferences経由でテーマ選択を永続化。

### 5. Feature Layer Usage Example

```dart
// 特徴レイヤーでの使用例
class AssignmentScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeExt = Theme.of(context).extension<PasspalThemeExt>()!;
    
    return Scaffold(
      backgroundColor: themeExt.surfaceVariant,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(SpaceTokens.md),
            decoration: BoxDecoration(
              color: themeExt.warningContainer,
              borderRadius: BorderRadius.circular(RadiusTokens.card),
            ),
            child: Text('課題期限注意'),
          ),
        ],
      ),
    );
  }
}
```

## Validation Strategy

### Test Coverage

1. **Unit Tests**: デザイントークン、テーマ生成ロジック
2. **Widget Tests**: テーマ切り替え、コンポーネント表示
3. **Golden Tests**: Light/Dark/HighContrastモードの視覚回帰テスト
4. **Contrast Tests**: WCAG 2.2準拠確認
5. **Integration Tests**: Remote Config連携、永続化

### Exception Propagation

テーマ初期化失敗時の例外伝播シナリオをテストし、`core/error`のCrashlyticsモックへの到達を確認。

## Links

* [Material Design 3 Color System](https://m3.material.io/styles/color/system)
* [WCAG 2.2 Contrast Guidelines](https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html)
* [Flutter Theme Documentation](https://docs.flutter.dev/cookbook/design/themes)
