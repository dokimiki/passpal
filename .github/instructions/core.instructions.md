---
applyTo: "lib/core/**"
---

## Rules

-   Each ADR **must include usage examples from Feature layer**.
-   **Inject all dependencies via Riverpod** and expose to Feature layer.
-   For **OS-specific (iOS/Android) features**, first check for existing packages that wrap both platforms.
    If none found, implement native code.
-   **When adding a package**, always check and confirm support for **both iOS and Android**.
