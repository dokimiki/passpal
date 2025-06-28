---
applyTo: "lib/features/timetable/**"
---

# Timetable Feature – Implementation Rules

## 0. Folder Skeleton

```
lib/features/timetable/
 ├─ data/
 │   ├─ datasources/            # one file per endpoint group
 │   │   ├─ cubics_timetable_remote_ds.dart
 │   │   ├─ manabo_timetable_remote_ds.dart
 │   │   ├─ manabo_class_remote_ds.dart        # directories / news / syllabus / contents
 │   │   └─ manabo_attendance_remote_ds.dart   # entry-exist / window / register
 │   ├─ models/                 # DTO only (Freezed + json_serializable)
 │   ├─ repositories/
 │   │   ├─ timetable_repository_impl.dart
 │   │   └─ attendance_repository_impl.dart
 │   └─ cache/                  # Sqflite table + DAO, keyed by term & campus
 │
 ├─ domain/
 │   ├─ entities/
 │   │   ├─ timetable_slot.dart     # period, weekday, courseRef
 │   │   ├─ course.dart             # id, title, teacher, room, manaboClassId
 │   │   ├─ course_material.dart    # directory / content / news
 │   │   ├─ syllabus.dart
 │   │   └─ attendance_state.dart   # enum: none|open|submitted(success|fail)
 │   ├─ value_objects/
 │   │   └─ term.dart
 │   └─ usecases/
 │       ├─ fetch_timetable_uc.dart
 │       ├─ refresh_timetable_uc.dart
 │       ├─ fetch_course_detail_uc.dart
 │       ├─ monitor_attendance_uc.dart
 │       └─ submit_attendance_uc.dart
 │
 ├─ application/
 │   ├─ timetable_controller.dart       # AsyncNotifier<List<TimetableSlot>>
 │   ├─ course_detail_controller.dart   # family-notifier by courseId
 │   ├─ attendance_controller.dart      # controls entry polling
 │   └─ providers.dart                  # exposes the above
 │
 └─ presentation/
     ├─ pages/
     │   ├─ timetable_page.dart
     │   ├─ course_detail_page.dart
     │   └─ materials_page.dart
     ├─ widgets/
     │   ├─ timetable_grid.dart
     │   ├─ course_card.dart
     │   └─ attendance_banner.dart
     └─ navigation.dart                 # typed helpers (pushCourseDetail...)
```

> **Sub-feature note**
> The `course_detail/` sub-folders previously discussed are now flattened under `timetable` for simplicity; if it grows, extract later using the same 4-layer structure.

---

## 1. Endpoint → Datasource Mapping

| Endpoint (↑ requirement)                    | RemoteDatasource.method                                      | HTTP details                                   |
| ------------------------------------------- | ------------------------------------------------------------ | ---------------------------------------------- |
| Cubics Timetable                            | `CubicsTimetableRemoteDs.fetchRooms()`                       | GET `NetworkTarget.cubics` path from ADR-0009  |
| MaNaBo Timetable                            | `ManaboTimetableRemoteDs.fetchSlots()`                       | POST form `action=glexa_ajax_timetable_view`   |
| Class Directory / News / Syllabus / Content | `ManaboClassRemoteDs.fetchDirectory/news/syllabus/content()` | POST form with `class_id` etc.                 |
| Quiz Result                                 | `ManaboClassRemoteDs.fetchQuizResult()`                      | GET                                            |
| Attendance\*                                | `ManaboAttendanceRemoteDs.*` *(see next section)*            | mix GET/POST                                   |

### Attendance flow

1. **Check if entry exists**
   POST `/ action=glexa_modal_entry_form` → returns JSON (`entry_exist`, `entry_none`).
2. **Open window** *(HTML)* – ignore for business: just needed for cookie seed.
3. **Submit**

   * plain → `entry_form_accept&uniqid=…`
   * password → same + `code=xxx`
4. **Map** to `AttendanceState` (`none/open/success/fail`).

Datasource must parse both HTML and JSON; provide **test fixtures** under `test_resources/` for CI parsing tests.

---

## 2. Repository Contracts

```dart
abstract class TimetableRepository {
  Future<List<TimetableSlot>> getTimetable(Term term, {bool forceRefresh = false});
  Future<CourseDetail> getCourseDetail(int manaboClassId);
}

abstract class AttendanceRepository {
  /// returns current attendance state (poll every 30 s while page visible)
  Future<AttendanceState> checkState(int classId);
  Future<AttendanceState> submit(int classId, {String? password});
}
```

*Repositories must*

* use `networkClientProvider` with correct `NetworkTarget`&#x20;
* implement **SWR** cache: valid ≤ 24 h for timetable, ≤ 1 h for course detail.&#x20;
* throw `AppException` on network / parse errors.&#x20;

---

## 3. Background & Polling

* Register a unique task `timetable.refresh` to refresh all terms ↓ every 6 h (`backgroundSchedulerProvider`).&#x20;
* While **CourseDetailPage** is in foreground, start a `Timer.periodic(30 s)` that calls `attendanceController.poll()`; cancel on `dispose`.
* Honour Remote Config keys:

  * `timetable_refresh_interval_h` (default 6)
  * `attendance_poll_sec` (default 30)&#x20;

---

## 4. Providers

```dart
final timetableControllerProvider =
    AsyncNotifierProvider<TimetableController, List<TimetableSlot>>(...);

final courseDetailControllerProvider =
    FamilyAsyncNotifierProvider<CourseDetailController, CourseDetail, int>(...);

final attendanceControllerProvider =
    FamilyNotifierProvider<AttendanceController, AttendanceState, int>(...);
```

> **Never** read repositories directly in UI; use the controllers only.

---

## 5. UI Rules

* `TimetableGrid` must align cells via `SliverGrid` and color tokens from `PasspalThemeExt` (no magic colors).&#x20;
* Show **pull-to-refresh** calling `controller.refresh(forceRefresh: true)`.
* If `AttendanceState == open`, display a sticky `AttendanceBanner` with a submit button; on `fail` show `ErrorOverlay`.&#x20;
* Deep-link `/main/timetable/:courseId/detail` handled through `goRouterProvider`.&#x20;

---

## 6. Tests Checklist

| Layer        | Must cover                                                      |
| ------------ | --------------------------------------------------------------- |
| data         | HTML/JSON parsing fixtures for all endpoints                    |
| domain       | Term value-object validation, attendance state transitions      |
| application  | controllers happy-/error-paths with mocked repos                |
| presentation | golden: timetable grid, course detail header, attendance banner |
