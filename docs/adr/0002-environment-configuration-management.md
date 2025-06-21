# 環境設定の型安全な管理とマルチポータル対応

* Status: accepted
* Deciders: Development Team
* Date: 2025-06-22
* Template used: [MADR 3.0.0](https://adr.github.io/madr/)

Technical Story: コンパイル時環境変数管理とポータル別設定の型安全な実装

## Context and Problem Statement

ぱすぱるアプリでは、開発・ステージング・本番環境での設定管理と、複数の大学ポータル（MaNaBo、ALBO、SSO）それぞれに対する個別設定が必要である。従来の文字列ベースの環境変数管理では以下の問題があった：

* **型安全性の欠如**: 環境変数の型エラーが実行時まで発見されない
* **設定漏れ**: 必要な環境変数が未設定の場合の検出が困難
* **ポータル設定の複雑さ**: 各ポータルごとの設定管理が煩雑
* **開発効率**: 環境変数の補完や型チェックができない
* **デプロイ時の問題**: 設定ミスによるデプロイ失敗

## Decision Drivers

* **型安全性**: コンパイル時に環境変数の型と存在をチェック
* **開発効率**: IDEによる補完とリファクタリング支援
* **ポータル対応**: 各ポータルに特化した設定の提供
* **保守性**: 環境変数の一元管理と変更の容易性
* **デプロイ安全性**: 設定ミスによるデプロイ失敗の防止

## Considered Options

* **Option 1**: 従来の `String.fromEnvironment()` を継続使用
* **Option 2**: `flutter_dotenv` パッケージを使用した実行時環境変数読み込み
* **Option 3**: `envied` パッケージを使用したコンパイル時環境変数管理
* **Option 4**: 独自の環境設定クラスを実装

## Decision Outcome

Chosen option: "`envied` パッケージを使用したコンパイル時環境変数管理"

### Positive Consequences

* **型安全性の向上**: コンパイル時に環境変数の型と存在が検証される
* **開発効率の向上**: IDEによる補完とリファクタリング支援
* **設定ミスの防止**: 必要な環境変数が未設定の場合はビルドエラーとなる
* **ポータル特化設定**: 各ポータルに最適化された設定を自動提供
* **デプロイ安全性**: 設定問題は実行時ではなくビルド時に発見される
* **パフォーマンス**: 実行時の環境変数読み込みオーバーヘッドがない

### Negative Consequences

* **ビルドプロセスの複雑化**: コード生成ステップが必要
* **学習コスト**: 新しいパッケージの理解が必要
* **実行時変更不可**: 環境変数の動的変更ができない（Firebase Remote Configで補完）

## Pros and Cons of the Options

### `envied` パッケージを使用したコンパイル時環境変数管理

**実装内容:**

```dart
@Envied(path: '.env')
abstract class EnvConfig {
  @EnviedField(varName: 'BASE_URL_MANABO', defaultValue: 'https://manabo.tokai-u.jp')
  static const String manaboBaseUrl = _EnvConfig.manaboBaseUrl;
  
  @EnviedField(varName: 'BASE_URL_ALBO', defaultValue: 'https://albo.tokai-u.jp')
  static const String alboBaseUrl = _EnvConfig.alboBaseUrl;
  
  @EnviedField(varName: 'ENABLE_LOGGING', defaultValue: false)
  static const bool enableLogging = _EnvConfig.enableLogging;
  
  @EnviedField(varName: 'API_TIMEOUT_SECONDS', defaultValue: 20)
  static const int apiTimeoutSeconds = _EnvConfig.apiTimeoutSeconds;
}

enum Portal { manabo, albo, sso }

class Environment {
  factory Environment.forPortal(Portal portal) {
    final baseUrl = switch (portal) {
      Portal.manabo => EnvConfig.manaboBaseUrl,
      Portal.albo => EnvConfig.alboBaseUrl,
      Portal.sso => EnvConfig.ssoBaseUrl,
    };
    
    return Environment(
      apiBase: baseUrl,
      enableLogging: EnvConfig.enableLogging,
      enablePinning: EnvConfig.enablePinning,
      timeoutSeconds: EnvConfig.apiTimeoutSeconds,
      maxRetryAttempts: EnvConfig.maxRetryAttempts,
      certificatePins: [
        if (EnvConfig.certPinMain.isNotEmpty) EnvConfig.certPinMain,
        if (EnvConfig.certPinBackup.isNotEmpty) EnvConfig.certPinBackup,
      ],
    );
  }
}
```

* Good, because コンパイル時に環境変数の存在と型が検証される
* Good, because IDEによる補完とリファクタリング支援が利用できる
* Good, because 各ポータルに特化した設定が自動的に提供される
* Good, because デフォルト値により設定漏れが防止される
* Good, because パフォーマンスが向上する（実行時読み込み不要）
* Bad, because ビルドプロセスにコード生成ステップが必要
* Bad, because 実行時の環境変数変更ができない

### 従来の `String.fromEnvironment()` を継続使用

* Good, because 追加の依存関係が不要
* Good, because 実装が簡単
* Bad, because 型安全性がない
* Bad, because 設定ミスが実行時まで発見されない
* Bad, because IDEによる支援が限定的
* Bad, because ポータル別設定の管理が煩雑

### `flutter_dotenv` パッケージを使用

* Good, because 実行時に環境変数を変更できる
* Good, because 設定ファイルの管理が容易
* Bad, because 実行時エラーのリスクがある
* Bad, because 型安全性がない
* Bad, because パフォーマンスオーバーヘッドがある

### 独自の環境設定クラスを実装

* Good, because 完全にカスタマイズされた実装が可能
* Bad, because 実装コストが高い
* Bad, because 保守コストが高い
* Bad, because 既存のベストプラクティスを再実装する必要がある

## Implementation Details

### Directory Structure

```text
lib/core/network/
├── env_config.dart          # 環境設定クラス
├── env_config.g.dart        # 生成されたコード
├── portal.dart              # Portal enum
├── environment.dart         # Environment クラス
└── network_provider.dart    # Riverpod プロバイダー
```

### Environment Variables

#### .env ファイル構成

```properties
# API Base URLs
API_BASE_URL=https://api.example.com
BASE_URL_MANABO=https://manabo.tokai-u.jp
BASE_URL_ALBO=https://albo.tokai-u.jp
SSO_BASE_URL=https://sso.tokai-u.jp

# Certificate pins
CERT_PIN_MAIN=sha256/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
CERT_PIN_BACKUP=sha256/YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY=

# Feature flags
ENABLE_LOGGING=true
ENABLE_PINNING=false

# Network configuration
API_TIMEOUT_SECONDS=20
MAX_RETRY_ATTEMPTS=3
```

#### 環境別設定

```bash
# 開発環境
.env.development

# ステージング環境
.env.staging

# 本番環境
.env.production
```

### Build Process

1. **コード生成**: `flutter packages pub run build_runner build`
2. **環境変数検証**: ビルド時に必要な環境変数の存在と型をチェック
3. **デフォルト値適用**: 未設定の環境変数にはデフォルト値を適用

### Portal Configuration

```dart
// 使用例
final envProvider = Provider.family<Environment, Portal>((ref, portal) {
  return Environment.forPortal(portal);
});

// 各ポータル専用のHTTPクライアント
final dioWrapperProvider = Provider.family<BaseDioWrapper, Portal>((ref, portal) {
  final env = ref.watch(envProvider(portal));
  
  return BaseDioWrapper(
    baseUrl: env.apiBase,
    timeout: env.timeout,
    maxRetry: env.maxRetryAttempts,
    enablePinning: env.enablePinning,
  );
});
```

## Testing Strategy

### Unit Tests

```dart
group('Environment Configuration', () {
  test('should provide correct base URL for each portal', () {
    // Given
    final manaboEnv = Environment.forPortal(Portal.manabo);
    final alboEnv = Environment.forPortal(Portal.albo);
    final ssoEnv = Environment.forPortal(Portal.sso);
    
    // Then
    expect(manaboEnv.apiBase, contains('manabo'));
    expect(alboEnv.apiBase, contains('albo'));
    expect(ssoEnv.apiBase, contains('sso'));
  });
  
  test('should apply default values when environment variables are missing', () {
    // Given & When
    final env = Environment.forPortal(Portal.manabo);
    
    // Then
    expect(env.timeoutSeconds, equals(20)); // default value
    expect(env.maxRetryAttempts, equals(3)); // default value
  });
});
```

### Integration Tests

```dart
testWidgets('should use portal-specific configuration in HTTP requests', (tester) async {
  // Given
  final container = ProviderContainer();
  
  // When
  final manaboWrapper = container.read(dioWrapperProvider(Portal.manabo));
  final alboWrapper = container.read(dioWrapperProvider(Portal.albo));
  
  // Then
  expect(manaboWrapper.dio.options.baseUrl, contains('manabo'));
  expect(alboWrapper.dio.options.baseUrl, contains('albo'));
});
```

## Migration Strategy

### Phase 1: Environment Configuration Setup

1. `.env` ファイルの作成と環境変数の移行
2. `EnvConfig` クラスの実装
3. ビルドプロセスの更新

### Phase 2: Portal Support Implementation

1. `Portal` enum の実装
2. `Environment.forPortal()` ファクトリーの実装
3. Riverpod プロバイダーの更新

### Phase 3: Existing Code Migration

1. 既存の環境変数使用箇所の特定
2. `EnvConfig` への段階的移行
3. テストの更新

### Phase 4: Validation and Cleanup

1. 全環境での動作検証
2. 不要な環境変数読み込みコードの削除
3. ドキュメントの更新

## Monitoring and Validation

### Build-time Validation

* 必要な環境変数の存在チェック
* 型の妥当性検証
* デフォルト値の適用ログ

### Runtime Monitoring

* ポータル別設定の使用状況
* 環境変数読み込みエラーの監視
* 設定値の正確性検証

## Security Considerations

### Sensitive Data Handling

* 証明書ピンやAPIキーの暗号化
* 環境変数ファイルの適切な除外設定
* CI/CDでの環境変数の安全な管理

### Access Control

* 環境変数へのアクセス制御
* 設定変更の監査ログ
* 権限管理の実装

## Links

* [基本的なHTTPクライアント実装](./0001-base-dio-wrapper-http-client.md)
* [Network Layer Instructions](../../.github/instructions/network.instructions.md)
* [envied パッケージドキュメント](https://pub.dev/packages/envied)

<!-- markdownlint-disable-file MD013 -->
