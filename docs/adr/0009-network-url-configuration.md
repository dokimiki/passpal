# 0009. ネットワークURL設定をConfigに統合

日付: 2025-06-28

## 状況

PassPalのネットワーク層では、以下のポータルサイトやAPIエンドポイントにアクセスする必要がある：

1. **ALBO**: 学生ポータル (`https://albo.chukyonet.jp`)
2. **MaNaBo**: 授業支援システム (`https://manabo.chukyonet.jp`)
3. **Cubics**: 学務システム (`https://cubics.chukyonet.jp`)
4. **SSO**: シングルサインオン (`https://sso.chukyonet.jp`)
5. **PalAPI**: PassPal独自API (`https://api.chukyo-passpal.app/v1`)

従来は`NetworkTarget`enumに直接URLがハードコードされており、以下の問題があった：

- **環境ごとの設定変更が困難**: テスト環境やステージング環境で異なるURLを使いたい場合に対応できない
- **動的な設定変更が不可能**: Remote Configでエンドポイントを動的に変更できない
- **設定の一元管理ができない**: 他の設定（機能フラグなど）と統一された方法で管理されていない

## 決定

ネットワーク層のURLを`core/config`システムに統合し、`ApiConfig`で一元管理する。

### 変更内容

1. **ApiConfigの拡張**:
   ```dart
   @freezed
   abstract class ApiConfig with _$ApiConfig {
     const factory ApiConfig({
       required String palapiBaseUrl,   // 旧: baseUrl
       required String alboBaseUrl,     // 新規
       required String manaboBaseUrl,   // 新規
       required String cubicsBaseUrl,   // 新規
       required String ssoBaseUrl,      // 新規
     }) = _ApiConfig;
   }
   ```

2. **NetworkTargetの変更**:
   ```dart
   enum NetworkTarget {
     albo, manabo, cubics, sso, palapi;
     
     // 旧: String get baseUrl => 'https://...'
     // 新: String getBaseUrl(ApiConfig config) => config.alboBaseUrl
     String getBaseUrl(ApiConfig config) {
       return switch (this) {
         NetworkTarget.albo => config.alboBaseUrl,
         NetworkTarget.manabo => config.manaboBaseUrl,
         // ...
       };
     }
   }
   ```

3. **NetworkClientFactoryにApiConfig注入**:
   ```dart
   class NetworkClientFactory {
     NetworkClientFactory({
       required this.apiConfig,  // 新規追加
       // ...
     });
     
     Dio create(NetworkTarget target) {
       return Dio(BaseOptions(
         baseUrl: target.getBaseUrl(apiConfig),  // 設定から取得
         // ...
       ));
     }
   }
   ```

4. **環境変数対応**:
   - `PAL_API_BASE_URL`: PalAPI URL
   - `ALBO_BASE_URL`: ALBO URL
   - `MANABO_BASE_URL`: MaNaBo URL
   - `CUBICS_BASE_URL`: Cubics URL
   - `SSO_BASE_URL`: SSO URL

## Feature層での使用例

```dart
// 1. 通常の使用（自動的に設定が注入される）
@riverpod
class AssignmentRepository extends _$AssignmentRepository {
  @override
  Future<List<Assignment>> build() async {
    final client = ref.watch(networkClientProvider(NetworkTarget.albo));
    final response = await client.get('/assignments');
    return parseAssignments(response.data);
  }
}

// 2. テスト環境での設定上書き
void main() {
  testWidgets('should fetch assignments', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWith((ref) async => AppConfig(
            api: ApiConfig(
              alboBaseUrl: 'https://test-albo.example.com',
              // ... other URLs
            ),
            // ... other configs
          )),
        ],
        child: MyApp(),
      ),
    );
    
    // テスト実行
  });
}

// 3. 動的設定変更への対応
Consumer(
  builder: (context, ref, child) {
    return ref.watch(configStreamProvider).when(
      data: (config) {
        // 設定変更時に自動的にネットワーククライアントも更新される
        return AssignmentsList();
      },
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => ErrorWidget(err),
    );
  },
)
```

## 利点

1. **環境ごとの設定**: `.env`ファイルや環境変数でURLを動的に変更可能
2. **統一された設定管理**: 他の設定（機能フラグ、デバッグ設定）と同じ仕組みで管理
3. **Remote Config対応**: Firebase Remote Configでエンドポイントを動的に変更可能
4. **テスタビリティ**: テスト時に簡単にモックURLを注入可能
5. **型安全性**: 設定の変更がコンパイル時にチェックされる

## 欠点

1. **複雑性の増加**: 単純なハードコードから設定注入に変わり、理解が必要
2. **初期化順序の依存**: 設定が読み込まれる前にネットワーククライアントを作成できない
3. **パフォーマンス**: 設定の読み込みが必要なため、わずかな初期化コストが発生

## 代替案

1. **A. 環境変数のみ使用**: Remote Configを使わず、ビルド時の環境変数のみで管理
   - 利点: シンプル
   - 欠点: 動的な変更ができない

2. **B. URLを静的に保持**: 現状維持で変更しない
   - 利点: 実装が簡単
   - 欠点: 環境ごとの設定ができない

3. **C. Flavorベースの設定**: Flutter Flavorで環境ごとのURLを管理
   - 利点: Flutterネイティブな方法
   - 欠点: ビルド時にしか変更できない

## 影響

### 影響を受けるファイル

- `lib/core/config/models/api_config.dart`: URL設定の追加
- `lib/core/config/repository/config_repository.dart`: URL読み込みロジック
- `lib/core/network/network_target.dart`: baseUrlからgetBaseUrl()に変更
- `lib/core/network/network_client_factory.dart`: ApiConfig注入
- `lib/core/network/providers.dart`: 設定プロバイダーとの統合
- `test/core/network/**`: テストの更新

### 後方互換性

この変更は破壊的変更となる：

- `NetworkTarget.baseUrl`が`NetworkTarget.getBaseUrl(config)`に変更
- `NetworkClientFactory()`の引数に`apiConfig`が必須追加

### 移行方法

1. 既存のコードで`target.baseUrl`を使用している箇所は`target.getBaseUrl(config)`に変更
2. `NetworkClientFactory`の作成時に`ApiConfig`を注入
3. テストコードで適切な`ApiConfig`を提供

## 実装状況

- [x] `ApiConfig`にURL設定を追加
- [x] `NetworkTarget.getBaseUrl()`メソッドの実装
- [x] `NetworkClientFactory`にApiConfig注入
- [x] `config_repository`でURL読み込み対応
- [x] `providers.dart`で設定プロバイダー統合
- [x] テストファイルの更新
- [x] 例外伝播シナリオのテスト（integration_test.dartで網羅）

## 関連

- [ADR-0008: Core設定管理アーキテクチャ](./0008-core-config-architecture.md)
- [ADR-0004: ネットワーク層アーキテクチャ](./0004-network-layer-architecture.md)
