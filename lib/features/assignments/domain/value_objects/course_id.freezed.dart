// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourseId {

 String get classId; String? get directoryId;
/// Create a copy of CourseId
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseIdCopyWith<CourseId> get copyWith => _$CourseIdCopyWithImpl<CourseId>(this as CourseId, _$identity);

  /// Serializes this CourseId to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseId&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.directoryId, directoryId) || other.directoryId == directoryId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classId,directoryId);

@override
String toString() {
  return 'CourseId(classId: $classId, directoryId: $directoryId)';
}


}

/// @nodoc
abstract mixin class $CourseIdCopyWith<$Res>  {
  factory $CourseIdCopyWith(CourseId value, $Res Function(CourseId) _then) = _$CourseIdCopyWithImpl;
@useResult
$Res call({
 String classId, String? directoryId
});




}
/// @nodoc
class _$CourseIdCopyWithImpl<$Res>
    implements $CourseIdCopyWith<$Res> {
  _$CourseIdCopyWithImpl(this._self, this._then);

  final CourseId _self;
  final $Res Function(CourseId) _then;

/// Create a copy of CourseId
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? classId = null,Object? directoryId = freezed,}) {
  return _then(_self.copyWith(
classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,directoryId: freezed == directoryId ? _self.directoryId : directoryId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CourseId implements CourseId {
  const _CourseId({required this.classId, this.directoryId});
  factory _CourseId.fromJson(Map<String, dynamic> json) => _$CourseIdFromJson(json);

@override final  String classId;
@override final  String? directoryId;

/// Create a copy of CourseId
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseIdCopyWith<_CourseId> get copyWith => __$CourseIdCopyWithImpl<_CourseId>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseIdToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseId&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.directoryId, directoryId) || other.directoryId == directoryId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classId,directoryId);

@override
String toString() {
  return 'CourseId(classId: $classId, directoryId: $directoryId)';
}


}

/// @nodoc
abstract mixin class _$CourseIdCopyWith<$Res> implements $CourseIdCopyWith<$Res> {
  factory _$CourseIdCopyWith(_CourseId value, $Res Function(_CourseId) _then) = __$CourseIdCopyWithImpl;
@override @useResult
$Res call({
 String classId, String? directoryId
});




}
/// @nodoc
class __$CourseIdCopyWithImpl<$Res>
    implements _$CourseIdCopyWith<$Res> {
  __$CourseIdCopyWithImpl(this._self, this._then);

  final _CourseId _self;
  final $Res Function(_CourseId) _then;

/// Create a copy of CourseId
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? classId = null,Object? directoryId = freezed,}) {
  return _then(_CourseId(
classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,directoryId: freezed == directoryId ? _self.directoryId : directoryId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
