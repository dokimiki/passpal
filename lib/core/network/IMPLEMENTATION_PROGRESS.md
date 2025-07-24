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

#### Issue #2: Network Monitoring ✅ **COMPLETED**
**PR Scope**: Implement connectivity monitoring
- [x] `services/connectivity_monitor.dart` - Track online/offline state
- [x] `models/network_event.dart` - Network state change events
- [x] Integration with `connectivity_plus` package
- [x] Reactive stream for connectivity changes

**Files created**: 2 files + generated Freezed files + tests
**Dependencies**: Issue #1
**Tests**: Unit tests with mocked connectivity_plus created

### ✅ Phase 2: Core HTTP Infrastructure (Completed)

#### Issue #3: Basic HTTP Client Setup ✅ **COMPLETED**
**PR Scope**: Setup Dio instances with basic configuration
- [x] `services/dio_factory.dart` - Create configured Dio instances
- [x] `services/base_http_client.dart` - Basic HTTP operations
- [x] Integration with config core for timeouts/endpoints
- [x] Basic request/response logging

**Files created**: 2 files + generated Riverpod files + tests
**Dependencies**: Issue #1, Config Core
**Tests**: Integration tests with test HTTP server created

#### Issue #4: Authentication Interceptor ✅ **COMPLETED**
**PR Scope**: Handle token/cookie management and auto-refresh
- [x] `interceptors/auth_interceptor.dart` - Add auth headers/cookies
- [x] Handle 401/403 errors with auto-refresh retry
- [x] Integration with auth core providers (mock implementation)
- [x] Support for different auth types per service

**Files created**: 1 file + generated Riverpod files + tests
**Dependencies**: Issue #3, Auth Core (mock for now)
**Tests**: Unit tests with mocked auth providers

### ✅ Phase 3: Error Handling & Recovery (Not Started)

#### Issue #5: Error Interceptor ✅ **COMPLETED**
**PR Scope**: Convert HTTP errors to unified AppError format
- [x] `interceptors/error_interceptor.dart` - DioException → AppError
- [x] `models/network_error_types.dart` - Network-specific error definitions
- [x] Integration with error core providers
- [x] Error context enrichment (request URL, headers, etc.)

**Files created**: 2 files + generated Riverpod files + tests
**Dependencies**: Issue #3, Error Core
**Tests**: Unit tests covering all error scenarios created

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
- **Completed**: 5
- **In Progress**: 0
- **Remaining**: 11

## Current Phase: Error Handling & Recovery

**Next Action**: Start with Issue #6 - Retry Interceptor

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

## Issue #2 Implementation Notes

**Completed**: 2025-01-24
**Files Created**:
- `services/connectivity_monitor.dart` - Full connectivity monitoring service with Riverpod providers
- `models/network_event.dart` - Freezed model for network state change events with factory methods
- `test/core/network/models/network_event_test.dart` - Comprehensive unit tests for network events
- `test/core/network/services/connectivity_monitor_test.dart` - Unit tests with mocked connectivity_plus

**Key Features Implemented**:
- Real-time connectivity monitoring using connectivity_plus package
- Network quality assessment with latency-based classification
- Reactive streams for status updates and network events
- Event type classification (connected, disconnected, typeChanged, qualityChanged, initial)
- Connection type mapping (WiFi, mobile, ethernet, VPN, bluetooth, other)
- Periodic quality monitoring with configurable intervals
- Internet connectivity validation using DNS lookups
- Comprehensive test coverage with mocked dependencies

**Code Generation**: Uses Freezed for immutable data classes and sealed union types
**Provider Integration**: Riverpod providers for dependency injection and state management
**Known Issues**: Some Freezed generation edge cases noted but functionality complete

## Issue #3 Implementation Notes

**Completed**: 2025-01-24
**Files Created**:
- `services/dio_factory.dart` - Factory class for creating configured Dio instances with Riverpod providers
- `services/base_http_client.dart` - Base HTTP client implementing NetworkClientInterface with full HTTP method support
- `test/core/network/services/base_http_client_test.dart` - Comprehensive integration tests with mocked HTTP server

**Key Features Implemented**:
- Service-specific Dio configuration (PalAPI, Portal services, SSO)
- Cookie management for portal authentication
- Request/response logging with dio interceptors
- Complete HTTP method support (GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS)
- Error handling and mapping between Dio exceptions and NetworkResponse
- Global header management and request timeout configuration
- Integration with Config Core for API endpoints and timeouts
- NetworkClientInterface implementation with all required methods

**Provider Integration**: Full Riverpod provider setup for dependency injection
- `dioFactoryProvider` - Factory instance
- Service-specific Dio providers: `palApiDioProvider`, `manaboDioProvider`, `alboDioProvider`, `cubicsDioProvider`, `ssoDioProvider`
- Service-specific client providers: `palApiClientProvider`, `manaboClientProvider`, etc.

**Test Coverage**: Comprehensive integration tests covering:
- All HTTP methods with success and error scenarios
- Query parameters and custom headers
- Network timeout and error handling
- Batch request execution
- URL reachability checks
- Global header management

**Code Generation**: Uses Riverpod annotation for provider generation
**Integration**: Successfully integrated with Config Core providers and Error Core logging
**Known Issues**: Connectivity status methods are stubs pointing to connectivity monitor provider

## Issue #4 Implementation Notes

**Completed**: 2025-01-24
**Files Created**:
- `interceptors/auth_interceptor.dart` - Complete authentication interceptor with auto-refresh retry
- `test/core/network/interceptors/auth_interceptor_test.dart` - Unit tests for authentication scenarios

**Key Features Implemented**:
- Service-specific authentication handling (token, cookie, form, OAuth2, custom)
- Automatic authentication header/cookie injection based on service configuration
- 401/403 error handling with intelligent auto-refresh retry logic
- Separate authentication flows for different service types (PalAPI vs Portal services)
- Mock AuthProvider implementation for testing and development until Auth Core is ready
- Support for Bearer tokens, session cookies, and custom authentication headers
- Comprehensive error handling and logging integration
- Request retry mechanism after successful authentication refresh

**Authentication Types Supported**:
- `AuthType.token`: Bearer token authentication (PalAPI)
- `AuthType.cookie`: Session cookie authentication (Portal services)
- `AuthType.form`: Form-based authentication (SSO login)
- `AuthType.oauth2`: OAuth 2.0 token authentication
- `AuthType.custom`: Custom authentication headers
- `AuthType.none`: No authentication required

**Mock Provider Features**:
- Token storage and retrieval simulation
- Cookie jar management simulation
- Realistic authentication refresh simulation
- Service-specific authentication status tracking
- Test helper methods for setting mock authentication data

**Provider Integration**: Full Riverpod provider setup
- `mockAuthProviderProvider` - Mock auth provider for development
- `authInterceptorProvider(ServiceConfig)` - Parameterized interceptor provider

**DioFactory Integration**: Authentication interceptor is automatically added to all Dio clients
- PalAPI client uses token authentication
- Portal clients (MaNaBo, ALBO, Cubics) use cookie authentication  
- SSO client uses form-based authentication

**Test Coverage**: Comprehensive unit tests covering:
- Authentication skipping for non-auth services
- Token and cookie authentication injection
- Authentication error handling (401/403)
- Auto-refresh retry logic
- Mock provider functionality
- Provider integration scenarios

**Code Generation**: Uses Riverpod code generation for provider setup
**Integration**: Successfully integrated with DioFactory and service configurations
**Known Issues**: Firebase initialization required for full test execution (tests pass with basic functionality)

## Issue #5 Implementation Notes

**Completed**: 2025-01-24
**Files Created**:
- `models/network_error_types.dart` - Comprehensive network error classification with Freezed unions
- `interceptors/error_interceptor.dart` - Full error interceptor with Japanese error messages and context enrichment
- `test/core/network/interceptors/error_interceptor_test.dart` - Unit tests for error classification and handling

**Key Features Implemented**:
- Detailed network error type classification (connection, timeout, response, cancelled, badRequest, certificate, unknown)
- DioException to AppError/Failure conversion with structured error data
- HTTP status code categorization (1xx-5xx) with specific handling
- Retry strategy determination based on error type and status code
- Comprehensive error context extraction (request URL, headers, timing, etc.)
- Japanese localized error messages for user-facing display
- Integration with Error Core providers (ErrorNotifier, AppLogger)
- Service-specific error interceptor providers via Riverpod
- Structured error attachment to DioException for downstream processing

**Error Classification System**:
- `DetailedNetworkErrorType` - Sealed union with 7 error categories
- `NetworkErrorClassifier` - Static utility class for error analysis
- `HttpStatusCategory` - 5 category classification for HTTP status codes
- Retry-ability determination with suggested delay calculation
- Error code mapping for Error Core integration

**Japanese Error Messages**:
- Connection errors: "ネットワーク接続に失敗しました"
- Timeout errors: "受信がタイムアウトしました (30秒)"
- HTTP 401: "認証が必要です (401 Unauthorized)"
- HTTP 404: "リソースが見つかりません (404 Not Found)"
- And more specific messages for common status codes

**Provider Integration**: Full Riverpod provider setup
- `errorInterceptorProvider` - General error interceptor
- `errorInterceptorForServiceProvider(serviceName)` - Service-specific interceptors
- Integration with `loggerForTagProvider` and `errorNotifierProvider`

**Test Coverage**: Comprehensive unit tests covering:
- All 7 error type classifications from DioException
- HTTP status code categorization and retry-ability logic
- Error context extraction with request/response data
- Retry delay suggestion algorithms
- Error code mapping for all error types
- NetworkErrorClassifier utility functions

**Code Generation**: Uses Freezed for immutable error types and Riverpod for provider generation
**Integration**: Successfully integrated with Error Core providers and DioFactory interceptor chain
**Known Issues**: Linter warnings about multiple underscores in test files (non-breaking)