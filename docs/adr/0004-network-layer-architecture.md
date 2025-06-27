# ADR-0001: ネットワーク層のアーキテクチャ設計

## ステータス

承認済み

## コンテキスト

PassPalアプリは複数の学内ポータル（ALBO、MaNaBo、Cubics）およびPalAPIと通信する必要がある。これらのシステムは異なる認証方法、エラーハンドリング、メンテナンス対応が必要であり、統一的なHTTPクライアント層が必要である。

### 要件

1. **複数エンドポイント対応**: ALBO、MaNaBo、Cubics（SSO Cookie認証）、PalAPI（Bearer Token認証）
2. **回復力**: 指数バックオフ再試行、メンテナンス検出、オフライン検出
3. **認証管理**: SSO Cookieとベアラートークンの自動付与・更新
4. **ログとデバッグ**: 本番環境では無効、開発時はcURLログ出力
5. **エラー正規化**: DioExceptionをドメイン例外に変換

## 決定

### アーキテクチャ概要

Interceptorチェーンパターンを採用し、以下の責務を分離：

```
Request → Connectivity → Auth → Retry → Maintenance → Logging → Server
Response ← Connectivity ← Auth ← Retry ← Maintenance ← Logging ← Server
```

### コンポーネント設計

#### 1. NetworkTarget Enum
- 各エンドポイントの設定（baseUrl、認証方式）を集約
- 型安全なターゲット指定

#### 2. Interceptor Chain
1. **ConnectivityInterceptor**: オフライン即座検出
2. **AuthInterceptor**: Cookie/Token自動付与・更新（後回し）
3. **RetryInterceptor**: 冪等リクエストの指数バックオフ再試行
4. **MaintenanceInterceptor**: 503+メンテナンスキーワード検出
5. **LoggingInterceptor**: デバッグモードでのcURLログ

#### 3. Error Mapping
- DioException → NetworkFailure/AuthenticationException/MaintenanceException
- ステータスコード別の適切な例外マッピング

#### 4. Riverpod Integration
- ターゲット別Dioインスタンスのファクトリーパターン
- 接続状態の監視

### Feature層での使用例

```dart
// Feature層のRepository実装例
class AssignmentRepository {
  AssignmentRepository(this._ref);
  
  final Ref _ref;
  
  Future<List<Assignment>> fetchAssignments() async {
    try {
      final client = _ref.read(networkClientProvider(NetworkTarget.albo));
      final response = await client.get('/assignments');
      return AssignmentDto.fromJsonList(response.data).map((dto) => dto.toDomain()).toList();
    } on DioException catch (e) {
      throw NetworkErrorMapper.mapDioException(e);
    }
  }
}
```

## 結果

### 利点

1. **関心の分離**: 各Interceptorが単一責務
2. **テスタビリティ**: モック可能な依存性注入
3. **再利用性**: ターゲット間での共通ロジック共有
4. **拡張性**: 新しいInterceptorやターゲットの追加が容易

### トレードオフ

1. **複雑性**: Interceptorチェーンの理解が必要
2. **パフォーマンス**: 各リクエストで複数Interceptor実行
3. **デバッグ**: Interceptor間の相互作用の追跡

## 補足

## 実装状況

### AuthInterceptor実装 (2025年6月27日)

AuthInterceptor実装完了。以下の機能を実装：

1. **認証ヘッダー自動付与**
   - SSO Cookie自動付与（ALBO、MaNaBo、Cubics）
   - Bearer Token自動付与（PalAPI）  
   - ターゲット別の認証方式切り替え

2. **401エラー時自動再認証**
   - 401エラー検知時、AuthFacade.refresh()を実行
   - リフレッシュ成功時、リクエスト再実行（1回のみ）
   - リフレッシュ失敗時、AuthenticationExceptionを伝播

3. **バックグラウンドリフレッシュ**
   - セッション期限5分前にバックグラウンドでリフレッシュ実行
   - UI処理をブロックしない非同期実行

4. **テスト実装**
   - ユニットテスト：認証ヘッダー付与とエラーハンドリング（5テスト）
   - ネットワーク層統合テスト：30テスト全て通過
   - 例外伝播シナリオの基本検証

#### Interceptorチェーン順序（実装済み）

```text
Request  → Connectivity → Auth → Retry → Maintenance → Logging → Server
Response ← Connectivity ← Auth ← Retry ← Maintenance ← Logging ← Server
```

#### 使用例

```dart
// Feature層のRepository実装例（更新版）
class AssignmentRepository {
  AssignmentRepository(this._ref);
  
  final Ref _ref;
  
  Future<List<Assignment>> fetchAssignments() async {
    try {
      // AuthInterceptorが自動的に認証ヘッダーを付与
      final client = _ref.read(networkClientProvider(NetworkTarget.albo));
      final response = await client.get('/assignments');
      
      return AssignmentDto.fromJsonList(response.data)
          .map((dto) => dto.toDomain())
          .toList();
    } on DioException catch (e) {
      // AuthenticationExceptionは自動的に伝播
      throw NetworkErrorMapper.mapDioException(e);
    }
  }
}
```

### 完了済み機能

- ✅ NetworkTarget設定とBaseURL管理
- ✅ Interceptorチェーン構築（全6種類）
- ✅ AuthInterceptor（認証ヘッダー自動付与・401リフレッシュ）
- ✅ ConnectivityInterceptor（オフライン検出）
- ✅ RetryInterceptor（指数バックオフリトライ）
- ✅ MaintenanceInterceptor（503メンテナンス検出）
- ✅ LoggingInterceptor（デバッグcURLログ）
- ✅ ErrorMapper（例外正規化）
- ✅ RiverpodProvider統合

### メンテナンス対応

503レスポンス + メンテナンスキーワード検出時：

- MaintenanceExceptionをthrow
- UI層でメンテナンス画面表示

### 例外伝播テスト

各Interceptorで意図的に例外を発生させ、core/errorのCrashlyticsモックに到達することを確認する統合テストを実装。

## 実装完了日

2025年6月26日（初回）  
2025年6月27日（AuthInterceptor組込み）
