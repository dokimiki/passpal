// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_update_monitor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$configUpdateMonitorHash() =>
    r'd600b976b8d6661310a789490ed13930cca495f0';

/// Provider for the configuration update monitor
///
/// Creates and manages the lifecycle of the ConfigUpdateMonitor.
/// Automatically starts monitoring when accessed and handles disposal.
///
/// Copied from [configUpdateMonitor].
@ProviderFor(configUpdateMonitor)
final configUpdateMonitorProvider =
    AutoDisposeProvider<ConfigUpdateMonitor>.internal(
      configUpdateMonitor,
      name: r'configUpdateMonitorProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$configUpdateMonitorHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConfigUpdateMonitorRef = AutoDisposeProviderRef<ConfigUpdateMonitor>;
String _$configUpdateStreamHash() =>
    r'5345bcd1193142136c1689ba84820e2f3c1fa4fc';

/// Provider for the configuration update stream
///
/// Provides a stream of AppConfig updates that are triggered by
/// Remote Config changes. The stream is automatically managed
/// and disposed of when no longer needed.
///
/// Copied from [configUpdateStream].
@ProviderFor(configUpdateStream)
final configUpdateStreamProvider =
    AutoDisposeStreamProvider<AppConfig>.internal(
      configUpdateStream,
      name: r'configUpdateStreamProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$configUpdateStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConfigUpdateStreamRef = AutoDisposeStreamProviderRef<AppConfig>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
