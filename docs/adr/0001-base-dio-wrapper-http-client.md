# BaseDioWrapperを使用したHTTPクライアント実装

* Status: accepted
* Deciders: Development Team
* Date: 2025-06-22
* Updated: 2025-06-22 (環境設定とPortal対応の追加)
* Template used: [MADR 3.0.0](https://adr.github.io/madr/)

Technical Story: コアネットワークモジュールのHTTPクライアント実装、環境設定管理、およびマルチポータル対応の設計

## Context and Problem Statement

ぱすぱるアプリでは、複数の大学ポータル（MaNaBo、ALBO、SSO）との通信において、ポータルごとに異なる設定を持ちながら、信頼性が高く安全なHTTP通信が必要である。特に以下の要件を満たす必要がある：

* **マルチポータル対応**: MaNaBo、ALBO、SSOポータルそれぞれに最適化された設定
* **環境設定管理**: コンパイル時環境変数による設定の型安全な管理
* 一時的なサーバーエラー（503/429）やネットワーク障害に対する自動リトライ機能
* セキュリティ強化のためのTLS証明書ピニング（Firebase Remote Config連携）
* セッション管理のための永続的なクッキー保存
* テストしやすい依存性注入の仕組み
* デバッグ時のリクエスト/レスポンスログ出力

## Decision Drivers

* **ポータル対応**: 各ポータルの特性に応じた個別設定が必要
* **型安全性**: 環境変数の型安全な管理とコンパイル時検証
* **信頼性**: ネットワーク障害に対する耐性が必要
* **セキュリティ**: 中間者攻撃からの保護と動的証明書更新が必要
* **保守性**: テストしやすく、設定変更が容易な実装
* **パフォーマンス**: 効率的なリトライ機構と適切なタイムアウト設定
* **開発効率**: デバッグ時の可視性とログ出力

## Considered Options

* **Option 1**: 標準のDioを直接使用し、各機能を個別に実装
* **Option 2**: BaseDioWrapperクラスでDioをラップし、設定を一元化
* **Option 3**: 外部のHTTPクライアントライブラリ（http、chopper等）を使用
* **Option 4**: ポータルごとに独立したHTTPクライアントを実装

## Decision Outcome

Chosen option: "BaseDioWrapperクラスでDioをラップし、Portal枠組みと環境設定を統合した設計"

### Positive Consequences

* **統一された設定**: 全てのHTTP通信で一貫した設定とインターセプターが適用される
* **ポータル特化**: 各ポータルに最適化された設定を個別に提供
* **型安全な環境設定**: `envied`によるコンパイル時環境変数管理
* **動的証明書管理**: Firebase Remote Configによる証明書ピンの動的更新
* **テストの容易性**: モック化とテストが簡単になる
* **保守性**: 設定変更が一箇所で済む
* **再利用性**: 複数の機能で同じHTTPクライアント設定を共有できる
* **開発効率**: デバッグ時のログが統一され、問題の特定が容易

### Negative Consequences

* **抽象化のオーバーヘッド**: 直接Dioを使用する場合と比べて若干の学習コストが発生
* **依存関係の複雑さ**: 複数のインターセプターによる実行順序への配慮が必要
* **環境設定の複雑さ**: 複数のポータル設定管理が必要

## Pros and Cons of the Options

### BaseDioWrapperクラスでDioをラップし、Portal枠組みと環境設定を統合

**実装内容:**

```dart
// Portal enum for multiple university portals
enum Portal {
  manabo, // Course management  
  albo,   // Assignment and grade management
  sso,    // Single sign-on
}

// Environment configuration with envied
class Environment {
  factory Environment.forPortal(Portal portal) {
    final baseUrl = switch (portal) {
      Portal.manabo => EnvConfig.manaboBaseUrl,
      Portal.albo => EnvConfig.alboBaseUrl,
      Portal.sso => EnvConfig.ssoBaseUrl,
    };
    // ...additional configuration
  }
}

// Updated BaseDioWrapper
class BaseDioWrapper {
  BaseDioWrapper({
    required String baseUrl,
    Duration timeout = const Duration(seconds: 20),
    int maxRetry = 3,
    bool enablePinning = true,
  });
}

// Riverpod providers for each portal
final dioProvider = Provider.family<Dio, Portal>((ref, portal) {
  final wrapper = ref.watch(dioWrapperProvider(portal));
  return wrapper.dio;
});
```

* Good, because 各ポータルに最適化された設定が自動的に適用される
* Good, because 型安全な環境変数管理により設定ミスが防止される
* Good, because リトライロジックが自動化され、指数バックオフ+ジッターが適用される
* Good, because Firebase Remote Configによる動的証明書更新が可能
* Good, because TLS証明書ピニングによりセキュリティが向上する
* Good, because Riverpodによる依存性注入でテストが容易になる
* Good, because デバッグログが統一され、開発効率が向上する
* Bad, because Dioへの直接アクセスに比べて抽象化レイヤーが増加する
* Bad, because 複数ポータル設定により複雑さが増加する

### 標準のDioを直接使用し、各機能を個別に実装

* Good, because 学習コストが低く、Dioの標準機能をそのまま利用できる
* Good, because 軽量で最小限の実装になる
* Bad, because 各ポータルごとに個別設定を管理する必要がある
* Bad, because 各箇所でリトライロジックやログ設定を個別に実装する必要がある
* Bad, because 設定の一貫性を保つのが困難
* Bad, because テスト時のモック設定が複雑になる

### 外部のHTTPクライアントライブラリを使用

* Good, because 特定のライブラリに最適化された機能を利用できる
* Bad, because Flutterエコシステムにおいて、Dio以外の選択肢は機能が限定的
* Bad, because 既存のDio関連プラグインとの互換性が失われる
* Bad, because チーム内でのDioに関する知識が活用できない

### ポータルごとに独立したHTTPクライアントを実装

* Good, because 各ポータルに完全に特化した実装が可能
* Bad, because コードの重複が大量に発生する
* Bad, because 共通機能（リトライ、ログ等）の保守が困難
* Bad, because テスト戦略が複雑化する

## 実装詳細

### Portal Enum

```dart
enum Portal {
  manabo, // MaNaBo - 東海大学授業支援システム
  albo,   // ALBO - 学生ポータル
  sso,    // SSO - シングルサインオン
}
```

各ポータルに対応する拡張機能:

* `displayName`: UIに表示するポータル名
* `identifier`: 内部識別子

### Environment Configuration

`envied` パッケージを使用したコンパイル時環境変数管理:

```dart
@Envied(path: '.env')
abstract class EnvConfig {
  @EnviedField(varName: 'BASE_URL_MANABO')
  static const String manaboBaseUrl = _EnvConfig.manaboBaseUrl;
  
  @EnviedField(varName: 'BASE_URL_ALBO') 
  static const String alboBaseUrl = _EnvConfig.alboBaseUrl;
  
  @EnviedField(varName: 'SSO_BASE_URL')
  static const String ssoBaseUrl = _EnvConfig.ssoBaseUrl;
  
  // 証明書ピン設定
  @EnviedField(varName: 'CERT_PIN_MAIN')
  static const String certPinMain = _EnvConfig.certPinMain;
  
  @EnviedField(varName: 'CERT_PIN_BACKUP')
  static const String certPinBackup = _EnvConfig.certPinBackup;
}
```

### RetryInterceptor

以下の条件でのみリトライを実行：

* HTTP 503 (Service Unavailable) レスポンス
* HTTP 429 (Too Many Requests) レスポンス
* `SocketException` (ネットワーク接続エラー)
* 接続タイムアウトエラー

指数バックオフ + ジッター: 1秒 → 2秒 → 4秒 → 8秒 → 16秒 (最大5回)

### Certificate Pinning with Remote Config

**段階的証明書管理:**

1. **Firebase Remote Config**: 動的証明書ピン取得

   ```dart
   Future<List<String>> _getRemoteConfigPins(String host) async {
     final remoteConfig = FirebaseRemoteConfig.instance;
     final configKey = '${host.replaceAll('.', '_')}_cert_pins';
     final pinsJson = remoteConfig.getString(configKey);
     return json.decode(pinsJson);
   }
   ```

2. **Local Fallback**: 環境変数からの証明書ピン取得

   ```dart
   List<String> _getLocalPins(String host) {
     return [
       if (EnvConfig.certPinMain.isNotEmpty) EnvConfig.certPinMain,
       if (EnvConfig.certPinBackup.isNotEmpty) EnvConfig.certPinBackup,
     ];
   }
   ```

3. **Development Mode**: デバッグビルドでのピニング無効化

**証明書更新戦略:**

* アプリ起動時にRemote Configから新しい証明書を取得
* 次回起動時に適用（アプリがブリックされることを防ぐ）
* 2つの証明書ピン（アクティブ + バックアップ）を常に保持

### Cookie Management

* `dio_cookie_manager` と `cookie_jar` を使用
* `path_provider` によりアプリケーションドキュメントディレクトリにクッキーを永続化
* `flutter_secure_storage` を使用したクッキーの暗号化（セキュリティ強化）

### Riverpod Integration

```dart
// Portal別のDioプロバイダー
final dioProvider = Provider.family<Dio, Portal>((ref, portal) {
  final wrapper = ref.watch(dioWrapperProvider(portal));
  return wrapper.dio;
});

// 環境設定プロバイダー
final envProvider = Provider.family<Environment, Portal>((ref, portal) {
  return Environment.forPortal(portal);
});

// 使用例
class CourseRepository {
  Future<List<Course>> getCourses(WidgetRef ref) async {
    final dio = ref.read(dioProvider(Portal.manabo));
    final response = await dio.get('/api/courses');
    return parseCoursesFromResponse(response.data);
  }
}
```

## Testing Strategy

* `fake_async` を使用したリトライロジックのタイミング検証
* `MockAdapter` によるHTTPレスポンスのモック化
* 指数バックオフ + ジッターの正確な実装検証
* 証明書ピニングの有効/無効切り替え検証
* Portal別設定の独立性検証
* 環境変数の型安全性検証

### テスト例

```dart
test('should retry on 503 with exponential backoff and jitter', () async {
  // Given
  final mockAdapter = DioAdapter();
  final wrapper = BaseDioWrapper(baseUrl: 'https://test.com');
  wrapper.dio.httpClientAdapter = mockAdapter;
  
  // When: 503エラーを2回返してから成功
  mockAdapter
    ..onGet('/test', (server) => server.throws(503, DioException(...)))
    ..onGet('/test', (server) => server.throws(503, DioException(...)))
    ..onGet('/test', (server) => server.reply(200, {'success': true}));
  
  // Then: 指数バックオフでリトライされ、最終的に成功する
  final response = await wrapper.dio.get('/test');
  expect(response.statusCode, equals(200));
});

test('should use different base URLs for different portals', () {
  // Given
  final container = ProviderContainer();
  
  // When & Then: 各ポータルで異なるbaseURLが使用される
  final manboDio = container.read(dioProvider(Portal.manabo));
  final alboDio = container.read(dioProvider(Portal.albo));
  
  expect(manboDio.options.baseUrl, contains('manabo'));
  expect(alboDio.options.baseUrl, contains('albo'));
});
```

## Environment Variables Configuration

### .envファイル構成

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

### ビルド時のコード生成

```bash
flutter packages pub run build_runner build
```

により `env_config.g.dart` が生成され、型安全な環境変数アクセスが可能になる。

## Migration Strategy

既存コードからの移行手順:

1. **Phase 1**: 既存の`dioProvider`を`defaultDioProvider`に置き換え
2. **Phase 2**: ポータル特化機能から順次`dioProvider(Portal.xxx)`に移行
3. **Phase 3**: 環境設定の.envファイル化とビルドプロセス更新
4. **Phase 4**: 証明書ピニングのRemote Config統合

## Monitoring and Observability

* **ログ**: リトライ実行、証明書ピニングエラー、環境設定読み込みエラー
* **メトリクス**: ポータル別レスポンス時間、リトライ率、証明書ピニング成功率
* **アラート**: 証明書ピニング失敗、環境設定読み込み失敗

## Links

* [Network Layer Instructions](../../.github/instructions/network.instructions.md)
* [General Architecture Guidelines](../../.github/instructions/general.instructions.md)

<!-- markdownlint-disable-file MD013 -->
