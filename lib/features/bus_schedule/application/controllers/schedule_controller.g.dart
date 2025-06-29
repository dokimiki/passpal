// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scheduleControllerHash() =>
    r'0c6fa723c941bf4344bf2d6a0d5806dbde36cc7f';

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

abstract class _$ScheduleController
    extends BuildlessAutoDisposeNotifier<TimetableState> {
  late final LineId lineId;
  late final RouteDirection direction;

  TimetableState build(LineId lineId, RouteDirection direction);
}

/// Controller for bus/train schedule functionality
///
/// Copied from [ScheduleController].
@ProviderFor(ScheduleController)
const scheduleControllerProvider = ScheduleControllerFamily();

/// Controller for bus/train schedule functionality
///
/// Copied from [ScheduleController].
class ScheduleControllerFamily extends Family<TimetableState> {
  /// Controller for bus/train schedule functionality
  ///
  /// Copied from [ScheduleController].
  const ScheduleControllerFamily();

  /// Controller for bus/train schedule functionality
  ///
  /// Copied from [ScheduleController].
  ScheduleControllerProvider call(LineId lineId, RouteDirection direction) {
    return ScheduleControllerProvider(lineId, direction);
  }

  @override
  ScheduleControllerProvider getProviderOverride(
    covariant ScheduleControllerProvider provider,
  ) {
    return call(provider.lineId, provider.direction);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'scheduleControllerProvider';
}

/// Controller for bus/train schedule functionality
///
/// Copied from [ScheduleController].
class ScheduleControllerProvider
    extends
        AutoDisposeNotifierProviderImpl<ScheduleController, TimetableState> {
  /// Controller for bus/train schedule functionality
  ///
  /// Copied from [ScheduleController].
  ScheduleControllerProvider(LineId lineId, RouteDirection direction)
    : this._internal(
        () => ScheduleController()
          ..lineId = lineId
          ..direction = direction,
        from: scheduleControllerProvider,
        name: r'scheduleControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$scheduleControllerHash,
        dependencies: ScheduleControllerFamily._dependencies,
        allTransitiveDependencies:
            ScheduleControllerFamily._allTransitiveDependencies,
        lineId: lineId,
        direction: direction,
      );

  ScheduleControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lineId,
    required this.direction,
  }) : super.internal();

  final LineId lineId;
  final RouteDirection direction;

  @override
  TimetableState runNotifierBuild(covariant ScheduleController notifier) {
    return notifier.build(lineId, direction);
  }

  @override
  Override overrideWith(ScheduleController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ScheduleControllerProvider._internal(
        () => create()
          ..lineId = lineId
          ..direction = direction,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lineId: lineId,
        direction: direction,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ScheduleController, TimetableState>
  createElement() {
    return _ScheduleControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ScheduleControllerProvider &&
        other.lineId == lineId &&
        other.direction == direction;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lineId.hashCode);
    hash = _SystemHash.combine(hash, direction.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ScheduleControllerRef on AutoDisposeNotifierProviderRef<TimetableState> {
  /// The parameter `lineId` of this provider.
  LineId get lineId;

  /// The parameter `direction` of this provider.
  RouteDirection get direction;
}

class _ScheduleControllerProviderElement
    extends
        AutoDisposeNotifierProviderElement<ScheduleController, TimetableState>
    with ScheduleControllerRef {
  _ScheduleControllerProviderElement(super.provider);

  @override
  LineId get lineId => (origin as ScheduleControllerProvider).lineId;
  @override
  RouteDirection get direction =>
      (origin as ScheduleControllerProvider).direction;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
