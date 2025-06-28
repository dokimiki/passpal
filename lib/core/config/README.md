# Core Config

設定管理コンポーネント - .env、Firebase Remote Config、デフォルト値からの統合設定管理

## 概要

`lib/core/config` は PassPal アプリケーションの設定管理を担当するコンポーネントです。複数の設定ソースから値を取得し、優先度に基づいて統合して提供します。

## 主要機能

- ✅ 複数設定ソースの統合（Remote Config > .env > Default）
- ✅ 型安全な設定アクセス
- ✅ リアクティブな設定変更通知
- ✅ 機能フラグによる動的機能制御
- ✅ Riverpod完全統合
- ✅ 例外伝播シナリオのテスト

## アーキテクチャ

```
ConfigService
     ↓
ConfigRepository (優先度管理)
     ↓
[RemoteConfigSource, DotEnvConfigSource, DefaultConfigSource]
```

### 優先度

1. **Firebase Remote Config** (最優先)
2. **.env ファイル**
3. **デフォルト値** (フォールバック)

## 使用例

### Feature層での基本使用

```dart
// 1. API設定の取得
@riverpod
class ApiClient extends _$ApiClient {
  @override
  Future<Dio> build() async {
    final config = ref.watch(configServiceProvider);
    final apiConfig = await config.getApiConfig();
    
    return Dio(BaseOptions(
      baseURL: apiConfig.palapiBaseUrl,
      connectTimeout: apiConfig.timeout,
    ));
  }
}

// 2. 機能フラグによる分岐
Consumer(
  builder: (context, ref, child) {
    return ref.watch(featureFlagProvider('biometricAuth')).when(
      data: (isEnabled) => isEnabled 
          ? BiometricLoginButton() 
          : StandardLoginButton(),
      loading: () => StandardLoginButton(),
      error: (_, __) => StandardLoginButton(),
    );
  },
)

// 3. デバッグ設定の利用
@riverpod
class AssignmentsNotifier extends _$AssignmentsNotifier {
  @override
  Future<List<Assignment>> build() async {
    final config = ref.watch(configServiceProvider);
    final debugConfig = await config.getDebugConfig();
    
    if (debugConfig.useMockData) {
      return MockAssignments.generate();
    }
    
    final repo = ref.watch(assignmentRepositoryProvider);
    return repo.fetchAssignments();
  }
}
```

### リアクティブな設定監視

```dart
@riverpod
class ConfigDependentNotifier extends _$ConfigDependentNotifier {
  @override
  Stream<DataState> build() {
    return ref.watch(configStreamProvider).asyncMap((config) async {
      // 設定変更時に自動的に再構築される
      if (config.features.enableNewAssignmentParser) {
        return await _fetchWithNewParser();
      } else {
        return await _fetchWithLegacyParser();
      }
    });
  }
}
```

## 設定キー

### API設定
- `PAL_API_BASE_URL`: APIベースURL
- `API_TIMEOUT`: タイムアウト時間（秒）
- `API_RETRY_COUNT`: リトライ回数
- `API_RETRY_DELAY`: リトライ間隔（秒）

### 機能フラグ
- `FEATURE_NEW_ASSIGNMENT_PARSER`: 新しい課題パーサーの有効化
- `FEATURE_BIOMETRIC_AUTH`: 生体認証の有効化
- `FEATURE_OFFLINE_MODE`: オフラインモードの有効化
- `FEATURE_EXPERIMENTAL`: 実験的機能の有効化

### デバッグ設定
- `DEBUG_SHOW_LOGS`: ログ表示の有効化
- `DEBUG_MOCK_DATA`: モックデータの使用
- `DEBUG_NETWORK_LOGGING`: ネットワークログの有効化
- `DEBUG_PERFORMANCE_MONITORING`: パフォーマンス監視の有効化

## .env設定

開発環境用の`.env`ファイルを作成：

```bash
cp .env.example .env
```

```env
# Development API
PAL_API_BASE_URL=https://api.chukyo-passpal.app/v1
FEATURE_NEW_ASSIGNMENT_PARSER=true
DEBUG_SHOW_LOGS=true
```

## Firebase Remote Config

本番環境では以下のキーをRemote Configで管理：

```json
{
  "PAL_API_BASE_URL": "https://api.chukyo-passpal.app/v1",
  "FEATURE_NEW_ASSIGNMENT_PARSER": false,
  "FEATURE_BIOMETRIC_AUTH": true,
  "force_update_min_version": "1.2.0"
}
```

## テスト

### 単体テスト

```dart
testWidgets('should use test config', (tester) async {
  final testConfig = AppConfig(
    api: ApiConfig(
      baseUrl: 'https://test.api.com',
      timeout: Duration(seconds: 5),
      retryCount: 1,
      retryDelay: Duration(milliseconds: 500),
    ),
    features: FeatureFlags(
      enableNewAssignmentParser: true,
      enableBiometricAuth: false,
      enableOfflineMode: false,
      enableExperimentalFeatures: false,
    ),
    debug: DebugConfig.defaultConfig,
  );

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWith((ref) async => testConfig),
      ],
      child: MyApp(),
    ),
  );
});
```

### 例外伝播テスト

```dart
test('should propagate config exceptions to Crashlytics', () async {
  // ConfigSourceException発生時のテスト
  final mockSource = MockRemoteConfigSource();
  when(mockSource.getString('PAL_API_BASE_URL'))
      .thenThrow(ConfigSourceException(message: 'Network error', source: 'Remote'));

  final repository = ConfigRepository(
    remoteSource: mockSource,
    dotEnvSource: MockDotEnvConfigSource(),
    defaultSource: DefaultConfigSource(),
  );

  // 例外がCrashlyticsに報告されることを確認
  await repository.getAppConfig();
  verify(mockCrashlytics.recordError(any, any)).called(1);
});
```

## エラーハンドリング

- **ConfigParseException**: 設定値のパースエラー
- **ConfigSourceException**: ソース固有のエラー  
- **RequiredConfigMissingException**: 必須設定の欠如
- 全例外は `core/error` 経由でCrashlyticsに報告

## パフォーマンス

- **Remote Configキャッシュ**: 15分間のメモリキャッシュ
- **初期化最適化**: アプリ起動時の並列読み込み
- **Stream最適化**: 設定変更時のみ通知

## 関連文書

- [ADR-0008: Core設定管理アーキテクチャ](../../docs/adr/0008-core-config-architecture.md)
- [ADR-0001: Core Error Handling](../../docs/adr/0001-core-error-handling-architecture.md)
- [ADR-0002: Core Storage Architecture](../../docs/adr/0002-core-storage-architecture.md)

## 新しい設定値の追加ガイド

新しい設定値を追加する際は、以下の手順に従ってください。

### 1. 設定キーの命名

設定キーは明確で一貫した命名規則に従ってください：

```
# 正しい例
API_TIMEOUT_SECONDS=30
FEATURE_ENABLE_DARK_MODE=true
DEBUG_MOCK_NETWORK_CALLS=false

# 避けるべき例
timeout=30                    # カテゴリ不明
EnableDarkMode=true          # 命名規則不一致
mock_network=false           # カテゴリ不明
```

#### カテゴリ別命名規則

| カテゴリ | プレフィックス | 例 |
|----------|---------------|-----|
| API設定 | `API_` | `PAL_API_BASE_URL`, `API_RETRY_COUNT` |
| 機能フラグ | `FEATURE_` | `FEATURE_ENABLE_BIOMETRIC`, `FEATURE_NEW_PARSER` |
| デバッグ | `DEBUG_` | `DEBUG_SHOW_LOGS`, `DEBUG_MOCK_DATA` |
| UI設定 | `UI_` | `UI_ANIMATION_DURATION`, `UI_THEME_MODE` |
| キャッシュ | `CACHE_` | `CACHE_TTL_HOURS`, `CACHE_MAX_SIZE` |

### 2. 設定モデルの更新

#### Step 1: 該当するモデルクラスにフィールドを追加

```dart
// lib/core/config/models/feature_flags.dart
@freezed
class FeatureFlags with _$FeatureFlags {
  const factory FeatureFlags({
    // ...existing code...
    required bool enableNewAssignmentParser,
    required bool enableBiometricAuth,
    // 新しいフィールドを追加
    required bool enableDarkMode,
    required bool enableNotifications,
  }) = _FeatureFlags;

  // ...existing code...
  
  /// デフォルトの機能フラグ
  static const FeatureFlags defaultConfig = FeatureFlags(
    // ...existing code...
    enableNewAssignmentParser: false,
    enableBiometricAuth: false,
    // デフォルト値を設定
    enableDarkMode: false,
    enableNotifications: true,
  );
}
```

#### Step 2: 新しいカテゴリが必要な場合は専用モデルを作成

```dart
// lib/core/config/models/ui_config.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_config.freezed.dart';
part 'ui_config.g.dart';

@freezed
class UiConfig with _$UiConfig {
  const factory UiConfig({
    required Duration animationDuration,
    required String themeMode,
    required double textScaleFactor,
  }) = _UiConfig;

  factory UiConfig.fromJson(Map<String, dynamic> json) => _$UiConfigFromJson(json);

  static const UiConfig defaultConfig = UiConfig(
    animationDuration: Duration(milliseconds: 300),
    themeMode: 'system',
    textScaleFactor: 1.0,
  );
}
```

#### Step 3: AppConfigに新しいカテゴリを追加

```dart
// lib/core/config/models/app_config.dart
@freezed
class AppConfig with _$AppConfig {
  const factory AppConfig({
    required ApiConfig api,
    required FeatureFlags features,
    required DebugConfig debug,
    // 新しいカテゴリを追加
    required UiConfig ui,
  }) = _AppConfig;

  // ...existing code...

  static const AppConfig defaultConfig = AppConfig(
    api: ApiConfig.defaultConfig,
    features: FeatureFlags.defaultConfig,
    debug: DebugConfig.defaultConfig,
    // デフォルト値を設定
    ui: UiConfig.defaultConfig,
  );
}
```

### 3. デフォルト値の追加

```dart
// lib/core/config/sources/default_config_source.dart
static const Map<String, dynamic> _defaultValues = {
  // ...existing code...
  
  // 新しい設定値を追加
  'FEATURE_ENABLE_DARK_MODE': false,
  'FEATURE_ENABLE_NOTIFICATIONS': true,
  'UI_ANIMATION_DURATION': 300,
  'UI_THEME_MODE': 'system',
  'UI_TEXT_SCALE_FACTOR': 1.0,
};
```

### 4. ConfigRepositoryの更新

新しいカテゴリを追加した場合は、ConfigRepositoryにビルドメソッドを追加：

```dart
// lib/core/config/repository/config_repository.dart
class ConfigRepository {
  // ...existing code...

  /// 統合されたアプリ設定を取得
  Future<AppConfig> getAppConfig() async {
    if (_cachedConfig != null) {
      return _cachedConfig!;
    }

    final apiConfig = await _buildApiConfig();
    final featureFlags = await _buildFeatureFlags();
    final debugConfig = await _buildDebugConfig();
    // 新しいカテゴリのビルドメソッドを呼び出し
    final uiConfig = await _buildUiConfig();

    _cachedConfig = AppConfig(
      api: apiConfig,
      features: featureFlags,
      debug: debugConfig,
      ui: uiConfig, // 新しいカテゴリを追加
    );

    return _cachedConfig!;
  }

  /// UI設定を構築
  Future<UiConfig> _buildUiConfig() async {
    final animationMs = await _getValue<int>('UI_ANIMATION_DURATION') ?? 
        UiConfig.defaultConfig.animationDuration.inMilliseconds;
    final themeMode = await _getValue<String>('UI_THEME_MODE') ?? 
        UiConfig.defaultConfig.themeMode;
    final textScale = await _getValue<double>('UI_TEXT_SCALE_FACTOR') ?? 
        UiConfig.defaultConfig.textScaleFactor;

    return UiConfig(
      animationDuration: Duration(milliseconds: animationMs),
      themeMode: themeMode,
      textScaleFactor: textScale,
    );
  }
}
```

### 5. ConfigServiceの更新

新しい設定へのアクセスメソッドを追加：

```dart
// lib/core/config/service/config_service.dart
class ConfigService {
  // ...existing code...

  /// UI設定を取得
  Future<UiConfig> getUiConfig() async {
    final config = await getAppConfig();
    return config.ui;
  }

  /// 特定のUI設定値を取得
  Future<Duration> getAnimationDuration() async {
    final uiConfig = await getUiConfig();
    return uiConfig.animationDuration;
  }

  /// テーマモードを取得
  Future<String> getThemeMode() async {
    final uiConfig = await getUiConfig();
    return uiConfig.themeMode;
  }
}
```

### 6. コード生成の実行

新しいモデルを追加した後は、freezedとjson_serializableのコードを生成：

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 7. テストの追加

新しい設定値のテストを作成：

```dart
// test/core/config/ui_config_test.dart
import 'package:test/test.dart';
import 'package:passpal/core/config/models/ui_config.dart';

void main() {
  group('UiConfig', () {
    test('should create with default values', () {
      const config = UiConfig.defaultConfig;
      
      expect(config.animationDuration, equals(Duration(milliseconds: 300)));
      expect(config.themeMode, equals('system'));
      expect(config.textScaleFactor, equals(1.0));
    });

    test('should create from json', () {
      final json = {
        'animationDuration': 500,
        'themeMode': 'dark',
        'textScaleFactor': 1.2,
      };

      final config = UiConfig.fromJson(json);
      
      expect(config.animationDuration, equals(Duration(milliseconds: 500)));
      expect(config.themeMode, equals('dark'));
      expect(config.textScaleFactor, equals(1.2));
    });
  });
}
```

### 8. .envファイルの更新

開発用の.envファイルに新しい設定値を追加：

```env
# .env.example

# UI設定
UI_ANIMATION_DURATION=300
UI_THEME_MODE=system
UI_TEXT_SCALE_FACTOR=1.0

# 新しい機能フラグ
FEATURE_ENABLE_DARK_MODE=true
FEATURE_ENABLE_NOTIFICATIONS=true
```

### 9. Remote Configの設定

Firebase Remote Configコンソールで新しいキーを追加：

1. Firebase Console → Remote Config
2. 新しいパラメータを追加
3. デフォルト値を設定
4. 条件付き値を設定（必要に応じて）

### 10. Feature層での使用

```dart
// features/settings/presentation/settings_page.dart
Consumer(
  builder: (context, ref, child) {
    return ref.watch(appConfigProvider).when(
      data: (config) => Column(
        children: [
          SwitchListTile(
            title: Text('ダークモード'),
            value: config.features.enableDarkMode,
            onChanged: (value) {
              // 設定変更の処理
            },
          ),
          SwitchListTile(
            title: Text('通知'),
            value: config.features.enableNotifications,
            onChanged: (value) {
              // 設定変更の処理
            },
          ),
        ],
      ),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('設定の読み込みに失敗しました'),
    );
  },
)
```

### ベストプラクティス

#### ✅ 推奨

- **型安全性**: 常に適切な型を使用（bool, int, Duration など）
- **デフォルト値**: すべての設定に安全なデフォルト値を提供
- **テスト駆動**: 設定を追加する前にテストを書く
- **命名一貫性**: 既存のパターンに従った命名
- **ドキュメント**: 設定の目的と使用方法を明記

#### ❌ 避けるべき

- **破壊的変更**: 既存の設定キーの型や意味を変更
- **曖昧な命名**: 目的が不明確な設定名
- **デフォルト値なし**: フォールバック値を提供しない
- **直接アクセス**: ConfigRepositoryを直接使用せずConfigServiceを経由
- **テストなし**: 新しい設定のテストを省略

### 例外伝播シナリオテスト

新しい設定値を追加した際は、例外処理のテストも追加：

```dart
// test/core/config/config_exception_propagation_test.dart
test('should propagate config exceptions to Crashlytics when fetching UI config', () async {
  final mockRemoteSource = MockRemoteConfigSource();
  final mockCrashlytics = MockCrashlyticsReporter();
  
  when(mockRemoteSource.getString('UI_THEME_MODE'))
      .thenThrow(ConfigSourceException(message: 'Network error', source: 'Remote'));

  final repository = ConfigRepository(
    remoteSource: mockRemoteSource,
    dotEnvSource: MockDotEnvConfigSource(),
    defaultSource: DefaultConfigSource(),
  );

  // 例外発生時もデフォルト値で動作することを確認
  final config = await repository.getAppConfig();
  expect(config.ui.themeMode, equals('system')); // デフォルト値

  // Crashlyticsに例外が報告されることを確認
  verify(mockCrashlytics.recordError(any, any, fatal: false)).called(1);
});
```

このガイドに従うことで、型安全で保守性の高い設定管理が実現できます。
