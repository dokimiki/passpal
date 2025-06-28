---
applyTo: "lib/features/login/**"
---

# PassPal — Login Feature Guidelines

## 0. 3-Step Flow & Routes

| Step | Path                | Purpose                                                          | Guard passes when…                             |
| ---- | ------------------- | ---------------------------------------------------------------- | ---------------------------------------------- |
| 1    | `/login/student-id` | Collect student-id (`[a-zA-Z]\d{6}`)                             | Regex OK → `Next`                              |
| 2    | `/login/google`     | Google SSO; email **must equal** `${studentId}@m.chukyo-u.ac.jp` | Firebase user + domain match → `Next`          |
| 3    | `/login/cu-id`      | Enter CU\_ID password (same id) → IdP login                      | `AuthFacade.login()` success → `/setup/campus` |

Routes are already declared in `core/routing` enum; **never hard-code strings** — import `AppRoute.loginStudentId`, etc.&#x20;

Guards (Force-Update → Maintenance → Auth → Setup) are handled globally — you only push/pop.&#x20;

---

## 1. Directory Skeleton

```
lib/features/login/
 ├─ data/                 # none (proxy through core/auth)
 ├─ domain/
 │   └─ student_id.dart   # VO with regex validator
 ├─ application/
 │   ├─ login_form_state.dart
 │   ├─ login_form_notifier.dart
 │   └─ validators.dart
 └─ presentation/
     ├─ student_id_page.dart
     ├─ google_signin_page.dart
     ├─ cu_id_page.dart
     └─ widgets/
         ├─ primary_button.dart
         └─ error_banner.dart
```

---

## 2. State & DI

* **Riverpod** only. Provide one `LoginFormNotifier` (State = `StudentId? id; bool loading; String? errorMsg`).
* Inject core services via providers:

| Need                            | Provider                     |
| ------------------------------- | ---------------------------- |
| Auth API (login, link, refresh) | `authFacadeProvider`         |
| Auth status stream              | `authStateProvider`          |
| Secure credential storage       | `credentialStorageProvider`  |
| Global error overlay            | `errorNotifierProvider`      |
| Router                          | `goRouterProvider`           |

---

## 3. Validation Rules

```dart
class StudentId extends ValueObject<String> {
  static final _reg = RegExp(r'^[a-zA-Z]\d{6}$');
  StudentId(String raw)
      : assert(_reg.hasMatch(raw),
            'Student-ID must match [a-zA-Z]\\d{6}'),
        super(raw.toLowerCase());
}
```

* Email check: `googleUser.email == '${id.value}@m.chukyo-u.ac.jp'`.
  Mismatch → throw `AccountLinkException`.&#x20;

---

## 4. Page Behaviour

### 4.1 `StudentIdPage`

* `TextField` with real-time regex validation; disable “Next” until valid.
* On submit: `ref.read(loginFormNotifierProvider.notifier).setId(id)`, then `context.pushNamed(AppRoute.loginGoogle.name)`.

### 4.2 `GoogleSigninPage`

* Use `firebase_auth` Google provider (no extra scopes).
* After sign-in:

  1. Verify domain; on mismatch call `errorBanner.show()` + `FirebaseAuth.signOut()`.
  2. Cache Firebase ID-token inside `AuthFacade.linkGoogle()`.
  3. `context.pushNamed(AppRoute.loginCuId.name)`.

### 4.3 `CuIdPage`

* `PasswordField` + “Login”.
* Call `authFacade.login(studentId, password)`.

  * Success → `router.goNamed(AppRoute.setupCampus.name)`.
  * `AuthenticationException.invalidCredential()` → inline error.
  * Any other `AppException` → bubble via `errorNotifier`.&#x20;

---

## 5. Error Handling Matrix

| Exception                                   | Show           | Action          |
| ------------------------------------------- | -------------- | --------------- |
| `AuthenticationException.invalidCredential` | Field error    | stay on page    |
| `AccountLinkException`                      | Error banner   | sign-out google |
| `NetworkFailure.offline`                    | Error overlay  | allow retry     |
| `MaintenanceException`                      | guard redirect | no code here    |
| Unknown                                     | overlay        | log + retry     |

Map all Dio/Firebase errors through `AppException` classes first.&#x20;

---

## 6. Theme & UX

* Use seed color + spacing tokens from `core/theme`; **no hard-coded hex**.&#x20;
* PrimaryButton extends Material 3 button; min height 48, radius `RadiusTokens.button`.
* Respect dark / light via `ThemeMode`.

---

## 7. Tests

| Layer        | Test                                                                                                                       |
| ------------ | -------------------------------------------------------------------------------------------------------------------------- |
| domain       | `StudentId` VO validation edge cases                                                                                       |
| application  | `LoginFormNotifier` happy / error paths (use `FakeAuthFacade`)                                                             |
| presentation | Widget tests for each page: keyboard focus, button enablement, routing                                                     |
| integration  | Full flow happy path; ensure authState → Authenticated triggers guard redirect to `/main/home` (mock setupCompleted=true). |

See routing ADR for guard redirection test pattern.&#x20;

---

## 8. Accessibility & i18n

* Label all form fields (`TextField.decoration.labelText`).
* Provide `Semantics` for primary buttons.
* Strings go to `l10n/login_*.arb` (ja only for now).

---

## 9. Done Definition Checklist

* [ ] All pages comply with design tokens.
* [ ] All new providers covered by unit tests (≥ 80%).
* [ ] No imports from other features.
* [ ] No direct Firebase/Dio usage in UI; only through `authFacade`.
* [ ] Guard redirection confirmed by integration test.

---

Stick to this spec; PRs deviating from these rules must be rejected during review.
