import 'package:passpal/features/onboarding/data/models/onboarding_status.dart';
import 'package:passpal/features/__shared__/models/campus.dart';
import 'package:passpal/features/__shared__/models/notification_permission.dart';

/// ドメイン層のリポジトリインターフェース
abstract class OnboardingRepository {
  /// オンボーディング状況を取得
  Future<OnboardingStatus> getStatus();

  /// キャンパスを保存
  Future<void> saveCampus(Campus campus);

  /// 通知権限を保存
  Future<void> saveNotificationPermission(NotificationPermission permission);

  /// オンボーディングを完了とマーク
  Future<void> completeOnboarding();

  /// オンボーディング状況をリセット（テスト用）
  Future<void> resetOnboarding();
}
