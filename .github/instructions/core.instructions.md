---
applyTo: "lib/core/**"
---

## Rules

-   Should write docs/adr in japanese on new features.
-   **All new features must be documented in ADRs** (Architecture Decision Records).
-   Always write tests first, then implement the feature.
-   Each ADR **must include usage examples from Feature layer**.
-   **Inject all dependencies via Riverpod** and expose to Feature layer.
-   For **OS-specific (iOS/Android) features**, first check for existing packages that wrap both platforms.
    If none found, implement native code.
-   **When adding a package**, always check and confirm support for **both iOS and Android**.
- 各 Core 完了時に “例外伝播シナリオ” のテストを追加し、core/error の Crashlytics モックに到達することを確認する。
