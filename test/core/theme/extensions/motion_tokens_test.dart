import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/theme/extensions/motion_tokens.dart';
import 'package:passpal/core/theme/models/motion_tokens.dart';

void main() {
  group('MotionTokensExtension', () {
    late MotionTokensExtension extension;

    setUp(() {
      extension = MotionTokensExtension.standard;
    });

    group('基本プロパティ', () {
      test('標準値が正しく設定されている', () {
        expect(extension.instant, equals(const Duration(milliseconds: 0)));
        expect(extension.fast, equals(const Duration(milliseconds: 100)));
        expect(extension.normal, equals(const Duration(milliseconds: 200)));
        expect(extension.slow, equals(const Duration(milliseconds: 300)));
        expect(extension.extraSlow, equals(const Duration(milliseconds: 500)));
      });

      test('Curveが正しく設定されている', () {
        expect(extension.standardCurve, equals(Curves.easeInOut));
        expect(extension.accelerateCurve, equals(Curves.easeIn));
        expect(extension.decelerateCurve, equals(Curves.easeOut));
        expect(extension.emphasizedCurve, equals(Curves.easeInOutCubic));
        expect(extension.bounceCurve, equals(Curves.bounceOut));
        expect(extension.elasticCurve, equals(Curves.elasticOut));
      });

      test('静的インスタンスが利用可能', () {
        expect(MotionTokensExtension.standard, isA<MotionTokensExtension>());
        expect(MotionTokensExtension.speedy, isA<MotionTokensExtension>());
        expect(MotionTokensExtension.relaxed, isA<MotionTokensExtension>());
        expect(MotionTokensExtension.disabled, isA<MotionTokensExtension>());
      });

      test('異なるプリセットで異なる持続時間を持つ', () {
        final standard = MotionTokensExtension.standard;
        final speedy = MotionTokensExtension.speedy;
        final relaxed = MotionTokensExtension.relaxed;
        final disabled = MotionTokensExtension.disabled;

        // speedy < standard < relaxed の順で持続時間が長くなる
        expect(speedy.normal.inMilliseconds, lessThan(standard.normal.inMilliseconds));
        expect(standard.normal.inMilliseconds, lessThan(relaxed.normal.inMilliseconds));

        // disabledは全て0
        expect(disabled.instant, equals(Duration.zero));
        expect(disabled.normal, equals(Duration.zero));
      });
    });

    group('AnimationController 作成', () {
      testWidgets('createController() が正しいAnimationControllerを作成する', (tester) async {
        final controller = extension.createController(
          vsync: tester,
          duration: const Duration(milliseconds: 300),
          debugLabel: 'test',
        );

        expect(controller.duration, equals(const Duration(milliseconds: 300)));
        expect(controller.debugLabel, equals('test'));

        controller.dispose();
      });

      testWidgets('持続時間を指定しない場合はnormalを使用する', (tester) async {
        final controller = extension.createController(vsync: tester);

        expect(controller.duration, equals(extension.normal));

        controller.dispose();
      });
    });

    group('Tween アニメーション', () {
      testWidgets('createTween() が正しいAnimationを作成する', (tester) async {
        final controller = AnimationController(
          duration: const Duration(milliseconds: 200),
          vsync: tester,
        );

        final animation = extension.createTween<double>(
          controller: controller,
          begin: 0.0,
          end: 1.0,
          curve: Curves.linear,
        );

        expect(animation.value, equals(0.0));

        controller.forward();
        await tester.pump(const Duration(milliseconds: 100));
        
        expect(animation.value, greaterThan(0.0));
        expect(animation.value, lessThan(1.0));

        controller.dispose();
      });

      testWidgets('Curveを指定しない場合はstandardCurveを使用する', (tester) async {
        final controller = AnimationController(
          duration: const Duration(milliseconds: 200),
          vsync: tester,
        );

        final animation = extension.createTween<double>(
          controller: controller,
          begin: 0.0,
          end: 1.0,
        );

        expect(animation, isA<Animation<double>>());

        controller.dispose();
      });
    });

    group('トランジション ウィジェット', () {
      testWidgets('slideTransition() がSlideTransitionウィジェットを生成する', (tester) async {
        final controller = AnimationController(
          duration: const Duration(milliseconds: 200),
          vsync: tester,
        );

        final widget = extension.slideTransition(
          animation: controller,
          child: const Text('Test'),
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        );

        await tester.pumpWidget(MaterialApp(home: widget));

        expect(find.byType(SlideTransition), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);

        controller.dispose();
      });

      testWidgets('fadeTransition() がFadeTransitionウィジェットを生成する', (tester) async {
        final controller = AnimationController(
          duration: const Duration(milliseconds: 200),
          vsync: tester,
        );

        final widget = extension.fadeTransition(
          animation: controller,
          child: const Text('Test'),
        );

        await tester.pumpWidget(MaterialApp(home: widget));

        expect(find.byType(FadeTransition), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);

        controller.dispose();
      });

      testWidgets('scaleTransition() がScaleTransitionウィジェットを生成する', (tester) async {
        final controller = AnimationController(
          duration: const Duration(milliseconds: 200),
          vsync: tester,
        );

        final widget = extension.scaleTransition(
          animation: controller,
          child: const Text('Test'),
          alignment: Alignment.center,
        );

        await tester.pumpWidget(MaterialApp(home: widget));

        expect(find.byType(ScaleTransition), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);

        controller.dispose();
      });

      testWidgets('combinedTransition() が複合トランジションを生成する', (tester) async {
        final controller = AnimationController(
          duration: const Duration(milliseconds: 200),
          vsync: tester,
        );

        final widget = extension.combinedTransition(
          animation: controller,
          child: const Text('Test'),
          slideBegin: const Offset(1.0, 0.0),
          slideEnd: Offset.zero,
          fadeBegin: 0.0,
          fadeEnd: 1.0,
          scaleBegin: 0.8,
          scaleEnd: 1.0,
        );

        await tester.pumpWidget(MaterialApp(home: widget));

        expect(find.byType(SlideTransition), findsOneWidget);
        expect(find.byType(FadeTransition), findsOneWidget);
        expect(find.byType(ScaleTransition), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);

        controller.dispose();
      });
    });

    group('コンポーネント専用持続時間', () {
      test('コンポーネント専用持続時間が正しく取得できる', () {
        expect(extension.buttonDuration, isA<Duration>());
        expect(extension.cardDuration, isA<Duration>());
        expect(extension.fabDuration, isA<Duration>());
        expect(extension.listItemDuration, isA<Duration>());
        expect(extension.navigationDuration, isA<Duration>());
        expect(extension.modalDuration, isA<Duration>());
        expect(extension.tooltipDuration, isA<Duration>());
        expect(extension.snackbarDuration, isA<Duration>());
      });

      test('アニメーションレベルによって持続時間が調整される', () {
        final standard = MotionTokensExtension.standard;
        final disabled = MotionTokensExtension.disabled;

        expect(standard.buttonDuration.inMilliseconds, greaterThan(0));
        expect(disabled.buttonDuration, equals(Duration.zero));
      });
    });

    group('レスポンシブ持続時間', () {
      test('getResponsiveDuration() が画面幅に応じて調整される', () {
        final baseDuration = const Duration(milliseconds: 200);
        
        // 小さい画面
        final smallDuration = extension.getResponsiveDuration(
          baseDuration: baseDuration,
          screenWidth: 320.0,
        );
        expect(smallDuration.inMilliseconds, lessThan(baseDuration.inMilliseconds));

        // 大きい画面
        final largeDuration = extension.getResponsiveDuration(
          baseDuration: baseDuration,
          screenWidth: 768.0,
        );
        expect(largeDuration.inMilliseconds, greaterThan(baseDuration.inMilliseconds));
      });
    });

    group('アクセシビリティ調整', () {
      test('adjustForAccessibility() がアクセシビリティ設定に応じて調整される', () {
        final baseDuration = const Duration(milliseconds: 200);

        final reducedMotion = extension.adjustForAccessibility(
          baseDuration: baseDuration,
          reduceMotion: true,
        );
        expect(reducedMotion, equals(Duration.zero));

        final slowAnimations = extension.adjustForAccessibility(
          baseDuration: baseDuration,
          slowAnimations: true,
        );
        expect(slowAnimations.inMilliseconds, greaterThan(baseDuration.inMilliseconds));

        final normal = extension.adjustForAccessibility(
          baseDuration: baseDuration,
        );
        expect(normal, equals(baseDuration));
      });
    });

    group('Material 3 トランジション', () {
      testWidgets('buildContainerTransform() がコンテナトランスフォームを生成する', (tester) async {
        final controller = AnimationController(
          duration: const Duration(milliseconds: 200),
          vsync: tester,
        );

        final widget = extension.buildContainerTransform(
          child: const Text('Test'),
          animation: controller,
        );

        await tester.pumpWidget(MaterialApp(home: widget));

        expect(find.byType(FadeTransition), findsOneWidget);
        expect(find.byType(ScaleTransition), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);

        controller.dispose();
      });

      testWidgets('buildSharedAxisTransition() がシェアードアクシストランジションを生成する', (tester) async {
        final controller = AnimationController(
          duration: const Duration(milliseconds: 200),
          vsync: tester,
        );

        final widget = extension.buildSharedAxisTransition(
          child: const Text('Test'),
          animation: controller,
          transitionType: SharedAxisTransitionType.horizontal,
        );

        await tester.pumpWidget(MaterialApp(home: widget));

        expect(find.byType(SlideTransition), findsOneWidget);
        expect(find.byType(FadeTransition), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);

        controller.dispose();
      });
    });

    group('copyWith', () {
      test('指定されたプロパティのみ変更される', () {
        final newExtension = extension.copyWith(
          fast: const Duration(milliseconds: 150),
          slow: const Duration(milliseconds: 400),
        );

        expect(newExtension.instant, equals(extension.instant));
        expect(newExtension.fast, equals(const Duration(milliseconds: 150))); // 変更
        expect(newExtension.normal, equals(extension.normal));
        expect(newExtension.slow, equals(const Duration(milliseconds: 400))); // 変更
        expect(newExtension.extraSlow, equals(extension.extraSlow));
      });
    });

    group('lerp', () {
      test('同じタイプの拡張間で補間される', () {
        final other = extension.copyWith(
          fast: const Duration(milliseconds: 200),
          normal: const Duration(milliseconds: 400),
        );

        final lerped = extension.lerp(other, 0.5);

        expect(lerped.fast.inMilliseconds, equals(150)); // (100 + 200) / 2
        expect(lerped.normal.inMilliseconds, equals(300)); // (200 + 400) / 2
      });

      test('異なるタイプの場合は元の値を返す', () {
        final lerped = extension.lerp(null, 0.5);
        expect(lerped, equals(extension));
      });

      test('境界値での補間が正しく動作する', () {
        final other = extension.copyWith(fast: const Duration(milliseconds: 200));

        final lerpedStart = extension.lerp(other, 0.0);
        expect(lerpedStart.fast.inMilliseconds, equals(100));

        final lerpedEnd = extension.lerp(other, 1.0);
        expect(lerpedEnd.fast.inMilliseconds, equals(200));
      });
    });

    group('等価性', () {
      test('同じ値を持つインスタンスは等しい', () {
        final other = MotionTokensExtension(
          instant: const Duration(milliseconds: 0),
          fast: const Duration(milliseconds: 100),
          normal: const Duration(milliseconds: 200),
          slow: const Duration(milliseconds: 300),
          extraSlow: const Duration(milliseconds: 500),
          standardCurve: Curves.easeInOut,
          accelerateCurve: Curves.easeIn,
          decelerateCurve: Curves.easeOut,
          emphasizedCurve: Curves.easeInOutCubic,
          bounceCurve: Curves.bounceOut,
          elasticCurve: Curves.elasticOut,
          motionTokens: MotionTokens.standardEase,
          animationLevel: AnimationLevel.standard,
        );

        expect(extension, equals(other));
        expect(extension.hashCode, equals(other.hashCode));
      });

      test('異なる値を持つインスタンスは等しくない', () {
        final other = extension.copyWith(fast: const Duration(milliseconds: 150));

        expect(extension, isNot(equals(other)));
        expect(extension.hashCode, isNot(equals(other.hashCode)));
      });
    });

    group('toString', () {
      test('適切な文字列表現を返す', () {
        final string = extension.toString();
        
        expect(string, contains('MotionTokensExtension'));
        expect(string, contains('instant: 0:00:00.000000'));
        expect(string, contains('fast: 0:00:00.100000'));
        expect(string, contains('animationLevel: AnimationLevel.standard'));
      });
    });
  });

  group('MotionTokensContext 拡張', () {
    testWidgets('BuildContextからモーショントークンにアクセスできる', (tester) async {
      final testExtension = MotionTokensExtension.standard;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData().withMotionTokens(testExtension),
          home: Builder(
            builder: (context) {
              final motion = context.motion;
              expect(motion, equals(testExtension));
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('モーショントークンが設定されていない場合はnullを返す', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final motion = context.motion;
              expect(motion, isNull);
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });

  group('MotionTokensTheme 拡張', () {
    test('ThemeDataにモーショントークンを追加できる', () {
      final testExtension = MotionTokensExtension.standard;
      final theme = ThemeData().withMotionTokens(testExtension);
      
      expect(theme.motion, equals(testExtension));
    });

    test('既存の拡張を置き換える', () {
      final original = MotionTokensExtension.standard;
      final replacement = MotionTokensExtension.speedy;
      
      final theme = ThemeData()
          .withMotionTokens(original)
          .withMotionTokens(replacement);
      
      expect(theme.motion, equals(replacement));
      expect(theme.motion, isNot(equals(original)));
    });
  });
}