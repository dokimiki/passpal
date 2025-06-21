# AuthApiクラスによるSAML認証の統一実装

* Status: accepted
* Deciders: 開発チーム
* Date: 2025-06-22
* Template used: [MADR 3.0.0](https://adr.github.io/madr/)

Technical Story: ALBO、MaNaBo、Cubicsポータルの認証処理を統一し、保守性と拡張性を向上させる

## Context and Problem Statement

これまでALBOとMaNaBoの認証処理は個別の関数として実装されており、コードの重複と保守の困難さが問題となっていた。各ポータルは共通のShibboleth SSOシステムを使用しているため、認証フローの大部分は共通化できるはずである。また、新たにCubicsポータルの対応も必要となった。

## Decision Drivers

* コードの重複排除と保守性の向上
* 新しいポータル（Cubics）への対応
* 統一されたエラーハンドリング
* テスタビリティの向上
* Clean Architectureの原則に従った実装

## Considered Options

* Option 1: 既存の個別関数をそのまま使用し、Cubics用の新しい関数を追加
* Option 2: AuthApiクラスを作成し、すべてのポータルの認証を統一
* Option 3: ポータルごとに別々のApiクラスを作成

## Decision Outcome

Chosen option: "Option 2: AuthApiクラスを作成し、すべてのポータルの認証を統一", because

* コードの重複を最大限排除できる
* 共通のSAMLフローを再利用できる
* 統一されたエラーハンドリングが可能
* 新しいポータルの追加が容易
* テストが書きやすい

### Positive Consequences

* コードの重複が大幅に削減される
* 統一されたエラーハンドリングにより、上位層での処理が簡潔になる
* 新しいポータルの追加時の実装コストが削減される
* テストカバレッジが向上する
* Clean Architectureの原則に従った設計

### Negative Consequences

* 既存のコードからの移行コストが発生する
* 初期実装の複雑さが若干増加する

## Pros and Cons of the Options

### Option 1: 既存の個別関数をそのまま使用

* Good, because 既存コードへの影響が最小限
* Bad, because コードの重複が続く
* Bad, because 保守コストが高い
* Bad, because 新しいポータル追加時の実装コストが高い

### Option 2: AuthApiクラスによる統一実装

* Good, because コードの重複が排除される
* Good, because 統一されたエラーハンドリング
* Good, because テスタビリティが向上
* Good, because 新しいポータルの追加が容易
* Bad, because 初期実装の複雑さが若干増加

### Option 3: ポータルごとに別々のApiクラス

* Good, because ポータル固有の処理に特化できる
* Bad, because 共通処理の重複が発生
* Bad, because 保守コストが高い

## Implementation Details

### AuthApiクラスの設計

```dart
class AuthApi {
  const AuthApi(this._dio);
  
  Future<List<Cookie>> login({
    required Portal portal,
    required String id,
    required String pw,
  });
  
  Future<void> refresh();
}
```

### 共通化されたSAMLフロー

1. **SAMLRequest取得**: ポータルのエントリポイントにアクセス
2. **AuthState取得**: SSOサーバーからログインフォームの状態を取得
3. **認証実行**: ユーザーIDとパスワードで認証
4. **SAMLResponse送信**: 認証結果をポータルに送信
5. **Cookie抽出**: ポータル固有のセッションCookieを取得

### エラーハンドリング戦略

sealed classを使用したAuthFailureにより、以下のエラータイプを定義：

* `NetworkError`: ネットワーク接続エラー
* `ServiceUnavailable`: サービス利用不可（503エラー）
* `InvalidCredentials`: 無効な認証情報
* `SamlRequestFailed`: SAMLリクエスト失敗
* `CookieExtractionFailed`: Cookie取得失敗
* `SessionRefreshFailed`: セッション更新失敗
* `UnexpectedError`: 予期しないエラー

### ポータル固有の差異対応

各ポータルの違いは`_PortalUrls`クラスで管理：

* **ALBO/Cubics**: JSESSIONID + _shibsessionクッキー
* **MaNaBo**: GlexaSESSID + _shibsessionクッキー
* **エンドポイントURL**: EnvConfigから取得

### セッション更新戦略

現在は簡易的な実装（ルートパスへのGETリクエスト）だが、将来的により具体的なセッション更新エンドポイントに対応できる設計となっている。

## Follow-up Actions

1. 既存のMaNaBo、ALBO認証コードをAuthApiに移行
2. Riverpodプロバイダの設定
3. 統合テストの実装
4. ドキュメントの更新
