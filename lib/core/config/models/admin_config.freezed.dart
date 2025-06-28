// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminConfig {

// メンテナンスモード
 bool get maintenanceMode;// 最小バージョン
 String get minimumVersion;
/// Create a copy of AdminConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminConfigCopyWith<AdminConfig> get copyWith => _$AdminConfigCopyWithImpl<AdminConfig>(this as AdminConfig, _$identity);

  /// Serializes this AdminConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminConfig&&(identical(other.maintenanceMode, maintenanceMode) || other.maintenanceMode == maintenanceMode)&&(identical(other.minimumVersion, minimumVersion) || other.minimumVersion == minimumVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maintenanceMode,minimumVersion);

@override
String toString() {
  return 'AdminConfig(maintenanceMode: $maintenanceMode, minimumVersion: $minimumVersion)';
}


}

/// @nodoc
abstract mixin class $AdminConfigCopyWith<$Res>  {
  factory $AdminConfigCopyWith(AdminConfig value, $Res Function(AdminConfig) _then) = _$AdminConfigCopyWithImpl;
@useResult
$Res call({
 bool maintenanceMode, String minimumVersion
});




}
/// @nodoc
class _$AdminConfigCopyWithImpl<$Res>
    implements $AdminConfigCopyWith<$Res> {
  _$AdminConfigCopyWithImpl(this._self, this._then);

  final AdminConfig _self;
  final $Res Function(AdminConfig) _then;

/// Create a copy of AdminConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maintenanceMode = null,Object? minimumVersion = null,}) {
  return _then(_self.copyWith(
maintenanceMode: null == maintenanceMode ? _self.maintenanceMode : maintenanceMode // ignore: cast_nullable_to_non_nullable
as bool,minimumVersion: null == minimumVersion ? _self.minimumVersion : minimumVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AdminConfig implements AdminConfig {
  const _AdminConfig({required this.maintenanceMode, required this.minimumVersion});
  factory _AdminConfig.fromJson(Map<String, dynamic> json) => _$AdminConfigFromJson(json);

// メンテナンスモード
@override final  bool maintenanceMode;
// 最小バージョン
@override final  String minimumVersion;

/// Create a copy of AdminConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminConfigCopyWith<_AdminConfig> get copyWith => __$AdminConfigCopyWithImpl<_AdminConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminConfig&&(identical(other.maintenanceMode, maintenanceMode) || other.maintenanceMode == maintenanceMode)&&(identical(other.minimumVersion, minimumVersion) || other.minimumVersion == minimumVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maintenanceMode,minimumVersion);

@override
String toString() {
  return 'AdminConfig(maintenanceMode: $maintenanceMode, minimumVersion: $minimumVersion)';
}


}

/// @nodoc
abstract mixin class _$AdminConfigCopyWith<$Res> implements $AdminConfigCopyWith<$Res> {
  factory _$AdminConfigCopyWith(_AdminConfig value, $Res Function(_AdminConfig) _then) = __$AdminConfigCopyWithImpl;
@override @useResult
$Res call({
 bool maintenanceMode, String minimumVersion
});




}
/// @nodoc
class __$AdminConfigCopyWithImpl<$Res>
    implements _$AdminConfigCopyWith<$Res> {
  __$AdminConfigCopyWithImpl(this._self, this._then);

  final _AdminConfig _self;
  final $Res Function(_AdminConfig) _then;

/// Create a copy of AdminConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maintenanceMode = null,Object? minimumVersion = null,}) {
  return _then(_AdminConfig(
maintenanceMode: null == maintenanceMode ? _self.maintenanceMode : maintenanceMode // ignore: cast_nullable_to_non_nullable
as bool,minimumVersion: null == minimumVersion ? _self.minimumVersion : minimumVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
