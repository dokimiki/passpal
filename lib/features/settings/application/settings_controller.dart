import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/auth/providers/auth_providers.dart';
import 'package:passpal/core/routing/routes.dart';
import 'package:passpal/core/storage/storage_providers.dart';
import 'package:passpal/core/theme/providers/theme_mode_provider.dart';
import 'package:passpal/core/error/error_notifier.dart';
import 'package:passpal/core/error/app_exception.dart';
import 'package:passpal/core/routing/providers.dart';

final settingsControllerProvider =
    AsyncNotifierProvider<SettingsController, void>(SettingsController.new);

class SettingsController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  /// ログアウト処理
  Future<void> logout() => _runGuarded(() async {
    await ref.read(authFacadeProvider).logout();
    ref.read(goRouterProvider).go(AppRoute.loginStudentId.path);
  });

  /// キャッシュクリア処理（個別のキーを削除）
  Future<void> clearCache() => _runGuarded(() async {
    // KeyValueCacheには全削除メソッドがないので、実装をスキップ
    // 実際の実装では具体的なキーを指定して削除する必要がある
    throw UnimplementedError('Cache clear not yet implemented');
  });

  /// キャンパス変更処理
  Future<void> changeCampus(String newCampus) => _runGuarded(() async {
    await ref.read(userPrefsProvider).setCampus(newCampus);
  });

  /// 時間割再取得処理
  Future<void> refreshTimetable() => _runGuarded(() async {
    // TODO: timetableSyncProviderが実装されたら追加
    // await ref.read(timetableSyncProvider.notifier).refreshNow();
    throw UnimplementedError('Timetable sync not yet implemented');
  });

  /// ダークモード切り替え（サイクル）
  void toggleTheme() {
    ref.read(themeModeProvider.notifier).cycle();
  }

  /// PassPalホームページを開く
  Future<void> openHomepage() => _runGuarded(() async {
    // TODO: configServiceProviderからURL取得とurl_launcher使用
    // final config = ref.read(configServiceProvider);
    // final url = config.getApiUrl('HOMEPAGE');
    // await launchUrl(Uri.parse(url));
    throw UnimplementedError('URL launcher not yet implemented');
  });

  /// エラーハンドリング付きの処理実行
  Future<void> _runGuarded(Future<void> Function() operation) async {
    try {
      state = const AsyncValue.loading();
      await operation();
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      // AppExceptionの場合のみerrorNotifierに送信
      if (error is AppException) {
        ref.read(errorNotifierProvider.notifier).show(error);
      }
    }
  }
}
