---
applyTo: "lib/core/network/**"
---

# 🛠️ Passpal Network Facade (core/network) — Instruction for GitHub Copilot

## Overview

-   **Goal**: Provide a unified HTTP facade over MaNaBo, ALBO, Cubics portals and palapi, hiding infra details.
-   **Key Features**:
    -   Auto‑attach/update cookies and auth tokens
    -   Exponential‑backoff + jitter retries
    -   Detect planned 503 maintenance
    -   Circuit‑break on offline
    -   Debug cURL logging
        All implemented via a chained Interceptor pattern.
-   **Assumption**: SSO cookies expire after 1 h. Re‑login handled in `core/auth`; `core/network` only notifies via TTL expiration.

---

## Domain Model

| Concept               | Notes                                                                         |
| --------------------- | ----------------------------------------------------------------------------- |
| **Shibboleth SSO**    | Two IdP cookies stored. Inactivity or TTL (30 min / 1 h) invalidates session. |
| **palapi auth**       | Send Firebase ID Token in `Authorization: Bearer <jwt>`.                      |
| **Maintenance**       | 503 response with “maintenance” text in HTML/JSON triggers maintenance flow.  |
| **Network detection** | Uses `connectivity_plus` for immediate offline shortcut.                      |

---

## Scope: Inclusions & Exclusions

### ✅ Included

1. **Dio setup** — Create instance per `target` (`albo`, `manabo`, `cubics`, `sso`, `palapi`) with ordered interceptors.
2. **Session/token management** — Attach cookie/Bearer and detect expiry. On expiry, call `AuthFacade.refresh()` and retry once.
3. **Resilience** — Retry idempotent requests up to 3 times using exponential backoff (base=0.5 s, factor=2, jitter ±30%).
4. **Error normalization** — Map `DioException` to `NetworkFailure` and forward to `core/error`.
5. **Dev logging** — Only in debug mode: log cURL via `dio_curl_interceptor`.

### ❌ Excluded

-   Parsing HTML/JSON into DTOs (handled under `features/**/data`)
-   Cache persistence (handled in `core/storage`)
-   UI-level error display (handled by `core/error` + presentation)

---

## Components & Responsibilities

| #   | Class / Interceptor         | Responsibilities                                           | Dependencies           |
| --- | --------------------------- | ---------------------------------------------------------- | ---------------------- |
| 1   | **NetworkClientFactory**    | Return pre‑configured Dio for each target                  | none                   |
| 2   | **AuthInterceptor**         | Attach auth, detect 401, call `AuthFacade.refresh()`       | `core/auth`            |
| 3   | **ConnectivityInterceptor** | Throw `NetworkFailure.offline()` immediately when offline  | `connectivity_plus`    |
| 4   | **RetryInterceptor**        | Retry idempotent requests with backoff + jitter            | `dart:math`            |
| 5   | **MaintenanceInterceptor**  | Convert 503 + "maintenance" text to `MaintenanceException` | none                   |
| 6   | **LoggingInterceptor**      | Emit cURL logs, debug only                                 | `dio_curl_interceptor` |
| 7   | **Provider**                | Expose `networkClientProvider(target)` as lazy singleton   | `riverpod`             |

> **Interceptor chain order**:  
> `Connectivity → Auth → Retry → Maintenance → Logging`  
> Ensures offline filtering, then auth attach, retry decisions, maintenance detection, then logging.

---

## Auth / Re‑login Flow

````mermaid
sequenceDiagram
  participant Repo
  participant Dio as NetworkClient
  participant AuthI as AuthInterceptor
  participant AuthF as AuthFacade

  Repo->>Dio: GET /assignments (target=albo)
  Dio->>AuthI: onRequest → attach cookies
  Dio-->Repo: 401 or HTML login page
  Dio->>AuthI: onError → call AuthFacade.refresh()
  AuthF-->>AuthI: new token/cookies or error
  AuthI-->Dio: repeat request (only once)

* If retry fails again → emit `AuthenticationException` to `core/error`.
* `core/background` job uses the same logic; on fail, job ends with **GiveUp**.

---

## Error Mapping

| HTTP Status  | Mapped Exception          | Retry?           | Layer Impact             |
| ------------ | ------------------------- | ---------------- | ------------------------ |
| 401 (palapi) | `AuthenticationException` | ❌ (only 1 retry) | error                    |
| 429          | pass through              | ❌                | feature layer to handle  |
| 503          | `MaintenanceException`    | ❌                | routed to maintenance UI |
| 5xx (other)  | `NetworkFailure.server()` | ✅ (3 retries)    | error                    |
| 4xx (client) | `NetworkFailure.http()`   | ❌                | error                    |

---

## Riverpod Provider Example

```dart
final networkClientProvider =
  Provider.family<Dio, NetworkTarget>((ref, target) {
    final factory = ref.watch(networkClientFactoryProvider);
    return factory.create(target);
});

final networkClientFactoryProvider =
  Provider.autoDispose<NetworkClientFactory>((ref) {
    return NetworkClientFactory();
});
````

`autoDispose` lets the Dio instance be GC’d under memory pressure.

---

## CI & Test Strategy

| Test Type       | Focus                                                                             |
| --------------- | --------------------------------------------------------------------------------- |
| **Unit**        | Test each interceptor using fakes (e.g. simulate 503 → `MaintenanceException`)    |
| **Widget**      | Golden tests of routing behavior under forced 503 to maintenance screen           |
| **Integration** | `WorkManager TestDriver` + `core/background` to validate retry and re-login logic |

---

> 💡 Use this as Copilot prompts for implementing `core/network` layer with correct interceptors, retry logic, session management, error mapping, and provider wiring.
