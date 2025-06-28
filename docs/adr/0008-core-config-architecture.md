# 0008. Core設定管理アーキテクチャ

日付: 2025-06-28

## 状況

PassPalアプリケーションにおいて、以下の設定管理が必要：

1. **環境変数（.env）**: 開発/本番環境での基本設定
2. **Firebase Remote Config**: 動的な機能フラグとA/Bテスト設定
3. **統合アクセス**: 他のcoreとfeaturesからの型安全で一貫したアクセス

現在の課題：
- 設定値が分散している（.env、Remote Config、ハードコード）
- 優先度管理が不明確
- 型安全性が確保されていない
- 設定変更のリアクティブ対応が困難

## 決定

3層構造の設定管理アーキテクチャを採用：

### 1. ConfigSource（設定ソース）
- **DotEnvConfigSource**: flutter_dotenvを使用した.env読み込み
- **RemoteConfigSource**: Firebase Remote Configからの動的設定

### 2. ConfigRepository（統合管理）
- **目的**: 複数ソースからの設定値統合と優先度管理
- **優先度**: Remote Config > .env
- **キャッシュ**: Remote Configは15分間キャッシュ
- **リアクティブ**: StreamControllerによる変更通知

### 3. ConfigService（フロントエンド）
- **目的**: 型安全な設定アクセスとRiverpod統合
- **API**: `getApiUrl()`, `isFeatureEnabled()`, `getDebugConfig()` など
- **Stream**: 設定変更の監視機能

### 4. 設定モデル
freezedによる型安全な設定クラス：

```dart
@freezed
class AppConfig with _$AppConfig {
  const factory AppConfig({
    required ApiConfig api,
    required FeatureFlags features,
    required DebugConfig debug,
  }) = _AppConfig;
}

@freezed
class ApiConfig with _$ApiConfig {
  const factory ApiConfig({
    required String baseUrl,
    required Duration timeout,
    required int retryCount,
  }) = _ApiConfig;
}

@freezed
class FeatureFlags with _$FeatureFlags {
  const factory FeatureFlags({
    required bool enableNewAssignmentParser,
    required bool enableBiometricAuth,
    required bool enableOfflineMode,
  }) = _FeatureFlags;
}
```

## 設定キー命名規則

| カテゴリ | 形式 | 例 |
|----------|------|-----|
| API設定 | `API_<NAME>` | `API_BASE_URL`, `API_TIMEOUT` |
| 機能フラグ | `FEATURE_<NAME>` | `FEATURE_NEW_PARSER`, `FEATURE_BIOMETRIC` |
| デバッグ | `DEBUG_<NAME>` | `DEBUG_SHOW_LOGS`, `DEBUG_MOCK_DATA` |

## 優先度とフォールバック

```
1. Remote Config（最優先）
   ↓ なし/エラー時
2. .env ファイル
```

## DI設計

```dart
final dotEnvConfigSourceProvider = Provider<DotEnvConfigSource>((ref) {
  return DotEnvConfigSource();
});

final remoteConfigSourceProvider = Provider<RemoteConfigSource>((ref) {
  return RemoteConfigSource(FirebaseRemoteConfig.instance);
});

final configRepositoryProvider = Provider<ConfigRepository>((ref) {
  return ConfigRepository(
    dotEnvSource: ref.watch(dotEnvConfigSourceProvider),
    remoteSource: ref.watch(remoteConfigSourceProvider),
  );
});

final configServiceProvider = Provider<ConfigService>((ref) {
  return ConfigService(ref.watch(configRepositoryProvider));
});

// リアクティブな設定監視
final configStreamProvider = StreamProvider<AppConfig>((ref) {
  final service = ref.watch(configServiceProvider);
  return service.configStream;
});
```

## Feature層での使用例

### 1. API設定の取得

```dart
// features/assignments/data/repository/assignment_repository.dart
@riverpod
class AssignmentRepository extends _$AssignmentRepository {
  @override
  Future<List<Assignment>> fetchAssignments() async {
    final config = ref.watch(configServiceProvider);
    final apiConfig = await config.getApiConfig();
    
    final dio = Dio(BaseOptions(
      baseURL: apiConfig.baseUrl,
      connectTimeout: apiConfig.timeout,
    ));
    
    // API呼び出し実装
  }
}
```

### 2. 機能フラグによる条件分岐

```dart
// features/auth/presentation/login_page.dart
Consumer(
  builder: (context, ref, child) {
    return ref.watch(configStreamProvider).when(
      data: (config) {
        if (config.features.enableBiometricAuth) {
          return BiometricLoginButton();
        }
        return StandardLoginButton();
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => StandardLoginButton(), // フォールバック
    );
  },
)
```

### 3. デバッグ設定による開発支援

```dart
// features/assignments/application/assignments_notifier.dart
@riverpod
class AssignmentsNotifier extends _$AssignmentsNotifier {
  @override
  Future<AsyncValue<List<Assignment>>> build() async {
    final config = ref.watch(configServiceProvider);
    final debugConfig = await config.getDebugConfig();
    
    if (debugConfig.useMockData) {
      return AsyncValue.data(MockAssignments.generate());
    }
    
    // 実際のデータ取得
    final repo = ref.watch(assignmentRepositoryProvider);
    return repo.fetchAssignments();
  }
}
```

## エラーハンドリング

- **ConfigException**: 設定取得エラーの基底クラス
- **ConfigParseException**: 設定値のパースエラー  
- **ConfigSourceException**: ソース固有のエラー
- **core/error**との統合: Crashlyticsへの自動報告

## テスト戦略

### 1. 単体テスト
- 各ConfigSourceの独立テスト
- ConfigRepositoryの優先度ロジックテスト
- ConfigServiceの型変換テスト

### 2. 統合テスト
- 複数ソースの統合動作テスト
- エラー時のフォールバック動作テスト

### 3. モック戦略
```dart
// テスト用の設定オーバーライド
final testConfigService = ConfigService(
  ConfigRepository(
    dotEnvSource: MockDotEnvConfigSource(),
    remoteSource: MockRemoteConfigSource(),
  ),
);

testWidgets('should use test config', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        configServiceProvider.overrideWithValue(testConfigService),
      ],
      child: MyApp(),
    ),
  );
});
```

## パフォーマンス考慮

- **Remote Configキャッシュ**: 15分間のメモリキャッシュ
- **初期化の最適化**: アプリ起動時の並列読み込み
- **Stream最適化**: 設定変更時のみ通知

## セキュリティ

- **機密情報の除外**: APIキーなどは.envに保存せず、firebase_remote_configで管理
- **本番環境での.env無効化**: リリースビルドでは.envを読み込まない

## 実装ファイル構成

```
lib/core/config/
 ├─ models/
 │   ├─ app_config.dart           # メイン設定モデル
 │   ├─ api_config.dart           # API関連設定
 │   ├─ feature_flags.dart        # 機能フラグ
 │   └─ debug_config.dart         # デバッグ設定
 ├─ sources/
 │   ├─ config_source.dart        # ベースインターフェース
 │   ├─ dotenv_config_source.dart # .env読み込み
 │   ├─ remote_config_source.dart # Remote Config
 ├─ repository/
 │   └─ config_repository.dart    # 統合管理
 ├─ service/
 │   └─ config_service.dart       # フロントエンド
 ├─ exceptions/
 │   └─ config_exception.dart     # 例外定義
 └─ config_providers.dart         # Riverpod統合
```

## 移行戦略

1. **Phase 1**: core/config実装とテスト
2. **Phase 2**: 既存ハードコード設定の移行
3. **Phase 3**: Remote Configキーの追加
4. **Phase 4**: 機能フラグの段階的導入

## 正の影響

- 設定の一元管理
- 型安全性の向上
- 動的な機能制御
- テスタビリティの向上
- 環境間の設定差分管理

## 負の影響

- 初期実装コストの増加
- Remote Configの依存性追加
- 設定変更時のテスト範囲拡大

## リンク

- 関連: [ADR-0001: Core Error Handling](0001-core-error-handling-architecture.md)
- 関連: [ADR-0002: Core Storage Architecture](0002-core-storage-architecture.md)
