---
applyTo: "test/**"
---

# GitHub Copilot Test Instructions for ぱすぱる

> **Audience**: GitHub Copilot & other code‑generation AI.
> **Goal**: Produce _maintainable, deterministic_ tests that conform to our Clean‑Architecture / Riverpod implementation, security constraints, and CI pipeline.

---

## 0. Quick‑start Checklist

1. **Follow TDD**: Red → Green → Refactor. Create failing test _before_ production code.
2. **Layers**: Test **Domain** logic in isolation, **Data** parsing with fixtures, **Application** providers with overrides, **Presentation** widgets with `testWidgets()`.
3. **Null‑safety** & `package:test` only. No deprecated `flutter_driver`; use `integration_test`.
4. Mock network with `mocktail` and **fake** Dio/HTTP.
5. Name files `<feature>_<unit|widget|integration>_test.dart`.
6. Keep each test ≤ 200 LOC, 1 assert per behaviour.

---

## 1. Directory Layout

```text
➜ test/
    ├─ fixtures/
    │   └─ html/   ← MaNaBo & ALBO sample pages (versioned)
    ├─ core/
    │   ├─ network_retry_interceptor_test.dart
    │   └─ isar_db_test.dart
    └─ features/
        ├─ assignments/
        │   ├─ fetch_assignments_usecase_test.dart
        │   ├─ assignment_notifier_test.dart
        │   └─ assignment_list_page_widget_test.dart
        └─ timetable/
            └─ timetable_repository_test.dart
```

---

## 2. Unit Tests

### 2.1 Domain Layer

-   **Pure Dart** classes. Instantiate directly — _no_ Flutter bindings needed.
-   Expectation style: `expect(actual, equals(expected));`.

### 2.2 Data Layer

-   Use **fixture files** under `test/fixtures/` for HTML & JSON.
-   Parse → DTO → Entity, then assert field mapping.
-   For Isar DB, initialise in‑memory instance:

    ```dart
    setUp(() async {
      isar = await openTempIsar([...schemas]);
    });
    ```

### 2.3 Network

-   Wrap Dio in `MockDio` via `mocktail`:

    ```dart
    final dio = MockDio();
    when(() => dio.get(any())).thenAnswer((_) async => Response(...));
    ```

-   Retry interceptor: simulate 503 → succeed on 3rd retry.

---

## 3. Application Layer Tests

-   Use `ProviderContainer(overrides: [...])` to inject mocks (Riverpod) and test `StateNotifier` logic.
-   Always call `addTearDown(container.dispose);`.

---

## 4. Widget Tests

-   Wrap widget with `ProviderScope` & `MaterialApp`.
-   Use golden tests for visual regressions (`flutter_test` + `flutter_goldens`).
-   Pump frames instead of `await tester.pumpAndSettle()` where possible for determinism.

---

## 5. Integration Tests

-   Use `integration_test` package; entrypoint in `integration_test/app_test.dart`.
-   Simulate push via `firebase_messaging` test‑double.
-   Background tasks:

    -   Android: trigger WorkManager using `TestDriver`.
    -   iOS: schedule dummy `BGAppRefreshTask` with `debugOverrideLaunchDate` in fake environment.

---

## 6. CI & Coverage

-   GitHub Actions: `flutter pub run flutter_test --coverage` → upload as artifact.
-   Enforce **≥ 80 %** coverage task fails build.

---

## 7. Naming & Style Conventions

| Type          | File suffix              | Arrange blocks        |
| ------------- | ------------------------ | --------------------- |
| Unit (Domain) | `_usecase_test.dart`     | Arrange‑Act‑Assert    |
| Data parse    | `_repository_test.dart`  | Given‑When‑Then       |
| Provider      | `_notifier_test.dart`    | Arrange‑Act‑Assert    |
| Widget        | `_widget_test.dart`      | Build‑Interact‑Verify |
| Integration   | `_integration_test.dart` | Scripted scenario     |

---

## 8. Common Test Utilities (auto‑import!)

-   `test_utils.dart` exports:

    -   `setupIsolatedContainer({List<Override> overrides})`.
    -   `loadFixture(String name)` returning `String`.
    -   `pumpWidgetWithProviders(WidgetTester tester, Widget child, {List<Override> overrides})`.

---

## 9. Security & Privacy in Tests

-   Never log real credentials. Use `user@example.com / p@ssw0rd`.
-   Mock TLS pinning by disabling certificate checks in test scope only.

---

## 10. AI‑Prompt Tips for Copilot

-   **Start with the failing test**:

    ```dart
    // Wanted: when fetchAssignmentsUsecase executes, it returns 3 assignments from fixture v1.
    ```

-   Use **precise comments**; include fixture names and expected states.
-   Declare provider overrides explicitly; Copilot tends to forget otherwise.
-   Request minimal UI in widget tests: `sizeToTest: const Size(400, 800)`.

---

## 11. References

-   Riverpod provider testing guide
-   Widget testing best practices
-   Flutter integration_test docs
-   Isar unit‑test discussion
-   Dio interceptor testing example
-   iOS BGTask testing advice
-   FCM Flutter client setup (for mocks)
-   Loading fixture files in tests
-   Additional Riverpod testing cookbook
-   Widget testing guide 2024
-   Integration testing deep dive
-   Isar GH discussion on testing
-   Retry interceptor medium article
-   Strategies for background testing on iOS
