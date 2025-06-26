# 0002. Coreストレージアーキテクチャ

日付: 2025-06-26

## 状況

PassPalアプリケーションにおいて、認証情報、キャッシュデータ、ユーザー設定を安全かつ効率的に管理するためのストレージレイヤーが必要。

要件：
- 認証情報（ID/PW/SSO Cookie）の暗号化保存
- JSONデータの効率的なキャッシュ機能（TTL + SWR）
- ユーザー設定の永続化
- リアクティブなデータストリーム
- テスタビリティとモックのサポート

## 決定

3層構造のストレージアーキテクチャを採用：

### 1. CredentialStorage（認証情報）
- **目的**: 機密情報の暗号化保存
- **実装**: `flutter_secure_storage` (AES-256, Keychain/Keystore)
- **API**: `save()`, `read()`, `purge()`

### 2. KeyValueCache（データキャッシュ）
- **目的**: JSONデータのキャッシュと監視
- **実装**: `SharedPreferences` + `StreamController`
- **API**: `putJson()`, `watchJson()`, `remove()`
- **名前空間**: `cache.<entity>`
- **TTL**: `lastFetchedAt`フィールドで管理

### 3. UserPrefs（ユーザー設定）
- **目的**: アプリ設定の永続化
- **実装**: `SharedPreferences`
- **API**: `theme`, `setTheme()`, `campus`, `setCampus()` など
- **名前空間**: `pref.*`

### 4. CachePolicy（キャッシュポリシー）
- **目的**: TTL判定とSWR（Stale-While-Revalidate）ロジック
- **実装**: `lastFetchedAt`ベースの判定

### 5. StorageException（例外処理）
- **目的**: ストレージ固有の例外定義
- **種類**: `deserialize`, `secureIo`, `kvIo`
- **連携**: `core/error`との統合

## TTL設定

| エンティティ    | TTL  | トリガー                |
|----------------|------|------------------------|
| Timetable      | 24h  | BGTask 6h, widget      |
| Period Master  | 3d   | BGTask                 |
| Bus Timetable  | 3d   | BGTask                 |
| Assignments    | 1h   | User open/push/BG      |
| Absence Log    | 24h  | User open              |
| Announcements  | 1h   | User open              |

## DI設計

全てRiverpod Providerで注入：

```dart
final sharedPrefsProvider = Provider<SharedPreferences>((_) => throw UnimplementedError());
final keyValueCacheProvider = Provider<KeyValueCache>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return SharedPrefsKeyValueCache(prefs);
});
final credentialStorageProvider = Provider<CredentialStorage>((_) => FlutterSecureStorageCredentialStorage());
final cachePolicyProvider = Provider<CachePolicy>((ref) => DefaultCachePolicy(ref.watch(clockProvider)));
```

## Feature層での使用例

### 課題一覧の取得（SWR）

```dart
// Application Layer
@riverpod
class AssignmentsNotifier extends _$AssignmentsNotifier {
  @override
  Stream<AsyncValue<List<Assignment>>> build() {
    final cache = ref.watch(keyValueCacheProvider);
    final policy = ref.watch(cachePolicyProvider);
    final repo = ref.watch(assignmentRepositoryProvider);
    
    return cache.watchJson('cache.assignments').asyncMap((cached) async {
      if (cached != null && !policy.isStale(cached['lastFetchedAt'])) {
        // Fresh data
        return AsyncValue.data(Assignment.fromJsonList(cached['data']));
      }
      
      try {
        // Stale or missing - fetch new data
        final assignments = await repo.fetchAssignments();
        await cache.putJson('cache.assignments', {
          'data': assignments.map((a) => a.toJson()).toList(),
          'lastFetchedAt': DateTime.now().toIso8601String(),
        });
        return AsyncValue.data(assignments);
      } catch (error) {
        // Return stale data if available, otherwise error
        if (cached != null) {
          return AsyncValue.data(Assignment.fromJsonList(cached['data']));
        }
        return AsyncValue.error(error, StackTrace.current);
      }
    });
  }
}
```

### 認証情報の管理

```dart
// Application Layer
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<AuthState> build() async {
    final credentialStorage = ref.watch(credentialStorageProvider);
    final credentials = await credentialStorage.read();
    
    return credentials != null 
      ? AuthState.authenticated(credentials)
      : const AuthState.unauthenticated();
  }
  
  Future<void> login(String username, String password) async {
    final credentialStorage = ref.watch(credentialStorageProvider);
    // ... login logic
    await credentialStorage.save(credentials);
    state = AsyncValue.data(AuthState.authenticated(credentials));
  }
  
  Future<void> logout() async {
    final credentialStorage = ref.watch(credentialStorageProvider);
    await credentialStorage.purge();
    state = const AsyncValue.data(AuthState.unauthenticated());
  }
}
```

### ユーザー設定の管理

```dart
// Application Layer
@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  SettingsState build() {
    final prefs = ref.watch(userPrefsProvider);
    return SettingsState(
      theme: prefs.theme,
      campus: prefs.campus,
    );
  }
  
  Future<void> updateTheme(ThemeMode theme) async {
    final prefs = ref.watch(userPrefsProvider);
    await prefs.setTheme(theme);
    state = state.copyWith(theme: theme);
  }
}
```

## 根拠

1. **セキュリティ**: 認証情報は暗号化が必須
2. **パフォーマンス**: SWRでUIの応答性向上
3. **一貫性**: 統一されたAPIでfeature層の複雑さを軽減
4. **テスタビリティ**: インターフェース分離とDIによる高いテスト性
5. **リアクティブ**: Streamベースで自動UI更新
6. **例外処理**: core/errorとの統合で一貫したエラーハンドリング

## 影響

- 全てのfeature層でストレージ操作が統一される
- 認証情報の漏洩リスクが大幅に軽減される
- キャッシュ戦略により通信回数が削減される
- テストの作成が容易になる
- Crashlyticsとの統合により問題の早期発見が可能

## 参考資料

- [0001-core-error-handling-architecture.md](./0001-core-error-handling-architecture.md)
- [Storage Layer Instructions](../../.github/instructions/storage.instructions.md)
