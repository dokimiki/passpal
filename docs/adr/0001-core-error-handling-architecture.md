# ADR-0001: Core Error Handling Architecture

## ステータス

採用済み

## 背景

PassPalアプリケーションでは、複数の層（UI、バックグラウンド、ドメイン）にわたって統一されたエラーハンドリングが必要です。現在、以下の課題があります：

- 例外処理が各層で分散している
- ネットワークエラー、認証エラー、パースエラーなどの分類が不明確
- Crashlyticsへの報告が一貫していない
- UIでのエラー表示が重複している
- バックグラウンドタスクのリトライ戦略が統一されていない

## 決定事項

`lib/core/error` パッケージを作成し、以下のアーキテクチャを採用します：

### 1. 統一例外モデル

```dart
abstract class AppException implements Exception {
  final String message;
  final StackTrace? stack;
  final bool isFatal;
}

// 具象クラス
class NetworkFailure extends AppException {
  final NetworkFailureKind kind; // offline, http4xx, server5xx
  final bool canRetry;
}

class AuthenticationException extends AppException {}
class MaintenanceException extends AppException {}
class ParseFailure extends AppException {}
class UnknownException extends AppException {}
```

### 2. Crashlytics統合

- すべての例外を `CrashlyticsReporter` 経由で報告
- `isFatal` フラグに基づいて重要度を分類
- 例外タイプごとにカスタムパラメータを付与

### 3. Remote Config Kill-Switch

- パースエラー時に機能を無効化
- 15分間のキャッシュ機能
- `disable_assignments_parser_v1`、`force_update_min_version` などのキー

### 4. Riverpod Notifier統合

```dart
final errorNotifierProvider = 
  NotifierProvider<ErrorNotifier, AppErrorState>(ErrorNotifier.new);
```

### 5. グローバル例外捕捉

- `runZonedGuarded` と `PlatformDispatcher.onError` を使用
- すべての未処理例外をCrashlyticsに送信

## 実装詳細

### ファイル構成

```text
lib/core/error/
 ├─ app_exception.dart      # 例外階層定義
 ├─ crashlytics_reporter.dart # Crashlytics統合
 ├─ remote_kill_switch.dart   # Remote Config管理
 ├─ error_guard.dart         # グローバル例外捕捉
 ├─ error_notifier.dart      # UIエラー状態管理
 └─ overlay/
     └─ error_overlay.dart   # エラー表示UI
```

### Feature層での使用例

#### 1. UIでのエラー表示

```dart
// features/assignments/presentation/assignments_page.dart
Consumer(
  builder: (context, ref, child) {
    final errorState = ref.watch(errorNotifierProvider);
    return Stack(
      children: [
        // メインコンテンツ
        AssignmentsContent(),
        // エラーオーバーレイ
        switch (errorState) {
          Showing(exception: final e) => ErrorOverlay(exception: e),
          Idle() => const SizedBox.shrink(),
        },
      ],
    );
  },
)
```

#### 2. バックグラウンドタスクでの例外処理

```dart
// features/assignments/application/sync_notifier.dart
class AssignmentsSyncNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    try {
      await ref.read(assignmentsRepositoryProvider).sync();
    } on ParseFailure catch (e) {
      // パースエラーはログのみ、ユーザーブロックしない
      ref.read(crashlyticsReporterProvider).recordError(e);
    } on NetworkFailure catch (e) {
      if (e.canRetry) {
        // リトライ可能なネットワークエラー
        throw e; // TaskDispatcherがリトライ
      }
      ref.read(errorNotifierProvider.notifier).show(e);
    }
  }
}
```

#### 3. データ層でのネットワークエラーマッピング

```dart
// features/assignments/data/assignments_remote_data_source.dart
class AssignmentsRemoteDataSource {
  Future<List<AssignmentDto>> getAssignments() async {
    try {
      final response = await dio.get('/assignments');
      return response.data.map(AssignmentDto.fromJson).toList();
    } on DioException catch (e) {
      // core/network の Interceptor が AppException に変換
      rethrow;
    } on FormatException catch (e) {
      throw ParseFailure(
        message: 'Assignment parse failed: ${e.message}',
        stack: StackTrace.current,
        isFatal: false,
      );
    }
  }
}
```

### マッピング戦略

| ネットワーク入力 | 例外タイプ | 備考 |
|-----------------|-----------|------|
| Dio timeout/unknown | NetworkFailure.offline() | ConnectivityInterceptor |
| HTTP 503 + "maintenance" | MaintenanceException | MaintenanceInterceptor |
| HTTP 5xx (3回リトライ後) | NetworkFailure.server() | RetryInterceptor |
| HTTP 4xx (401以外) | NetworkFailure.http() | リトライ不可 |
| 2回目の401 | AuthenticationException | AuthInterceptor |

### バックグラウンドタスク戦略

| 例外タイプ | リトライポリシー | タスク結果 |
|-----------|-----------------|-----------|
| NetworkFailure.server() | あり（指数バックオフ） | Result.retry() |
| AuthenticationException | なし | Result.failure(giveUp: true) |
| MaintenanceException | なし | Result.failure(giveUp: true) |
| ParseFailure | なし（kill-switch） | Result.success() + ログのみ |

## 影響

### 利点

1. **統一されたエラーハンドリング**: 全層で一貫した例外処理
2. **可観測性の向上**: Crashlyticsへの統一報告
3. **ユーザビリティ**: UIでの適切なエラー表示とリトライ機能
4. **保守性**: 例外ロジックの重複削除
5. **運用性**: Remote Configによる機能kill-switch

### 考慮事項

1. **パフォーマンス**: グローバル例外捕捉のオーバーヘッド
2. **複雑性**: 例外マッピングルールの管理
3. **テスト**: モック作成の複雑さ

## 代替案

### 1. 各Feature独自のエラーハンドリング

- **却下理由**: コードの重複、一貫性の欠如

### 2. Either<Failure, T>パターンのみ

- **却下理由**: ボイラープレートが多い、例外の統一報告困難

### 3. グローバルErrorBoundaryのみ

- **却下理由**: 細かい制御不可、バックグラウンドタスク対応困難

## 参考資料

- [Flutter Error Handling Best Practices](https://docs.flutter.dev/testing/errors)
- [Riverpod Error Handling](https://riverpod.dev/docs/concepts/reading#handling-errors)
- [Firebase Crashlytics](https://firebase.google.com/docs/crashlytics)
