# セキュアクレデンシャルストレージの実装と管理戦略

* Status: accepted
* Deciders: Development Team
* Date: 2025-06-22
* Template used: [MADR 3.0.0](https://adr.github.io/madr/)

Technical Story: ユーザー認証情報の安全な保存とアクセス管理の実装

## Context and Problem Statement

ぱすぱるアプリでは、大学ポータル（MaNaBo、ALBO）へのログイン認証情報（ユーザーID、パスワード）を安全に保存・管理する必要がある。ユーザーの利便性を高めるため認証情報を保存する一方で、セキュリティリスクを最小化し、プラットフォーム固有の暗号化機能を活用する必要がある。

主な課題：

* **セキュリティ**: 認証情報の平文保存は重大なセキュリティリスク
* **プラットフォーム対応**: iOS（Keychain）とAndroid（EncryptedSharedPreferences）の違い
* **テスタビリティ**: セキュリティを保ちつつテスト可能な設計
* **使いやすさ**: 開発者が安全に使用できるシンプルなAPI

## Decision Drivers

* **セキュリティ第一**: ハードウェアベースの暗号化を活用
* **プラットフォーム最適化**: 各OSの標準セキュリティメカニズムを使用
* **Clean Architecture**: 依存関係の逆転とテスタビリティ
* **開発効率**: シンプルで直感的なAPI設計
* **保守性**: 明確な責任分離とドキュメント化

## Considered Options

* **Option 1**: `flutter_secure_storage`をラップしたCredentialStoreクラス
* **Option 2**: カスタムAES-256暗号化 + SharedPreferences
* **Option 3**: SQLiteベースの暗号化データベース（SQLCipher）
* **Option 4**: 外部キー管理サービス（AWS KMS、Azure Key Vault）

## Decision Outcome

Chosen option: "**Option 1: flutter_secure_storage wrapper**", because:

1. **プラットフォーム最適化**: 各OS固有の最適なセキュリティメカニズムを自動選択
2. **実装の簡素化**: 暗号化の複雑さを隠蔽し、開発効率を向上
3. **テスタビリティ**: 依存注入によるモック化が容易
4. **メンテナンス**: よくテストされたライブラリで安定性が高い

### Positive Consequences

* **セキュリティ向上**: iOS Keychain、Android EncryptedSharedPreferencesによるハードウェア暗号化
* **開発効率**: シンプルなwrite/read/delete APIで学習コストが低い
* **テスト容易性**: Mockitoによる完全なユニットテスト実装
* **Clean Architecture準拠**: Riverpod依存注入で疎結合設計
* **クロスプラットフォーム**: iOSとAndroidで統一されたAPI

### Negative Consequences

* **外部依存**: flutter_secure_storageライブラリへの依存
* **プラットフォーム制約**: 各OSのセキュリティ制約に依存
* **デバッグ困難性**: 暗号化により実行時のデバッグが困難

## Pros and Cons of the Options

### Option 1: flutter_secure_storage wrapper

* Good, because プラットフォーム固有の最適化が自動的に適用される
* Good, because 豊富なコミュニティサポートと実績がある
* Good, because Clean Architectureに適合する設計が可能
* Good, because テストフレンドリーな実装ができる
* Bad, because 外部ライブラリへの依存が発生する
* Bad, because 暗号化アルゴリズムの詳細制御ができない

### Option 2: カスタムAES-256暗号化

* Good, because 暗号化アルゴリズムの完全制御が可能
* Good, because 外部依存の最小化
* Bad, because 暗号化実装の複雑性と脆弱性リスク
* Bad, because プラットフォーム最適化が困難
* Bad, because キー管理の複雑性

### Option 3: SQLCipher

* Good, because データベースレベルでの暗号化
* Good, because 複雑なクエリに対応
* Bad, because 認証情報保存には過剰機能
* Bad, because パフォーマンスオーバーヘッド
* Bad, because ライセンス問題（商用利用）

### Option 4: 外部キー管理サービス

* Good, because エンタープライズレベルのセキュリティ
* Good, because キー管理の外部化
* Bad, because ネットワーク依存でオフライン使用不可
* Bad, because コスト増加
* Bad, because 複雑な設定と管理

## Implementation Details

### Core Components

```dart
// メインのクレデンシャルストアクラス
class CredentialStore {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete({String? key, bool all = false});
}

// Riverpod Provider
final credentialStoreProvider = Provider<CredentialStore>((ref) => ...);
```

### Security Configuration

* **iOS**: `KeychainAccessibility.first_unlock_this_device`
* **Android**: `encryptedSharedPreferences: true`
* **Key Management**: 自動キー生成・ローテーション

### Testing Strategy

* **Unit Tests**: MockFlutterSecureStorageによる完全テスト
* **Integration Tests**: ProviderContainerを使用したエンドツーエンドテスト
* **Error Handling**: PlatformException処理の検証

## Usage Patterns

### 基本的な使用方法

```dart
// 認証情報の保存
await credentialStore.write('auth_id', userId);
await credentialStore.write('auth_pw', password);

// 認証情報の読み取り
final userId = await credentialStore.read('auth_id');
final password = await credentialStore.read('auth_pw');

// 認証情報の削除
await credentialStore.delete(all: true);
```

### Riverpod統合

```dart
final credentialStore = ref.read(credentialStoreProvider);
```

## Security Considerations

### 保護される脅威

* **Device Compromise**: 端末の物理アクセスによる情報漏洩
* **App Reverse Engineering**: アプリのリバースエンジニアリング
* **Memory Dump**: メモリダンプによる情報抽出
* **Backup Extraction**: バックアップからの情報抽出

### 制限事項

* **Root/Jailbreak**: ルート化/ジェイルブレイク端末では保護レベルが低下
* **OS Vulnerabilities**: OS脆弱性による暗号化迂回の可能性
* **Side-channel Attacks**: サイドチャネル攻撃への対策は限定的

## Future Considerations

### 拡張性

* **Biometric Authentication**: 生体認証との統合可能性
* **Hardware Security Module**: HSM連携の検討
* **Key Rotation**: 定期的なキーローテーション機能

### 監査とコンプライアンス

* **Audit Logging**: アクセスログの記録（プライバシー配慮）
* **Compliance**: GDPR、個人情報保護法への対応
* **Penetration Testing**: 定期的なセキュリティテスト実施

## Migration Strategy

### 既存データの移行

1. **Detection**: 既存の平文保存データの検出
2. **Migration**: 安全な暗号化ストレージへの移行
3. **Cleanup**: 平文データの完全削除
4. **Verification**: 移行完了の検証

### Rollback Plan

* **Backward Compatibility**: 旧バージョンとの互換性保持
* **Data Recovery**: 移行失敗時のデータ復旧手順
* **User Communication**: ユーザーへの影響説明

## References

* [flutter_secure_storage Documentation](https://pub.dev/packages/flutter_secure_storage)
* [iOS Keychain Services Programming Guide](https://developer.apple.com/documentation/security/keychain_services)
* [Android EncryptedSharedPreferences](https://developer.android.com/reference/androidx/security/crypto/EncryptedSharedPreferences)
* [OWASP Mobile Security Testing Guide](https://owasp.org/www-project-mobile-security-testing-guide/)

## Change Log

* **2025-06-22**: 初回作成 - CredentialStore実装決定
* **Future**: セキュリティ監査結果に基づく更新予定
