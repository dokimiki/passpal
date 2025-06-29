import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/auth/providers/auth_providers.dart';
import 'package:passpal/core/auth/providers/auth_state_notifier.dart';
import 'package:passpal/core/theme/providers/theme_mode_provider.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';
import 'package:passpal/features/settings/application/settings_controller.dart';
import 'package:passpal/features/settings/presentation/widgets/confirmation_sheet.dart';
import 'package:passpal/features/settings/presentation/widgets/settings_tile.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final themeMode = ref.watch(themeModeProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    ref.listen(settingsControllerProvider, (_, next) {
      if (next.hasError && !next.isLoading) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${next.error}')));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(SpaceTokens.md),
        children: [
          _buildSection(
            context,
            title: 'Account',
            children: [
              SettingsTile(
                title: 'Student ID',
                subtitle: _getStudentIdText(authState),
                leading: const Icon(Icons.person_outline),
              ),
              SettingsTile(
                title: 'Logout',
                leading: const Icon(Icons.logout),
                onTap: () => _showLogoutConfirmation(context, controller),
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Data Management',
            children: [
              SettingsTile(
                title: 'Clear Cache',
                subtitle: 'Remove cached data',
                leading: const Icon(Icons.delete_sweep_outlined),
                onTap: () => _showClearCacheConfirmation(context, controller),
              ),
              SettingsTile(
                title: 'Refresh Timetable',
                subtitle: 'Fetch the latest timetable',
                leading: const Icon(Icons.refresh_outlined),
                onTap: () =>
                    _showRefreshTimetableConfirmation(context, controller),
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Appearance',
            children: [
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: themeMode == ThemeMode.dark,
                onChanged: (_) => controller.toggleTheme(),
                secondary: const Icon(Icons.brightness_6_outlined),
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'About',
            children: [
              SettingsTile(
                title: 'About PassPal',
                subtitle: 'Version 1.0.0', // Replace with dynamic version
                leading: const Icon(Icons.info_outline),
                onTap: () => controller.openHomepage(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            SpaceTokens.md,
            SpaceTokens.md,
            SpaceTokens.md,
            SpaceTokens.sm,
          ),
          child: Text(
            title.toUpperCase(),
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        Card(
          elevation: 0,
          color: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.3,
          ),
          child: Column(children: children),
        ),
        const SizedBox(height: SpaceTokens.md),
      ],
    );
  }

  String _getStudentIdText(AuthState authState) {
    return switch (authState) {
      AuthStateAuthenticated(:final session) => session.username,
      AuthStateRefreshing(:final session) => session.username,
      _ => 'Not logged in',
    };
  }

  void _showLogoutConfirmation(
    BuildContext context,
    SettingsController controller,
  ) {
    showConfirmationSheet(
      context,
      title: 'Logout',
      message: 'Are you sure you want to log out?',
      confirmText: 'Logout',
      isDestructive: true,
      onConfirm: controller.logout,
    );
  }

  void _showClearCacheConfirmation(
    BuildContext context,
    SettingsController controller,
  ) {
    showConfirmationSheet(
      context,
      title: 'Clear Cache',
      message: 'This will remove all cached data. Are you sure?',
      confirmText: 'Clear',
      isDestructive: true,
      onConfirm: controller.clearCache,
    );
  }

  void _showRefreshTimetableConfirmation(
    BuildContext context,
    SettingsController controller,
  ) {
    showConfirmationSheet(
      context,
      title: 'Refresh Timetable',
      message: 'Fetch the latest timetable data from the server?',
      confirmText: 'Refresh',
      onConfirm: controller.refreshTimetable,
    );
  }
}
