import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/auth/providers/auth_providers.dart';
import 'package:passpal/core/auth/providers/auth_state_notifier.dart';
import 'package:passpal/core/theme/providers/theme_mode_provider.dart';
import 'package:passpal/features/settings/application/settings_controller.dart';
import 'package:passpal/features/settings/presentation/widgets/settings_section.dart';
import 'package:passpal/features/settings/presentation/widgets/settings_tile.dart';
import 'package:passpal/features/settings/presentation/widgets/confirmation_sheet.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final themeMode = ref.watch(themeModeProvider);
    final controllerState = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    // エラー時のSnackBar表示
    ref.listen(settingsControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('エラーが発生しました: $error'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // アカウント設定
            SettingsSection(
              title: 'アカウント',
              children: [
                SettingsTile(
                  title: '学生ID',
                  subtitle: _getStudentIdText(authState),
                  leading: const Icon(Icons.person),
                ),
                SettingsTile(
                  title: 'ログアウト',
                  leading: const Icon(Icons.logout),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showLogoutConfirmation(context, controller),
                ),
              ],
            ),

            // データ設定
            SettingsSection(
              title: 'データ',
              children: [
                SettingsTile(
                  title: 'キャッシュをクリア',
                  subtitle: '保存されたデータを削除します',
                  leading: const Icon(Icons.cleaning_services),
                  trailing: const Icon(Icons.chevron_right),
                  isLoading: controllerState.isLoading,
                  onTap: () => _showClearCacheConfirmation(context, controller),
                ),
                SettingsTile(
                  title: '時間割を再取得',
                  subtitle: '最新の時間割データを取得します',
                  leading: const Icon(Icons.refresh),
                  trailing: const Icon(Icons.chevron_right),
                  isLoading: controllerState.isLoading,
                  onTap: () =>
                      _showRefreshTimetableConfirmation(context, controller),
                ),
              ],
            ),

            // 表示設定
            SettingsSection(
              title: '表示',
              children: [
                SettingsTile(
                  title: 'ダークモード',
                  subtitle: _getThemeModeDescription(themeMode),
                  leading: const Icon(Icons.dark_mode),
                  trailing: Switch.adaptive(
                    value: themeMode == ThemeMode.dark,
                    onChanged: (_) => controller.toggleTheme(),
                  ),
                ),
              ],
            ),

            // 情報設定
            SettingsSection(
              title: '情報',
              children: [
                SettingsTile(
                  title: 'PassPalについて',
                  subtitle: 'ホームページを開きます',
                  leading: const Icon(Icons.info),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () => controller.openHomepage(),
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  String _getStudentIdText(AuthState authState) {
    switch (authState) {
      case AuthStateAuthenticated(:final session):
        return session.username;
      case AuthStateRefreshing(:final session):
        return session.username;
      case AuthStateUnauthenticated():
        return '未ログイン';
      case AuthStateAuthenticating():
        return '認証中...';
      case AuthStateError():
        return 'エラー';
    }
  }

  String _getThemeModeDescription(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'ライトモード';
      case ThemeMode.dark:
        return 'ダークモード';
      case ThemeMode.system:
        return 'システム設定に従う';
    }
  }

  void _showLogoutConfirmation(
    BuildContext context,
    SettingsController controller,
  ) {
    showConfirmationSheet(
      context,
      title: 'ログアウト',
      message: 'ログアウトしますか？',
      confirmText: 'ログアウト',
      isDestructive: true,
      onConfirm: () => controller.logout(),
    );
  }

  void _showClearCacheConfirmation(
    BuildContext context,
    SettingsController controller,
  ) {
    showConfirmationSheet(
      context,
      title: 'キャッシュクリア',
      message: '保存されたキャッシュデータを削除しますか？',
      confirmText: 'クリア',
      isDestructive: true,
      onConfirm: () => controller.clearCache(),
    );
  }

  void _showRefreshTimetableConfirmation(
    BuildContext context,
    SettingsController controller,
  ) {
    showConfirmationSheet(
      context,
      title: '時間割再取得',
      message: '最新の時間割データを取得しますか？',
      confirmText: '取得',
      onConfirm: () => controller.refreshTimetable(),
    );
  }
}
