// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CampusEntity {

 Campus get id; String get name; String get description; List<LineId> get availableLines;
/// Create a copy of CampusEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusEntityCopyWith<CampusEntity> get copyWith => _$CampusEntityCopyWithImpl<CampusEntity>(this as CampusEntity, _$identity);

  /// Serializes this CampusEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.availableLines, availableLines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,const DeepCollectionEquality().hash(availableLines));

@override
String toString() {
  return 'CampusEntity(id: $id, name: $name, description: $description, availableLines: $availableLines)';
}


}

/// @nodoc
abstract mixin class $CampusEntityCopyWith<$Res>  {
  factory $CampusEntityCopyWith(CampusEntity value, $Res Function(CampusEntity) _then) = _$CampusEntityCopyWithImpl;
@useResult
$Res call({
 Campus id, String name, String description, List<LineId> availableLines
});




}
/// @nodoc
class _$CampusEntityCopyWithImpl<$Res>
    implements $CampusEntityCopyWith<$Res> {
  _$CampusEntityCopyWithImpl(this._self, this._then);

  final CampusEntity _self;
  final $Res Function(CampusEntity) _then;

/// Create a copy of CampusEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? availableLines = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Campus,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,availableLines: null == availableLines ? _self.availableLines : availableLines // ignore: cast_nullable_to_non_nullable
as List<LineId>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CampusEntity implements CampusEntity {
  const _CampusEntity({required this.id, required this.name, required this.description, required final  List<LineId> availableLines}): _availableLines = availableLines;
  factory _CampusEntity.fromJson(Map<String, dynamic> json) => _$CampusEntityFromJson(json);

@override final  Campus id;
@override final  String name;
@override final  String description;
 final  List<LineId> _availableLines;
@override List<LineId> get availableLines {
  if (_availableLines is EqualUnmodifiableListView) return _availableLines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableLines);
}


/// Create a copy of CampusEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusEntityCopyWith<_CampusEntity> get copyWith => __$CampusEntityCopyWithImpl<_CampusEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampusEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._availableLines, _availableLines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,const DeepCollectionEquality().hash(_availableLines));

@override
String toString() {
  return 'CampusEntity(id: $id, name: $name, description: $description, availableLines: $availableLines)';
}


}

/// @nodoc
abstract mixin class _$CampusEntityCopyWith<$Res> implements $CampusEntityCopyWith<$Res> {
  factory _$CampusEntityCopyWith(_CampusEntity value, $Res Function(_CampusEntity) _then) = __$CampusEntityCopyWithImpl;
@override @useResult
$Res call({
 Campus id, String name, String description, List<LineId> availableLines
});




}
/// @nodoc
class __$CampusEntityCopyWithImpl<$Res>
    implements _$CampusEntityCopyWith<$Res> {
  __$CampusEntityCopyWithImpl(this._self, this._then);

  final _CampusEntity _self;
  final $Res Function(_CampusEntity) _then;

/// Create a copy of CampusEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? availableLines = null,}) {
  return _then(_CampusEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Campus,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,availableLines: null == availableLines ? _self._availableLines : availableLines // ignore: cast_nullable_to_non_nullable
as List<LineId>,
  ));
}


}

// dart format on
