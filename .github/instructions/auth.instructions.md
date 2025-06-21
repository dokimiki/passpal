---
applyTo: "lib/features/auth/**"
---

# GitHub Copilot Instructions – **Auth Feature**

> **Read me first**: Every time you generate or refactor authentication code, follow the rules in _this_ file **and** the root‑level `general.instructions.md`. Keep prompts short, specific, and context‑rich so Copilot can infer maximum detail.

---

## 0. Scope & Goals

-   Implement secure, test‑driven **SSO + Firebase auth** for the _ぱすぱる_ app.
-   Handle two parallel identity domains:

    1. **University Shibboleth IdP** (HTML form → session cookies)
    2. **Google Sign‑In via FirebaseAuth** (org account `@m.chukyo-u.ac.jp`).

-   Ensure the _same_ username is used in both domains; surface mismatch to the user.
-   Store campus ID / password only in encrypted secure storage.
-   Auto‑refresh sessions; gracefully recover on 401/403/503.

---

## 1. Folder & File Naming

```
lib/
 └─ features/
     └─ auth/
         ├─ data/
         │   ├─ datasources/
         │   │   ├─ auth_remote_ds.dart       // Dio + cookie_jar + HTML form
         │   │   └─ google_remote_ds.dart     // FirebaseAuth + GoogleSignIn
         │   ├─ dto/
         │   │   └─ login_response_dto.dart
         │   ├─ models/
         │   │   └─ session_model.dart        // tokens, cookies, expiry
         │   └─ repository_impl/
         │       └─ auth_repository_impl.dart
         ├─ domain/
         │   ├─ entities/
         │   │   └─ session.dart
         │   ├─ repositories/
         │   │   └─ auth_repository.dart
         │   └─ usecases/
         │       ├─ sign_in_uc.dart
         │       ├─ auto_refresh_uc.dart
         │       └─ sign_out_uc.dart
         ├─ application/
         │   └─ providers/
         │       ├─ auth_notifier.dart        // StateNotifier<AsyncValue<Session?>>
         │       └─ auth_provider.dart        // Riverpod facade
         └─ presentation/
             ├─ pages/login_page.dart
             ├─ pages/account_mismatch_dialog.dart
             └─ widgets/login_button.dart
```

-   **Pattern**: `<layer>/<role>/<feature>_<suffix>.dart`.
-   One public class per file. Prefer immutable DTOs with `freezed` + `json_serializable`.

---

## 2. Data Layer Guidance

1. **HTTP client**: Use **Dio 6** with:

    - `CookieManager(PersistCookieJar())` for session cookies.
    - `RetryInterceptor` – exponential back‑off on **503**.
2. **Secure storage**: Persist ID/PW with `flutter_secure_storage` (AES+RSA) and optional extra AES via `encrypt` pkg if needed.
3. **Auth HTML form**: Submit credentials to IdP, follow redirects, extract `Set‑Cookie` headers into cookie jar.
4. **Interceptor for 401/403**:

    - On first 401/403, call `signInUc.autoRefresh()` once.
    - If refresh fails, throw `AuthenticationException()`.

5. **FirebaseAuth**: Use `signInWithGoogle()`; verify email domain ends with `m.chukyo-u.ac.jp`.

---

## 3. Domain Layer

-   **Entity `Session`**

    -   `userId`, `expiresAt`, `cookies`, `firebaseIdToken`.

-   **Repository contract**

    ```dart
    abstract class AuthRepository {
      Future<Session> signIn({required String id, required String password});
      Future<Session?> reAuthenticateIfNeeded();
      Future<void> signOut();
    }
    ```

-   Keep pure Dart (no Flutter imports). Use `Either<Failure,T>` or exceptions.

---

## 4. Application Layer (Riverpod)

-   **Notifier**: `AuthNotifier extends AsyncNotifier<Session?>`.

    -   `signIn()`, `signOut()`, `ensureFreshSession()` methods.

-   **Global Provider**: `final authProvider = NotifierProvider<AuthNotifier, AsyncValue<Session?>>(...);`.
-   **Background refresh**: Expose `autoLoginTask()` callable by WorkManager/BGTask scheduler.

---

## 5. Presentation Layer

-   `LoginPage` reacts to `authProvider` state:

    -   `loading` ⇒ show progress.
    -   `error(AuthenticationException)` ⇒ route to LoginPage.
    -   `error(AccountMismatchException)` ⇒ show `AccountMismatchDialog`.

-   Do **not** navigate inside providers; UI layer listens & routes.

---

## 6. Testing Strategy

| Level       | What to test                                | Tools                                     |
| ----------- | ------------------------------------------- | ----------------------------------------- |
| Unit        | Repository impl parses cookies, handles 503 | `mockito`, `http_mock_adapter`, `test` 🚀 |
| Unit        | Dio `RetryInterceptor` logic                | See Medium guide                          |
| Domain      | `signInUc` happy / error paths              | pure Dart tests                           |
| Widget      | `LoginPage` reacts to provider states       | `flutter_test`, `riverpod_test`           |
| Integration | Full login flow against staging IdP         | `integration_test`                        |

---

## 7. Security Checklist

-   [x] Wipe credentials on sign‑out or re‑auth failure.
-   [x] Encrypt cookies/HTML cache using `flutter_secure_storage` (+ AES).
-   [x] Mismatch of Google account & campus ID triggers forced logout.

---

## 8. Copilot Prompt Patterns

```text
// GOOD (specific)
"Create Dio RetryInterceptor in lib/features/auth/data/network/retry_interceptor.dart that retries on 503 with exponential backoff & jitter, unit‑test friendly"

// BAD (vague)
"Create auth interceptor"
```

-   Always specify **folder path, file name, class name, purpose, constraints**.
-   Use imperative verbs (“Create”, “Refactor”, “Generate tests for…”).
-   End prompts with “add null‑safety and docs”.

---

## 9. TODO Scaffolds for Copilot

When starting a new file, include:

```dart
// TODO(copilot): implement signIn form submission with cookie extraction.
```

Copilot will expand the TODO into workable code chunks.

---

## 10. References (inline citation IDs)

1. Secure storage AES sample
2. Dio 401 retry pattern
3. Riverpod auth state advice
4. Google Sign‑In tutorial
5. Shibboleth IdP plugin docs
6. Clean architecture auth repo discussion
7. Testing interceptors guide
8. flutter_secure_storage API
9. Dio 401 refresh token article .
10. Riverpod auth YouTube tutorial .
11. Firebase Auth masterclass .
