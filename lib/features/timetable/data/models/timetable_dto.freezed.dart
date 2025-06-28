// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timetable_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ManaboTimetableResponseDto {

/// HTMLコンテンツ
 String get html;/// レスポンス成功フラグ
 bool get success;
/// Create a copy of ManaboTimetableResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManaboTimetableResponseDtoCopyWith<ManaboTimetableResponseDto> get copyWith => _$ManaboTimetableResponseDtoCopyWithImpl<ManaboTimetableResponseDto>(this as ManaboTimetableResponseDto, _$identity);

  /// Serializes this ManaboTimetableResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManaboTimetableResponseDto&&(identical(other.html, html) || other.html == html)&&(identical(other.success, success) || other.success == success));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,html,success);

@override
String toString() {
  return 'ManaboTimetableResponseDto(html: $html, success: $success)';
}


}

/// @nodoc
abstract mixin class $ManaboTimetableResponseDtoCopyWith<$Res>  {
  factory $ManaboTimetableResponseDtoCopyWith(ManaboTimetableResponseDto value, $Res Function(ManaboTimetableResponseDto) _then) = _$ManaboTimetableResponseDtoCopyWithImpl;
@useResult
$Res call({
 String html, bool success
});




}
/// @nodoc
class _$ManaboTimetableResponseDtoCopyWithImpl<$Res>
    implements $ManaboTimetableResponseDtoCopyWith<$Res> {
  _$ManaboTimetableResponseDtoCopyWithImpl(this._self, this._then);

  final ManaboTimetableResponseDto _self;
  final $Res Function(ManaboTimetableResponseDto) _then;

/// Create a copy of ManaboTimetableResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? html = null,Object? success = null,}) {
  return _then(_self.copyWith(
html: null == html ? _self.html : html // ignore: cast_nullable_to_non_nullable
as String,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ManaboTimetableResponseDto implements ManaboTimetableResponseDto {
  const _ManaboTimetableResponseDto({required this.html, this.success = true});
  factory _ManaboTimetableResponseDto.fromJson(Map<String, dynamic> json) => _$ManaboTimetableResponseDtoFromJson(json);

/// HTMLコンテンツ
@override final  String html;
/// レスポンス成功フラグ
@override@JsonKey() final  bool success;

/// Create a copy of ManaboTimetableResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManaboTimetableResponseDtoCopyWith<_ManaboTimetableResponseDto> get copyWith => __$ManaboTimetableResponseDtoCopyWithImpl<_ManaboTimetableResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ManaboTimetableResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManaboTimetableResponseDto&&(identical(other.html, html) || other.html == html)&&(identical(other.success, success) || other.success == success));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,html,success);

@override
String toString() {
  return 'ManaboTimetableResponseDto(html: $html, success: $success)';
}


}

/// @nodoc
abstract mixin class _$ManaboTimetableResponseDtoCopyWith<$Res> implements $ManaboTimetableResponseDtoCopyWith<$Res> {
  factory _$ManaboTimetableResponseDtoCopyWith(_ManaboTimetableResponseDto value, $Res Function(_ManaboTimetableResponseDto) _then) = __$ManaboTimetableResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String html, bool success
});




}
/// @nodoc
class __$ManaboTimetableResponseDtoCopyWithImpl<$Res>
    implements _$ManaboTimetableResponseDtoCopyWith<$Res> {
  __$ManaboTimetableResponseDtoCopyWithImpl(this._self, this._then);

  final _ManaboTimetableResponseDto _self;
  final $Res Function(_ManaboTimetableResponseDto) _then;

/// Create a copy of ManaboTimetableResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? html = null,Object? success = null,}) {
  return _then(_ManaboTimetableResponseDto(
html: null == html ? _self.html : html // ignore: cast_nullable_to_non_nullable
as String,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CubicsRoomDto {

/// 建物名
 String get building;/// 教室番号
 String get room;/// キャンパス
 String get campus;
/// Create a copy of CubicsRoomDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CubicsRoomDtoCopyWith<CubicsRoomDto> get copyWith => _$CubicsRoomDtoCopyWithImpl<CubicsRoomDto>(this as CubicsRoomDto, _$identity);

  /// Serializes this CubicsRoomDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CubicsRoomDto&&(identical(other.building, building) || other.building == building)&&(identical(other.room, room) || other.room == room)&&(identical(other.campus, campus) || other.campus == campus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,building,room,campus);

@override
String toString() {
  return 'CubicsRoomDto(building: $building, room: $room, campus: $campus)';
}


}

/// @nodoc
abstract mixin class $CubicsRoomDtoCopyWith<$Res>  {
  factory $CubicsRoomDtoCopyWith(CubicsRoomDto value, $Res Function(CubicsRoomDto) _then) = _$CubicsRoomDtoCopyWithImpl;
@useResult
$Res call({
 String building, String room, String campus
});




}
/// @nodoc
class _$CubicsRoomDtoCopyWithImpl<$Res>
    implements $CubicsRoomDtoCopyWith<$Res> {
  _$CubicsRoomDtoCopyWithImpl(this._self, this._then);

  final CubicsRoomDto _self;
  final $Res Function(CubicsRoomDto) _then;

/// Create a copy of CubicsRoomDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? building = null,Object? room = null,Object? campus = null,}) {
  return _then(_self.copyWith(
building: null == building ? _self.building : building // ignore: cast_nullable_to_non_nullable
as String,room: null == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String,campus: null == campus ? _self.campus : campus // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CubicsRoomDto implements CubicsRoomDto {
  const _CubicsRoomDto({required this.building, required this.room, required this.campus});
  factory _CubicsRoomDto.fromJson(Map<String, dynamic> json) => _$CubicsRoomDtoFromJson(json);

/// 建物名
@override final  String building;
/// 教室番号
@override final  String room;
/// キャンパス
@override final  String campus;

/// Create a copy of CubicsRoomDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CubicsRoomDtoCopyWith<_CubicsRoomDto> get copyWith => __$CubicsRoomDtoCopyWithImpl<_CubicsRoomDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CubicsRoomDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CubicsRoomDto&&(identical(other.building, building) || other.building == building)&&(identical(other.room, room) || other.room == room)&&(identical(other.campus, campus) || other.campus == campus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,building,room,campus);

@override
String toString() {
  return 'CubicsRoomDto(building: $building, room: $room, campus: $campus)';
}


}

/// @nodoc
abstract mixin class _$CubicsRoomDtoCopyWith<$Res> implements $CubicsRoomDtoCopyWith<$Res> {
  factory _$CubicsRoomDtoCopyWith(_CubicsRoomDto value, $Res Function(_CubicsRoomDto) _then) = __$CubicsRoomDtoCopyWithImpl;
@override @useResult
$Res call({
 String building, String room, String campus
});




}
/// @nodoc
class __$CubicsRoomDtoCopyWithImpl<$Res>
    implements _$CubicsRoomDtoCopyWith<$Res> {
  __$CubicsRoomDtoCopyWithImpl(this._self, this._then);

  final _CubicsRoomDto _self;
  final $Res Function(_CubicsRoomDto) _then;

/// Create a copy of CubicsRoomDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? building = null,Object? room = null,Object? campus = null,}) {
  return _then(_CubicsRoomDto(
building: null == building ? _self.building : building // ignore: cast_nullable_to_non_nullable
as String,room: null == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String,campus: null == campus ? _self.campus : campus // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ManaboSlotDto {

/// 曜日（1=月、2=火...）
 int get weekday;/// 時限
 int get period;/// 授業名
 String? get courseName;/// 教員名
 String? get teacher;/// 教室
 String? get room;/// MaNaBoクラスID
 int? get manaboClassId;/// 授業コード
 String? get courseCode;
/// Create a copy of ManaboSlotDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManaboSlotDtoCopyWith<ManaboSlotDto> get copyWith => _$ManaboSlotDtoCopyWithImpl<ManaboSlotDto>(this as ManaboSlotDto, _$identity);

  /// Serializes this ManaboSlotDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManaboSlotDto&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.period, period) || other.period == period)&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.teacher, teacher) || other.teacher == teacher)&&(identical(other.room, room) || other.room == room)&&(identical(other.manaboClassId, manaboClassId) || other.manaboClassId == manaboClassId)&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekday,period,courseName,teacher,room,manaboClassId,courseCode);

@override
String toString() {
  return 'ManaboSlotDto(weekday: $weekday, period: $period, courseName: $courseName, teacher: $teacher, room: $room, manaboClassId: $manaboClassId, courseCode: $courseCode)';
}


}

/// @nodoc
abstract mixin class $ManaboSlotDtoCopyWith<$Res>  {
  factory $ManaboSlotDtoCopyWith(ManaboSlotDto value, $Res Function(ManaboSlotDto) _then) = _$ManaboSlotDtoCopyWithImpl;
@useResult
$Res call({
 int weekday, int period, String? courseName, String? teacher, String? room, int? manaboClassId, String? courseCode
});




}
/// @nodoc
class _$ManaboSlotDtoCopyWithImpl<$Res>
    implements $ManaboSlotDtoCopyWith<$Res> {
  _$ManaboSlotDtoCopyWithImpl(this._self, this._then);

  final ManaboSlotDto _self;
  final $Res Function(ManaboSlotDto) _then;

/// Create a copy of ManaboSlotDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekday = null,Object? period = null,Object? courseName = freezed,Object? teacher = freezed,Object? room = freezed,Object? manaboClassId = freezed,Object? courseCode = freezed,}) {
  return _then(_self.copyWith(
weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as int,courseName: freezed == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String?,teacher: freezed == teacher ? _self.teacher : teacher // ignore: cast_nullable_to_non_nullable
as String?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String?,manaboClassId: freezed == manaboClassId ? _self.manaboClassId : manaboClassId // ignore: cast_nullable_to_non_nullable
as int?,courseCode: freezed == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ManaboSlotDto implements ManaboSlotDto {
  const _ManaboSlotDto({required this.weekday, required this.period, this.courseName, this.teacher, this.room, this.manaboClassId, this.courseCode});
  factory _ManaboSlotDto.fromJson(Map<String, dynamic> json) => _$ManaboSlotDtoFromJson(json);

/// 曜日（1=月、2=火...）
@override final  int weekday;
/// 時限
@override final  int period;
/// 授業名
@override final  String? courseName;
/// 教員名
@override final  String? teacher;
/// 教室
@override final  String? room;
/// MaNaBoクラスID
@override final  int? manaboClassId;
/// 授業コード
@override final  String? courseCode;

/// Create a copy of ManaboSlotDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManaboSlotDtoCopyWith<_ManaboSlotDto> get copyWith => __$ManaboSlotDtoCopyWithImpl<_ManaboSlotDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ManaboSlotDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManaboSlotDto&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.period, period) || other.period == period)&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.teacher, teacher) || other.teacher == teacher)&&(identical(other.room, room) || other.room == room)&&(identical(other.manaboClassId, manaboClassId) || other.manaboClassId == manaboClassId)&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekday,period,courseName,teacher,room,manaboClassId,courseCode);

@override
String toString() {
  return 'ManaboSlotDto(weekday: $weekday, period: $period, courseName: $courseName, teacher: $teacher, room: $room, manaboClassId: $manaboClassId, courseCode: $courseCode)';
}


}

/// @nodoc
abstract mixin class _$ManaboSlotDtoCopyWith<$Res> implements $ManaboSlotDtoCopyWith<$Res> {
  factory _$ManaboSlotDtoCopyWith(_ManaboSlotDto value, $Res Function(_ManaboSlotDto) _then) = __$ManaboSlotDtoCopyWithImpl;
@override @useResult
$Res call({
 int weekday, int period, String? courseName, String? teacher, String? room, int? manaboClassId, String? courseCode
});




}
/// @nodoc
class __$ManaboSlotDtoCopyWithImpl<$Res>
    implements _$ManaboSlotDtoCopyWith<$Res> {
  __$ManaboSlotDtoCopyWithImpl(this._self, this._then);

  final _ManaboSlotDto _self;
  final $Res Function(_ManaboSlotDto) _then;

/// Create a copy of ManaboSlotDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekday = null,Object? period = null,Object? courseName = freezed,Object? teacher = freezed,Object? room = freezed,Object? manaboClassId = freezed,Object? courseCode = freezed,}) {
  return _then(_ManaboSlotDto(
weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as int,courseName: freezed == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String?,teacher: freezed == teacher ? _self.teacher : teacher // ignore: cast_nullable_to_non_nullable
as String?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String?,manaboClassId: freezed == manaboClassId ? _self.manaboClassId : manaboClassId // ignore: cast_nullable_to_non_nullable
as int?,courseCode: freezed == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
