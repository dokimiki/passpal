## Core Rules

* When creating or updating `core`, always add a README in the core folder with usage examples from the feature side.
* Expose all core modules via Riverpod DI so features can use them.
* For OS-dependent (iOS/Android) features, first check for existing wrapper packages. Only write native code if no package exists.
* Follow KISS: prioritize maintainability and simplicity.
* Every `core` folder must include `providers.dart`.
* Organize source code into appropriate folders.
