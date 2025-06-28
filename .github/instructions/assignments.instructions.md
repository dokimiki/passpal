---
applyTo: "lib/features/assignments/**"
---

# PassPal — Assignments Feature · Implementation Guide

> **Purpose**
> Provide a complete Assignments experience: list, status-sync, due-date reminders, and quick jumps to the original MaNaBo quiz/result screens.

## 1. Folder Skeleton

```
lib/features/assignments/
 ├─ data/
 │   ├─ datasources/
 │   │   └─ manabo_assignments_remote_ds.dart
 │   ├─ dtos/
 │   ├─ mappers/
 │   ├─ repositories/
 │   │   └─ assignment_repository_impl.dart
 │   └─ parsers/                  # HTML → DTO, versioned (v1_, v2_, …)
 │
 ├─ domain/
 │   ├─ entities/                 # assignment.dart, course_id.dart, …
 │   ├─ value_objects/
 │   ├─ enums/
 │   └─ usecases/
 │       ├─ get_assignments.dart
 │       └─ sync_assignments.dart
 │
 ├─ application/
 │   ├─ providers.dart            # top-level Riverpod providers
 │   └─ notifiers/
 │       └─ assignments_notifier.dart
 │
 └─ presentation/
     ├─ pages/
     │   └─ assignments_page.dart
     ├─ widgets/
     │   ├─ assignment_card.dart
     │   └─ assignment_group_header.dart
     └─ navigation.dart           # typed route helpers
```

> **Tests**
> *Every layer gets its own `*_test.dart` in the same folder.*
> Focus: parsers → repository → notifier golden path; error states; HTML regression.

---

## 2. Data Layer

### 2-1. End-points (all via `NetworkTarget.manabo`)

| Logical name  | URL fragment                                   | Method              | Payload / Params              |
| ------------- | ---------------------------------------------- | ------------------- | ----------------------------- |
| Timetable     | `/` (`action=glexa_ajax_timetable_view`)       | `POST (x-url-form)` | term, week(optional)          |
| Class Dir     | `/` (`action=glexa_ajax_class_directory_list`) | `POST`              | `class_id`, `directory_id`    |
| Class Content | `/` (`action=glexa_ajax_class_content_list`)   | `POST`              | `class_id`, `directory_id`    |
| Quiz Result   | `?action=plugin_quiz_ajax_result_list`         | `GET`               | many qs params (pass-through) |

*Build requests with the **core/network** “path-only” rule; host & cookies come from the interceptor chain.*

### 2-2. Remote DS

```dart
class ManaboAssignmentsRemoteDs {
  final NetClient _client;              // injected via networkClientProvider

  Future<String> fetchTimetable(Term t);
  Future<String> fetchClassDirectory(int classId, int dirId);
  Future<String> fetchClassContent(int classId, int dirId);
  Future<String> fetchQuizResult(Map<String, String> qs);   // raw HTML/JSON
}
```

### 2-3. Parsing

* Version every parser (`v1_timetable_parser.dart`, …).
* Use `html` package.
* On failure, fall back to **regex-only title extract** (see Core ADR-0006).
* Ship **test HTML fixtures** in `test_resources/` and assert snapshot parity.

### 2-4. Repository Contract

```dart
abstract class AssignmentRepository {
  Stream<List<Assignment>> watchAssignments(Term term);
  Future<void> refreshAssignments(Term term);      // SWR
  Future<void> markSeen(AssignmentId id);          // optional UX
}
```

*`Impl` handles TTL (1 h) with SWR-while-revalidate, saving JSON cache via `keyValueCacheProvider` (“cache.assignments”).*

---

## 3. Domain Layer

* **Entities**

  * `Assignment` → id, title, courseId, status(opened/deleted), dueAt?, createdAt, updatedAt.
  * `CourseId` (value object).
* **Use-cases**

  * `GetAssignments(term)` → `Stream<List<Assignment>>`.
  * `SyncAssignments(term)` → triggers repository refresh; returns `Either<Failure, int newCount>`.

All entities/use-cases must remain framework-free.

---

## 4. Application Layer

### 4-1. Providers

```dart
final assignmentsRepositoryProvider = Provider<AssignmentRepository>(...);

final assignmentsNotifierProvider =
    AsyncNotifierProvider.autoDispose<AssignmentsNotifier, List<Assignment>>(
      AssignmentsNotifier.new,
    );
```

*Notifier* subscribes to `watchAssignments`, exposes pull-to-refresh (`refresh()`).
Background task (`assignments.sync`) calls `SyncAssignments` every **6 h**, `networkRequired: true`, exponential back-off.

---

## 5. Presentation Layer

* **Route**: `/main/assignments` (registered in `core/routing`).
* **Page UX**

  * Pull-to-refresh.
  * Group list by “due-date-bucket” (“Today”, “Tomorrow”, “Next 7 days”, “No due date”).
  * Badge count in BottomNav comes from `assignmentsNotifierProvider` unread length.
* **Widgets**

  * `AssignmentCard` shows title, course chip, due-countdown (“D-3”), and status icon.
  * Tapping opens original quiz/content in *WebView* with auth cookies — **do not parse full HTML**.

---

## 6. Background & Notifications

* Background task compares newly fetched list against cached list; enqueue push via *core/background* when **added** or **due-1-day**.
* Use unique task name `assignments.sync`; register in `main.dart` after auth-success.

---

## 7. Error Handling

* Network / parse errors bubble as `AppException`; presentation layer shows `ErrorOverlay` with retry button.
* A 503 triggers Auto-retry handled by interceptor; show maintenance screen if flagged.

---

## 8. Configuration Flags

| Flag                                  | Default | Purpose                                         |
| ------------------------------------- | ------- | ----------------------------------------------- |
| `assignments.useParserVersion`        | `v1`    | Opt-in to v2 parser when HTML structure changes |
| `assignments.enableLocalNotification` | `true`  | Allow device-side reminder scheduling           |

Access via `configStreamProvider`, never via Remote Config directly.

---

## 9. Coding Checklist

* [ ] All DTO & Entity classes use **Freezed + JSON**.
* [ ] No feature-to-feature imports.
* [ ] Providers wired in `application/` only.
* [ ] Parser unit tests with fixture HTML.
* [ ] Golden test for `AssignmentCard`.
* [ ] Background task registered.
* [ ] All public APIs dart-doc’d.
