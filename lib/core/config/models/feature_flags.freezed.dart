// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feature_flags.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeatureFlags {

 bool get enableNewAssignmentParser; bool get enableBiometricAuth; bool get enableOfflineMode; bool get enableExperimentalFeatures;
/// Create a copy of FeatureFlags
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeatureFlagsCopyWith<FeatureFlags> get copyWith => _$FeatureFlagsCopyWithImpl<FeatureFlags>(this as FeatureFlags, _$identity);

  /// Serializes this FeatureFlags to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeatureFlags&&(identical(other.enableNewAssignmentParser, enableNewAssignmentParser) || other.enableNewAssignmentParser == enableNewAssignmentParser)&&(identical(other.enableBiometricAuth, enableBiometricAuth) || other.enableBiometricAuth == enableBiometricAuth)&&(identical(other.enableOfflineMode, enableOfflineMode) || other.enableOfflineMode == enableOfflineMode)&&(identical(other.enableExperimentalFeatures, enableExperimentalFeatures) || other.enableExperimentalFeatures == enableExperimentalFeatures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enableNewAssignmentParser,enableBiometricAuth,enableOfflineMode,enableExperimentalFeatures);

@override
String toString() {
  return 'FeatureFlags(enableNewAssignmentParser: $enableNewAssignmentParser, enableBiometricAuth: $enableBiometricAuth, enableOfflineMode: $enableOfflineMode, enableExperimentalFeatures: $enableExperimentalFeatures)';
}


}

/// @nodoc
abstract mixin class $FeatureFlagsCopyWith<$Res>  {
  factory $FeatureFlagsCopyWith(FeatureFlags value, $Res Function(FeatureFlags) _then) = _$FeatureFlagsCopyWithImpl;
@useResult
$Res call({
 bool enableNewAssignmentParser, bool enableBiometricAuth, bool enableOfflineMode, bool enableExperimentalFeatures
});




}
/// @nodoc
class _$FeatureFlagsCopyWithImpl<$Res>
    implements $FeatureFlagsCopyWith<$Res> {
  _$FeatureFlagsCopyWithImpl(this._self, this._then);

  final FeatureFlags _self;
  final $Res Function(FeatureFlags) _then;

/// Create a copy of FeatureFlags
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enableNewAssignmentParser = null,Object? enableBiometricAuth = null,Object? enableOfflineMode = null,Object? enableExperimentalFeatures = null,}) {
  return _then(_self.copyWith(
enableNewAssignmentParser: null == enableNewAssignmentParser ? _self.enableNewAssignmentParser : enableNewAssignmentParser // ignore: cast_nullable_to_non_nullable
as bool,enableBiometricAuth: null == enableBiometricAuth ? _self.enableBiometricAuth : enableBiometricAuth // ignore: cast_nullable_to_non_nullable
as bool,enableOfflineMode: null == enableOfflineMode ? _self.enableOfflineMode : enableOfflineMode // ignore: cast_nullable_to_non_nullable
as bool,enableExperimentalFeatures: null == enableExperimentalFeatures ? _self.enableExperimentalFeatures : enableExperimentalFeatures // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FeatureFlags implements FeatureFlags {
  const _FeatureFlags({required this.enableNewAssignmentParser, required this.enableBiometricAuth, required this.enableOfflineMode, required this.enableExperimentalFeatures});
  factory _FeatureFlags.fromJson(Map<String, dynamic> json) => _$FeatureFlagsFromJson(json);

@override final  bool enableNewAssignmentParser;
@override final  bool enableBiometricAuth;
@override final  bool enableOfflineMode;
@override final  bool enableExperimentalFeatures;

/// Create a copy of FeatureFlags
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeatureFlagsCopyWith<_FeatureFlags> get copyWith => __$FeatureFlagsCopyWithImpl<_FeatureFlags>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeatureFlagsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeatureFlags&&(identical(other.enableNewAssignmentParser, enableNewAssignmentParser) || other.enableNewAssignmentParser == enableNewAssignmentParser)&&(identical(other.enableBiometricAuth, enableBiometricAuth) || other.enableBiometricAuth == enableBiometricAuth)&&(identical(other.enableOfflineMode, enableOfflineMode) || other.enableOfflineMode == enableOfflineMode)&&(identical(other.enableExperimentalFeatures, enableExperimentalFeatures) || other.enableExperimentalFeatures == enableExperimentalFeatures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enableNewAssignmentParser,enableBiometricAuth,enableOfflineMode,enableExperimentalFeatures);

@override
String toString() {
  return 'FeatureFlags(enableNewAssignmentParser: $enableNewAssignmentParser, enableBiometricAuth: $enableBiometricAuth, enableOfflineMode: $enableOfflineMode, enableExperimentalFeatures: $enableExperimentalFeatures)';
}


}

/// @nodoc
abstract mixin class _$FeatureFlagsCopyWith<$Res> implements $FeatureFlagsCopyWith<$Res> {
  factory _$FeatureFlagsCopyWith(_FeatureFlags value, $Res Function(_FeatureFlags) _then) = __$FeatureFlagsCopyWithImpl;
@override @useResult
$Res call({
 bool enableNewAssignmentParser, bool enableBiometricAuth, bool enableOfflineMode, bool enableExperimentalFeatures
});




}
/// @nodoc
class __$FeatureFlagsCopyWithImpl<$Res>
    implements _$FeatureFlagsCopyWith<$Res> {
  __$FeatureFlagsCopyWithImpl(this._self, this._then);

  final _FeatureFlags _self;
  final $Res Function(_FeatureFlags) _then;

/// Create a copy of FeatureFlags
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enableNewAssignmentParser = null,Object? enableBiometricAuth = null,Object? enableOfflineMode = null,Object? enableExperimentalFeatures = null,}) {
  return _then(_FeatureFlags(
enableNewAssignmentParser: null == enableNewAssignmentParser ? _self.enableNewAssignmentParser : enableNewAssignmentParser // ignore: cast_nullable_to_non_nullable
as bool,enableBiometricAuth: null == enableBiometricAuth ? _self.enableBiometricAuth : enableBiometricAuth // ignore: cast_nullable_to_non_nullable
as bool,enableOfflineMode: null == enableOfflineMode ? _self.enableOfflineMode : enableOfflineMode // ignore: cast_nullable_to_non_nullable
as bool,enableExperimentalFeatures: null == enableExperimentalFeatures ? _self.enableExperimentalFeatures : enableExperimentalFeatures // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
