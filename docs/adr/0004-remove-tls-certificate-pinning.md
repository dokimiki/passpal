# TLS証明書ピニングの廃止

* Status: accepted
* Deciders: Development Team
* Date: 2025-06-22
* Template used: [MADR 3.0.0](https://adr.github.io/madr/)

Technical Story: TLS証明書ピニング機能の廃止とDioデフォルトSSL検証への移行

## Context and Problem Statement

ぱすぱるアプリでは、セキュリティ強化のためにTLS証明書ピニング機能を実装していました。しかし、実際の運用において以下の問題が発生しています：

* **運用の複雑性**: 証明書の更新時にアプリケーションの更新が必要
* **複数サイト対応の困難さ**: 各大学ポータル（MaNaBo、ALBO、SSO）ごとに異なる証明書管理が必要
* **デバッグの困難さ**: 開発時にピニングエラーが頻発し、開発効率が低下
* **Firebase Remote Configの依存**: 動的証明書更新のための複雑なインフラが必要
* **証明書ローテーション**: 証明書の期限切れやローテーション時の対応が困難

一方、DioのデフォルトSSL検証は十分に堅牢であり、一般的なWebアプリケーションにおいて適切なセキュリティレベルを提供します。

## Decision Drivers

* **運用の簡素化**: 証明書管理の複雑さを排除
* **開発効率の向上**: デバッグ時の障害要因を除去
* **保守性の向上**: 複雑なピニング機構の保守コストを削減
* **十分なセキュリティ**: DioのデフォルトSSL検証で十分なセキュリティレベルを確保
* **複数サイト対応**: 各ポータルに対する統一的なアプローチ

## Considered Options

* **Option 1**: 現在のTLS証明書ピニングを継続し、運用を改善
* **Option 2**: TLS証明書ピニングを廃止し、DioのデフォルトSSL検証を使用
* **Option 3**: 選択的ピニング（重要なエンドポイントのみピニング）を実装
* **Option 4**: 証明書ピニング機能を保持しつつ、デフォルトで無効化

## Decision Outcome

Chosen option: "TLS証明書ピニングを廃止し、DioのデフォルトSSL検証を使用"

### Positive Consequences

* **運用の簡素化**: 証明書管理に関する複雑な作業が不要
* **開発効率の向上**: デバッグ時のピニングエラーがなくなり、開発がスムーズに
* **保守性の向上**: 複雑なピニング関連コードの保守が不要
* **複数サイト対応の容易さ**: 各ポータルに対する統一的なアプローチが可能
* **依存関係の削減**: Firebase Remote Configへの依存が減少
* **セキュリティの十分性**: DioのデフォルトSSL検証は業界標準として十分

### Negative Consequences

* **セキュリティレベルの変更**: 証明書ピニングによる追加のセキュリティ層が失われる
* **中間者攻撃への脆弱性**: 理論的には中間者攻撃のリスクが若干増加
* **コンプライアンス要件**: 一部の高セキュリティ要件において証明書ピニングが必要な場合がある

## Pros and Cons of the Options

### TLS証明書ピニングを廃止し、DioのデフォルトSSL検証を使用

**実装変更内容:**

```dart
// 変更前
class BaseDioWrapper {
  final bool enablePinning;
  
  BaseDioWrapper({
    required this.baseUrl,
    this.enablePinning = true,
  });
}

// 変更後
class BaseDioWrapper {
  BaseDioWrapper({
    required this.baseUrl,
  });
}
```

* ✅ Good, because 運用の複雑さが大幅に削減される
* ✅ Good, because 開発効率が向上する
* ✅ Good, because 複数サイト対応が容易になる
* ✅ Good, because 保守コストが削減される
* ✅ Good, because DioのデフォルトSSL検証は十分に堅牢
* ✅ Good, because 依存関係が簡素化される
* ❌ Bad, because 証明書ピニングによる追加セキュリティ層が失われる
* ❌ Bad, because 理論的には中間者攻撃のリスクが若干増加

### 現在のTLS証明書ピニングを継続

* ✅ Good, because 最高レベルのセキュリティを維持できる
* ✅ Good, because 中間者攻撃への強固な防御が可能
* ❌ Bad, because 運用の複雑さが継続する
* ❌ Bad, because 開発効率が低下する
* ❌ Bad, because 複数サイト対応が困難
* ❌ Bad, because 保守コストが高い

### 選択的ピニング（重要なエンドポイントのみ）

* ✅ Good, because 重要なエンドポイントのセキュリティを維持
* ✅ Good, because 部分的に運用の複雑さを削減
* ❌ Bad, because 実装の複雑さが増加
* ❌ Bad, because どのエンドポイントが重要かの判断が困難
* ❌ Bad, because 部分的にピニング関連の問題が残存

### 証明書ピニング機能を保持しつつデフォルトで無効化

* ✅ Good, because 将来的にピニングが必要になった場合に対応可能
* ✅ Good, because 現在の問題を解決
* ❌ Bad, because 使用されないコードが残存し、保守負荷が発生
* ❌ Bad, because 実装の複雑さが維持される

## Implementation Details

### 削除されるコンポーネント

1. **CertificatePinningInterceptor**: TLS証明書ピニングを実行するインターセプター
2. **enablePinning**: 証明書ピニングの有効/無効を制御するフラグ
3. **certificatePins**: 証明書ピンのリスト
4. **Firebase Remote Config**: 動的証明書更新のためのRemote Config連携
5. **環境変数**: `CERT_PIN_MAIN`, `CERT_PIN_BACKUP`, `ENABLE_PINNING`

### 変更されるファイル

```text
lib/core/network/
├── base_dio_wrapper.dart           # ピニング関連コードの削除
├── environment.dart                # ピニング関連プロパティの削除
├── env_config.dart                 # ピニング関連環境変数の削除
└── network_provider.dart           # ピニング関連パラメータの削除

test/core/network/
└── base_dio_wrapper_test.dart      # ピニング関連テストの削除

pubspec.yaml                        # http_certificate_pinning依存関係の削除
.env.example                        # ピニング関連環境変数の削除
README.md                           # ピニング関連記述の削除
```

### セキュリティ代替措置

1. **DioのデフォルトSSL検証**:
   * 有効な証明書チェーンの検証
   * ホスト名の検証
   * 証明書の有効期限確認

2. **HTTPS強制**:
   * 全てのHTTP通信をHTTPSに限定
   * HTTP通信は自動的に拒否

3. **ネットワークセキュリティ設定**:
   * Android: Network Security Config
   * iOS: App Transport Security (ATS)

## Testing Strategy

### 削除されるテスト

```dart
// 削除されるテストケース
group('Certificate Pinning', () {
  test('should be disabled when enablePinning is false', () { ... });
  test('should be enabled when enablePinning is true', () { ... });
});
```

### 新しいテスト

```dart
// 追加されるテストケース
group('SSL Verification', () {
  test('should use default Dio SSL verification', () {
    // DioのデフォルトSSL検証が有効であることを確認
    expect(wrapper.dio.options.receiveTimeout, isNotNull);
    expect(wrapper.dio.httpClientAdapter, isA<DefaultHttpClientAdapter>());
  });
  
  test('should reject invalid certificates', () async {
    // 無効な証明書を持つサーバーへの接続が拒否されることを確認
    // （統合テストでのみ実行）
  });
});
```

## Migration Strategy

### Phase 1: コード削除（即座実行）

1. `_CertificatePinningInterceptor`クラスの削除
2. `enablePinning`パラメータの削除
3. `certificatePins`関連プロパティの削除
4. 関連するテストコードの削除

### Phase 2: 依存関係クリーンアップ

1. `pubspec.yaml`から`http_certificate_pinning`の削除
2. `firebase_remote_config`の証明書関連用途を削除
3. 環境変数設定の更新

### Phase 3: ドキュメント更新

1. ADRドキュメントの更新
2. README.mdの更新
3. 開発者向けドキュメントの更新

### Phase 4: テストと検証

1. 全てのHTTPS通信が正常に動作することを確認
2. 無効な証明書を持つサーバーへの接続が適切に拒否されることを確認
3. セキュリティ検証の実施

## Security Considerations

### 残存するセキュリティ機能

1. **Transport Layer Security (TLS 1.2+)**:
   * 通信内容の暗号化
   * 認証局による証明書検証
   * 完全前方秘匿

2. **Application Layer Security**:
   * セッションベースの認証
   * 適切なCookie管理
   * セキュアストレージの使用

3. **Network Policy**:
   * HTTPS通信の強制
   * 適切なタイムアウト設定
   * リトライ機構の実装

### セキュリティ監視

1. **通信エラーの監視**: SSL/TLS関連エラーのログ収集
2. **異常な通信パターンの検出**: 予期しない通信先への接続検出
3. **セキュリティアップデート**: Dioおよび関連ライブラリの定期的な更新

## Links

* [ADR-0001: Base Dio Wrapper HTTP Client](./0001-base-dio-wrapper-http-client.md)
* [ADR-0002: Environment Configuration Management](./0002-environment-configuration-management.md)
* [Network Layer Instructions](../../.github/instructions/network.instructions.md)
* [Dio Package Documentation](https://pub.dev/packages/dio)

<!-- markdownlint-disable-file MD013 -->
