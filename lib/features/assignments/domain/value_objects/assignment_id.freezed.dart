// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assignment_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AssignmentId {

 String get contentId; String get classId; String? get pluginId;
/// Create a copy of AssignmentId
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssignmentIdCopyWith<AssignmentId> get copyWith => _$AssignmentIdCopyWithImpl<AssignmentId>(this as AssignmentId, _$identity);

  /// Serializes this AssignmentId to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssignmentId&&(identical(other.contentId, contentId) || other.contentId == contentId)&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.pluginId, pluginId) || other.pluginId == pluginId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contentId,classId,pluginId);

@override
String toString() {
  return 'AssignmentId(contentId: $contentId, classId: $classId, pluginId: $pluginId)';
}


}

/// @nodoc
abstract mixin class $AssignmentIdCopyWith<$Res>  {
  factory $AssignmentIdCopyWith(AssignmentId value, $Res Function(AssignmentId) _then) = _$AssignmentIdCopyWithImpl;
@useResult
$Res call({
 String contentId, String classId, String? pluginId
});




}
/// @nodoc
class _$AssignmentIdCopyWithImpl<$Res>
    implements $AssignmentIdCopyWith<$Res> {
  _$AssignmentIdCopyWithImpl(this._self, this._then);

  final AssignmentId _self;
  final $Res Function(AssignmentId) _then;

/// Create a copy of AssignmentId
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contentId = null,Object? classId = null,Object? pluginId = freezed,}) {
  return _then(_self.copyWith(
contentId: null == contentId ? _self.contentId : contentId // ignore: cast_nullable_to_non_nullable
as String,classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,pluginId: freezed == pluginId ? _self.pluginId : pluginId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AssignmentId implements AssignmentId {
  const _AssignmentId({required this.contentId, required this.classId, this.pluginId});
  factory _AssignmentId.fromJson(Map<String, dynamic> json) => _$AssignmentIdFromJson(json);

@override final  String contentId;
@override final  String classId;
@override final  String? pluginId;

/// Create a copy of AssignmentId
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssignmentIdCopyWith<_AssignmentId> get copyWith => __$AssignmentIdCopyWithImpl<_AssignmentId>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssignmentIdToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssignmentId&&(identical(other.contentId, contentId) || other.contentId == contentId)&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.pluginId, pluginId) || other.pluginId == pluginId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contentId,classId,pluginId);

@override
String toString() {
  return 'AssignmentId(contentId: $contentId, classId: $classId, pluginId: $pluginId)';
}


}

/// @nodoc
abstract mixin class _$AssignmentIdCopyWith<$Res> implements $AssignmentIdCopyWith<$Res> {
  factory _$AssignmentIdCopyWith(_AssignmentId value, $Res Function(_AssignmentId) _then) = __$AssignmentIdCopyWithImpl;
@override @useResult
$Res call({
 String contentId, String classId, String? pluginId
});




}
/// @nodoc
class __$AssignmentIdCopyWithImpl<$Res>
    implements _$AssignmentIdCopyWith<$Res> {
  __$AssignmentIdCopyWithImpl(this._self, this._then);

  final _AssignmentId _self;
  final $Res Function(_AssignmentId) _then;

/// Create a copy of AssignmentId
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contentId = null,Object? classId = null,Object? pluginId = freezed,}) {
  return _then(_AssignmentId(
contentId: null == contentId ? _self.contentId : contentId // ignore: cast_nullable_to_non_nullable
as String,classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,pluginId: freezed == pluginId ? _self.pluginId : pluginId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
