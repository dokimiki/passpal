// main.dartでの設定初期化の例

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passpal/core/storage/storage_providers.dart';
import 'package:passpal/core/config/config_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SharedPreferencesの初期化
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // 依存性注入のオーバーライド
        sharedPrefsProvider.overrideWithValue(sharedPrefs),
      ],
      child: const PassPalApp(),
    ),
  );
}

class PassPalApp extends ConsumerWidget {
  const PassPalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 設定の初期化を監視
    return ref
        .watch(configInitializationProvider)
        .when(
          data: (_) => _buildApp(ref),
          loading: () => const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          ),
          error: (error, stack) => MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('設定の初期化に失敗しました: $error'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          ref.refresh(configInitializationProvider),
                      child: const Text('再試行'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }

  Widget _buildApp(WidgetRef ref) {
    return ref
        .watch(configStreamProvider)
        .when(
          data: (config) => MaterialApp(
            title: 'PassPal',
            theme: ThemeData(
              // 設定に基づいたテーマ構築
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            ),
            home: const HomePage(),
          ),
          loading: () => const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          ),
          error: (error, stack) => MaterialApp(
            home: Scaffold(body: Center(child: Text('設定エラー: $error'))),
          ),
        );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('PassPal')),
      body: Column(
        children: [
          // 機能フラグに基づく条件表示の例
          ref
              .watch(featureFlagProvider('biometricAuth'))
              .when(
                data: (isEnabled) => isEnabled
                    ? const ListTile(
                        leading: Icon(Icons.fingerprint),
                        title: Text('生体認証が利用可能です'),
                      )
                    : const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),

          // デバッグ情報の表示（デバッグ設定に基づく）
          ref
              .watch(appConfigProvider)
              .when(
                data: (config) => config.debug.showLogs
                    ? Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('デバッグ情報'),
                              Text('PalAPI URL: ${config.api.palapiBaseUrl}'),
                              Text('Mock Data: ${config.debug.useMockData}'),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
        ],
      ),
    );
  }
}
