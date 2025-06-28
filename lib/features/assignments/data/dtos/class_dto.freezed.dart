// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClassDto {

 String get classId; String get name; String get instructor; String? get url;
/// Create a copy of ClassDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassDtoCopyWith<ClassDto> get copyWith => _$ClassDtoCopyWithImpl<ClassDto>(this as ClassDto, _$identity);

  /// Serializes this ClassDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassDto&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.name, name) || other.name == name)&&(identical(other.instructor, instructor) || other.instructor == instructor)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classId,name,instructor,url);

@override
String toString() {
  return 'ClassDto(classId: $classId, name: $name, instructor: $instructor, url: $url)';
}


}

/// @nodoc
abstract mixin class $ClassDtoCopyWith<$Res>  {
  factory $ClassDtoCopyWith(ClassDto value, $Res Function(ClassDto) _then) = _$ClassDtoCopyWithImpl;
@useResult
$Res call({
 String classId, String name, String instructor, String? url
});




}
/// @nodoc
class _$ClassDtoCopyWithImpl<$Res>
    implements $ClassDtoCopyWith<$Res> {
  _$ClassDtoCopyWithImpl(this._self, this._then);

  final ClassDto _self;
  final $Res Function(ClassDto) _then;

/// Create a copy of ClassDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? classId = null,Object? name = null,Object? instructor = null,Object? url = freezed,}) {
  return _then(_self.copyWith(
classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,instructor: null == instructor ? _self.instructor : instructor // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ClassDto implements ClassDto {
  const _ClassDto({required this.classId, required this.name, required this.instructor, this.url});
  factory _ClassDto.fromJson(Map<String, dynamic> json) => _$ClassDtoFromJson(json);

@override final  String classId;
@override final  String name;
@override final  String instructor;
@override final  String? url;

/// Create a copy of ClassDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClassDtoCopyWith<_ClassDto> get copyWith => __$ClassDtoCopyWithImpl<_ClassDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClassDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClassDto&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.name, name) || other.name == name)&&(identical(other.instructor, instructor) || other.instructor == instructor)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classId,name,instructor,url);

@override
String toString() {
  return 'ClassDto(classId: $classId, name: $name, instructor: $instructor, url: $url)';
}


}

/// @nodoc
abstract mixin class _$ClassDtoCopyWith<$Res> implements $ClassDtoCopyWith<$Res> {
  factory _$ClassDtoCopyWith(_ClassDto value, $Res Function(_ClassDto) _then) = __$ClassDtoCopyWithImpl;
@override @useResult
$Res call({
 String classId, String name, String instructor, String? url
});




}
/// @nodoc
class __$ClassDtoCopyWithImpl<$Res>
    implements _$ClassDtoCopyWith<$Res> {
  __$ClassDtoCopyWithImpl(this._self, this._then);

  final _ClassDto _self;
  final $Res Function(_ClassDto) _then;

/// Create a copy of ClassDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? classId = null,Object? name = null,Object? instructor = null,Object? url = freezed,}) {
  return _then(_ClassDto(
classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,instructor: null == instructor ? _self.instructor : instructor // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
