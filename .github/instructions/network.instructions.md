---
applyTo: "lib/core/network/**"
---

# Copilot Network Layer Instructions – ぱすぱる

> 🧠 **Purpose**
> These guidelines teach GitHub Copilot how to generate code for the **network core** of the app. Everything here lives under `lib/core/network/` and is shared by every feature‑module.

---

## 1 High‑level Responsibilities

1. **HTTP client configuration** – Build `Dio` instances with: base URL, timeouts, proxy / debug logging flags.
2. **Security** – TLS certificate pinning, HTTPS‑only, cookie encryption.
3. **Session management** – Attach Shibboleth SSO cookies to every request. Auto‑refresh when expired.
4. **Reliability** – Retry 503 & network errors with jittered exponential back‑off; short‑circuit on 4xx (except 429).
5. **Error translation** – Map `DioError` → `NetworkFailure` sealed class for domain layer.
6. **Offline & maintenance** – Detect lack of connectivity or scheduled portal downtime and surface `MaintenanceException`.

## 2 Packages to Use

```yaml
# pubspec.yaml (excerpt)
dependencies:
    dio: ^5.4.0
    dio_cookie_manager: ^3.0.0
    cookie_jar: ^4.0.0
    http_certificate_pinning: ^2.1.0
    flutter_secure_storage: ^9.0.0
    connectivity_plus: ^5.0.2
    riverpod: ^3.0.0
    firebase_remote_config: ^5.0.0
    retry: ^3.1.0 # for back‑off logic
```

> **Copilot rule:** never import `dart:io` in platform code; use plugins above.

## 3 Folder & File Naming

```
lib/core/network/
 ├─ dio_factory.dart          # builds configured Dio
 ├─ interceptors/
 │    ├─ auth_interceptor.dart
 │    ├─ retry_interceptor.dart
 │    ├─ logging_interceptor.dart (debug only)
 │    └─ connectivity_interceptor.dart
 ├─ certs/
 │    └─ known_fingerprints.json  # updated through RemoteConfig
 ├─ models/network_failure.dart   # sealed result types
 └─ provider/network_provider.dart # Riverpod global
```

## 4 Implementation Guidelines

### 4.1 DioFactory

-   Expose `Dio create({required Portal portal})` where `Portal` is an enum (`albo`, `manabo`, `sso`).
-   Read **baseURL** & **timeout** from `RemoteConfig` with local fallback.
-   Attach **CookieManager** using `PersistCookieJar`, directory at `path_provider.getApplicationDocumentsDirectory()/cookies/`.
-   **Pin TLS** via `HttpCertificatePinning.check()` in a custom `PinningInterceptor` executed before network handshake.
-   Set `followRedirects: false` – we handle 302 manually for SSO.

### 4.2 AuthInterceptor

-   On every request, inject `Cookie` header with `ShibbolethSession` tokens from `PersistCookieJar`.
-   On **401|403**:

    1. Call `AuthRepository.refreshSession()` using a **secondary Dio** (no AuthInterceptor) to hit the SSO login form.
    2. If refresh succeeds → replay original request.
    3. On second failure → throw `AuthExpiredException`, bubble to UI for forced re‑login.

### 4.3 RetryInterceptor

-   Trigger only on `DioExceptionType.connectionTimeout` or HTTP **503|429**.
-   Use [`retry`](https://pub.dev/packages/retry) package with: `maxAttempts = 5`, `delayFactor = 1s`, `maxDelay = 32s`, **jitter = 50%**.
-   Abort retries when battery saver is active (`PowerMode.broadcastStream`).

### 4.4 ConnectivityInterceptor

-   Before each request: `await Connectivity().checkConnectivity()`.
-   If `none` → throw `NoConnectionException` immediately.

### 4.5 Logging

-   Only enabled in **‒‒dart‑define=flavor=dev** builds.
-   Use `PrettyDioLogger` with masked headers for `Cookie`, `Set‑Cookie`, `Authorization`.

### 4.6 Error Mapping

```dart
sealed class NetworkFailure {
  const NetworkFailure();
}
class NetworkTimeout extends NetworkFailure {}
class MaintenanceFailure extends NetworkFailure {}
class AuthExpiredFailure extends NetworkFailure {}
class NoConnectionFailure extends NetworkFailure {}
```

-   Extend if feature teams need specific cases.
-   Convert inside `FailureMapper.onError(DioError e)`.

## 5 Security Rules

1. **TLS pinning** uses _two_ fingerprints (active + backup). Update fingerprints via RemoteConfig; fallback to bundled copy.
2. **Cookies** & other session data are **AES‑256 encrypted** inside `PersistCookieJar` using a key from `flutter_secure_storage`.
3. **No HTTP** – fail fast if `scheme != https`.
4. **Certificate rotation** – At app start, download new fingerprints; apply on next launch to avoid bricking.

## 6 Testing (+ CI)

-   **Unit tests** – Mock `DioAdapter` to verify retry/backoff, header injection, pin validation.
-   **Integration** – Use [`http_mock_adapter`](https://pub.dev/packages/http_mock_adapter) with fixture HTML/JSON.
-   GitHub Actions runs `flutter test --coverage`. Reject PRs under 90 % line coverage for `core/network/`.

## 7 Copilot Prompt Patterns

| Goal                      | Prefix Copilot with…                                    |
| ------------------------- | ------------------------------------------------------- |
| Add new interceptor       | `/// Generate a Dio interceptor that …`                 |
| Call secured endpoint     | `final dio = ref.watch(networkProvider(Portal.albo));`  |
| Write unit test for retry | `test('should retry on 503 with backoff', () async { …` |
| Map DioError → Failure    | `switch (e.type) { …`                                   |

> ✨ **Always:** Write null‑safe Dart, keep files < 300 LOC, add doc comments, respect package constraints.
