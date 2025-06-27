import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/routing/guards/setup_guard.dart';
import 'package:passpal/core/auth/providers/auth_state_notifier.dart';
import 'package:passpal/core/auth/models/auth_session.dart';

void main() {
  group('SetupGuard', () {
    late SetupGuard guard;

    setUp(() {
      guard = SetupGuard();
    });

    test('未認証の場合、リダイレクトなし', () {
      const authState = AuthStateUnauthenticated();

      final result = guard.evaluate(
        authState: authState,
        isSetupCompleted: false,
        currentPath: '/main/home',
      );

      expect(result, isNull);
    });

    test('認証済みでセットアップ完了済みの場合、リダイレクトなし', () {
      final authState = AuthStateAuthenticated(
        session: AuthSession(
          username: 'test@user.com',
          cookies: const {'session': 'token'},
          expiresAt: DateTime(2025, 12, 31),
          lastRefreshed: DateTime.now(),
        ),
      );

      final result = guard.evaluate(
        authState: authState,
        isSetupCompleted: true,
        currentPath: '/main/home',
      );

      expect(result, isNull);
    });

    test('認証済みでセットアップ未完了の場合、setupにリダイレクト', () {
      final authState = AuthStateAuthenticated(
        session: AuthSession(
          username: 'test@user.com',
          cookies: const {'session': 'token'},
          expiresAt: DateTime(2025, 12, 31),
          lastRefreshed: DateTime.now(),
        ),
      );

      final result = guard.evaluate(
        authState: authState,
        isSetupCompleted: false,
        currentPath: '/main/home',
      );

      expect(result, '/setup/campus');
    });

    test('認証済みでセットアップ未完了だが既にsetupフローにいる場合、リダイレクトなし', () {
      final authState = AuthStateAuthenticated(
        session: AuthSession(
          username: 'test@user.com',
          cookies: const {'session': 'token'},
          expiresAt: DateTime(2025, 12, 31),
          lastRefreshed: DateTime.now(),
        ),
      );

      final result = guard.evaluate(
        authState: authState,
        isSetupCompleted: false,
        currentPath: '/setup/campus',
      );

      expect(result, isNull);
    });

    test('認証済みでセットアップ未完了だがメンテナンスページにいる場合、リダイレクトなし', () {
      final authState = AuthStateAuthenticated(
        session: AuthSession(
          username: 'test@user.com',
          cookies: const {'session': 'token'},
          expiresAt: DateTime(2025, 12, 31),
          lastRefreshed: DateTime.now(),
        ),
      );

      final result = guard.evaluate(
        authState: authState,
        isSetupCompleted: false,
        currentPath: '/maintenance',
      );

      expect(result, isNull);
    });
  });
}
