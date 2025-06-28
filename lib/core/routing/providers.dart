import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:passpal/core/routing/deep_link_handler.dart';
import 'package:passpal/core/routing/observers/navigation_observer.dart';
import 'package:passpal/core/routing/app_router.dart';
import 'package:passpal/core/config/config_providers.dart';
import 'package:passpal/core/config/service/config_service.dart';
import 'package:passpal/core/storage/storage_providers.dart';

/// GoRouter provider
final goRouterProvider = Provider<GoRouter>((ref) {
  return createAppRouter(ref);
});

/// Deep link handler provider
final deepLinkHandlerProvider = Provider<DeepLinkHandler>((ref) {
  final router = ref.read(goRouterProvider);
  return DeepLinkHandler(router);
});

/// Navigation observer provider
final navigationObserverProvider = Provider<NavigationObserver>((ref) {
  return NavigationObserver(ref);
});

/// Setup completion status provider
/// ユーザーがキャンパス設定や通知設定を完了しているかを判定
final setupCompletedProvider = Provider<bool>((ref) {
  final userPrefs = ref.watch(userPrefsProvider);

  // キャンパスが設定されており、通知設定が保存されていれば完了とみなす
  final hasCampus = userPrefs.campus != null && userPrefs.campus!.isNotEmpty;
  // 通知設定は初期値がtrueなので、設定されていればOK
  final hasNotificationSettings =
      true; // notificationsEnabledはデフォルト値があるため常にtrue

  return hasCampus && hasNotificationSettings;
});

/// Maintenance flag provider
/// Remote ConfigからメンテナンスフラグとFirebase接続状況を監視
final maintenanceFlagProvider = Provider<bool>((ref) {
  final configAsync = ref.watch(appConfigProvider);

  return configAsync.when(
    data: (config) => config.admin.maintenanceMode,
    loading: () => false, // ロード中はメンテナンスモードではない
    error: (_, __) => false, // エラー時はメンテナンスモードではない（別のエラーハンドリングで処理）
  );
});

/// Remote config provider
/// 設定サービスからRemote Configのアクセス機能を提供
final remoteConfigProvider = Provider<RemoteConfigService>((ref) {
  final configService = ref.watch(configServiceProvider);
  return RemoteConfigService(configService);
});

/// Remote Config サービス実装
class RemoteConfigService {
  const RemoteConfigService(this._configService);

  // ignore: unused_field
  final ConfigService _configService;

  /// 強制アップデートが必要かチェック
  Future<bool> requiresForceUpdate({String? currentVersion}) async {
    try {
      if (currentVersion == null) return false;

      final minVersion = await minimumVersion;
      if (minVersion == null) return false;

      // セマンティックバージョニングの簡易比較
      // 実際の実装では pub_semver パッケージを使用することを推奨
      return _isVersionLowerThan(currentVersion, minVersion);
    } catch (e) {
      // エラーの場合は強制アップデートなしとして処理
      return false;
    }
  }

  /// 最小必須バージョンを取得
  Future<String?> get minimumVersion async {
    try {
      return await _configService.getMinimumVersion();
    } catch (e) {
      return null;
    }
  }

  /// バージョン比較の簡易実装
  bool _isVersionLowerThan(String current, String minimum) {
    final currentParts = current
        .split('.')
        .map(int.tryParse)
        .whereType<int>()
        .toList();
    final minimumParts = minimum
        .split('.')
        .map(int.tryParse)
        .whereType<int>()
        .toList();

    final maxLength = [
      currentParts.length,
      minimumParts.length,
    ].reduce((a, b) => a > b ? a : b);

    for (int i = 0; i < maxLength; i++) {
      final currentPart = i < currentParts.length ? currentParts[i] : 0;
      final minimumPart = i < minimumParts.length ? minimumParts[i] : 0;

      if (currentPart < minimumPart) return true;
      if (currentPart > minimumPart) return false;
    }

    return false; // 同じバージョンの場合は強制アップデート不要
  }
}

/// Force update check provider
/// Remote ConfigからminimumVersionと現在のバージョンを比較して強制アップデートが必要かチェック
final forceUpdateRequiredProvider = FutureProvider.family<bool, String?>((
  ref,
  currentVersion,
) async {
  final remoteConfigService = ref.watch(remoteConfigProvider);
  return remoteConfigService.requiresForceUpdate(
    currentVersion: currentVersion,
  );
});
