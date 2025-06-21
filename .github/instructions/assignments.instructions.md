---
applyTo: "lib/features/assignments/**"
---

## 1. Scope & Responsibilities

-   **Primary goal** : list, cache, notify, and submit MaNaBo / ALBO / Cubics assignments.
-   **Out of scope** : full content parsing (display assignments in a WebView), unrelated portal resources.

## 2. Folder Layout (feature‑first × 4‑layer)

```
features/assignments/
 ├─ data/
 │   ├─ remote/
 │   │   └─ assignment_api.dart      // Dio wrapper + 503 retry
 │   ├─ local/
 │   │   ├─ assignment_cache.dart    // Isar DAO
 │   │   └─ assignment_log_dao.dart  // For deadline notifications
 │   ├─ dto/
 │   │   └─ assignment_dto.dart
 │   └─ repository_impl.dart         // Implements Domain interface
 ├─ domain/
 │   ├─ entity/
 │   │   └─ assignment.dart
 │   ├─ repository/
 │   │   └─ assignment_repository.dart
 │   └─ usecase/
 │       ├─ fetch_assignments.dart
 │       ├─ refresh_assignments.dart // stale‑while‑revalidate
 │       └─ schedule_deadline_alerts.dart
 ├─ application/
 │   └─ provider/
 │       ├─ assignment_notifier.dart // StateNotifier<List<Assignment>>
 │       └─ overdue_notifier.dart    // Emits List<Assignment> about to expire
 └─ presentation/
     ├─ pages/assignment_list_page.dart
     └─ widgets/assignment_card.dart
```

## 3. Coding Conventions

1. **Null safety & exhaustive `when`** on sealed classes.
2. **Dio** : add `RetryInterceptor` (503 ⇒ exp. back‑off ≤ 3). Inject via Riverpod.
3. **Isar** DAO methods must be async & transactional. Emit Streams to providers.
4. **Crypto** : pass cookies via `SecureStorage.read(key)` only.
5. **WebView submission** : open URL + auth cookies, never parse answer UI.
6. **Notification rule** : schedule `deadline − 24h` local alert once. Cancel/replace when assignment is removed.

## 4. Typical Copilot Prompt Patterns

| Scenario            | Minimal Prompt                                                             | Expected Output                                                                |
| ------------------- | -------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| Parse HTML into DTO | `"""Parse ALBO homework rows <tr>…</tr> into AssignmentDto"""`             | RegExp‑based parser with tests pinned to `/test/fixtures/html/albo_list.html`. |
| Repository          | `"""class AssignmentRepositoryImpl implements AssignmentRepository"""`     | Methods: `watchAll()`, `syncRemote()`, `logOperation()`                        |
| Provider            | `"""Riverpod StateNotifier that exposes grouped assignments by lecture"""` | Notifier with `groupBy((a)=>a.lectureId)`                                      |
| Widget              | `"""Flutter assignment card with title, dueDate badge, onTap callback"""`  | Reusable `AssignmentCard` sized widget                                         |

**Tip for Copilot**: Start prompts with _“Write a null‑safe …”_ and specify _inputs, outputs, side‑effects_. End with _“add unit tests”_ for best results.

## 5. Testing Matrix

| Layer          | What to test                                       | File                 | Tool                 |
| -------------- | -------------------------------------------------- | -------------------- | -------------------- |
| Data/Parser    | HTML → DTO correctness, versioned fixture          | `parser_test.dart`   | `flutter test`       |
| Domain/UseCase | `refresh_assignments()` merges cache & remote diff | `usecase_test.dart`  | Mockito + fake clock |
| Application    | `overdue_notifier` emits at correct times          | `notifier_test.dart` | FakeAsync            |
| Presentation   | `AssignmentListPage` renders loading/error         | `widget_test.dart`   | Golden toolkit       |

## 6. Security & Error Handling Checklist

-   Catch `HtmlParseException` → fallback regex, log to Crashlytics.
-   Encrypt cache with AES‑256 (Isar built‑in `encrypt=true`).
-   Respect 503 maintenance windows; propagate `PortalMaintenanceFailure` to UI overlay.

---

## 7. Seed Code Snippet

```dart
@riverpod
class AssignmentNotifier extends _$AssignmentNotifier {
  late final _repo = ref.read(assignmentRepositoryProvider);
  @override
  FutureOr<List<Assignment>> build() => _repo.watchAll();

  Future<void> refresh() => _repo.syncRemote();
}
```

> Copilot: expand this to expose `groupByCourse()`, handle `AsyncValue.guard`, and emit diff events for UI badges.
