# IsarServiceを使用したローカルデータベース実装

* Status: accepted
* Deciders: Development Team
* Date: 2025-06-22
* Template used: [MADR 3.0.0](https://adr.github.io/madr/)

Technical Story: ぱすぱるアプリにおけるローカルデータキャッシング、時間割データ管理、課題ログ管理のためのIsar NoSQLデータベース実装

## Context and Problem Statement

ぱすぱるアプリでは、大学ポータルから取得した時間割データや課題情報をローカルにキャッシュし、オフライン時でも利用可能にする必要がある。また、課題の追加・削除を追跡するログシステムも必要である。以下の要件を満たすローカルデータベース実装が求められる：

* **高速なデータアクセス**: 時間割表示時の即座なレスポンス
* **型安全性**: Dartの型システムを活用したエンティティ定義
* **インデックス最適化**: キャンパス・曜日・時限での効率的なクエリ
* **TTL管理**: データの有効期限管理と自動削除
* **テストしやすさ**: 単体テストとインテグレーションテストが可能
* **Riverpod統合**: 依存性注入とステート管理の統合
* **データ整合性**: トランザクション処理とエラーハンドリング

## Decision Drivers

* **パフォーマンス**: 時間割表示は100ms以内のレスポンスが必要
* **開発効率**: Flutter/Dartエコシステムとの親和性
* **型安全性**: コンパイル時のエラー検出とIDEサポート
* **将来性**: データスキーマの変更に対する対応力
* **テスタビリティ**: CI/CDパイプラインでのテスト実行
* **メモリ使用量**: モバイルデバイスでの効率的なメモリ使用

## Considered Options

* **Option 1**: Isar NoSQLデータベース + シングルトンサービス
* **Option 2**: Drift (SQLite) + Repository パターン
* **Option 3**: Hive + Box管理システム
* **Option 4**: Firebase Firestore オフラインモード

## Decision Outcome

Chosen option: "**Option 1: Isar NoSQLデータベース + シングルトンサービス**", because Isarは最高のパフォーマンスを提供し、Dartのコード生成により型安全性を保証し、複雑なインデックス機能を持ち、Flutterコミュニティで広く採用されているため。

### Positive Consequences

* **高速なクエリ性能**: Isarのネイティブ実装により、SQLiteより高速
* **コード生成による型安全性**: スキーマ変更時のコンパイルエラー検出
* **インデックス最適化**: 複合インデックスによる効率的なクエリ
* **シンプルなAPI**: 直感的なクエリ構文とトランザクション管理
* **テストサポート**: メモリ内データベースによる高速テスト
* **プラットフォーム対応**: iOS/Android/Windows/macOS対応

### Negative Consequences

* **学習コスト**: SQLに慣れた開発者にとってのNoSQL学習コスト
* **デバッグツール**: SQLiteと比較してデバッグツールが限定的
* **データ移行**: 既存SQLiteデータベースからの移行が必要な場合の複雑さ

## Pros and Cons of the Options

### Option 1: Isar NoSQLデータベース + シングルトンサービス

Isarは、Dartで書かれた高速NoSQLデータベースで、Flutter向けに最適化されている。

* Good, because 最高レベルのパフォーマンス（ベンチマークでSQLiteの2-3倍高速）
* Good, because コード生成による完全な型安全性
* Good, because 複合インデックスによる高速クエリ
* Good, because Dartネイティブ（FFI）実装によるゼロコピーアクセス
* Good, because シンプルで直感的なAPI設計
* Good, because トランザクションサポートと自動スキーママイグレーション
* Good, because テスト用のメモリ内データベース
* Bad, because SQLに慣れた開発者の学習コスト
* Bad, because コミュニティがSQLiteより小さい

### Option 2: Drift (SQLite) + Repository パターン

SQLiteベースのタイプセーフなORMライブラリ。

* Good, because SQL標準に準拠した成熟したデータベース
* Good, because 豊富なデバッグツールとエコシステム
* Good, because 複雑なリレーショナルクエリのサポート
* Good, because 既存SQLite知識の活用
* Bad, because パフォーマンスがIsarより劣る
* Bad, because 設定が複雑（.moor ファイル、build_runner）
* Bad, because モバイルでのメモリ使用量が大きい

### Option 3: Hive + Box管理システム

軽量なkey-valueデータベース。

* Good, because 非常にシンプルなAPI
* Good, because 高速な起動時間
* Good, because 暗号化サポート
* Bad, because クエリ機能が限定的（インデックスなし）
* Bad, because 複雑なデータ構造には不向き
* Bad, because 型安全性のサポートが限定的

### Option 4: Firebase Firestore オフラインモード

Firebase Firestoreのオフライン機能を使用。

* Good, because リアルタイム同期機能
* Good, because サーバーレスアーキテクチャ
* Good, because 自動バックアップ・復元
* Bad, because ネットワーク依存が強い
* Bad, because コスト（読み書き料金）
* Bad, because 複雑なオンライン・オフライン状態管理

## Implementation Details

### エンティティ設計

```dart
@collection
class Timetable {
  Id id = Isar.autoIncrement;
  late String campusId;           // "toyota", "nagoya"
  late int weekday;               // 1=Mon … 6=Sat
  late int period;                // 1限,2限…
  late String courseName;
  late String instructor;
  DateTime updatedAt = DateTime.now();

  @Index(composite: [CompositeIndex('campusId'), CompositeIndex('weekday'), CompositeIndex('period')])
  String get searchKey => '$campusId-$weekday-$period';
}

@collection
class AssignmentLog {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  late String assignmentId;         // MaNaBo 固有 ID
  @Enumerated(EnumType.ordinal)
  late AssignmentAction action;     // added, removed
  DateTime? dueAt;                  // 期限（nullable）
  DateTime createdAt = DateTime.now();
  bool notified = false;            // プッシュ通知済みフラグ
}
```

### サービス設計

```dart
class IsarService {
  static final IsarService instance = IsarService._internal();
  IsarService._internal();

  Isar? _isar;
  Isar? get isar => _isar;

  Future<Isar> open() async {
    if (_isar != null) return _isar!;
    
    final appDocDir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [TimetableSchema, AssignmentLogSchema],
      directory: appDocDir.path,
      name: 'passpal_db',
    );
    return _isar!;
  }

  Future<void> clear() async { /* テスト用 */ }
  Future<Map<String, dynamic>> getStats() async { /* 統計情報 */ }
}
```

### Riverpod統合

```dart
final isarProvider = Provider<Isar>((ref) {
  final service = IsarService.instance;
  if (service.isar == null) {
    throw StateError('Isar not opened. Call open() first');
  }
  return service.isar!;
});

final databaseStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final service = ref.read(isarServiceProvider);
  return await service.getStats();
});
```

## Performance Considerations

* **インデックス戦略**: 複合インデックスによる高速クエリ（campus + weekday + period）
* **バッチ操作**: `putAll()` による一括挿入でパフォーマンス向上
* **トランザクション**: 複数操作の原子性保証
* **メモリ管理**: 大量データでのページング実装

## Testing Strategy

* **単体テスト**: エンティティ検証、シングルトンパターン、エラーハンドリング
* **統合テスト**: 実際のIsarインスタンスを使用したCRUD操作テスト
* **パフォーマンステスト**: 大量データでのクエリ性能測定
* **モックテスト**: ProviderContainer を使用したRiverpod統合テスト

## Migration Strategy

* **スキーマバージョニング**: Isarの自動マイグレーション機能を活用
* **データ移行**: 既存データの段階的移行戦略
* **ロールバック**: 問題発生時の旧スキーマへの復旧手順

## Security Considerations

* **データ暗号化**: 将来的に `flutter_secure_storage` との連携で暗号化キー管理
* **アクセス制御**: アプリケーション層での適切な権限管理
* **データ完全性**: トランザクションによるデータ整合性保証

## Future Enhancements

* **TTL実装**: `DateTime expiresAt` フィールドによる自動データ削除
* **暗号化**: 機密データの暗号化ストレージ実装
* **同期機能**: サーバーとのデータ同期メカニズム
* **バックアップ**: ローカルデータのクラウドバックアップ

## Links

* [Isar Documentation](https://isar.dev/)
* [Flutter Riverpod](https://riverpod.dev/)
* [ADR-0003: Secure Credential Storage](0003-secure-credential-storage-implementation.md) - 暗号化との連携

<!-- markdownlint-disable-file MD013 -->