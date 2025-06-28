// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchTimetableUseCaseHash() =>
    r'bf823a1f075a6dd49d4f655cff56f1886cd56ead';

/// UseCaseのプロバイダー
///
/// Copied from [fetchTimetableUseCase].
@ProviderFor(fetchTimetableUseCase)
final fetchTimetableUseCaseProvider =
    AutoDisposeProvider<FetchTimetableUseCase>.internal(
      fetchTimetableUseCase,
      name: r'fetchTimetableUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$fetchTimetableUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchTimetableUseCaseRef =
    AutoDisposeProviderRef<FetchTimetableUseCase>;
String _$refreshTimetableUseCaseHash() =>
    r'31467d4c634ff4ad14e6ec9906c07bec888cc912';

/// See also [refreshTimetableUseCase].
@ProviderFor(refreshTimetableUseCase)
final refreshTimetableUseCaseProvider =
    AutoDisposeProvider<RefreshTimetableUseCase>.internal(
      refreshTimetableUseCase,
      name: r'refreshTimetableUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$refreshTimetableUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RefreshTimetableUseCaseRef =
    AutoDisposeProviderRef<RefreshTimetableUseCase>;
String _$fetchCourseDetailUseCaseHash() =>
    r'be136df820f3cd76d62bace31a035441fd54cd36';

/// See also [fetchCourseDetailUseCase].
@ProviderFor(fetchCourseDetailUseCase)
final fetchCourseDetailUseCaseProvider =
    AutoDisposeProvider<FetchCourseDetailUseCase>.internal(
      fetchCourseDetailUseCase,
      name: r'fetchCourseDetailUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$fetchCourseDetailUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchCourseDetailUseCaseRef =
    AutoDisposeProviderRef<FetchCourseDetailUseCase>;
String _$timetableRepositoryProviderHash() =>
    r'fa68c9424b1682adcfc08d1cbe5426730e1f94ff';

/// See also [timetableRepositoryProvider].
@ProviderFor(timetableRepositoryProvider)
final timetableRepositoryProviderProvider =
    AutoDisposeProvider<TimetableRepository>.internal(
      timetableRepositoryProvider,
      name: r'timetableRepositoryProviderProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$timetableRepositoryProviderHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TimetableRepositoryProviderRef =
    AutoDisposeProviderRef<TimetableRepository>;
String _$timetableControllerHash() =>
    r'570691d266e05f08c39a1d6aeaf4528f3a1d5488';

/// 時間割コントローラー
///
/// Copied from [TimetableController].
@ProviderFor(TimetableController)
final timetableControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      TimetableController,
      List<TimetableSlot>
    >.internal(
      TimetableController.new,
      name: r'timetableControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$timetableControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TimetableController = AutoDisposeAsyncNotifier<List<TimetableSlot>>;
String _$courseDetailControllerHash() =>
    r'4a5f153619c95d6028c87cad4330ea59c44a8fca';

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

abstract class _$CourseDetailController
    extends BuildlessAutoDisposeAsyncNotifier<CourseDetail> {
  late final int manaboClassId;

  FutureOr<CourseDetail> build(int manaboClassId);
}

/// 授業詳細コントローラー（Family）
///
/// Copied from [CourseDetailController].
@ProviderFor(CourseDetailController)
const courseDetailControllerProvider = CourseDetailControllerFamily();

/// 授業詳細コントローラー（Family）
///
/// Copied from [CourseDetailController].
class CourseDetailControllerFamily extends Family<AsyncValue<CourseDetail>> {
  /// 授業詳細コントローラー（Family）
  ///
  /// Copied from [CourseDetailController].
  const CourseDetailControllerFamily();

  /// 授業詳細コントローラー（Family）
  ///
  /// Copied from [CourseDetailController].
  CourseDetailControllerProvider call(int manaboClassId) {
    return CourseDetailControllerProvider(manaboClassId);
  }

  @override
  CourseDetailControllerProvider getProviderOverride(
    covariant CourseDetailControllerProvider provider,
  ) {
    return call(provider.manaboClassId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'courseDetailControllerProvider';
}

/// 授業詳細コントローラー（Family）
///
/// Copied from [CourseDetailController].
class CourseDetailControllerProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          CourseDetailController,
          CourseDetail
        > {
  /// 授業詳細コントローラー（Family）
  ///
  /// Copied from [CourseDetailController].
  CourseDetailControllerProvider(int manaboClassId)
    : this._internal(
        () => CourseDetailController()..manaboClassId = manaboClassId,
        from: courseDetailControllerProvider,
        name: r'courseDetailControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$courseDetailControllerHash,
        dependencies: CourseDetailControllerFamily._dependencies,
        allTransitiveDependencies:
            CourseDetailControllerFamily._allTransitiveDependencies,
        manaboClassId: manaboClassId,
      );

  CourseDetailControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.manaboClassId,
  }) : super.internal();

  final int manaboClassId;

  @override
  FutureOr<CourseDetail> runNotifierBuild(
    covariant CourseDetailController notifier,
  ) {
    return notifier.build(manaboClassId);
  }

  @override
  Override overrideWith(CourseDetailController Function() create) {
    return ProviderOverride(
      origin: this,
      override: CourseDetailControllerProvider._internal(
        () => create()..manaboClassId = manaboClassId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        manaboClassId: manaboClassId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CourseDetailController, CourseDetail>
  createElement() {
    return _CourseDetailControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseDetailControllerProvider &&
        other.manaboClassId == manaboClassId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, manaboClassId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CourseDetailControllerRef
    on AutoDisposeAsyncNotifierProviderRef<CourseDetail> {
  /// The parameter `manaboClassId` of this provider.
  int get manaboClassId;
}

class _CourseDetailControllerProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          CourseDetailController,
          CourseDetail
        >
    with CourseDetailControllerRef {
  _CourseDetailControllerProviderElement(super.provider);

  @override
  int get manaboClassId =>
      (origin as CourseDetailControllerProvider).manaboClassId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
