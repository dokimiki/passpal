import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:passpal/core/util/package_info_provider.dart';
import 'package:passpal/core/config/config_providers.dart';
import 'package:passpal/features/system/shared/widgets/system_scaffold.dart';
import 'package:passpal/features/system/force_update/presentation/widgets/update_prompt_card.dart';

/// Force update page displayed when app version is below minimum supported version
class ForceUpdatePage extends ConsumerWidget {
  const ForceUpdatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfoAsync = ref.watch(packageInfoProvider);
    final configAsync = ref.watch(appConfigProvider);

    return SystemScaffold(
      title: 'アップデート必須',
      body: packageInfoAsync.when(
        data: (packageInfo) => configAsync.when(
          data: (config) => _buildContent(
            context,
            currentVersion: packageInfo.version,
            requiredVersion: config.admin.minimumVersion,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) =>
              Center(child: Text('設定の読み込みに失敗しました: $error')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('アプリ情報の取得に失敗しました: $error')),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required String currentVersion,
    required String requiredVersion,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: UpdatePromptCard(
          currentVersion: currentVersion,
          requiredVersion: requiredVersion,
          onUpdatePressed: () => _launchStore(),
        ),
      ),
    );
  }

  Future<void> _launchStore() async {
    late final Uri storeUrl;

    if (Platform.isIOS) {
      // iOS App Store URL
      storeUrl = Uri.parse('https://apps.apple.com/app/passpal/id1234567890');
    } else if (Platform.isAndroid) {
      // Google Play Store URL
      storeUrl = Uri.parse(
        'https://play.google.com/store/apps/details?id=com.chukyo.passpal',
      );
    } else {
      // Fallback for other platforms
      return;
    }

    if (await canLaunchUrl(storeUrl)) {
      await launchUrl(storeUrl, mode: LaunchMode.externalApplication);
    }
  }
}
