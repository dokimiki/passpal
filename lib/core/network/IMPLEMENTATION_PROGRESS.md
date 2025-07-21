# Network Core Module - Implementation Progress

## Overview

The Network core module provides unified HTTP communication for all external services (palapi, ALBO, MaNaBo, Cubics, SSO) with transparent authentication, error handling, caching, retry logic, and offline support.

## Dependencies

### Core Module Dependencies
- `core/config` - API endpoint configuration and service settings
- `core/auth` - Authentication tokens and session management  
- `core/storage` - Cache storage interface for HTTP response caching
- `core/error` - Error handling and reporting infrastructure

### External Package Dependencies
- `dio: ^5.8.0+1` - HTTP client (✅ Available)
- `cookie_jar: ^4.0.8` - Cookie management (✅ Available)
- `dio_cookie_manager: ^3.2.0` - Dio cookie integration (✅ Available)
- `html: ^0.15.6` - HTML parsing for portal services (✅ Available)
- `connectivity_plus` - Network connectivity monitoring (✅ Available)

## Implementation Issues

### Phase 1: Foundation (Issues #1-4)

#### Issue #1: Add Missing Dependencies and Core Models
**Scope**: Add connectivity_plus package and create foundational models  
**Files**: 
- `pubspec.yaml` (add connectivity_plus)
- `lib/core/network/models/cache_strategy.dart`
- `lib/core/network/models/network_config.dart`
- `lib/core/network/models/request_options.dart`
- `lib/core/network/models/network_exceptions.dart`

**Tasks**:
- [ ] Add `connectivity_plus` dependency via `flutter pub add connectivity_plus`
- [ ] Create `CacheStrategy` enum (networkFirst, cacheFirst, networkOnly, cacheOnly)
- [ ] Create `NetworkConfig` model for service-specific configurations
- [ ] Create `RequestOptions` model for per-request settings
- [ ] Create `NetworkException` classes extending AppError

**Dependencies**: None  
**Estimated Size**: Small PR (~200 lines)

---

#### Issue #2: NetworkClient Interface and Abstractions
**Scope**: Define core NetworkClient interface and service type abstractions  
**Files**:
- `lib/core/network/interfaces/network_client_interface.dart`
- `lib/core/network/models/service_type.dart`
- `lib/core/network/models/response_wrapper.dart`

**Tasks**:
- [ ] Create `NetworkClientInterface` with standard HTTP methods (get, post, put, delete)
- [ ] Define `ServiceType` enum (palapi, albo, manabo, cubics, sso, publicApi)
- [ ] Create `ResponseWrapper<T>` for unified response handling
- [ ] Include cache strategy parameter support in interface methods

**Dependencies**: Issue #1  
**Estimated Size**: Small PR (~150 lines)

---

#### Issue #3: Network Monitoring Infrastructure
**Scope**: Implement network connectivity monitoring  
**Files**:
- `lib/core/network/services/connectivity_monitor.dart`
- `lib/core/network/models/connectivity_status.dart`

**Tasks**:
- [ ] Create `ConnectivityMonitor` service using connectivity_plus
- [ ] Define `ConnectivityStatus` model (wifi, cellular, ethernet, offline)
- [ ] Implement `isOnline` getter and connectivity stream
- [ ] Add connectivity status change logging

**Dependencies**: Issue #1  
**Estimated Size**: Small PR (~100 lines)

---

#### Issue #4: Base Dio Configuration and Factory
**Scope**: Create base Dio configuration and factory for different services  
**Files**:
- `lib/core/network/services/dio_factory.dart`
- `lib/core/network/config/dio_config.dart`

**Tasks**:
- [ ] Create `DioFactory` for creating configured Dio instances per service
- [ ] Define base configurations (timeouts, headers, response types)
- [ ] Add debug logging interceptor configuration
- [ ] Include service-specific base URL and timeout settings

**Dependencies**: Issues #1, #2  
**Estimated Size**: Small PR (~200 lines)

---

### Phase 2: Interceptors (Issues #5-8)

#### Issue #5: Error Handling Interceptor
**Scope**: Convert DioException to AppError with unified error handling  
**Files**:
- `lib/core/network/interceptors/error_interceptor.dart`
- `lib/core/network/models/network_error_types.dart`

**Tasks**:
- [ ] Create `ErrorInterceptor` extending Dio Interceptor
- [ ] Map DioException types to specific AppError subclasses
- [ ] Handle HTTP status codes (401, 403, 429, 500s, 503)
- [ ] Integrate with error core module for error reporting
- [ ] Add network error type categorization

**Dependencies**: Issues #1, #2, #4  
**Estimated Size**: Medium PR (~300 lines)

---

#### Issue #6: Authentication Interceptor
**Scope**: Automatic authentication header/cookie attachment and refresh  
**Files**:
- `lib/core/network/interceptors/auth_interceptor.dart`

**Tasks**:
- [ ] Create `AuthInterceptor` with service type detection
- [ ] Add Firebase ID token for palapi requests (Bearer header)
- [ ] Add automatic cookie attachment for portal services
- [ ] Implement 401/403 auto-refresh logic with single retry
- [ ] Integrate with auth core module for token/session management

**Dependencies**: Issues #1, #2, #4, #5  
**Estimated Size**: Medium PR (~250 lines)

---

#### Issue #7: Cache Interceptor with SWR Support
**Scope**: HTTP response caching with stale-while-revalidate strategy  
**Files**:
- `lib/core/network/interceptors/cache_interceptor.dart`
- `lib/core/network/services/http_cache_manager.dart`

**Tasks**:
- [ ] Create `CacheInterceptor` with cache strategy support
- [ ] Implement cache key generation and collision handling
- [ ] Add ETag and Last-Modified header support
- [ ] Implement SWR pattern for background updates
- [ ] Integrate with storage core module for cache persistence
- [ ] Add offline-first fallback behavior

**Dependencies**: Issues #1, #2, #4, storage core module  
**Estimated Size**: Large PR (~400 lines)

---

#### Issue #8: Retry Interceptor with Smart Backoff
**Scope**: Intelligent retry logic with exponential backoff and jitter  
**Files**:
- `lib/core/network/interceptors/retry_interceptor.dart`
- `lib/core/network/models/retry_config.dart`

**Tasks**:
- [ ] Create `RetryInterceptor` with configurable retry policies
- [ ] Implement exponential backoff with jitter (0-1s)
- [ ] Add retry count limits per error type (timeout: 3x, 500s: 5x)
- [ ] Handle 429 rate limiting with Retry-After header parsing
- [ ] Add non-retryable error detection (503 maintenance)

**Dependencies**: Issues #1, #2, #4, #5  
**Estimated Size**: Medium PR (~250 lines)

---

### Phase 3: Client Implementations (Issues #9-10)

#### Issue #9: PalapiClient Implementation
**Scope**: Firebase-authenticated JSON API client  
**Files**:
- `lib/core/network/clients/palapi_client.dart`
- `lib/core/network/config/palapi_config.dart`

**Tasks**:
- [ ] Create `PalapiClient` implementing NetworkClientInterface
- [ ] Configure JSON content-type and 10s/30s timeouts
- [ ] Add Firebase ID token automatic attachment
- [ ] Implement typed response parsing
- [ ] Add Firebase Performance Monitoring integration

**Dependencies**: Issues #1-8, config core module  
**Estimated Size**: Medium PR (~200 lines)

---

#### Issue #10: PortalClient Implementation  
**Scope**: Cookie-based HTML portal client for ALBO/MaNaBo/Cubics  
**Files**:
- `lib/core/network/clients/portal_client.dart`
- `lib/core/network/services/session_detector.dart`
- `lib/core/network/config/portal_config.dart`

**Tasks**:
- [ ] Create `PortalClient` implementing NetworkClientInterface
- [ ] Add persistent cookie jar configuration
- [ ] Implement `getHtml` method with HTML Document response
- [ ] Add session expiration detection (login form parsing)
- [ ] Throw `AuthenticationException.sessionExpired()` on expired sessions
- [ ] Configure plain text response type for HTML parsing

**Dependencies**: Issues #1-8, auth core module  
**Estimated Size**: Medium PR (~250 lines)

---

### Phase 4: Dependency Injection & Integration (Issues #11-12)

#### Issue #11: Core Providers and Dependency Injection
**Scope**: Riverpod providers for all network services  
**Files**:
- `lib/core/network/providers.dart`
- `lib/core/network/providers/network_providers.dart`

**Tasks**:
- [ ] Create `dioProvider` family for service-specific Dio instances
- [ ] Create `palapiClientProvider` with config/auth injection
- [ ] Create `alboClientProvider`, `manaboClientProvider`, `cubicsClientProvider`
- [ ] Create `connectivityStatusProvider` watching network status
- [ ] Add provider export structure following other core modules
- [ ] Include test override providers for mocking

**Dependencies**: Issues #1-10, config/auth/storage core modules  
**Estimated Size**: Medium PR (~300 lines)

---

#### Issue #12: README and Usage Documentation
**Scope**: Usage examples and integration documentation  
**Files**:
- `lib/core/network/README.md`

**Tasks**:
- [ ] Document NetworkClient interface usage
- [ ] Provide service-specific client examples
- [ ] Document cache strategy options and SWR patterns
- [ ] Add error handling best practices
- [ ] Include testing and mocking examples
- [ ] Document integration with other core modules

**Dependencies**: Issues #1-11  
**Estimated Size**: Small PR (~100 lines documentation)

---

### Phase 5: Testing Infrastructure (Issues #13-15)

#### Issue #13: Mock Implementations and Test Utilities
**Scope**: Mock network clients and test helpers  
**Files**:
- `lib/core/network/testing/mock_network_client.dart`
- `lib/core/network/testing/network_test_utils.dart`
- `lib/core/network/testing/mock_connectivity_monitor.dart`

**Tasks**:
- [ ] Create `MockNetworkClient` implementing NetworkClientInterface
- [ ] Add response registration with delay simulation
- [ ] Create test utilities for interceptor testing
- [ ] Add `MockConnectivityMonitor` for offline testing
- [ ] Include integration test helpers

**Dependencies**: Issues #1-12  
**Estimated Size**: Medium PR (~300 lines)

---

#### Issue #14: Interceptor Unit Tests
**Scope**: Comprehensive testing for all interceptors  
**Files**:
- `test/core/network/interceptors/auth_interceptor_test.dart`
- `test/core/network/interceptors/error_interceptor_test.dart`
- `test/core/network/interceptors/cache_interceptor_test.dart`
- `test/core/network/interceptors/retry_interceptor_test.dart`

**Tasks**:
- [ ] Test AuthInterceptor 401 auto-refresh flow
- [ ] Test ErrorInterceptor DioException → AppError conversion
- [ ] Test CacheInterceptor SWR patterns and offline behavior
- [ ] Test RetryInterceptor backoff and rate limiting
- [ ] Use MockAuthProvider and MockDio for isolation

**Dependencies**: Issue #13  
**Estimated Size**: Large PR (~600 lines)

---

#### Issue #15: Integration Tests and Performance Monitoring
**Scope**: End-to-end testing and performance metrics  
**Files**:
- `test/core/network/integration/network_integration_test.dart`
- `lib/core/network/services/performance_monitor.dart`

**Tasks**:
- [ ] Create integration tests for complete request flows
- [ ] Test service-specific authentication flows
- [ ] Add Firebase Performance HTTP metrics integration
- [ ] Implement network performance monitoring
- [ ] Test cache persistence and SWR patterns
- [ ] Add offline/online transition testing

**Dependencies**: Issues #1-14  
**Estimated Size**: Large PR (~500 lines)

---

## Current Status

- **Issues Completed**: 0/15
- **Current Phase**: Phase 1 - Foundation
- **Next Issue**: #1 - Add Missing Dependencies and Core Models

## Notes

1. **Critical Dependency**: `connectivity_plus` package must be added before starting implementation
2. **Core Integration**: Network module depends heavily on config, auth, storage, and error modules
3. **Testing Strategy**: Each interceptor requires isolated unit tests with mocked dependencies
4. **Performance**: Firebase Performance Monitoring integration planned for production metrics
5. **Offline Support**: SWR pattern with cache-first fallback ensures good offline UX

## Implementation Guidelines

- Follow existing core module patterns (providers.dart export structure)
- Use riverpod_annotation for code generation
- Implement comprehensive error handling with AppError integration
- Include Japanese comments for domain-specific logic
- Maintain test coverage above 90% for all network components
- Follow clean architecture dependency rules (no reverse dependencies)
