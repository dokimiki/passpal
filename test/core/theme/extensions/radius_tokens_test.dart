import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/theme/extensions/radius_tokens.dart';
import 'package:passpal/core/theme/models/radius_tokens.dart';

void main() {
  group('RadiusTokensExtension', () {
    late RadiusTokensExtension extension;

    setUp(() {
      extension = RadiusTokensExtension.standard;
    });

    group('基本プロパティ', () {
      test('標準値が正しく設定されている', () {
        expect(extension.none, equals(0.0));
        expect(extension.xs, equals(4.0));
        expect(extension.sm, equals(8.0));
        expect(extension.md, equals(12.0));
        expect(extension.lg, equals(16.0));
        expect(extension.xl, equals(24.0));
        expect(extension.full, equals(9999.0));
      });

      test('静的インスタンスが利用可能', () {
        expect(RadiusTokensExtension.standard, isA<RadiusTokensExtension>());
        expect(RadiusTokensExtension.compact, isA<RadiusTokensExtension>());
        expect(RadiusTokensExtension.rounded, isA<RadiusTokensExtension>());
      });
    });

    group('BorderRadius ユーティリティ', () {
      test('circular() が正しいBorderRadiusを返す', () {
        final radius = extension.circular(12.0);
        expect(radius, equals(BorderRadius.circular(12.0)));
      });

      test('便利ゲッターが正しく動作する', () {
        expect(extension.circularXs, equals(BorderRadius.circular(4.0)));
        expect(extension.circularSm, equals(BorderRadius.circular(8.0)));
        expect(extension.circularMd, equals(BorderRadius.circular(12.0)));
        expect(extension.circularLg, equals(BorderRadius.circular(16.0)));
        expect(extension.circularXl, equals(BorderRadius.circular(24.0)));
        expect(extension.circularFull, equals(BorderRadius.circular(9999.0)));
      });

      test('topOnly() が正しいBorderRadiusを返す', () {
        final radius = extension.topOnly(16.0);
        expect(
          radius,
          equals(BorderRadius.vertical(top: Radius.circular(16.0))),
        );
      });

      test('bottomOnly() が正しいBorderRadiusを返す', () {
        final radius = extension.bottomOnly(16.0);
        expect(
          radius,
          equals(BorderRadius.vertical(bottom: Radius.circular(16.0))),
        );
      });

      test('leftOnly() が正しいBorderRadiusを返す', () {
        final radius = extension.leftOnly(16.0);
        expect(
          radius,
          equals(BorderRadius.horizontal(left: Radius.circular(16.0))),
        );
      });

      test('rightOnly() が正しいBorderRadiusを返す', () {
        final radius = extension.rightOnly(16.0);
        expect(
          radius,
          equals(BorderRadius.horizontal(right: Radius.circular(16.0))),
        );
      });

      test('custom() が正しいBorderRadiusを返す', () {
        final radius = extension.custom(
          topLeft: 8.0,
          topRight: 16.0,
          bottomLeft: 4.0,
          bottomRight: 12.0,
        );
        expect(
          radius,
          equals(
            BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(16.0),
              bottomLeft: Radius.circular(4.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
        );
      });

      test('custom() でnullパラメータは0になる', () {
        final radius = extension.custom(topLeft: 8.0);
        expect(
          radius,
          equals(
            BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(0.0),
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
            ),
          ),
        );
      });
    });

    group('コンポーネント角丸', () {
      test('コンポーネント専用角丸が正しく取得できる', () {
        expect(extension.button, isA<BorderRadius>());
        expect(extension.card, isA<BorderRadius>());
        expect(extension.chip, isA<BorderRadius>());
        expect(extension.input, isA<BorderRadius>());
        expect(extension.modal, isA<BorderRadius>());
        expect(extension.bottomSheet, isA<BorderRadius>());
        expect(extension.fab, isA<BorderRadius>());
        expect(extension.avatar, isA<BorderRadius>());
        expect(extension.image, isA<BorderRadius>());
        expect(extension.navigation, isA<BorderRadius>());
        expect(extension.badge, isA<BorderRadius>());
        expect(extension.progress, isA<BorderRadius>());
      });

      test('異なるスタイルで異なる角丸値を持つ', () {
        final standard = RadiusTokensExtension.standard;
        final compact = RadiusTokensExtension.compact;
        final rounded = RadiusTokensExtension.rounded;

        // standard < compact < rounded の順で値が大きくなることを期待しない
        // 代わりに、それぞれが異なる値を持つことを確認
        expect(standard.xs, isNot(equals(compact.xs)));
        expect(compact.xl, isNot(equals(rounded.xl)));
      });
    });

    group('レスポンシブ角丸', () {
      test('getResponsiveRadius() が画面幅に応じて調整される', () {
        final baseRadius = 16.0;

        // 小さい画面
        final smallRadius = extension.getResponsiveRadius(
          baseRadius: baseRadius,
          screenWidth: 320.0,
        );
        expect(smallRadius, lessThan(baseRadius));

        // 大きい画面
        final largeRadius = extension.getResponsiveRadius(
          baseRadius: baseRadius,
          screenWidth: 768.0,
        );
        expect(largeRadius, greaterThan(baseRadius));

        // 中間サイズ
        final mediumRadius = extension.getResponsiveRadius(
          baseRadius: baseRadius,
          screenWidth: 500.0,
        );
        expect(
          mediumRadius,
          allOf(greaterThan(smallRadius), lessThan(largeRadius)),
        );
      });

      test('getResponsiveBorderRadius() が正しく動作する', () {
        final baseBorderRadius = BorderRadius.circular(16.0);

        final responsiveRadius = extension.getResponsiveBorderRadius(
          baseBorderRadius: baseBorderRadius,
          screenWidth: 320.0,
        );

        expect(responsiveRadius, isA<BorderRadius>());
        expect(responsiveRadius.topLeft.x, lessThan(16.0));
      });
    });

    group('部分角丸', () {
      test('partial() が正しい部分角丸を生成する', () {
        final radius = extension.partial(top: true, right: true, radius: 16.0);

        expect(radius.topLeft.x, equals(0.0));
        expect(radius.topRight.x, equals(16.0));
        expect(radius.bottomLeft.x, equals(0.0));
        expect(radius.bottomRight.x, equals(16.0));
      });
    });

    group('copyWith', () {
      test('指定されたプロパティのみ変更される', () {
        final newExtension = extension.copyWith(xs: 6.0, lg: 20.0);

        expect(newExtension.none, equals(extension.none));
        expect(newExtension.xs, equals(6.0)); // 変更
        expect(newExtension.sm, equals(extension.sm));
        expect(newExtension.md, equals(extension.md));
        expect(newExtension.lg, equals(20.0)); // 変更
        expect(newExtension.xl, equals(extension.xl));
        expect(newExtension.full, equals(extension.full));
      });

      test('nullパラメータは元の値を保持する', () {
        final newExtension = extension.copyWith();

        expect(newExtension.none, equals(extension.none));
        expect(newExtension.xs, equals(extension.xs));
        expect(newExtension.sm, equals(extension.sm));
        expect(newExtension.md, equals(extension.md));
        expect(newExtension.lg, equals(extension.lg));
        expect(newExtension.xl, equals(extension.xl));
        expect(newExtension.full, equals(extension.full));
      });
    });

    group('lerp', () {
      test('同じタイプの拡張間で補間される', () {
        final other = extension.copyWith(xs: 8.0, md: 20.0);

        final lerped = extension.lerp(other, 0.5);

        expect(lerped.xs, equals(6.0)); // (4.0 + 8.0) / 2
        expect(lerped.md, equals(16.0)); // (12.0 + 20.0) / 2
      });

      test('異なるタイプの場合は元の値を返す', () {
        final lerped = extension.lerp(null, 0.5);
        expect(lerped, equals(extension));
      });

      test('境界値での補間が正しく動作する', () {
        final other = extension.copyWith(xs: 8.0);

        final lerpedStart = extension.lerp(other, 0.0);
        expect(lerpedStart.xs, equals(4.0));

        final lerpedEnd = extension.lerp(other, 1.0);
        expect(lerpedEnd.xs, equals(8.0));
      });
    });

    group('等価性', () {
      test('同じ値を持つインスタンスは等しい', () {
        final other = RadiusTokensExtension(
          none: 0.0,
          xs: 4.0,
          sm: 8.0,
          md: 12.0,
          lg: 16.0,
          xl: 24.0,
          full: 9999.0,
          radiusTokens: RadiusTokens.standard,
          componentRadiusTokens: ComponentRadiusTokens.standard,
        );

        expect(extension, equals(other));
        expect(extension.hashCode, equals(other.hashCode));
      });

      test('異なる値を持つインスタンスは等しくない', () {
        final other = extension.copyWith(xs: 6.0);

        expect(extension, isNot(equals(other)));
        expect(extension.hashCode, isNot(equals(other.hashCode)));
      });
    });

    group('toString', () {
      test('適切な文字列表現を返す', () {
        final string = extension.toString();

        expect(string, contains('RadiusTokensExtension'));
        expect(string, contains('none: 0.0'));
        expect(string, contains('xs: 4.0'));
        expect(string, contains('full: 9999.0'));
      });
    });
  });

  group('RadiusTokensContext 拡張', () {
    testWidgets('BuildContextから角丸トークンにアクセスできる', (tester) async {
      final testExtension = RadiusTokensExtension.standard;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData().withRadiusTokens(testExtension),
          home: Builder(
            builder: (context) {
              final radius = context.radius;
              expect(radius, equals(testExtension));
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('角丸トークンが設定されていない場合はnullを返す', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final radius = context.radius;
              expect(radius, isNull);
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });

  group('RadiusTokensTheme 拡張', () {
    test('ThemeDataに角丸トークンを追加できる', () {
      final testExtension = RadiusTokensExtension.standard;
      final theme = ThemeData().withRadiusTokens(testExtension);

      expect(theme.radius, equals(testExtension));
    });

    test('既存の拡張を置き換える', () {
      final original = RadiusTokensExtension.standard;
      final replacement = RadiusTokensExtension.compact;

      final theme = ThemeData()
          .withRadiusTokens(original)
          .withRadiusTokens(replacement);

      expect(theme.radius, equals(replacement));
      expect(theme.radius, isNot(equals(original)));
    });
  });
}
