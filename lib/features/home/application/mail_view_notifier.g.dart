// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mailViewNotifierHash() => r'78efd5812291cbdbc6489737b203522f60c52719';

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

abstract class _$MailViewNotifier
    extends BuildlessAutoDisposeAsyncNotifier<MailBody> {
  late final String mailId;

  FutureOr<MailBody> build(String mailId);
}

/// See also [MailViewNotifier].
@ProviderFor(MailViewNotifier)
const mailViewNotifierProvider = MailViewNotifierFamily();

/// See also [MailViewNotifier].
class MailViewNotifierFamily extends Family<AsyncValue<MailBody>> {
  /// See also [MailViewNotifier].
  const MailViewNotifierFamily();

  /// See also [MailViewNotifier].
  MailViewNotifierProvider call(String mailId) {
    return MailViewNotifierProvider(mailId);
  }

  @override
  MailViewNotifierProvider getProviderOverride(
    covariant MailViewNotifierProvider provider,
  ) {
    return call(provider.mailId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'mailViewNotifierProvider';
}

/// See also [MailViewNotifier].
class MailViewNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<MailViewNotifier, MailBody> {
  /// See also [MailViewNotifier].
  MailViewNotifierProvider(String mailId)
    : this._internal(
        () => MailViewNotifier()..mailId = mailId,
        from: mailViewNotifierProvider,
        name: r'mailViewNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$mailViewNotifierHash,
        dependencies: MailViewNotifierFamily._dependencies,
        allTransitiveDependencies:
            MailViewNotifierFamily._allTransitiveDependencies,
        mailId: mailId,
      );

  MailViewNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mailId,
  }) : super.internal();

  final String mailId;

  @override
  FutureOr<MailBody> runNotifierBuild(covariant MailViewNotifier notifier) {
    return notifier.build(mailId);
  }

  @override
  Override overrideWith(MailViewNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: MailViewNotifierProvider._internal(
        () => create()..mailId = mailId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mailId: mailId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MailViewNotifier, MailBody>
  createElement() {
    return _MailViewNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MailViewNotifierProvider && other.mailId == mailId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mailId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MailViewNotifierRef on AutoDisposeAsyncNotifierProviderRef<MailBody> {
  /// The parameter `mailId` of this provider.
  String get mailId;
}

class _MailViewNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MailViewNotifier, MailBody>
    with MailViewNotifierRef {
  _MailViewNotifierProviderElement(super.provider);

  @override
  String get mailId => (origin as MailViewNotifierProvider).mailId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
