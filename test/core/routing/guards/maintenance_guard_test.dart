import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/routing/guards/maintenance_guard.dart';

void main() {
  group('MaintenanceGuard', () {
    late MaintenanceGuard guard;

    setUp(() {
      guard = MaintenanceGuard();
    });

    test('メンテナンスモードでない場合、リダイレクトなし', () {
      final result = guard.evaluate(
        isMaintenanceMode: false,
        currentPath: '/main/home',
      );

      expect(result, isNull);
    });

    test('メンテナンスモードで既に/maintenanceにいる場合、リダイレクトなし', () {
      final result = guard.evaluate(
        isMaintenanceMode: true,
        currentPath: '/maintenance',
      );

      expect(result, isNull);
    });

    test('メンテナンスモードで他のページにいる場合、/maintenanceにリダイレクト', () {
      final result = guard.evaluate(
        isMaintenanceMode: true,
        currentPath: '/main/home',
      );

      expect(result, '/maintenance');
    });

    test('メンテナンスモードでloginページにいる場合、/maintenanceにリダイレクト', () {
      final result = guard.evaluate(
        isMaintenanceMode: true,
        currentPath: '/login/student-id',
      );

      expect(result, '/maintenance');
    });
  });
}
