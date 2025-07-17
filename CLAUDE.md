# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## App Overview

- Name: ぱすぱる (PassPal)
- Target: Chukyo University students (Nagoya/Toyota campus)
- Platform: Android & iOS (Flutter, single codebase)
- Core Features: Assignment tracking/notifications, attendance, today's timetable widget, campus bus/train schedule, ALBO/MaNaBo news, offline material viewing
- Language: Japanese only

## Goals

1. Portal Integration: Aggregate data from MaNaBo, ALBO, Cubics into one screen; minimize logins/navigation.
2. Learning Support: Push notify assignment add/delete/deadline; prevent missed tasks.
3. Optimize Actions: Sync campus-specific timetables & transport; reduce lateness/absences.
4. Security & UX: Seamless auth (Shibboleth SSO + Google SSO); credentials in device secure storage.

## Architecture

### Layering (Clean Architecture)

- Data Dio wrapper abstracts HTTP/cookie/session; split fetch/parsing/DTO.
- Domain: Only depend on data interfaces; hold pure logic (assignment diff/notification).
- UI: State via Riverpod Provider; optimize rebuilds & testability.

### Directory Structure

  ```
lib/
  ├─ core/            // Shared modules
  └─ features/
      ├─ timetable/
      │   ├─ data/
      │   ├─ domain/
      │   ├─ application/
      │   └─ presentation/
      ├─ assignments/
      ...
```

- Direction: data → domain → application → presentation (one-way only)
- Each feature owns its own 4 layers (feature-first + layered)
- No reverse dependencies; follow Clean Architecture Dependency Rule.

### Dependency Injection & Testing

- Use Riverpod as DI root. Mock by `ProviderContainer(overrides: ...)`
- TDD required: unit/widget/integration tests using Flutter standard frameworks
- HTML parsers must be tested with real sample HTML for spec-change resilience.

### Notification UX & Error Handling

- Onboarding: explain "deadline reminders", then show OS permission dialog.
- If denied, use non-blocking banner for re-request (deferred permission pattern).
- On portal 503/offline: show overlay error component (retry/FAQ), never infinite spinner.

### Coding Conventions

- File: `snake_case.dart`
- Class: `PascalCase`
- Provider: `<Noun>Provider`
- Use `freezed` for immutable classes & sealed unions.
- Only one public class per file.

### Adding Packages

- Always add dependencies via `flutter pub add <package_name>`.
- **Never** edit `pubspec.yaml` by hand.

---


## Development Commands

### Core Flutter Commands
```bash
# Clean build cache
flutter clean

# Get dependencies
flutter pub get

# Run code generation
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Code Quality
```bash
# Run static analysis
dart fix --apply && flutter analyze

# Run tests
flutter test
```

## Architecture

### Project Structure
- lib/core/: Core architecture modules (auth, network, storage, etc.)
- lib/features/: Feature-specific modules
- lib/firebase_options.dart: Firebase configuration
- test/fixtures/: Test data including MaNaBo, ALBO, CUBICS

### Key Technologies
- State Management: Riverpod with code generation
- Data Classes: Freezed for immutable models
- Networking: Dio HTTP client with cookie management
- Local Storage: SQLite (sqflite) + secure storage
- Authentication: Firebase Auth with Google Sign-In
- Background Processing: WorkManager and background fetch

### Architecture Patterns
- Clean Architecture with core/features separation
- Dependency injection via Riverpod
- Immutable data classes with Freezed
- Functional programming patterns with Dartz
- Repository pattern for data access

## Problem-Solving Approach
- Leverage thinking capabilities for complex multi-step reasoning
- Focus on understanding problem requirements rather than just passing tests
- Use test-driven development

## Code Generation

This project uses extensive code generation. After making changes to files with:
- `@freezed` annotations
- `@riverpod` annotations
- `@JsonSerializable` classes

Run: `flutter packages pub run build_runner build --delete-conflicting-outputs`

## Firebase Integration

Firebase services configured:
- Analytics
- Authentication
- Messaging (FCM)
- Crashlytics
- Remote Config

Project ID: `passpal-c55ac`

## Testing

Test fixtures include data from Japanese educational systems (Manabo, CUBICS). When adding tests:
- Use existing fixtures in `test/fixtures/data/`
- Mock HTTP responses with `http_mock_adapter`
- Use `mockito` or `mocktail` for unit test mocking

## Platform Targets

- Android: Min SDK 23, Target SDK 35
- iOS: Standard iOS deployment target
- Languages: Dart with Japanese language support

## Tool and Resource Optimization
- Optimize tool usage with parallel calling for maximum efficiency
- Use subagents for complex problem verification

## Development Rules

- Every `core` folder must include `providers.dart`.
- When creating or updating `core`, always add a README in the core folder with usage examples from the feature side.
- Expose all `core` modules via Riverpod DI so features can use them.
- For OS-dependent (iOS/Android) features, first check for existing wrapper packages. Only write native code if no package exists.
- Follow **KISS**: prioritize maintainability and simplicity.
- Always Think in English, but respond in Japanese.

## Development Notes

- No main.dart file exists yet - needs to be created
- CI/CD pipeline configured with GitHub Actions for Flutter 3.32.4
- Personal data in test fixtures is gitignored for security
- IDE configured for Japanese language support (spell check)
