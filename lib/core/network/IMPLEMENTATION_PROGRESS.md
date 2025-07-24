# Network Core Implementation Progress

## Overview

The Network Core module provides unified HTTP platform for all external API communication in PassPal, including palapi, ALBO, MaNaBo, Cubics, and SSO services. It handles authentication, error handling, caching, retry strategies, and offline support.

## Dependencies

- **Config Core**: `apiConfigProvider` for API endpoints and timeouts
- **Error Core**: `errorNotifierProvider`, `appLoggerProvider` for error handling
- **Storage Core**: `cacheStorageProvider` for SWR caching strategy
- **Auth Core**: Will provide token/cookie management (not yet implemented)

## Implementation Issues (Pull Request Scope)

### ✅ Phase 1: Foundation & Interfaces (Completed)

#### Issue #1: Core Models & Interfaces ✅ **COMPLETED**
**PR Scope**: Define fundamental data structures and interfaces
- [x] `models/cache_strategy.dart` - Define caching strategy enum
- [x] `models/network_request.dart` - Request model with Freezed
- [x] `models/network_response.dart` - Response model with Freezed
- [x] `models/connectivity_status.dart` - Network status model
- [x] `interfaces/network_client_interface.dart` - Abstract NetworkClient
- [x] `models/service_config.dart` - Per-service configuration model

**Files created**: 6 files + generated Freezed files
**Dependencies**: None (foundation)
**Tests**: Unit tests created for cache_strategy, basic tests for other models

#### Issue #2: Network Monitoring
**PR Scope**: Implement connectivity monitoring
- [ ] `services/connectivity_monitor.dart` - Track online/offline state
- [ ] `models/network_event.dart` - Network state change events
- [ ] Integration with `connectivity_plus` package
- [ ] Reactive stream for connectivity changes

**Files to create**: 2 files
**Dependencies**: Issue #1
**Tests**: Unit tests with mocked connectivity_plus

### ✅ Phase 2: Core HTTP Infrastructure (Not Started)

#### Issue #3: Basic HTTP Client Setup
**PR Scope**: Setup Dio instances with basic configuration
- [ ] `services/dio_factory.dart` - Create configured Dio instances
- [ ] `services/base_http_client.dart` - Basic HTTP operations
- [ ] Integration with config core for timeouts/endpoints
- [ ] Basic request/response logging

**Files to create**: 2 files
**Dependencies**: Issue #1, Config Core
**Tests**: Integration tests with test HTTP server

#### Issue #4: Authentication Interceptor
**PR Scope**: Handle token/cookie management and auto-refresh
- [ ] `interceptors/auth_interceptor.dart` - Add auth headers/cookies
- [ ] Handle 401/403 errors with auto-refresh retry
- [ ] Integration with auth core providers (when available)
- [ ] Support for different auth types per service

**Files to create**: 1 file
**Dependencies**: Issue #3, Auth Core (mock for now)
**Tests**: Unit tests with mocked auth providers

### ✅ Phase 3: Error Handling & Recovery (Not Started)

#### Issue #5: Error Interceptor
**PR Scope**: Convert HTTP errors to unified AppError format
- [ ] `interceptors/error_interceptor.dart` - DioException → AppError
- [ ] `models/network_error_types.dart` - Network-specific error definitions
- [ ] Integration with error core providers
- [ ] Error context enrichment (request URL, headers, etc.)

**Files to create**: 2 files
**Dependencies**: Issue #3, Error Core
**Tests**: Unit tests covering all error scenarios

#### Issue #6: Retry Interceptor
**PR Scope**: Implement intelligent retry with exponential backoff
- [ ] `interceptors/retry_interceptor.dart` - Smart retry logic
- [ ] `services/retry_strategy.dart` - Exponential backoff with jitter
- [ ] `models/retry_config.dart` - Retry configuration per error type
- [ ] Rate limit handling (429 responses)

**Files to create**: 3 files
**Dependencies**: Issue #5
**Tests**: Unit tests with time manipulation

### ✅ Phase 4: Caching & SWR Strategy (Not Started)

#### Issue #7: Cache Interceptor
**PR Scope**: Implement Stale-While-Revalidate caching
- [ ] `interceptors/cache_interceptor.dart` - SWR implementation
- [ ] `services/cache_strategy_resolver.dart` - Strategy selection logic
- [ ] Integration with storage core cache providers
- [ ] ETag/Last-Modified support for cache validation

**Files to create**: 2 files
**Dependencies**: Issue #3, Storage Core
**Tests**: Integration tests with cache storage

#### Issue #8: Cache Key Management
**PR Scope**: Intelligent cache key generation and management
- [ ] `services/cache_key_generator.dart` - Generate consistent cache keys
- [ ] `models/cache_metadata.dart` - Cache entry metadata
- [ ] Support for parameterized requests
- [ ] Cache invalidation strategies

**Files to create**: 2 files
**Dependencies**: Issue #7
**Tests**: Unit tests for key generation logic

### ✅ Phase 5: Service-Specific Clients (Not Started)

#### Issue #9: Palapi Client
**PR Scope**: Firebase authenticated client for internal API
- [ ] `clients/palapi_client.dart` - Firebase token authentication
- [ ] Configuration via config core
- [ ] Firebase Performance monitoring integration
- [ ] Service-specific error handling

**Files to create**: 1 file
**Dependencies**: Issues #4, #5, #7
**Tests**: Integration tests with mock Firebase auth

#### Issue #10: Portal Clients (ALBO, MaNaBo, Cubics)
**PR Scope**: Shibboleth cookie-based clients
- [ ] `clients/portal_client.dart` - Base portal client
- [ ] `clients/albo_client.dart` - ALBO-specific client
- [ ] `clients/manabo_client.dart` - MaNaBo-specific client  
- [ ] `clients/cubics_client.dart` - Cubics-specific client
- [ ] Cookie jar management and session detection

**Files to create**: 4 files
**Dependencies**: Issues #4, #5, #7
**Tests**: Unit tests with mock cookie jar

#### Issue #11: SSO Client
**PR Scope**: Form-based authentication client
- [ ] `clients/sso_client.dart` - Form auth for Shibboleth SSO
- [ ] Redirect detection and handling
- [ ] Integration with auth core for credential management
- [ ] Session state management

**Files to create**: 1 file
**Dependencies**: Issues #4, #5
**Tests**: Unit tests with mock form submissions

### ✅ Phase 6: Dependency Injection & Integration (Not Started)

#### Issue #12: Riverpod Providers
**PR Scope**: Setup all providers for dependency injection
- [ ] `providers.dart` - Export all network providers
- [ ] Service-specific client providers
- [ ] Network monitoring providers
- [ ] Configuration and initialization providers

**Files to create**: 1 file
**Dependencies**: All previous issues
**Tests**: Provider integration tests

#### Issue #13: Cross-Module Integration
**PR Scope**: Integration with other core modules
- [ ] Config core integration tests
- [ ] Error core integration tests  
- [ ] Storage core integration tests
- [ ] Background core preparation (hooks)

**Files to create**: 0 files (tests only)
**Dependencies**: Issue #12, All Core modules
**Tests**: Integration test suite

### ✅ Phase 7: Testing & Reliability (Not Started)

#### Issue #14: Mock Implementation
**PR Scope**: Testing utilities and mock clients
- [ ] `testing/mock_network_client.dart` - Mock for testing
- [ ] `testing/network_test_utils.dart` - Test utilities
- [ ] `testing/http_mock_responses.dart` - Predefined responses
- [ ] Test fixtures for different scenarios

**Files to create**: 3 files
**Dependencies**: Issue #12
**Tests**: Tests for test utilities (meta-testing)

#### Issue #15: Performance Monitoring
**PR Scope**: Firebase Performance integration
- [ ] `extensions/performance_extensions.dart` - HTTP tracing
- [ ] `services/network_metrics.dart` - Performance metrics collection
- [ ] Integration with Firebase Performance SDK
- [ ] Metrics reporting and alerting

**Files to create**: 2 files
**Dependencies**: Issue #12
**Tests**: Unit tests for performance tracking

### ✅ Phase 8: Documentation & Polish (Not Started)

#### Issue #16: Documentation & README
**PR Scope**: Complete module documentation
- [ ] `README.md` - Module usage examples
- [ ] API documentation and examples
- [ ] Architecture decision records
- [ ] Migration guide from direct Dio usage

**Files to create**: 1 file + docs
**Dependencies**: All previous issues
**Tests**: Documentation examples as tests

## Current Status

- **Total Issues**: 16
- **Completed**: 1
- **In Progress**: 0
- **Remaining**: 15

## Current Phase: Core HTTP Infrastructure

**Next Action**: Start with Issue #2 - Network Monitoring

## Key Integration Points

### With Config Core
- `apiConfigProvider` for service endpoints and timeouts
- Configuration-driven service selection

### With Error Core  
- `errorNotifierProvider` for error reporting
- `appLoggerProvider` for structured logging
- `AppError` model for unified error handling

### With Storage Core
- `cacheStorageProvider` for SWR implementation
- Cache key management and TTL

### With Auth Core (Future)
- Token management for Firebase authentication
- Cookie management for Shibboleth
- Session state and refresh logic

## Testing Strategy

- **Unit Tests**: Each service and interceptor
- **Integration Tests**: Cross-module interaction
- **Mock Server**: Real HTTP scenario testing
- **Performance Tests**: Cache hit rates, response times
- **Error Scenario Tests**: Network failures, auth errors

## Metrics to Track

- API response times (p50, p95, p99)
- Error rates by service and type
- Cache hit rates
- Retry success rates
- Network connectivity change frequency

---

*Last Updated: 2025-01-24*
*Current Assignee: Claude*
*Review Required: After each phase completion*

## Issue #1 Implementation Notes

**Completed**: 2025-01-24
**Files Created**:
- `models/cache_strategy.dart` - Caching strategy enum with utility extensions
- `models/network_request.dart` - Freezed request model with fluent API
- `models/network_response.dart` - Freezed response model with status helpers
- `models/connectivity_status.dart` - Network status model with quality assessment
- `interfaces/network_client_interface.dart` - Complete interface hierarchy
- `models/service_config.dart` - Service configuration with predefined configs

**Code Generation**: All models use Freezed with JSON serialization support
**Test Coverage**: Basic unit tests created, cache_strategy fully tested
**Known Issues**: NetworkResponse generic type has JSON serialization limitations (documented in code)