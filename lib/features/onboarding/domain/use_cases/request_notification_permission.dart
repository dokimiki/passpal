import 'package:permission_handler/permission_handler.dart';
import 'package:passpal/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:passpal/features/__shared__/models/notification_permission.dart';
import 'package:passpal/core/error/app_exception.dart';

/// ユースケース：通知権限をリクエストする
class RequestNotificationPermissionUseCase {
  const RequestNotificationPermissionUseCase(this._repository);

  final OnboardingRepository _repository;

  /// 通知権限をリクエストして結果を保存
  Future<NotificationPermission> call() async {
    try {
      // システムの通知権限をリクエスト
      final permission = await Permission.notification.request();

      // PermissionStatusをNotificationPermissionにマッピング
      final notificationPermission = _mapPermissionStatus(permission);

      // 結果を保存
      await _repository.saveNotificationPermission(notificationPermission);

      return notificationPermission;
    } catch (e) {
      throw UnknownException(
        message: '通知権限の取得に失敗しました',
        originalException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// PermissionStatusをNotificationPermissionにマッピング
  NotificationPermission _mapPermissionStatus(PermissionStatus status) {
    return switch (status) {
      PermissionStatus.granted => const NotificationPermission.granted(),
      PermissionStatus.denied => const NotificationPermission.denied(),
      PermissionStatus.permanentlyDenied =>
        const NotificationPermission.denied(),
      PermissionStatus.restricted => const NotificationPermission.denied(),
      PermissionStatus.limited => const NotificationPermission.provisional(),
      PermissionStatus.provisional =>
        const NotificationPermission.provisional(),
    };
  }
}
