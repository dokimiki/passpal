// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Term {

/// アーカイブID (MaNaBoで使用)
 int get archiveId;/// 年度
 int get year;/// 学期 (春学期/秋学期)
 Semester get semester;/// 表示名 (例: "2025 春学期")
 String get displayName;
/// Create a copy of Term
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TermCopyWith<Term> get copyWith => _$TermCopyWithImpl<Term>(this as Term, _$identity);

  /// Serializes this Term to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Term&&(identical(other.archiveId, archiveId) || other.archiveId == archiveId)&&(identical(other.year, year) || other.year == year)&&(identical(other.semester, semester) || other.semester == semester)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,archiveId,year,semester,displayName);

@override
String toString() {
  return 'Term(archiveId: $archiveId, year: $year, semester: $semester, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class $TermCopyWith<$Res>  {
  factory $TermCopyWith(Term value, $Res Function(Term) _then) = _$TermCopyWithImpl;
@useResult
$Res call({
 int archiveId, int year, Semester semester, String displayName
});




}
/// @nodoc
class _$TermCopyWithImpl<$Res>
    implements $TermCopyWith<$Res> {
  _$TermCopyWithImpl(this._self, this._then);

  final Term _self;
  final $Res Function(Term) _then;

/// Create a copy of Term
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? archiveId = null,Object? year = null,Object? semester = null,Object? displayName = null,}) {
  return _then(_self.copyWith(
archiveId: null == archiveId ? _self.archiveId : archiveId // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,semester: null == semester ? _self.semester : semester // ignore: cast_nullable_to_non_nullable
as Semester,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Term implements Term {
  const _Term({required this.archiveId, required this.year, required this.semester, required this.displayName});
  factory _Term.fromJson(Map<String, dynamic> json) => _$TermFromJson(json);

/// アーカイブID (MaNaBoで使用)
@override final  int archiveId;
/// 年度
@override final  int year;
/// 学期 (春学期/秋学期)
@override final  Semester semester;
/// 表示名 (例: "2025 春学期")
@override final  String displayName;

/// Create a copy of Term
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TermCopyWith<_Term> get copyWith => __$TermCopyWithImpl<_Term>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TermToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Term&&(identical(other.archiveId, archiveId) || other.archiveId == archiveId)&&(identical(other.year, year) || other.year == year)&&(identical(other.semester, semester) || other.semester == semester)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,archiveId,year,semester,displayName);

@override
String toString() {
  return 'Term(archiveId: $archiveId, year: $year, semester: $semester, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$TermCopyWith<$Res> implements $TermCopyWith<$Res> {
  factory _$TermCopyWith(_Term value, $Res Function(_Term) _then) = __$TermCopyWithImpl;
@override @useResult
$Res call({
 int archiveId, int year, Semester semester, String displayName
});




}
/// @nodoc
class __$TermCopyWithImpl<$Res>
    implements _$TermCopyWith<$Res> {
  __$TermCopyWithImpl(this._self, this._then);

  final _Term _self;
  final $Res Function(_Term) _then;

/// Create a copy of Term
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? archiveId = null,Object? year = null,Object? semester = null,Object? displayName = null,}) {
  return _then(_Term(
archiveId: null == archiveId ? _self.archiveId : archiveId // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,semester: null == semester ? _self.semester : semester // ignore: cast_nullable_to_non_nullable
as Semester,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
