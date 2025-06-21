---
applyTo: "lib/features/attendance/**"
---

# GitHub Copilot – Attendance Module Instructions

> **Goal**: Generate robust, test‑driven Flutter/Dart code for the **Attendance** feature of the _ぱすぱる_ app. Follow the project‑wide Clean Architecture & feature‑first guidelines laid out in `general.instructions.md`.
>
> **Quick mnemonic**: **P‑T‑T‑P** → _Periodic polling (30 s)_, _TLS‑safe network_, _Test fixtures first_, _Provider‑driven UI_.

---

## 1. Layer‑Specific Guidelines

### 1.1 Data Layer

-   **Remote**

    -   `AttendanceApi` wraps Dio + `RetryInterceptor` (exponential back‑off, max 3)
    -   Expose:

        ```dart
        Future<String> fetchAttendanceHtml(CookieJar authCookie);
        Future<void> postAttendance({required AttendanceDto dto});
        ```

-   **Local**

    -   Prefer **Isar** for offline cache of `AttendanceRecord` keyed by `(semester, date, period)`.
    -   Provide `clearExpired()` that purges data older than the current semester.

-   **Parsers**

    -   Accept raw HTML, return `AttendanceDto`. Fall back to Regex when CSS selectors fail. Emit `ParserException` with Crashlytics logging.

-   **DTO ↔ Entity mappers** live in the same file as DTO for cohesion.

### 1.2 Domain Layer

-   **Entity**

    ```dart
    class AttendanceRecord {
      final DateTime date;
      final int period;        // 1‑5
      final String status;     // "attended", "absent", "late"
      final String courseCode; // MaNaBo course id
    }
    ```

-   **Repository interface** should remain _pure_ and platform‑agnostic.
-   **Use‑cases** return `Either<Failure, …>` (dartz) and stream when appropriate.

### 1.3 Application Layer

-   `AttendanceNotifier` extends **StateNotifier\<AsyncValue\<AttendanceRecord?>>**.

    -   On `init`, start a **Timer.periodic(const Duration(seconds:30))** that:

        1. Calls `MonitorAttendance()` use‑case.
        2. If the use‑case emits a change `status == "attending"`, push a modal via `showAttendanceModal()`.

    -   Automatically disposes timer in `dispose()`.

-   Handle 401 / 403 by invoking `AuthService.refreshSession()` once; surface `AuthenticationException` to UI only after failure.

### 1.4 Presentation Layer

-   **Widgets** must be _stateless_ where possible and read providers via `Consumer`. Use shadcn/ui components.
-   **AttendanceModal** shows ⏰ countdown (auto‑close in 2 min) & _Submit_ button. Uses `AnimatedOpacity` + Framer‑Motion style transitions.
-   **Error overlay**: reuse `CoreErrorOverlay` with retry callback.

---

## 2. Business Rules & Edge Cases

1. Polling **only while AttendancePage is in the widget tree** (use `RouteAware` or `FocusDetector`).
2. Remote portal returns **503 during nightly maintenance**: surface `MaintenanceOverlay` and pause polling until HTTP 200.
3. Session expires after 1 h → rely on Auth provider to auto‑refresh; do **not** prompt user unless refresh fails.
4. HTML changes: switch parser via **Firebase Remote Config** (`active_parser_version`).
5. Accessibility: label modal buttons with `Semantics` for screen readers.

---

## 3. Testing Strategy

| Layer      | Tool / Pattern  | Key Points                                                                                    |
| ---------- | --------------- | --------------------------------------------------------------------------------------------- |
| Parser     | `html` + `test` | Fixture HTMLs under `test/fixtures/attendance/`. Add regression test for each parser version. |
| Repository | `mockito`       | Mock remote/local to assert caching & refresh logic.                                          |
| Notifier   | `riverpod_test` | Drive periodic timer with `FakeAsync`.                                                        |
| Widget     | `flutter_test`  | Pump `AttendanceModal`, simulate tap, verify `postAttendance` called.                         |

---

## 4. Copilot Prompt Snippets

Paste the following comment at top of new files to steer Copilot:

```dart
// Copilot: Generate a Dart class that implements {interface} inside the Clean Architecture structure.
// ‑ Use Riverpod for DI (see provider below).
// ‑ Follow null‑safety, idiomatic Dart.
// ‑ Throw Failure subclasses on error, do NOT catch at this layer.
// ‑ Add exhaustive tests for public methods in {corresponding _test.dart}.
```

_Example for the API class_

```dart
// Copilot: Generate AttendanceApi with Dio, RetryInterceptor (max3, exponential),
```

---

## 5. Common Pitfalls – Guardrails

| ❌ Anti‑pattern                     | ✅ Correct Approach                |
| ----------------------------------- | ---------------------------------- |
| Polling via `while(true)` + `sleep` | Use `Timer.periodic` and dispose   |
| Access providers inside entity      | Keep entities platform‑agnostic    |
| Parsing HTML in Presentation        | Move to Data parsers               |
| Direct Firebase call from UI        | Go through Repository & Use‑case   |
| Hard‑coding campus periods          | Inject `CampusScheduleRepository`  |

---

## 6. Definition of Done (DoD)

1. All tests green (`flutter test`).
2. No TODOs or ignored lints.
3. Coverage ≥ 90 % for Data & Domain layers.
4. Android & iOS manual smoke test: joining a class triggers modal within 30 s.
5. CI workflow passes (GitHub Actions).
