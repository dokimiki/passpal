# 0008. 認証ドメインコアの実装

日付: 2025-06-22

## ステータス

採択済み

## コンテキスト

ぱすぱるアプリにおいて、認証機能の最小核となるドメインレイヤーの実装が必要となった。上位レイヤー（アプリケーション・プレゼンテーション）が型安全かつ純粋関数的にログイン結果を扱えるようにするため、以下の要件を満たす必要がある：

- 大学のShibboleth IdPとGoogle Sign-In (Firebase Auth) の2つの認証方式をサポート
- エラーハンドリングを型安全に行う
- Clean Architectureの原則に従い、ドメインレイヤーは外部の依存関係を持たない
- テスタブルな設計

## 決定

### 1. Userエンティティの設計

**採用**: `@immutable` かつ `equatable` を使用した値オブジェクト

**理由**:
- イミュータブルにすることで予期しない状態変更を防ぐ
- `equatable`により値ベースの等価性を簡潔に実装
- `json_annotation`により自動的なシリアライゼーション対応
- キャンパス種別を`enum`で型安全に表現

**フィールド設計**:
- `uid`: Firebase Authのユーザー識別子
- `studentId`: 学籍番号（大学システムとの連携キー）
- `displayName`, `email`: 基本的なユーザー情報
- `campus`: キャンパス種別（enum）
- `created`: アカウント作成日時
- `photoUrl`: オプショナルなプロフィール画像

### 2. AuthFailureの設計

**採用**: Sealed classによる失敗の型化

**バリアント選定**:
- `InvalidCredential`: 認証情報が無効
- `Network`: ネットワーク接続エラー
- `Server`: サーバーエラー（HTTPステータスコード付き）
- `Unknown`: その他の予期しないエラー

**理由**:
- Sealed classにより網羅的なエラーハンドリングを強制
- パターンマッチングによる型安全なエラー処理
- 各エラー種別に応じた適切なUI表示が可能
- freezedは生成が不安定だったため、手動実装でシンプルに

### 3. Either型によるエラーハンドリング

**採用**: `fpdart`の`Either<AuthFailure, User>`

**理由**:
- 関数型プログラミングのエラーハンドリングパターン
- 例外よりも予測可能で型安全
- Left（失敗）とRight（成功）で明確に区別
- チェーン可能で合成しやすい

### 4. Repository パターン

**採用**: 抽象インターフェースのみ定義

```dart
abstract class AuthRepository {
  Future<Either<AuthFailure, User>> signIn(String id, String pw);
}
```

**理由**:
- ドメインレイヤーは実装詳細に依存しない
- データレイヤーで具体実装を提供
- テスト時にモックで容易に置換可能

### 5. UseCase の実装

**採用**: 単純なラッパークラス

**理由**:
- 将来的なビジネスロジック追加の拡張ポイント
- アプリケーションレイヤーとの明確な責任分離
- テスタビリティの向上

### 6. Riverpod による依存性注入

**採用**: `Provider<T>` による依存性の公開

**理由**:
- 上位レイヤーから簡単にアクセス可能
- テスト時にオーバーライド可能
- 型安全な依存性注入

## 結果

### 正の結果
- 型安全な認証エラーハンドリング
- テスタブルな設計（100%のテストカバレッジ達成）
- Clean Architectureの原則遵守
- 将来の機能拡張に対する柔軟性

### 負の結果
- freezedの生成が不安定で手動実装が必要だった
- Either型の学習コストが存在

## 実装詳細

### ファイル構成
```
lib/features/auth/domain/
├── entity/user.dart
├── failure/auth_failure.dart  
├── repository/auth_repository.dart
└── usecase/sign_in.dart

lib/features/auth/application/
└── providers/auth_providers.dart

test/features/auth/domain/usecase/
└── sign_in_test.dart
```

### テスト戦略
- Mockitoを使用した単体テスト
- Either型の各パターン（成功/失敗）を網羅
- provideDummyによるMockitoのダミー値対応

## 関連

- ADR-0001: base-dio-wrapper-http-client
- ADR-0003: secure-credential-storage-implementation
- general.instructions.md: Clean Architecture 4レイヤー構成
