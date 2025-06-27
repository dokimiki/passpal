import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/routing/guards/force_update_guard.dart';
import 'package:passpal/core/error/app_exception.dart';

void main() {
  group('ForceUpdateGuard', () {
    late ForceUpdateGuard guard;

    setUp(() {
      guard = ForceUpdateGuard();
    });

    test('現在のバージョンが最小要求バージョンより低い場合、force-updateにリダイレクト', () {
      const currentVersion = '1.0.0';
      const minimumVersion = '1.1.0';
      const currentPath = '/main/home';

      final result = guard.evaluate(
        currentVersion: currentVersion,
        minimumVersion: minimumVersion,
        currentPath: currentPath,
      );

      expect(result, '/force-update');
    });

    test('現在のバージョンが最小要求バージョンと同じ場合、リダイレクトなし', () {
      const currentVersion = '1.1.0';
      const minimumVersion = '1.1.0';
      const currentPath = '/main/home';

      final result = guard.evaluate(
        currentVersion: currentVersion,
        minimumVersion: minimumVersion,
        currentPath: currentPath,
      );

      expect(result, isNull);
    });

    test('現在のバージョンが最小要求バージョンより高い場合、リダイレクトなし', () {
      const currentVersion = '1.2.0';
      const minimumVersion = '1.1.0';
      const currentPath = '/main/home';

      final result = guard.evaluate(
        currentVersion: currentVersion,
        minimumVersion: minimumVersion,
        currentPath: currentPath,
      );

      expect(result, isNull);
    });

    test('既に/force-updateにいる場合、リダイレクトなし', () {
      const currentVersion = '1.0.0';
      const minimumVersion = '1.1.0';
      const currentPath = '/force-update';

      final result = guard.evaluate(
        currentVersion: currentVersion,
        minimumVersion: minimumVersion,
        currentPath: currentPath,
      );

      expect(result, isNull);
    });

    test('最小バージョンが設定されていない場合、リダイレクトなし', () {
      const currentVersion = '1.0.0';
      const currentPath = '/main/home';

      final result = guard.evaluate(
        currentVersion: currentVersion,
        minimumVersion: null,
        currentPath: currentPath,
      );

      expect(result, isNull);
    });

    test('バージョン文字列が不正な場合、例外をスロー', () {
      const currentVersion = 'invalid';
      const minimumVersion = '1.1.0';
      const currentPath = '/main/home';

      expect(
        () => guard.evaluate(
          currentVersion: currentVersion,
          minimumVersion: minimumVersion,
          currentPath: currentPath,
        ),
        throwsA(isA<ForceUpdateException>()),
      );
    });
  });
}
