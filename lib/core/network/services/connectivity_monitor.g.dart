// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_monitor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$connectivityMonitorHash() =>
    r'752fa4288691b16ce48eaefed87c74e0cf8f6dc5';

/// Provider for the connectivity monitor service
///
/// Copied from [connectivityMonitor].
@ProviderFor(connectivityMonitor)
final connectivityMonitorProvider =
    AutoDisposeProvider<ConnectivityMonitor>.internal(
      connectivityMonitor,
      name: r'connectivityMonitorProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$connectivityMonitorHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConnectivityMonitorRef = AutoDisposeProviderRef<ConnectivityMonitor>;
String _$connectivityStatusHash() =>
    r'cfb675f20740a9d199558da80389201982f37004';

/// Provider for the current connectivity status
///
/// Copied from [connectivityStatus].
@ProviderFor(connectivityStatus)
final connectivityStatusProvider =
    AutoDisposeStreamProvider<ConnectivityStatus>.internal(
      connectivityStatus,
      name: r'connectivityStatusProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$connectivityStatusHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConnectivityStatusRef =
    AutoDisposeStreamProviderRef<ConnectivityStatus>;
String _$networkEventsHash() => r'486fae2e7c252930ad866525ac846d4179d05d51';

/// Provider for network events stream
///
/// Copied from [networkEvents].
@ProviderFor(networkEvents)
final networkEventsProvider = AutoDisposeStreamProvider<NetworkEvent>.internal(
  networkEvents,
  name: r'networkEventsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$networkEventsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NetworkEventsRef = AutoDisposeStreamProviderRef<NetworkEvent>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
