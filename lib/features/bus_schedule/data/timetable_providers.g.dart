// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$holidayRepositoryHash() => r'879b8c9dc4dee42a9128ee66e7274b0ac64e68f3';

/// See also [holidayRepository].
@ProviderFor(holidayRepository)
final holidayRepositoryProvider =
    AutoDisposeProvider<HolidayRepository>.internal(
      holidayRepository,
      name: r'holidayRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$holidayRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HolidayRepositoryRef = AutoDisposeProviderRef<HolidayRepository>;
String _$busDiagramRepositoryHash() =>
    r'f928db8c36e43c13d0e6391a32cee8774f53a672';

/// See also [busDiagramRepository].
@ProviderFor(busDiagramRepository)
final busDiagramRepositoryProvider =
    AutoDisposeProvider<BusDiagramRepository>.internal(
      busDiagramRepository,
      name: r'busDiagramRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$busDiagramRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BusDiagramRepositoryRef = AutoDisposeProviderRef<BusDiagramRepository>;
String _$timetableRepositoryHash() =>
    r'c7a12c0f133bfdb9073987c571111ba1dfcff533';

/// See also [timetableRepository].
@ProviderFor(timetableRepository)
final timetableRepositoryProvider =
    AutoDisposeProvider<TimetableRepository>.internal(
      timetableRepository,
      name: r'timetableRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$timetableRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TimetableRepositoryRef = AutoDisposeProviderRef<TimetableRepository>;
String _$nextDeparturesHash() => r'a0b9eeba86abacbd2edb8ec3738f630e060fe82c';

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

/// See also [nextDepartures].
@ProviderFor(nextDepartures)
const nextDeparturesProvider = NextDeparturesFamily();

/// See also [nextDepartures].
class NextDeparturesFamily extends Family<AsyncValue<List<DepartureEntity>>> {
  /// See also [nextDepartures].
  const NextDeparturesFamily();

  /// See also [nextDepartures].
  NextDeparturesProvider call(LineId lineId) {
    return NextDeparturesProvider(lineId);
  }

  @override
  NextDeparturesProvider getProviderOverride(
    covariant NextDeparturesProvider provider,
  ) {
    return call(provider.lineId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'nextDeparturesProvider';
}

/// See also [nextDepartures].
class NextDeparturesProvider
    extends AutoDisposeFutureProvider<List<DepartureEntity>> {
  /// See also [nextDepartures].
  NextDeparturesProvider(LineId lineId)
    : this._internal(
        (ref) => nextDepartures(ref as NextDeparturesRef, lineId),
        from: nextDeparturesProvider,
        name: r'nextDeparturesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$nextDeparturesHash,
        dependencies: NextDeparturesFamily._dependencies,
        allTransitiveDependencies:
            NextDeparturesFamily._allTransitiveDependencies,
        lineId: lineId,
      );

  NextDeparturesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lineId,
  }) : super.internal();

  final LineId lineId;

  @override
  Override overrideWith(
    FutureOr<List<DepartureEntity>> Function(NextDeparturesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NextDeparturesProvider._internal(
        (ref) => create(ref as NextDeparturesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lineId: lineId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DepartureEntity>> createElement() {
    return _NextDeparturesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NextDeparturesProvider && other.lineId == lineId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lineId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NextDeparturesRef on AutoDisposeFutureProviderRef<List<DepartureEntity>> {
  /// The parameter `lineId` of this provider.
  LineId get lineId;
}

class _NextDeparturesProviderElement
    extends AutoDisposeFutureProviderElement<List<DepartureEntity>>
    with NextDeparturesRef {
  _NextDeparturesProviderElement(super.provider);

  @override
  LineId get lineId => (origin as NextDeparturesProvider).lineId;
}

String _$departuresHash() => r'8a69f17e3092d15935532ed89d50ddb4ffc92c18';

/// See also [departures].
@ProviderFor(departures)
const departuresProvider = DeparturesFamily();

/// See also [departures].
class DeparturesFamily extends Family<AsyncValue<List<DepartureEntity>>> {
  /// See also [departures].
  const DeparturesFamily();

  /// See also [departures].
  DeparturesProvider call(LineId lineId, DiagramId diagramId) {
    return DeparturesProvider(lineId, diagramId);
  }

  @override
  DeparturesProvider getProviderOverride(
    covariant DeparturesProvider provider,
  ) {
    return call(provider.lineId, provider.diagramId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'departuresProvider';
}

/// See also [departures].
class DeparturesProvider
    extends AutoDisposeFutureProvider<List<DepartureEntity>> {
  /// See also [departures].
  DeparturesProvider(LineId lineId, DiagramId diagramId)
    : this._internal(
        (ref) => departures(ref as DeparturesRef, lineId, diagramId),
        from: departuresProvider,
        name: r'departuresProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$departuresHash,
        dependencies: DeparturesFamily._dependencies,
        allTransitiveDependencies: DeparturesFamily._allTransitiveDependencies,
        lineId: lineId,
        diagramId: diagramId,
      );

  DeparturesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lineId,
    required this.diagramId,
  }) : super.internal();

  final LineId lineId;
  final DiagramId diagramId;

  @override
  Override overrideWith(
    FutureOr<List<DepartureEntity>> Function(DeparturesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeparturesProvider._internal(
        (ref) => create(ref as DeparturesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lineId: lineId,
        diagramId: diagramId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DepartureEntity>> createElement() {
    return _DeparturesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeparturesProvider &&
        other.lineId == lineId &&
        other.diagramId == diagramId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lineId.hashCode);
    hash = _SystemHash.combine(hash, diagramId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeparturesRef on AutoDisposeFutureProviderRef<List<DepartureEntity>> {
  /// The parameter `lineId` of this provider.
  LineId get lineId;

  /// The parameter `diagramId` of this provider.
  DiagramId get diagramId;
}

class _DeparturesProviderElement
    extends AutoDisposeFutureProviderElement<List<DepartureEntity>>
    with DeparturesRef {
  _DeparturesProviderElement(super.provider);

  @override
  LineId get lineId => (origin as DeparturesProvider).lineId;
  @override
  DiagramId get diagramId => (origin as DeparturesProvider).diagramId;
}

String _$isHolidayHash() => r'11c913cf461792a7c08537052df02036de9c5f34';

/// See also [isHoliday].
@ProviderFor(isHoliday)
const isHolidayProvider = IsHolidayFamily();

/// See also [isHoliday].
class IsHolidayFamily extends Family<AsyncValue<bool>> {
  /// See also [isHoliday].
  const IsHolidayFamily();

  /// See also [isHoliday].
  IsHolidayProvider call(DateTime date) {
    return IsHolidayProvider(date);
  }

  @override
  IsHolidayProvider getProviderOverride(covariant IsHolidayProvider provider) {
    return call(provider.date);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isHolidayProvider';
}

/// See also [isHoliday].
class IsHolidayProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [isHoliday].
  IsHolidayProvider(DateTime date)
    : this._internal(
        (ref) => isHoliday(ref as IsHolidayRef, date),
        from: isHolidayProvider,
        name: r'isHolidayProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isHolidayHash,
        dependencies: IsHolidayFamily._dependencies,
        allTransitiveDependencies: IsHolidayFamily._allTransitiveDependencies,
        date: date,
      );

  IsHolidayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(FutureOr<bool> Function(IsHolidayRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: IsHolidayProvider._internal(
        (ref) => create(ref as IsHolidayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _IsHolidayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsHolidayProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsHolidayRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _IsHolidayProviderElement extends AutoDisposeFutureProviderElement<bool>
    with IsHolidayRef {
  _IsHolidayProviderElement(super.provider);

  @override
  DateTime get date => (origin as IsHolidayProvider).date;
}

String _$campusLinesHash() => r'9f692ab71d721500823cb320d5dea6cf702fd7f0';

/// See also [campusLines].
@ProviderFor(campusLines)
const campusLinesProvider = CampusLinesFamily();

/// See also [campusLines].
class CampusLinesFamily extends Family<AsyncValue<List<LineEntity>>> {
  /// See also [campusLines].
  const CampusLinesFamily();

  /// See also [campusLines].
  CampusLinesProvider call(Campus campus) {
    return CampusLinesProvider(campus);
  }

  @override
  CampusLinesProvider getProviderOverride(
    covariant CampusLinesProvider provider,
  ) {
    return call(provider.campus);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'campusLinesProvider';
}

/// See also [campusLines].
class CampusLinesProvider extends AutoDisposeFutureProvider<List<LineEntity>> {
  /// See also [campusLines].
  CampusLinesProvider(Campus campus)
    : this._internal(
        (ref) => campusLines(ref as CampusLinesRef, campus),
        from: campusLinesProvider,
        name: r'campusLinesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$campusLinesHash,
        dependencies: CampusLinesFamily._dependencies,
        allTransitiveDependencies: CampusLinesFamily._allTransitiveDependencies,
        campus: campus,
      );

  CampusLinesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.campus,
  }) : super.internal();

  final Campus campus;

  @override
  Override overrideWith(
    FutureOr<List<LineEntity>> Function(CampusLinesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CampusLinesProvider._internal(
        (ref) => create(ref as CampusLinesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        campus: campus,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<LineEntity>> createElement() {
    return _CampusLinesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CampusLinesProvider && other.campus == campus;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, campus.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CampusLinesRef on AutoDisposeFutureProviderRef<List<LineEntity>> {
  /// The parameter `campus` of this provider.
  Campus get campus;
}

class _CampusLinesProviderElement
    extends AutoDisposeFutureProviderElement<List<LineEntity>>
    with CampusLinesRef {
  _CampusLinesProviderElement(super.provider);

  @override
  Campus get campus => (origin as CampusLinesProvider).campus;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
