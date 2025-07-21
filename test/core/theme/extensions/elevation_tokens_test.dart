import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/theme/extensions/elevation_tokens.dart';
import 'package:passpal/core/theme/models/elevation_tokens.dart';

void main() {
  group('ElevationTokensExtension', () {
    late ElevationTokensExtension extension;

    setUp(() {
      extension = ElevationTokensExtension.standardLight;
    });

    group('基本プロパティ', () {
      test('標準値が正しく設定されている', () {
        expect(extension.level0, equals(0.0));
        expect(extension.level1, equals(1.0));
        expect(extension.level2, equals(3.0));
        expect(extension.level3, equals(6.0));
        expect(extension.level4, equals(8.0));
        expect(extension.level5, equals(12.0));
      });

      test('静的インスタンスが利用可能', () {
        expect(ElevationTokensExtension.standardLight, isA<ElevationTokensExtension>());
        expect(ElevationTokensExtension.standardDark, isA<ElevationTokensExtension>());
        expect(ElevationTokensExtension.enhancedLight, isA<ElevationTokensExtension>());
        expect(ElevationTokensExtension.enhancedDark, isA<ElevationTokensExtension>());
        expect(ElevationTokensExtension.flatLight, isA<ElevationTokensExtension>());
        expect(ElevationTokensExtension.flatDark, isA<ElevationTokensExtension>());
      });

      test('ライト・ダークテーマで適切なシャドウトークンが設定されている', () {
        final light = ElevationTokensExtension.standardLight;
        final dark = ElevationTokensExtension.standardDark;

        expect(light.brightness, equals(Brightness.light));
        expect(dark.brightness, equals(Brightness.dark));
        expect(light.shadowTokens, equals(ShadowTokens.light));
        expect(dark.shadowTokens, equals(ShadowTokens.dark));
      });
    });

    group('BoxShadow 生成', () {
      test('shadowForLevel() がエレベーション0で空リストを返す', () {
        final shadows = extension.shadowForLevel(0.0);
        expect(shadows, isEmpty);
      });

      test('shadowForLevel() が正のエレベーションでシャドウを生成する', () {
        final shadows = extension.shadowForLevel(6.0);
        expect(shadows, isNotEmpty);
        expect(shadows.length, equals(2)); // ambient + key shadow
      });

      test('便利ゲッターが正しく動作する', () {
        expect(extension.shadow0, isEmpty);
        expect(extension.shadow1, isNotEmpty);
        expect(extension.shadow2, isNotEmpty);
        expect(extension.shadow3, isNotEmpty);
        expect(extension.shadow4, isNotEmpty);
        expect(extension.shadow5, isNotEmpty);
      });

      test('ライトとダークテーマで異なるシャドウ不透明度を使用する', () {
        final light = ElevationTokensExtension.standardLight;
        final dark = ElevationTokensExtension.standardDark;

        final lightShadows = light.shadowForLevel(6.0);
        final darkShadows = dark.shadowForLevel(6.0);

        expect(lightShadows, isNotEmpty);
        expect(darkShadows, isNotEmpty);
        
        // ダークテーマの方が不透明度が高い
        final lightAmbient = (lightShadows[0].color.a * 255.0).round() & 0xff;
        final darkAmbient = (darkShadows[0].color.a * 255.0).round() & 0xff;
        expect(darkAmbient, greaterThan(lightAmbient));
      });
    });

    group('BoxDecoration 生成', () {
      test('decorationWithElevation() が正しいBoxDecorationを生成する', () {
        final decoration = extension.decorationWithElevation(
          6.0,
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        );

        expect(decoration.color, equals(Colors.white));
        expect(decoration.borderRadius, equals(BorderRadius.circular(8.0)));
        expect(decoration.boxShadow, isNotEmpty);
      });

      test('エレベーション0でシャドウが空の場合も正しく動作する', () {
        final decoration = extension.decorationWithElevation(0.0);
        expect(decoration.boxShadow, isEmpty);
      });
    });

    group('Material ウィジェット', () {
      testWidgets('materialWithElevation() がMaterialウィジェットを生成する', (tester) async {
        final widget = extension.materialWithElevation(
          6.0,
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
          child: const Text('Test'),
        );

        await tester.pumpWidget(MaterialApp(home: widget));

        final material = tester.widget<Material>(find.byType(Material));
        expect(material.elevation, equals(6.0));
        expect(material.color, equals(Colors.blue));
        expect(material.borderRadius, equals(BorderRadius.circular(8.0)));
      });

      testWidgets('animatedElevation() がアニメーション付きMaterialを生成する', (tester) async {
        final widget = extension.animatedElevation(
          elevation: 6.0,
          duration: const Duration(milliseconds: 200),
          child: const Text('Test'),
        );

        await tester.pumpWidget(MaterialApp(home: widget));

        expect(find.byType(TweenAnimationBuilder<double>), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);
      });
    });

    group('コンポーネント専用エレベーション', () {
      test('コンポーネント専用エレベーション値が正しく取得できる', () {
        expect(extension.surface, isA<double>());
        expect(extension.card, isA<double>());
        expect(extension.button, isA<double>());
        expect(extension.fab, isA<double>());
        expect(extension.navigationBar, isA<double>());
        expect(extension.appBar, isA<double>());
        expect(extension.drawer, isA<double>());
        expect(extension.modal, isA<double>());
        expect(extension.menu, isA<double>());
        expect(extension.snackbar, isA<double>());
        expect(extension.tooltip, isA<double>());
        expect(extension.bottomSheet, isA<double>());
        expect(extension.tabBar, isA<double>());
        expect(extension.chip, isA<double>());
      });

      test('異なるスタイルで異なるエレベーション値を持つ', () {
        final standard = ElevationTokensExtension.standardLight;
        final enhanced = ElevationTokensExtension.enhancedLight;
        final flat = ElevationTokensExtension.flatLight;

        // enhancedは標準より高い、flatは標準より低い
        expect(enhanced.card, greaterThan(standard.card));
        expect(flat.card, lessThanOrEqualTo(standard.card));
      });
    });

    group('レスポンシブエレベーション', () {
      test('getResponsiveElevation() が画面幅に応じて調整される', () {
        final baseElevation = 6.0;
        
        // 小さい画面
        final smallElevation = extension.getResponsiveElevation(
          baseElevation: baseElevation,
          screenWidth: 320.0,
        );
        expect(smallElevation, lessThan(baseElevation));

        // 大きい画面
        final largeElevation = extension.getResponsiveElevation(
          baseElevation: baseElevation,
          screenWidth: 768.0,
        );
        expect(largeElevation, greaterThan(baseElevation));
      });
    });

    group('インタラクションステート', () {
      test('getElevationForState() がステートに応じて調整される', () {
        final baseElevation = 6.0;

        final disabledElevation = extension.getElevationForState(
          baseElevation: baseElevation,
          isDisabled: true,
        );
        expect(disabledElevation, equals(0.0));

        final pressedElevation = extension.getElevationForState(
          baseElevation: baseElevation,
          isPressed: true,
        );
        expect(pressedElevation, greaterThan(baseElevation));

        final hoveredElevation = extension.getElevationForState(
          baseElevation: baseElevation,
          isHovered: true,
        );
        expect(hoveredElevation, greaterThan(baseElevation));

        final focusedElevation = extension.getElevationForState(
          baseElevation: baseElevation,
          isFocused: true,
        );
        expect(focusedElevation, greaterThan(baseElevation));
      });
    });

    group('Surface Tint', () {
      test('getSurfaceTint() が正しくティント色を計算する', () {
        final baseColor = Colors.white;
        final tintColor = Colors.blue;

        final tintedColor = extension.getSurfaceTint(
          baseColor: baseColor,
          tintColor: tintColor,
          elevation: 6.0,
        );

        expect(tintedColor, isNot(equals(baseColor)));
        // エレベーションがあるとき、ベース色とは異なる色になる
      });

      test('エレベーション0でベース色を返す', () {
        final baseColor = Colors.white;
        final tintColor = Colors.blue;

        final tintedColor = extension.getSurfaceTint(
          baseColor: baseColor,
          tintColor: tintColor,
          elevation: 0.0,
        );

        expect(tintedColor, equals(baseColor));
      });
    });

    group('copyWith', () {
      test('指定されたプロパティのみ変更される', () {
        final newExtension = extension.copyWith(
          level1: 2.0,
          level3: 8.0,
        );

        expect(newExtension.level0, equals(extension.level0));
        expect(newExtension.level1, equals(2.0)); // 変更
        expect(newExtension.level2, equals(extension.level2));
        expect(newExtension.level3, equals(8.0)); // 変更
        expect(newExtension.level4, equals(extension.level4));
        expect(newExtension.level5, equals(extension.level5));
      });
    });

    group('lerp', () {
      test('同じタイプの拡張間で補間される', () {
        final other = extension.copyWith(
          level1: 3.0,
          level3: 12.0,
        );

        final lerped = extension.lerp(other, 0.5);

        expect(lerped.level1, equals(2.0)); // (1.0 + 3.0) / 2
        expect(lerped.level3, equals(9.0)); // (6.0 + 12.0) / 2
      });

      test('異なるタイプの場合は元の値を返す', () {
        final lerped = extension.lerp(null, 0.5);
        expect(lerped, equals(extension));
      });
    });

    group('等価性', () {
      test('同じ値を持つインスタンスは等しい', () {
        final other = ElevationTokensExtension(
          level0: 0.0,
          level1: 1.0,
          level2: 3.0,
          level3: 6.0,
          level4: 8.0,
          level5: 12.0,
          elevationTokens: ElevationTokens.standard,
          componentElevationTokens: ComponentElevationTokens.standard,
          shadowTokens: ShadowTokens.light,
          brightness: Brightness.light,
        );

        expect(extension, equals(other));
        expect(extension.hashCode, equals(other.hashCode));
      });

      test('異なる値を持つインスタンスは等しくない', () {
        final other = extension.copyWith(level1: 2.0);

        expect(extension, isNot(equals(other)));
        expect(extension.hashCode, isNot(equals(other.hashCode)));
      });
    });

    group('toString', () {
      test('適切な文字列表現を返す', () {
        final string = extension.toString();
        
        expect(string, contains('ElevationTokensExtension'));
        expect(string, contains('level0: 0.0'));
        expect(string, contains('level1: 1.0'));
        expect(string, contains('brightness: Brightness.light'));
      });
    });
  });

  group('ElevationTokensContext 拡張', () {
    testWidgets('BuildContextからエレベーショントークンにアクセスできる', (tester) async {
      final testExtension = ElevationTokensExtension.standardLight;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData().withElevationTokens(testExtension),
          home: Builder(
            builder: (context) {
              final elevation = context.elevation;
              expect(elevation, equals(testExtension));
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('エレベーショントークンが設定されていない場合はnullを返す', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final elevation = context.elevation;
              expect(elevation, isNull);
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });

  group('ElevationTokensTheme 拡張', () {
    test('ThemeDataにエレベーショントークンを追加できる', () {
      final testExtension = ElevationTokensExtension.standardLight;
      final theme = ThemeData().withElevationTokens(testExtension);
      
      expect(theme.elevation, equals(testExtension));
    });

    test('既存の拡張を置き換える', () {
      final original = ElevationTokensExtension.standardLight;
      final replacement = ElevationTokensExtension.enhancedLight;
      
      final theme = ThemeData()
          .withElevationTokens(original)
          .withElevationTokens(replacement);
      
      expect(theme.elevation, equals(replacement));
      expect(theme.elevation, isNot(equals(original)));
    });
  });
}