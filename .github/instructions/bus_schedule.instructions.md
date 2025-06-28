---
applyTo: "lib/features/bus_schedule/**"
---

# PassPal – Bus / Train Timetable Feature

## 0. Goal

Implement a vertical slice that shows the next-three departures and provides a 1-minute–refreshing home-widget of the *nearest* ride for each campus.

---

## 1. Directory Skeleton

```
lib/features/bus_schedule/
 ├─ data/
 │   ├─ sources/
 │   │   └─ timetable_remote_ds.dart      # fetch JSON via Dio
 │   ├─ adapters/
 │   │   └─ line_json_adapter.dart        # JSON → Entity
 │   ├─ repository/
 │   │   └─ line_repository_impl.dart     # SWR + 24 h TTL cache
 │   └─ timetable_providers.dart          # Riverpod ‘family’ providers
 ├─ domain/
 │   ├─ entities/                         # model from the Mermaid diagram
 │   ├─ services/
 │   │   ├─ pattern_resolver.dart
 │   │   ├─ timetable_query.dart
 │   │   ├─ arrival_calculator.dart
 │   │   └─ widget_provider.dart
 │   └─ value_objects.dart
 ├─ application/
 │   ├─ controllers/
 │   │   └─ schedule_controller.dart      # AsyncNotifier <TimetableState>
 │   └─ bg_tasks/
 │       └─ bus_schedule_sync_task.dart   # uniqueId: bus_schedule.sync
 └─ presentation/
     ├─ pages/
     │   └─ timetable_page.dart           # receives lineId & direction
     ├─ widgets/
     │   ├─ next_departures_list.dart
     │   ├─ departure_tile.dart
     │   └─ empty_banner.dart             # “No Service” pattern
     └─ home_widget/
         └─ departure_widget_provider.dart
```

---

## 2. Data Layer Rules

1. **Remote fetch**: `NetworkClientProvider(NetworkTarget.timetable)` (JSON only).
2. **Cache key**: `cache.timetable.<lineId>.json`; **TTL = 24 h** (see ADR-0002 storage)
3. **SWR** strategy: serve stale data instantly, then `refetch()` in background; on parse failure keep old cache + log.
4. Map all `DioException` via core interceptors so that only `AppException` bubbles up .

---

## 3. Domain Layer

Replicate the diagram exactly (Campus, Line, Direction, Diagram, Departure, ElapsedTime, enums).

* Helpers:

  * `PatternResolver` decides today’s `DiagramId` by reading Remote Config for BUS or holiday API for TRAIN.
  * `TimetableQuery` returns *n* future `DepartureDTO`s (default 3).
  * `ArrivalCalculator` adds `elapsed.normal | via` when mode == BUS.
  * `WidgetProvider` returns the single nearest departure for the home widget.

All domain classes are **Freezed**; no Flutter imports.

---

## 4. Application Layer

* **State**: `TimetableState` = `{ List<DepartureDTO> items, bool loading, AppException? error }`.
* **Controller**: `ScheduleController(lineId, direction)` reads repository, calls `TimetableQuery`, handles errors via `errorNotifierProvider` .
* **Background task**: `bus_schedule.sync`

  * Runs every 6 h, network-required.
  * Retries with exponential back-off for `NetworkFailure.server()` only .

---

## 5. Presentation Layer

* **timetable\_page** displays:

  * Large card for “nearest” ride.
  * List of the next two after that.
  * Chips to switch *Line* / *Direction* / *Campus*.
* **Empty state banners**: “Service Holiday” when `PatternResolver` returns `NoService`.
* **Colors & typography**: pull from `PasspalThemeExt` only—never hard-code .
* **Deep link**: `/main/bus?line={id}&dir=forward`.

---

## 6. Config & Flags

Read Remote Config once through `configServiceProvider` .
Keys:

* `FEATURE_BUS_WIDGET` – if false, hide home-widget registration.
* `BUS_SPECIAL_DIAGRAM_URL` – override calendar JSON when present.

---

## 7. Tests

* **Domain**: PatternResolver (weekday vs holiday), arrival time math.
* **Data**: repository caching & SWR.
* **Application**: controller happy-path + error.
* **Presentation**: golden of timetable\_page (nearest highlighted).
* **BG task**: verify retry policy.

---

## 8. Error Handling

Throw only `AppException` subclasses; UI listens to `errorNotifierProvider` for overlay .
Parsing bugs trigger `ParseFailure` → logged, old cache kept, banner shown.

---

## 9. Coding Checklist

* No feature-to-feature imports.
* Providers live in `application/` or `data/…/providers.dart`.
* Use `@riverpod` generator everywhere.
* All diagram IDs/enums go through `const` extensions for readability.
* Follow the ADR-0008 config priority Remote Config > .env .
