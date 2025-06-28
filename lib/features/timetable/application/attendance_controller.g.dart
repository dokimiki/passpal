// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$monitorAttendanceUseCaseHash() =>
    r'58a08bad0eec63ab537c314e9e83f07fb4699b63';

/// UseCaseのプロバイダー
///
/// Copied from [monitorAttendanceUseCase].
@ProviderFor(monitorAttendanceUseCase)
final monitorAttendanceUseCaseProvider =
    AutoDisposeProvider<MonitorAttendanceUseCase>.internal(
      monitorAttendanceUseCase,
      name: r'monitorAttendanceUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$monitorAttendanceUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MonitorAttendanceUseCaseRef =
    AutoDisposeProviderRef<MonitorAttendanceUseCase>;
String _$submitAttendanceUseCaseHash() =>
    r'2930dd3a1614349dc33edce7aba4895c399a0a2e';

/// See also [submitAttendanceUseCase].
@ProviderFor(submitAttendanceUseCase)
final submitAttendanceUseCaseProvider =
    AutoDisposeProvider<SubmitAttendanceUseCase>.internal(
      submitAttendanceUseCase,
      name: r'submitAttendanceUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$submitAttendanceUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubmitAttendanceUseCaseRef =
    AutoDisposeProviderRef<SubmitAttendanceUseCase>;
String _$attendanceRepositoryProviderHash() =>
    r'eccdffb70e6c47221be6c5b799b29cc9682f1d84';

/// See also [attendanceRepositoryProvider].
@ProviderFor(attendanceRepositoryProvider)
final attendanceRepositoryProviderProvider =
    AutoDisposeProvider<AttendanceRepository>.internal(
      attendanceRepositoryProvider,
      name: r'attendanceRepositoryProviderProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$attendanceRepositoryProviderHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AttendanceRepositoryProviderRef =
    AutoDisposeProviderRef<AttendanceRepository>;
String _$attendanceControllerHash() =>
    r'bfb1485733efa6a1d68171bef1b0074c1715e707';

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

abstract class _$AttendanceController
    extends BuildlessAutoDisposeNotifier<AttendanceState> {
  late final int classId;

  AttendanceState build(int classId);
}

/// 出席コントローラー（Family）
///
/// Copied from [AttendanceController].
@ProviderFor(AttendanceController)
const attendanceControllerProvider = AttendanceControllerFamily();

/// 出席コントローラー（Family）
///
/// Copied from [AttendanceController].
class AttendanceControllerFamily extends Family<AttendanceState> {
  /// 出席コントローラー（Family）
  ///
  /// Copied from [AttendanceController].
  const AttendanceControllerFamily();

  /// 出席コントローラー（Family）
  ///
  /// Copied from [AttendanceController].
  AttendanceControllerProvider call(int classId) {
    return AttendanceControllerProvider(classId);
  }

  @override
  AttendanceControllerProvider getProviderOverride(
    covariant AttendanceControllerProvider provider,
  ) {
    return call(provider.classId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'attendanceControllerProvider';
}

/// 出席コントローラー（Family）
///
/// Copied from [AttendanceController].
class AttendanceControllerProvider
    extends
        AutoDisposeNotifierProviderImpl<AttendanceController, AttendanceState> {
  /// 出席コントローラー（Family）
  ///
  /// Copied from [AttendanceController].
  AttendanceControllerProvider(int classId)
    : this._internal(
        () => AttendanceController()..classId = classId,
        from: attendanceControllerProvider,
        name: r'attendanceControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$attendanceControllerHash,
        dependencies: AttendanceControllerFamily._dependencies,
        allTransitiveDependencies:
            AttendanceControllerFamily._allTransitiveDependencies,
        classId: classId,
      );

  AttendanceControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.classId,
  }) : super.internal();

  final int classId;

  @override
  AttendanceState runNotifierBuild(covariant AttendanceController notifier) {
    return notifier.build(classId);
  }

  @override
  Override overrideWith(AttendanceController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AttendanceControllerProvider._internal(
        () => create()..classId = classId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        classId: classId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<AttendanceController, AttendanceState>
  createElement() {
    return _AttendanceControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AttendanceControllerProvider && other.classId == classId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, classId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AttendanceControllerRef
    on AutoDisposeNotifierProviderRef<AttendanceState> {
  /// The parameter `classId` of this provider.
  int get classId;
}

class _AttendanceControllerProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          AttendanceController,
          AttendanceState
        >
    with AttendanceControllerRef {
  _AttendanceControllerProviderElement(super.provider);

  @override
  int get classId => (origin as AttendanceControllerProvider).classId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
