---
applyTo: "lib/features/system/**"
---

# PassPal – System Feature Rules

## 0 . Scope

`features/system` owns **“app-self-protection”** UIs only:

| Path            | Purpose             |
| --------------- | ------------------- |
| `/maintenance`  | 全サービス停止時に表示         |
| `/force-update` | 古いアプリをブロック          |
| `/error`        | ルーティング失敗など最終フォールバック |

*No data/domain layers are needed—presentation only.*

The **Force-Update → Maintenance → Auth → Setup** guard chain is defined in core/routing; you just supply the pages .

---

## 1 . Directory Skeleton

```
lib/features/system/
 ├─ maintenance/
 │   └─ presentation/
 │       ├─ maintenance_page.dart
 │       └─ widgets/
 ├─ force_update/
 │   └─ presentation/
 │       ├─ force_update_page.dart
 │       └─ widgets/
 └─ error/
     └─ presentation/
         ├─ error_page.dart
         └─ widgets/
```

*Export each page at feature root so core/routing can `import 'package:passpal/features/system/…'`.*

---

## 2 . Common Page Contract

```dart
class SystemScaffold extends StatelessWidget {
  const SystemScaffold({
    required this.title,
    required this.body,
    this.actions,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<PasspalThemeExt>()!; // tokens :contentReference[oaicite:1]{index=1}
    return Scaffold(
      backgroundColor: theme.surface1,
      appBar: AppBar(title: Text(title)),
      body: SafeArea(child: body),
      persistentFooterButtons: actions,
    );
  }
}
```

* Use **Passpal design tokens** for color/spacing.
* No business logic—providers below feed state.

---

## 3 . Maintenance Page

* Show an illustration + “ただいまメンテナンス中です”。
* Provide **Retry** button → `ref.read(maintenanceFlagProvider).refresh()`.
* If retry succeeds (flag == false) push `context.go('/')`.

Source of truth is `maintenanceFlagProvider` already set by `MaintenanceInterceptor` .

---

## 4 . Force-Update Page

* Compare `packageInfo.version` with `remoteConfig.minSupportedVersion` (`force_update_min_version` key) .
* Show “最新バージョンへアップデートしてください” + **Update** CTA that launches store URL via `url_launcher`.
* **Close** button is hidden; this screen must be modal until version ≥ min.

---

## 5 . Error Page

* Accept `ErrorPageData` (passed via `extra` from `GoRouter`) and display:

  * Title (default “エラーが発生しました”)
  * `exception.message` if present.
* Optionally show **Try again** button that pops or `context.go('/')`.
* Do **not** swallow `UnknownException`; ErrorOverlay still shows on top when guard chain is bypassed .

---

## 6 . Routing Glue

Core already registers routes; just export pages:

```dart
export 'maintenance/presentation/maintenance_page.dart';
export 'force_update/presentation/force_update_page.dart';
export 'error/presentation/error_page.dart';
```

---

## 7 . Providers You May Read

| Use-case         | Provider                             |
| ---------------- | ------------------------------------ |
| Remote config    | `remoteConfigProvider`               |
| Maintenance flag | `maintenanceFlagProvider` (bool)     |
| Error overlay    | `errorNotifierProvider`              |
| Package version  | `packageInfoProvider` (in core/util) |

*Never* mutate global state here.

---

## 8 . Testing Checklist

1. **Widget golden** for each page (light/dark).
2. **Routing**: supply fake guards; assert correct page when flags active.
3. **Accessibility**: `SemanticsTester` to ensure labels present.
4. **Deep-link fallback**: `/error` shows when `RouteParsingException` extra supplied.

---

## 9 . Style Rules Recap

* Material 3 + tokens; no ad-hoc colors/fonts.
* Keep layout responsive: `LayoutBuilder` for narrow width.
* Avoid `setState`; pages are stateless or `ConsumerWidget`.
* All buttons use elevated style unless link-style needed.

---

## 10 . Acceptance Definition

* With maintenance flag true, app redirects to `/maintenance` and **Retry** clears screen when flag resets.
* When version < min, `/force-update` blocks navigation until updated.
* Any unhandled route error shows `/error` with message.
* No console warnings; all tests pass.

---

Follow this doc strictly; any pull request that deviates (e.g., business logic in pages or missing tokens) must be rejected during review.
