import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:passpal/core/config/sources/dotenv_config_source.dart';
import 'package:passpal/core/config/sources/remote_config_source.dart';
import 'package:passpal/core/config/sources/default_config_source.dart';
import 'package:passpal/core/config/repository/config_repository.dart';
import 'package:passpal/core/config/service/config_service.dart';
import 'package:passpal/core/config/models/app_config.dart';

/// DotEnv設定ソースのProvider
final dotEnvConfigSourceProvider = Provider<DotEnvConfigSource>((ref) {
  return DotEnvConfigSource();
});

/// Remote Config設定ソースのProvider
final remoteConfigSourceProvider = Provider<RemoteConfigSource>((ref) {
  return RemoteConfigSource(FirebaseRemoteConfig.instance);
});

/// デフォルト設定ソースのProvider
final defaultConfigSourceProvider = Provider<DefaultConfigSource>((ref) {
  return const DefaultConfigSource();
});

/// 設定リポジトリのProvider
final configRepositoryProvider = Provider<ConfigRepository>((ref) {
  return ConfigRepository(
    dotEnvSource: ref.watch(dotEnvConfigSourceProvider),
    remoteSource: ref.watch(remoteConfigSourceProvider),
    defaultSource: ref.watch(defaultConfigSourceProvider),
  );
});

/// 設定サービスのProvider
final configServiceProvider = Provider<ConfigService>((ref) {
  return ConfigService(ref.watch(configRepositoryProvider));
});

/// アプリ設定の非同期Provider
final appConfigProvider = FutureProvider<AppConfig>((ref) async {
  final service = ref.watch(configServiceProvider);
  return service.getAppConfig();
});

/// リアクティブな設定変更を監視するStreamProvider
final configStreamProvider = StreamProvider<AppConfig>((ref) {
  final service = ref.watch(configServiceProvider);

  // 初期値を取得してからストリームを開始
  return service.getAppConfig().asStream().asyncExpand((initialConfig) async* {
    yield initialConfig;
    yield* service.configStream;
  });
});

/// 特定の機能フラグを監視するProviderファミリー
final featureFlagProvider = StreamProvider.family<bool, String>((
  ref,
  featureName,
) {
  final service = ref.watch(configServiceProvider);
  return service.featureStream(featureName);
});

/// 設定の初期化Provider
final configInitializationProvider = FutureProvider<void>((ref) async {
  final repository = ref.watch(configRepositoryProvider);
  await repository.initialize();
});
