---
applyTo: "lib/core/storage/**"
---

# GitHub Copilot Instructions – **Storage Component**

> **Goal** – Generate secure, test‑first, and maintainable Flutter code that fulfills the storage responsibilities defined in the ぱすぱる architecture: local caching (Isar/Drift), secure credential storage, encryption, TTL cleanup, stale‑while‑revalidate, and Firestore cost control.

---

## 1. Scope & Boundaries

| Layer            | Storage Responsibility                                                                                                |
| ---------------- | --------------------------------------------------------------------------------------------------------------------- |
| **Data**         | _Create concrete sources:_ `LocalDatabase`, `SecureStore`, `CacheCleaner`, plus platform helpers (Keychain/Keystore). |
| **Domain**       | _Define abstractions:_ `StorageRepository`, `CredentialRepository`.                                                   |
| **Application**  | _Schedule tasks:_ `BackgroundCacheRefreshService`, TTL sweeper.                                                       |
| **Presentation** | **No direct DB calls** – always through Riverpod providers.                                                           |

### Do **NOT**

-   Access UI or network directly.
-   Store plain credentials.

---

## 2. Package Choices & Configuration

| Concern            | Package                                              | Notes                                                            |
| ------------------ | ---------------------------------------------------- | ---------------------------------------------------------------- |
| NoSQL DB           | **Isar**                                             | Lightning‑fast; supports indexes & queries. Use for most caches. |
| Relational         | **Drift**                                            | Use only when complex JOINs trump speed.                         |
| Secure credentials | **flutter_secure_storage**                           | Keychain/Keystore backed.                                        |
| Field encryption   | **cryptography**                                     | AES‑256‑GCM; 12‑byte IV, 16‑byte tag. Store key in SecureStore.  |
| Background cleanup | **Workmanager (Android)** / `BGAppRefreshTask` (iOS) | Run TTL sweeper & revalidate.                                    |

Add the following to `pubspec.yaml`:

```yaml
dependencies:
    isar: ^4.0.0
    isar_flutter_libs: any
    drift: ^2.0.0
    flutter_secure_storage: ^9.0.0
    cryptography: ^2.5.0
```

---

## 3. Database Schema Guidelines (Isar)

1. **Entities reside in `core/storage/data/local_db/schemas/*.dart`.**
2. Use `@collection` + generated `*.isar.dart`.
3. Add `DateTime expiresAt` when data has TTL.
4. Index frequently queried fields (`@Index(unique: true)` for IDs).
5. Provide `migrate()` helpers for breaking schema changes.
6. Wrap Isar instance in a singleton Riverpod Provider (`isarProvider`).

### Drift

-   Place `.moor` files or Dart table classes in `local_db/drift/`.
-   Generate with `drift_dev` build runner.

---

## 4. Caching Strategy – **Stale‑While‑Revalidate**

-   **Read flow:** Return cached object _immediately_ → If `expiresAt < now`, trigger background re‑fetch via `BackgroundCacheRefreshService`.
-   **Write flow:** Update cache & set `expiresAt = DateTime.now().add(ttl)`.
-   Add a `CachePolicy` enum (staleWhileRevalidate, networkOnly, cacheFirst). Defaults to staleWhileRevalidate.

---

## 5. TTL & Cleanup

-   For entities with TTL (e.g., timetable 24 h, periodTimes 7 d):

    -   TTL constant lives in Domain layer next to entity.
    -   Implement `CacheCleaner` that runs daily:

        ```dart
        final now = DateTime.now();
        await isar.writeTxn(() async {
          await isar.assignmentCaches.filter().expiresAtLessThan(now).deleteAll();
        });
        ```

-   Register cleaner in `BackgroundCacheRefreshService`.

---

## 6. Secure Credential Storage

-   Use `SecureStore.writeEncrypted(key, value)` – wraps `flutter_secure_storage` + AES‑256.
-   Never store plaintext IDs/Passwords in DB.
-   In Android, set:

    ```dart
    const AndroidOptions _aOpts = AndroidOptions(
      encryptedSharedPreferences: true,
    );
    ```

-   In iOS, set:

    ```dart
    const IOSOptions _iOpts = IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    );
    ```

---

## 7. Firestore Cost Control Helpers

-   Batch updates (`WriteBatch`) when pushing logs.
-   Expose `FirestoreBillingGuard` util with:

    -   `shouldThrottleReads(int readCount24h)`.
    -   `aggregateAssignments()` for high‑volume collections.

-   Store local read counters in Isar.

---

## 8. Testing Checklist

-   **Unit** – Encryption round‑trip, TTL expiration, Isar adapters.
-   **Widget** – None (storage is non‑UI).
-   **Integration** – CacheCleaner with Workmanager mock.
-   Use `ProviderContainer(overrides: [...])` to inject in‑memory Isar for tests.
-   Add sample HTML fixtures under `test/fixtures/html/` for scraper tests.

---

## 9. Copilot Prompting Tips

-   Comment every public method with summary, params, and returns – Copilot amplifies JSDoc‑style comments.
-   Begin new files with a small banner like:

    ```dart
    // GENERATED WITH: "Riverpod Isar secure storage" prompt
    ```

-   Include TODOs for edge cases; Copilot tends to implement them immediately.
-   Use explicit types (`final` over `var`) for clearer completions.
-   Keep functions <60 LOC; split bigger logic to helpers.

---

## 10. Sample Starter Snippet

```dart
// lib/core/storage/data/secure/secure_store.dart
class SecureStore {
  SecureStore(this._storage);
  final FlutterSecureStorage _storage;

  Future<void> writeEncrypted(String key, String value) async {
    final secretKey = await _obtainKey();
    final aes = AesGcm.with256bits();
    final secretBox = await aes.encrypt(
      utf8.encode(value),
      secretKey: secretKey,
    );
    await _storage.write(key: key, value: base64Encode(secretBox.concatenation()));
  }

  // ... readEncrypted, delete ...
}
```
