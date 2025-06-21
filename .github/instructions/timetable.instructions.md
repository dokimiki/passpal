---
applyTo: "lib/features/timetable/**"
---

# Timetable Component – GitHub Copilot Instructions

> **Goal** Create a clean, test‑driven, feature‑first implementation of the _timetable_ experience for the ぱすぱる app, covering class schedule storage, background refresh, and UI rendering. Follow these guidelines whenever Copilot is asked to generate or complete code inside `features/timetable/`.

---

## 1. Directory & Layer Layout

```
features/
  timetable/
    data/
      remote/          # Dio scrapers ↔ ALBO / MaNaBo portals
      local/           # Isar collection & DAO
      dto/             # JSON/HTML‑parsed models
      repository_impl.dart
    domain/
      entity/          # TimetableDay, Period, Class
      repository.dart  # abstract TimetableRepository
      usecase/         # FetchTimetable, GetClassesForDate, ...
    application/
      provider/        # Riverpod Notifiers & Schedulers
      background/      # WorkManager & BGAppRefresh bridges
    presentation/
      pages/           # TimetablePage, ClassDetailBottomSheet
      widgets/         # TimetableGrid, TodayClassesWidget
```

_Never import across features except via `domain` contracts._

---

## 2. Data Layer Rules

-   **Remote fetch**

    -   Use a _versioned_ HTML parser (`v1_timetable_parser.dart`) that consumes fixture HTML under `test/fixtures/html/timetable/`.
    -   Wrap Dio with `RetryInterceptor` (expo back‑off) and catch 503/401 for auto‑relogin.

-   **Local cache** (Isar)

    -   Collections: `TimetableClass` (compound index: term, day, period) and `CampusPeriod`.
    -   TTL = 24 h from last successful fetch (`LastSyncAt` key in Isar preferences).
    -   Implement **stale‑while‑revalidate**: return cached data instantly, then fire `FetchTimetableUseCase` in the background; emit a stream update when fresh data arrives.

---

## 3. Domain Layer Contracts

```dart
abstract class TimetableRepository {
  Future<List<TimetableClass>> fetchRemote();
  Future<List<TimetableClass>> readCache();
  Future<void> saveCache(List<TimetableClass> data);
  Stream<List<TimetableClass>> watch();
}
```

Entities must be immutable, null‑safe value objects with `equatable`.

UseCases (command‑query split):

1. `FetchTimetable` – network → cache → output list.
2. `GetClassesForDate(DateTime date)` – read Isar, group by period.
3. `RefreshIfStale()` – if TTL passed, call `FetchTimetable`.

---

## 4. Application Layer

-   **Providers**

    -   `timetableRepositoryProvider` returns implementation with injected remote/local sources.
    -   `timetableControllerProvider` (StateNotifier) exposes `AsyncValue<List<TimetableClass>>` and triggers `RefreshIfStale()` on init.

-   **Background refresh**

    -   Android: schedule periodic WorkManager every 6 h with back‑off; cancel if FCM push for timetable arrives.
    -   iOS: register `BGAppRefreshTask` with earliest 6 h.
    -   Both must call `RefreshIfStale()` and update home‐screen widget via platform channel.

---

## 5. Presentation Layer

-   `TimetablePage` shows week grid; reuse open‑source **JonasWanke/timetable** widget for layout (MIT) but wrap in our ViewModel.
-   Today widget and home‑screen widget show next class countdown and list.
-   Support **multiple campuses** by color‑tagging periods and fetching `CampusPeriod` map weekly.
-   Offline mode: render cached data + banner _"オフライン表示"_.

---

## 6. Testing Strategy

-   **Unit**: Use Fake Dio + fixture HTML; assert parser → DTO → Entity.
-   **Widget**: Wrap `TimetablePage` in `ProviderScope` with mock repo; pump and expect class tiles.
-   **Integration**: Simulate WorkManager call inside test‑only Flutter driver.

---

## 7. Security & Compliance

-   Fetch via `core/network/secure_dio.dart` with TLS pinning.
-   Timetable data is **non‑PII**; however respect campus selection stored in secure storage.

---

## 8. Copilot Prompting Hints

-   **Always start by generating failing tests** (`*_test.dart`).
-   Prefer functional returns; avoid exposing Isar objects outside data layer.
-   Use descriptive names: `TimetableClass`, `PeriodSlot`, not `TimeTableModel`.
-   Annotate public methods with `///` doc comments, include _"Throws"_ section.
-   Split widget build methods >200 LOC into private widgets.
-   When uncertain, ask for clarification via TODO inside code.

---

## 9. Example Skeleton (abbrev.)

```dart
final timetableControllerProvider = StateNotifierProvider.autoDispose<
    TimetableController, AsyncValue<List<TimetableClass>>>(
  (ref) => TimetableController(
    fetch: ref.watch(fetchTimetableUseCaseProvider),
    getForDate: ref.watch(getClassesForDateUseCaseProvider),
  )..init(),
);
```

Use this as template for Copilot completions.

---

## 10. Done Criteria

Copilot‑generated PRs for this feature must:

1. Pass all **unit + widget + integration tests**.
2. Follow directory scheme & naming.
3. Achieve ≥ 80 % line coverage in `features/timetable/`.
4. Contain no direct `print` calls (use `logger`).
5. Obtain ✅ from ADR reviewer.
