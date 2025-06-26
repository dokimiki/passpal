import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/network/network_target.dart';

void main() {
  group('NetworkTarget', () {
    test('should have correct base URLs', () {
      expect(NetworkTarget.albo.baseUrl, 'https://albo.chukyonet.jp');
      expect(NetworkTarget.manabo.baseUrl, 'https://manabo.chukyonet.jp');
      expect(NetworkTarget.cubics.baseUrl, 'https://cubics.chukyonet.jp');
      expect(NetworkTarget.sso.baseUrl, 'https://sso.chukyonet.jp');
      expect(NetworkTarget.palapi.baseUrl, 'https://api.passpal.app');
    });

    test('should have correct display names', () {
      expect(NetworkTarget.albo.displayName, 'ALBO');
      expect(NetworkTarget.manabo.displayName, 'MaNaBo');
      expect(NetworkTarget.cubics.displayName, 'Cubics');
      expect(NetworkTarget.sso.displayName, 'SSO');
      expect(NetworkTarget.palapi.displayName, 'PalAPI');
    });

    test('should correctly identify auth requirements', () {
      expect(NetworkTarget.albo.requiresAuth, true);
      expect(NetworkTarget.manabo.requiresAuth, true);
      expect(NetworkTarget.cubics.requiresAuth, true);
      expect(NetworkTarget.sso.requiresAuth, false);
      expect(NetworkTarget.palapi.requiresAuth, true);
    });

    test('should correctly identify SSO cookie usage', () {
      expect(NetworkTarget.albo.usesSsoCookies, true);
      expect(NetworkTarget.manabo.usesSsoCookies, true);
      expect(NetworkTarget.cubics.usesSsoCookies, true);
      expect(NetworkTarget.sso.usesSsoCookies, false);
      expect(NetworkTarget.palapi.usesSsoCookies, false);
    });

    test('should correctly identify Bearer token usage', () {
      expect(NetworkTarget.albo.usesBearerToken, false);
      expect(NetworkTarget.manabo.usesBearerToken, false);
      expect(NetworkTarget.cubics.usesBearerToken, false);
      expect(NetworkTarget.sso.usesBearerToken, false);
      expect(NetworkTarget.palapi.usesBearerToken, true);
    });
  });
}
