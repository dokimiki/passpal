---
applyTo: "lib/features/background/**"
---

# Bus Schedule Feature – GitHub Copilot Instructions

> **Goal** — Implement a _campus‑aware_ **bus_schedule** module that fetches the latest school‑bus departures for each campus, caches them locally, and exposes them via Riverpod providers to both the timetable widget and the Bus tab. The code must follow our Clean‑Architecture × Feature‑first guidelines and be fully testable.

---

## 1. Data Layer

### 1‑1 Remote Data Source

-   Use **Dio** with a custom `RetryInterceptor` implementing _exponential back‑off + jitter_ (see reference) when a 503 occurs.
-   Endpoint varies by campus:

    -   `https://albo.chukyo-u.ac.jp/bus/<campus_code>/schedule.html` for HTML fallback.
    -   If Remote Config announces a JSON API (`v2`), switch to `…/schedule.json`.

-   Parser classes live in `parser/`, versioned (`v1_html_bus_parser.dart`). Add corresponding **fixtures HTML** under `test/fixtures/bus/`.

### 1‑2 Local Data Source

-   Primary store: **Isar** collection `BusDepartureCollection` with composite index `[campus,date,time]`.
-   TTL = **7 days**; background refresh will purge & repopulate.
-   If Isar unavailable (e.g. background isolate restriction on iOS BGTasks), fall back to encrypted **Hive** box.

---

## 2. Domain Layer

```dart
@immutable class Departure {
  final Campus campus;
  final DateTime departureTime;
  final String destination;
}

abstract class BusScheduleRepository {
  Stream<List<Departure>> watch(Campus campus);
  Future<void> refresh(Campus campus);
}
```

-   **UseCases**: `WatchBusSchedule` (stream), `RefreshBusSchedule` (one‑shot, called by Workmanager/BGTask & pull‑to‑refresh).

---

## 3. Application Layer

### 3‑1 Providers & State

-   `busScheduleNotifier` extends `AutoDisposeAsyncNotifier<List<Departure>>`.
-   `selectedCampusProvider` holds current campus; drive UI & data refresh.
-   Expose helper `nextDepartureProvider` that returns the soonest departure ≥ now.

### 3‑2 Background Fetch

-   **Android:** Workmanager task every **6 h** (min interval OS‑controlled). Tag: `bus_refresh`.
-   **iOS:** `BGAppRefreshTaskRequest` identifier `jp.paspal.bus.refresh` requested every **8 h**.
-   Both tasks call `RefreshBusSchedule` for **all stored campuses**; skip if within TTL.

### 3‑3 Push Trigger (future)

-   When Firebase Remote Config flag `bus_schedule_force_sync` toggles, trigger immediate refresh.

---

## 4. Presentation Layer

-   **BusSchedulePage** shows a `CampusSelector` (TabBar) and a list of `DepartureCard` widgets grouped by hour.
-   Provide a **pull‑to‑refresh** `RefreshIndicator` tied to `RefreshBusSchedule`.
-   During offline / 503 states show `CommonErrorOverlay` with a "Retry" button.
-   Use **relative time labels** ("次発  5  分後") plus absolute time for accessibility.

---

## 5. Testing Strategy

| Test Type       | What to cover                                                                            |
| --------------- | ---------------------------------------------------------------------------------------- |
| **Unit**        | HTML/JSON parser returns correct DTOs; RetryInterceptor delay sequence; TTL expiry logic |
| **Widget**      | Presentation list renders correct grouping, error overlay shows on Provider error        |
| **Integration** | Background handler refreshes data & notifies UI without app reopen                       |

Use `ProviderContainer(overrides: …)` to inject mocks. Fixtures live under `test/fixtures/bus/`.

---

## 6. Security & Compliance

-   Store SHA‑256 pins in **Remote Config** keys `bus_pin_primary`, `bus_pin_backup` for hot‑swap.
-   When pin mismatch occurs, emit `BusSecurityException` captured by Core ErrorHandler & show blocking dialog.

---

## 7. Copilot Prompt Snippets

-   "Create a Dio RetryInterceptor with exponential backoff and jitter for bus_schedule" → outputs class in `core/network`.
-   "Generate Isar BusDepartureCollection schema with campus index".
-   "Write a Riverpod AutoDisposeAsyncNotifier that exposes next bus departure given selectedCampusProvider".
-   "Write a BGTaskRegistrar to schedule BGAppRefreshTaskRequest every 8 hours for bus_refresh".

> **Always:** prefer **null‑safe Dart**, avoid magic numbers (use constants), and write **failing tests first**.
