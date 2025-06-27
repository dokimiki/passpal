import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/routing/guards/auth_guard.dart';
import 'package:passpal/core/auth/providers/auth_state_notifier.dart';
import 'package:passpal/core/auth/models/auth_session.dart';

void main() {
  group('AuthGuard', () {
    late AuthGuard guard;

    setUp(() {
      guard = AuthGuard();
    });

    test('認証済みの場合、リダイレクトなし', () {
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
        currentPath: '/main/home',
      );

      expect(result, isNull);
    });

    test('未認証で保護されたルートにアクセスする場合、loginにリダイレクト', () {
      const authState = AuthStateUnauthenticated();

      final result = guard.evaluate(
        authState: authState,
        currentPath: '/main/home',
      );

      expect(result, '/login/student-id');
    });

    test('未認証で既にloginフローにいる場合、リダイレクトなし', () {
      const authState = AuthStateUnauthenticated();

      final result = guard.evaluate(
        authState: authState,
        currentPath: '/login/student-id',
      );

      expect(result, isNull);
    });

    test('未認証でメンテナンスページにアクセスする場合、リダイレクトなし', () {
      const authState = AuthStateUnauthenticated();

      final result = guard.evaluate(
        authState: authState,
        currentPath: '/maintenance',
      );

      expect(result, isNull);
    });

    test('未認証でforce-updateページにアクセスする場合、リダイレクトなし', () {
      const authState = AuthStateUnauthenticated();

      final result = guard.evaluate(
        authState: authState,
        currentPath: '/force-update',
      );

      expect(result, isNull);
    });

    test('未認証でerrorページにアクセスする場合、リダイレクトなし', () {
      const authState = AuthStateUnauthenticated();

      final result = guard.evaluate(
        authState: authState,
        currentPath: '/error',
      );

      expect(result, isNull);
    });
  });
}
