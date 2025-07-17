// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$crashlyticsServiceHash() =>
    r'542aa3ece81c80242afe3dfde3fa1fe1963c01f9';

/// Provider for the Crashlytics service
///
/// Copied from [crashlyticsService].
@ProviderFor(crashlyticsService)
final crashlyticsServiceProvider =
    AutoDisposeProvider<CrashlyticsService>.internal(
      crashlyticsService,
      name: r'crashlyticsServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$crashlyticsServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CrashlyticsServiceRef = AutoDisposeProviderRef<CrashlyticsService>;
String _$errorReporterHash() => r'bdd7bfddd1ddab4c6b487b00362cf0a433dc0959';

/// Provider for the error reporter
///
/// Copied from [errorReporter].
@ProviderFor(errorReporter)
final errorReporterProvider = AutoDisposeProvider<ErrorReporter>.internal(
  errorReporter,
  name: r'errorReporterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$errorReporterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ErrorReporterRef = AutoDisposeProviderRef<ErrorReporter>;
String _$appLoggerHash() => r'45198d9fea724544f750fad638f6623fd76cf7f8';

/// Provider for the main app logger
///
/// Copied from [appLogger].
@ProviderFor(appLogger)
final appLoggerProvider = AutoDisposeProvider<AppLogger>.internal(
  appLogger,
  name: r'appLoggerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appLoggerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppLoggerRef = AutoDisposeProviderRef<AppLogger>;
String _$errorLoggerHash() => r'8f2c7731b212038b882c527424a1824636ea7888';

/// Provider for error-specific logger
///
/// Copied from [errorLogger].
@ProviderFor(errorLogger)
final errorLoggerProvider = AutoDisposeProvider<AppLogger>.internal(
  errorLogger,
  name: r'errorLoggerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$errorLoggerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ErrorLoggerRef = AutoDisposeProviderRef<AppLogger>;
String _$globalErrorHandlerHash() =>
    r'18c3e2aa97a90820e5d8b3d501f506c08d7a41e7';

/// Provider for the global error handler
///
/// Copied from [globalErrorHandler].
@ProviderFor(globalErrorHandler)
final globalErrorHandlerProvider =
    AutoDisposeProvider<GlobalErrorHandler>.internal(
      globalErrorHandler,
      name: r'globalErrorHandlerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$globalErrorHandlerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GlobalErrorHandlerRef = AutoDisposeProviderRef<GlobalErrorHandler>;
String _$errorStateHash() => r'92a7a22c941fc0647fe3b7ea126d07523354b085';

/// Provider for accessing the error notifier state
///
/// Copied from [errorState].
@ProviderFor(errorState)
final errorStateProvider = AutoDisposeProvider<ErrorState>.internal(
  errorState,
  name: r'errorStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$errorStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ErrorStateRef = AutoDisposeProviderRef<ErrorState>;
String _$hasActiveErrorsHash() => r'3c28a6221ccb65c5d6d3e17a9c227d268a684335';

/// Provider for checking if there are any active errors
///
/// Copied from [hasActiveErrors].
@ProviderFor(hasActiveErrors)
final hasActiveErrorsProvider = AutoDisposeProvider<bool>.internal(
  hasActiveErrors,
  name: r'hasActiveErrorsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasActiveErrorsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasActiveErrorsRef = AutoDisposeProviderRef<bool>;
String _$lastErrorHash() => r'1bd136886931ff831ddca952cddb175657ea2b10';

/// Provider for getting the last error
///
/// Copied from [lastError].
@ProviderFor(lastError)
final lastErrorProvider = AutoDisposeProvider<AppError?>.internal(
  lastError,
  name: r'lastErrorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lastErrorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LastErrorRef = AutoDisposeProviderRef<AppError?>;
String _$isHandlingErrorHash() => r'7319ea7e1e1fa1ea99af3269209eb4b83af70e1d';

/// Provider for checking if error handling is in progress
///
/// Copied from [isHandlingError].
@ProviderFor(isHandlingError)
final isHandlingErrorProvider = AutoDisposeProvider<bool>.internal(
  isHandlingError,
  name: r'isHandlingErrorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isHandlingErrorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsHandlingErrorRef = AutoDisposeProviderRef<bool>;
String _$activeErrorsHash() => r'b22eeb8033e9f0a74f20012a2c4b0958f16d0ac0';

/// Provider for getting non-dismissed errors
///
/// Copied from [activeErrors].
@ProviderFor(activeErrors)
final activeErrorsProvider = AutoDisposeProvider<List<AppError>>.internal(
  activeErrors,
  name: r'activeErrorsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeErrorsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveErrorsRef = AutoDisposeProviderRef<List<AppError>>;
String _$errorsOfTypeHash() => r'840856a794eea5cd06a71b215da40f2082b0f297';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for getting errors of a specific type
///
/// Copied from [errorsOfType].
@ProviderFor(errorsOfType)
const errorsOfTypeProvider = ErrorsOfTypeFamily();

/// Provider for getting errors of a specific type
///
/// Copied from [errorsOfType].
class ErrorsOfTypeFamily extends Family<List<AppError>> {
  /// Provider for getting errors of a specific type
  ///
  /// Copied from [errorsOfType].
  const ErrorsOfTypeFamily();

  /// Provider for getting errors of a specific type
  ///
  /// Copied from [errorsOfType].
  ErrorsOfTypeProvider call(Type errorType) {
    return ErrorsOfTypeProvider(errorType);
  }

  @override
  ErrorsOfTypeProvider getProviderOverride(
    covariant ErrorsOfTypeProvider provider,
  ) {
    return call(provider.errorType);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'errorsOfTypeProvider';
}

/// Provider for getting errors of a specific type
///
/// Copied from [errorsOfType].
class ErrorsOfTypeProvider extends AutoDisposeProvider<List<AppError>> {
  /// Provider for getting errors of a specific type
  ///
  /// Copied from [errorsOfType].
  ErrorsOfTypeProvider(Type errorType)
    : this._internal(
        (ref) => errorsOfType(ref as ErrorsOfTypeRef, errorType),
        from: errorsOfTypeProvider,
        name: r'errorsOfTypeProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$errorsOfTypeHash,
        dependencies: ErrorsOfTypeFamily._dependencies,
        allTransitiveDependencies:
            ErrorsOfTypeFamily._allTransitiveDependencies,
        errorType: errorType,
      );

  ErrorsOfTypeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.errorType,
  }) : super.internal();

  final Type errorType;

  @override
  Override overrideWith(
    List<AppError> Function(ErrorsOfTypeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ErrorsOfTypeProvider._internal(
        (ref) => create(ref as ErrorsOfTypeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        errorType: errorType,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<AppError>> createElement() {
    return _ErrorsOfTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ErrorsOfTypeProvider && other.errorType == errorType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, errorType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ErrorsOfTypeRef on AutoDisposeProviderRef<List<AppError>> {
  /// The parameter `errorType` of this provider.
  Type get errorType;
}

class _ErrorsOfTypeProviderElement
    extends AutoDisposeProviderElement<List<AppError>>
    with ErrorsOfTypeRef {
  _ErrorsOfTypeProviderElement(super.provider);

  @override
  Type get errorType => (origin as ErrorsOfTypeProvider).errorType;
}

String _$scopedLoggerHash() => r'c7196a7324a6847e5ab3d8cc903a74368fd85ce0';

/// Provider for creating a scoped logger with a specific tag
///
/// Copied from [scopedLogger].
@ProviderFor(scopedLogger)
const scopedLoggerProvider = ScopedLoggerFamily();

/// Provider for creating a scoped logger with a specific tag
///
/// Copied from [scopedLogger].
class ScopedLoggerFamily extends Family<AppLogger> {
  /// Provider for creating a scoped logger with a specific tag
  ///
  /// Copied from [scopedLogger].
  const ScopedLoggerFamily();

  /// Provider for creating a scoped logger with a specific tag
  ///
  /// Copied from [scopedLogger].
  ScopedLoggerProvider call(String tag) {
    return ScopedLoggerProvider(tag);
  }

  @override
  ScopedLoggerProvider getProviderOverride(
    covariant ScopedLoggerProvider provider,
  ) {
    return call(provider.tag);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'scopedLoggerProvider';
}

/// Provider for creating a scoped logger with a specific tag
///
/// Copied from [scopedLogger].
class ScopedLoggerProvider extends AutoDisposeProvider<AppLogger> {
  /// Provider for creating a scoped logger with a specific tag
  ///
  /// Copied from [scopedLogger].
  ScopedLoggerProvider(String tag)
    : this._internal(
        (ref) => scopedLogger(ref as ScopedLoggerRef, tag),
        from: scopedLoggerProvider,
        name: r'scopedLoggerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$scopedLoggerHash,
        dependencies: ScopedLoggerFamily._dependencies,
        allTransitiveDependencies:
            ScopedLoggerFamily._allTransitiveDependencies,
        tag: tag,
      );

  ScopedLoggerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tag,
  }) : super.internal();

  final String tag;

  @override
  Override overrideWith(AppLogger Function(ScopedLoggerRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: ScopedLoggerProvider._internal(
        (ref) => create(ref as ScopedLoggerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tag: tag,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<AppLogger> createElement() {
    return _ScopedLoggerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ScopedLoggerProvider && other.tag == tag;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tag.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ScopedLoggerRef on AutoDisposeProviderRef<AppLogger> {
  /// The parameter `tag` of this provider.
  String get tag;
}

class _ScopedLoggerProviderElement extends AutoDisposeProviderElement<AppLogger>
    with ScopedLoggerRef {
  _ScopedLoggerProviderElement(super.provider);

  @override
  String get tag => (origin as ScopedLoggerProvider).tag;
}

String _$initializeErrorCoreHash() =>
    r'2e85025c8e3418eb89bb0be05f27b116e2e596e3';

/// Provider for initializing the error core module
/// This should be called during app startup to set up global error handling
///
/// Copied from [initializeErrorCore].
@ProviderFor(initializeErrorCore)
final initializeErrorCoreProvider = AutoDisposeFutureProvider<void>.internal(
  initializeErrorCore,
  name: r'initializeErrorCoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$initializeErrorCoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InitializeErrorCoreRef = AutoDisposeFutureProviderRef<void>;
String _$loggerForTagHash() => r'4c178267d6e28346446984d7003d02386c75bc90';

/// Provider family for creating loggers with specific tags
///
/// Copied from [loggerForTag].
@ProviderFor(loggerForTag)
const loggerForTagProvider = LoggerForTagFamily();

/// Provider family for creating loggers with specific tags
///
/// Copied from [loggerForTag].
class LoggerForTagFamily extends Family<AppLogger> {
  /// Provider family for creating loggers with specific tags
  ///
  /// Copied from [loggerForTag].
  const LoggerForTagFamily();

  /// Provider family for creating loggers with specific tags
  ///
  /// Copied from [loggerForTag].
  LoggerForTagProvider call(String tag) {
    return LoggerForTagProvider(tag);
  }

  @override
  LoggerForTagProvider getProviderOverride(
    covariant LoggerForTagProvider provider,
  ) {
    return call(provider.tag);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'loggerForTagProvider';
}

/// Provider family for creating loggers with specific tags
///
/// Copied from [loggerForTag].
class LoggerForTagProvider extends AutoDisposeProvider<AppLogger> {
  /// Provider family for creating loggers with specific tags
  ///
  /// Copied from [loggerForTag].
  LoggerForTagProvider(String tag)
    : this._internal(
        (ref) => loggerForTag(ref as LoggerForTagRef, tag),
        from: loggerForTagProvider,
        name: r'loggerForTagProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$loggerForTagHash,
        dependencies: LoggerForTagFamily._dependencies,
        allTransitiveDependencies:
            LoggerForTagFamily._allTransitiveDependencies,
        tag: tag,
      );

  LoggerForTagProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tag,
  }) : super.internal();

  final String tag;

  @override
  Override overrideWith(AppLogger Function(LoggerForTagRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: LoggerForTagProvider._internal(
        (ref) => create(ref as LoggerForTagRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tag: tag,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<AppLogger> createElement() {
    return _LoggerForTagProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoggerForTagProvider && other.tag == tag;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tag.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LoggerForTagRef on AutoDisposeProviderRef<AppLogger> {
  /// The parameter `tag` of this provider.
  String get tag;
}

class _LoggerForTagProviderElement extends AutoDisposeProviderElement<AppLogger>
    with LoggerForTagRef {
  _LoggerForTagProviderElement(super.provider);

  @override
  String get tag => (origin as LoggerForTagProvider).tag;
}

String _$errorsByCodeHash() => r'fc900dfe4b548dea641a188595fa792f8a450df7';

/// Provider family for filtering errors by error code
///
/// Copied from [errorsByCode].
@ProviderFor(errorsByCode)
const errorsByCodeProvider = ErrorsByCodeFamily();

/// Provider family for filtering errors by error code
///
/// Copied from [errorsByCode].
class ErrorsByCodeFamily extends Family<List<AppError>> {
  /// Provider family for filtering errors by error code
  ///
  /// Copied from [errorsByCode].
  const ErrorsByCodeFamily();

  /// Provider family for filtering errors by error code
  ///
  /// Copied from [errorsByCode].
  ErrorsByCodeProvider call(String errorCode) {
    return ErrorsByCodeProvider(errorCode);
  }

  @override
  ErrorsByCodeProvider getProviderOverride(
    covariant ErrorsByCodeProvider provider,
  ) {
    return call(provider.errorCode);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'errorsByCodeProvider';
}

/// Provider family for filtering errors by error code
///
/// Copied from [errorsByCode].
class ErrorsByCodeProvider extends AutoDisposeProvider<List<AppError>> {
  /// Provider family for filtering errors by error code
  ///
  /// Copied from [errorsByCode].
  ErrorsByCodeProvider(String errorCode)
    : this._internal(
        (ref) => errorsByCode(ref as ErrorsByCodeRef, errorCode),
        from: errorsByCodeProvider,
        name: r'errorsByCodeProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$errorsByCodeHash,
        dependencies: ErrorsByCodeFamily._dependencies,
        allTransitiveDependencies:
            ErrorsByCodeFamily._allTransitiveDependencies,
        errorCode: errorCode,
      );

  ErrorsByCodeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.errorCode,
  }) : super.internal();

  final String errorCode;

  @override
  Override overrideWith(
    List<AppError> Function(ErrorsByCodeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ErrorsByCodeProvider._internal(
        (ref) => create(ref as ErrorsByCodeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        errorCode: errorCode,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<AppError>> createElement() {
    return _ErrorsByCodeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ErrorsByCodeProvider && other.errorCode == errorCode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, errorCode.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ErrorsByCodeRef on AutoDisposeProviderRef<List<AppError>> {
  /// The parameter `errorCode` of this provider.
  String get errorCode;
}

class _ErrorsByCodeProviderElement
    extends AutoDisposeProviderElement<List<AppError>>
    with ErrorsByCodeRef {
  _ErrorsByCodeProviderElement(super.provider);

  @override
  String get errorCode => (origin as ErrorsByCodeProvider).errorCode;
}

String _$isErrorRecoverableHash() =>
    r'b1fd273203dc568305f6d4468b1da1419e9c0323';

/// Provider family for checking if a specific error type is recoverable
///
/// Copied from [isErrorRecoverable].
@ProviderFor(isErrorRecoverable)
const isErrorRecoverableProvider = IsErrorRecoverableFamily();

/// Provider family for checking if a specific error type is recoverable
///
/// Copied from [isErrorRecoverable].
class IsErrorRecoverableFamily extends Family<bool> {
  /// Provider family for checking if a specific error type is recoverable
  ///
  /// Copied from [isErrorRecoverable].
  const IsErrorRecoverableFamily();

  /// Provider family for checking if a specific error type is recoverable
  ///
  /// Copied from [isErrorRecoverable].
  IsErrorRecoverableProvider call(AppError error) {
    return IsErrorRecoverableProvider(error);
  }

  @override
  IsErrorRecoverableProvider getProviderOverride(
    covariant IsErrorRecoverableProvider provider,
  ) {
    return call(provider.error);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isErrorRecoverableProvider';
}

/// Provider family for checking if a specific error type is recoverable
///
/// Copied from [isErrorRecoverable].
class IsErrorRecoverableProvider extends AutoDisposeProvider<bool> {
  /// Provider family for checking if a specific error type is recoverable
  ///
  /// Copied from [isErrorRecoverable].
  IsErrorRecoverableProvider(AppError error)
    : this._internal(
        (ref) => isErrorRecoverable(ref as IsErrorRecoverableRef, error),
        from: isErrorRecoverableProvider,
        name: r'isErrorRecoverableProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isErrorRecoverableHash,
        dependencies: IsErrorRecoverableFamily._dependencies,
        allTransitiveDependencies:
            IsErrorRecoverableFamily._allTransitiveDependencies,
        error: error,
      );

  IsErrorRecoverableProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.error,
  }) : super.internal();

  final AppError error;

  @override
  Override overrideWith(bool Function(IsErrorRecoverableRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: IsErrorRecoverableProvider._internal(
        (ref) => create(ref as IsErrorRecoverableRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        error: error,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsErrorRecoverableProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsErrorRecoverableProvider && other.error == error;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, error.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsErrorRecoverableRef on AutoDisposeProviderRef<bool> {
  /// The parameter `error` of this provider.
  AppError get error;
}

class _IsErrorRecoverableProviderElement
    extends AutoDisposeProviderElement<bool>
    with IsErrorRecoverableRef {
  _IsErrorRecoverableProviderElement(super.provider);

  @override
  AppError get error => (origin as IsErrorRecoverableProvider).error;
}

String _$recoveryAttemptCountHash() =>
    r'2e4f0198139d8f6660fea983a563148fc8b35847';

/// Provider family for getting recovery attempt count for an error
///
/// Copied from [recoveryAttemptCount].
@ProviderFor(recoveryAttemptCount)
const recoveryAttemptCountProvider = RecoveryAttemptCountFamily();

/// Provider family for getting recovery attempt count for an error
///
/// Copied from [recoveryAttemptCount].
class RecoveryAttemptCountFamily extends Family<int> {
  /// Provider family for getting recovery attempt count for an error
  ///
  /// Copied from [recoveryAttemptCount].
  const RecoveryAttemptCountFamily();

  /// Provider family for getting recovery attempt count for an error
  ///
  /// Copied from [recoveryAttemptCount].
  RecoveryAttemptCountProvider call(AppError error) {
    return RecoveryAttemptCountProvider(error);
  }

  @override
  RecoveryAttemptCountProvider getProviderOverride(
    covariant RecoveryAttemptCountProvider provider,
  ) {
    return call(provider.error);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'recoveryAttemptCountProvider';
}

/// Provider family for getting recovery attempt count for an error
///
/// Copied from [recoveryAttemptCount].
class RecoveryAttemptCountProvider extends AutoDisposeProvider<int> {
  /// Provider family for getting recovery attempt count for an error
  ///
  /// Copied from [recoveryAttemptCount].
  RecoveryAttemptCountProvider(AppError error)
    : this._internal(
        (ref) => recoveryAttemptCount(ref as RecoveryAttemptCountRef, error),
        from: recoveryAttemptCountProvider,
        name: r'recoveryAttemptCountProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$recoveryAttemptCountHash,
        dependencies: RecoveryAttemptCountFamily._dependencies,
        allTransitiveDependencies:
            RecoveryAttemptCountFamily._allTransitiveDependencies,
        error: error,
      );

  RecoveryAttemptCountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.error,
  }) : super.internal();

  final AppError error;

  @override
  Override overrideWith(int Function(RecoveryAttemptCountRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: RecoveryAttemptCountProvider._internal(
        (ref) => create(ref as RecoveryAttemptCountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        error: error,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _RecoveryAttemptCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecoveryAttemptCountProvider && other.error == error;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, error.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RecoveryAttemptCountRef on AutoDisposeProviderRef<int> {
  /// The parameter `error` of this provider.
  AppError get error;
}

class _RecoveryAttemptCountProviderElement
    extends AutoDisposeProviderElement<int>
    with RecoveryAttemptCountRef {
  _RecoveryAttemptCountProviderElement(super.provider);

  @override
  AppError get error => (origin as RecoveryAttemptCountProvider).error;
}

String _$testErrorReporterHash() => r'd9a4f556cc7f9195277bc4747e3f03520119ddae';

/// Provider for testing - allows overriding the error reporter
///
/// Copied from [testErrorReporter].
@ProviderFor(testErrorReporter)
final testErrorReporterProvider = AutoDisposeProvider<ErrorReporter>.internal(
  testErrorReporter,
  name: r'testErrorReporterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testErrorReporterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestErrorReporterRef = AutoDisposeProviderRef<ErrorReporter>;
String _$testLoggerHash() => r'3bfe9635ce903d393f115a91a7c09af27237c8ef';

/// Provider for testing - allows overriding the logger
///
/// Copied from [testLogger].
@ProviderFor(testLogger)
final testLoggerProvider = AutoDisposeProvider<AppLogger>.internal(
  testLogger,
  name: r'testLoggerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testLoggerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestLoggerRef = AutoDisposeProviderRef<AppLogger>;
String _$testCrashlyticsServiceHash() =>
    r'fa1f44f5760e7cadbfa840af1feb9254ea2eb21c';

/// Provider for testing - allows overriding the Crashlytics service
///
/// Copied from [testCrashlyticsService].
@ProviderFor(testCrashlyticsService)
final testCrashlyticsServiceProvider =
    AutoDisposeProvider<CrashlyticsService>.internal(
      testCrashlyticsService,
      name: r'testCrashlyticsServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$testCrashlyticsServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestCrashlyticsServiceRef = AutoDisposeProviderRef<CrashlyticsService>;
String _$errorNotifierKeepAliveHash() =>
    r'9762f5f222eb7eee3589d25fd2d0096c0f0f2d44';

/// Provider for the error notifier that should be kept alive
///
/// Copied from [errorNotifierKeepAlive].
@ProviderFor(errorNotifierKeepAlive)
final errorNotifierKeepAliveProvider =
    AutoDisposeProvider<ErrorNotifier>.internal(
      errorNotifierKeepAlive,
      name: r'errorNotifierKeepAliveProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$errorNotifierKeepAliveHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ErrorNotifierKeepAliveRef = AutoDisposeProviderRef<ErrorNotifier>;
String _$recoveryManagerKeepAliveHash() =>
    r'02a8017c5e6789e881743f66d0bd8df2f0794567';

/// Provider for the recovery manager that should be kept alive
///
/// Copied from [recoveryManagerKeepAlive].
@ProviderFor(recoveryManagerKeepAlive)
final recoveryManagerKeepAliveProvider =
    AutoDisposeProvider<RecoveryManager>.internal(
      recoveryManagerKeepAlive,
      name: r'recoveryManagerKeepAliveProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$recoveryManagerKeepAliveHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RecoveryManagerKeepAliveRef = AutoDisposeProviderRef<RecoveryManager>;
String _$globalErrorHandlerKeepAliveHash() =>
    r'10516efa778409f59d1dff73a98bfe0b5aaf8ab3';

/// Provider for the global error handler that should be kept alive
///
/// Copied from [globalErrorHandlerKeepAlive].
@ProviderFor(globalErrorHandlerKeepAlive)
final globalErrorHandlerKeepAliveProvider =
    AutoDisposeProvider<GlobalErrorHandler>.internal(
      globalErrorHandlerKeepAlive,
      name: r'globalErrorHandlerKeepAliveProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$globalErrorHandlerKeepAliveHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GlobalErrorHandlerKeepAliveRef =
    AutoDisposeProviderRef<GlobalErrorHandler>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
