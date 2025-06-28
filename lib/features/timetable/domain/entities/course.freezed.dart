// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Course {

/// コースID
 String get id;/// 授業名
 String get title;/// 教員名
 String get teacher;/// 教室
 String? get room;/// MaNaBoクラスID
 int get manaboClassId;/// 授業コード
 String? get courseCode;/// 単位数
 int? get credits;/// 授業形態
 String? get format;
/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseCopyWith<Course> get copyWith => _$CourseCopyWithImpl<Course>(this as Course, _$identity);

  /// Serializes this Course to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Course&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.teacher, teacher) || other.teacher == teacher)&&(identical(other.room, room) || other.room == room)&&(identical(other.manaboClassId, manaboClassId) || other.manaboClassId == manaboClassId)&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.credits, credits) || other.credits == credits)&&(identical(other.format, format) || other.format == format));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,teacher,room,manaboClassId,courseCode,credits,format);

@override
String toString() {
  return 'Course(id: $id, title: $title, teacher: $teacher, room: $room, manaboClassId: $manaboClassId, courseCode: $courseCode, credits: $credits, format: $format)';
}


}

/// @nodoc
abstract mixin class $CourseCopyWith<$Res>  {
  factory $CourseCopyWith(Course value, $Res Function(Course) _then) = _$CourseCopyWithImpl;
@useResult
$Res call({
 String id, String title, String teacher, String? room, int manaboClassId, String? courseCode, int? credits, String? format
});




}
/// @nodoc
class _$CourseCopyWithImpl<$Res>
    implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._self, this._then);

  final Course _self;
  final $Res Function(Course) _then;

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? teacher = null,Object? room = freezed,Object? manaboClassId = null,Object? courseCode = freezed,Object? credits = freezed,Object? format = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,teacher: null == teacher ? _self.teacher : teacher // ignore: cast_nullable_to_non_nullable
as String,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String?,manaboClassId: null == manaboClassId ? _self.manaboClassId : manaboClassId // ignore: cast_nullable_to_non_nullable
as int,courseCode: freezed == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String?,credits: freezed == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as int?,format: freezed == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Course implements Course {
  const _Course({required this.id, required this.title, required this.teacher, this.room, required this.manaboClassId, this.courseCode, this.credits, this.format});
  factory _Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

/// コースID
@override final  String id;
/// 授業名
@override final  String title;
/// 教員名
@override final  String teacher;
/// 教室
@override final  String? room;
/// MaNaBoクラスID
@override final  int manaboClassId;
/// 授業コード
@override final  String? courseCode;
/// 単位数
@override final  int? credits;
/// 授業形態
@override final  String? format;

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseCopyWith<_Course> get copyWith => __$CourseCopyWithImpl<_Course>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Course&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.teacher, teacher) || other.teacher == teacher)&&(identical(other.room, room) || other.room == room)&&(identical(other.manaboClassId, manaboClassId) || other.manaboClassId == manaboClassId)&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.credits, credits) || other.credits == credits)&&(identical(other.format, format) || other.format == format));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,teacher,room,manaboClassId,courseCode,credits,format);

@override
String toString() {
  return 'Course(id: $id, title: $title, teacher: $teacher, room: $room, manaboClassId: $manaboClassId, courseCode: $courseCode, credits: $credits, format: $format)';
}


}

/// @nodoc
abstract mixin class _$CourseCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$CourseCopyWith(_Course value, $Res Function(_Course) _then) = __$CourseCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String teacher, String? room, int manaboClassId, String? courseCode, int? credits, String? format
});




}
/// @nodoc
class __$CourseCopyWithImpl<$Res>
    implements _$CourseCopyWith<$Res> {
  __$CourseCopyWithImpl(this._self, this._then);

  final _Course _self;
  final $Res Function(_Course) _then;

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? teacher = null,Object? room = freezed,Object? manaboClassId = null,Object? courseCode = freezed,Object? credits = freezed,Object? format = freezed,}) {
  return _then(_Course(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,teacher: null == teacher ? _self.teacher : teacher // ignore: cast_nullable_to_non_nullable
as String,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String?,manaboClassId: null == manaboClassId ? _self.manaboClassId : manaboClassId // ignore: cast_nullable_to_non_nullable
as int,courseCode: freezed == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String?,credits: freezed == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as int?,format: freezed == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CourseDetail {

/// 基本情報
 Course get course;/// シラバス
 Syllabus? get syllabus;/// 授業資料リスト
 List<CourseMaterial> get materials;/// お知らせリスト
 List<CourseNews> get news;/// 出席状態
 AttendanceState? get attendanceState;
/// Create a copy of CourseDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseDetailCopyWith<CourseDetail> get copyWith => _$CourseDetailCopyWithImpl<CourseDetail>(this as CourseDetail, _$identity);

  /// Serializes this CourseDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetail&&(identical(other.course, course) || other.course == course)&&(identical(other.syllabus, syllabus) || other.syllabus == syllabus)&&const DeepCollectionEquality().equals(other.materials, materials)&&const DeepCollectionEquality().equals(other.news, news)&&(identical(other.attendanceState, attendanceState) || other.attendanceState == attendanceState));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,course,syllabus,const DeepCollectionEquality().hash(materials),const DeepCollectionEquality().hash(news),attendanceState);

@override
String toString() {
  return 'CourseDetail(course: $course, syllabus: $syllabus, materials: $materials, news: $news, attendanceState: $attendanceState)';
}


}

/// @nodoc
abstract mixin class $CourseDetailCopyWith<$Res>  {
  factory $CourseDetailCopyWith(CourseDetail value, $Res Function(CourseDetail) _then) = _$CourseDetailCopyWithImpl;
@useResult
$Res call({
 Course course, Syllabus? syllabus, List<CourseMaterial> materials, List<CourseNews> news, AttendanceState? attendanceState
});


$CourseCopyWith<$Res> get course;$SyllabusCopyWith<$Res>? get syllabus;$AttendanceStateCopyWith<$Res>? get attendanceState;

}
/// @nodoc
class _$CourseDetailCopyWithImpl<$Res>
    implements $CourseDetailCopyWith<$Res> {
  _$CourseDetailCopyWithImpl(this._self, this._then);

  final CourseDetail _self;
  final $Res Function(CourseDetail) _then;

/// Create a copy of CourseDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? course = null,Object? syllabus = freezed,Object? materials = null,Object? news = null,Object? attendanceState = freezed,}) {
  return _then(_self.copyWith(
course: null == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as Course,syllabus: freezed == syllabus ? _self.syllabus : syllabus // ignore: cast_nullable_to_non_nullable
as Syllabus?,materials: null == materials ? _self.materials : materials // ignore: cast_nullable_to_non_nullable
as List<CourseMaterial>,news: null == news ? _self.news : news // ignore: cast_nullable_to_non_nullable
as List<CourseNews>,attendanceState: freezed == attendanceState ? _self.attendanceState : attendanceState // ignore: cast_nullable_to_non_nullable
as AttendanceState?,
  ));
}
/// Create a copy of CourseDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CourseCopyWith<$Res> get course {
  
  return $CourseCopyWith<$Res>(_self.course, (value) {
    return _then(_self.copyWith(course: value));
  });
}/// Create a copy of CourseDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SyllabusCopyWith<$Res>? get syllabus {
    if (_self.syllabus == null) {
    return null;
  }

  return $SyllabusCopyWith<$Res>(_self.syllabus!, (value) {
    return _then(_self.copyWith(syllabus: value));
  });
}/// Create a copy of CourseDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceStateCopyWith<$Res>? get attendanceState {
    if (_self.attendanceState == null) {
    return null;
  }

  return $AttendanceStateCopyWith<$Res>(_self.attendanceState!, (value) {
    return _then(_self.copyWith(attendanceState: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _CourseDetail implements CourseDetail {
  const _CourseDetail({required this.course, this.syllabus, final  List<CourseMaterial> materials = const [], final  List<CourseNews> news = const [], this.attendanceState}): _materials = materials,_news = news;
  factory _CourseDetail.fromJson(Map<String, dynamic> json) => _$CourseDetailFromJson(json);

/// 基本情報
@override final  Course course;
/// シラバス
@override final  Syllabus? syllabus;
/// 授業資料リスト
 final  List<CourseMaterial> _materials;
/// 授業資料リスト
@override@JsonKey() List<CourseMaterial> get materials {
  if (_materials is EqualUnmodifiableListView) return _materials;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_materials);
}

/// お知らせリスト
 final  List<CourseNews> _news;
/// お知らせリスト
@override@JsonKey() List<CourseNews> get news {
  if (_news is EqualUnmodifiableListView) return _news;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_news);
}

/// 出席状態
@override final  AttendanceState? attendanceState;

/// Create a copy of CourseDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseDetailCopyWith<_CourseDetail> get copyWith => __$CourseDetailCopyWithImpl<_CourseDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseDetail&&(identical(other.course, course) || other.course == course)&&(identical(other.syllabus, syllabus) || other.syllabus == syllabus)&&const DeepCollectionEquality().equals(other._materials, _materials)&&const DeepCollectionEquality().equals(other._news, _news)&&(identical(other.attendanceState, attendanceState) || other.attendanceState == attendanceState));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,course,syllabus,const DeepCollectionEquality().hash(_materials),const DeepCollectionEquality().hash(_news),attendanceState);

@override
String toString() {
  return 'CourseDetail(course: $course, syllabus: $syllabus, materials: $materials, news: $news, attendanceState: $attendanceState)';
}


}

/// @nodoc
abstract mixin class _$CourseDetailCopyWith<$Res> implements $CourseDetailCopyWith<$Res> {
  factory _$CourseDetailCopyWith(_CourseDetail value, $Res Function(_CourseDetail) _then) = __$CourseDetailCopyWithImpl;
@override @useResult
$Res call({
 Course course, Syllabus? syllabus, List<CourseMaterial> materials, List<CourseNews> news, AttendanceState? attendanceState
});


@override $CourseCopyWith<$Res> get course;@override $SyllabusCopyWith<$Res>? get syllabus;@override $AttendanceStateCopyWith<$Res>? get attendanceState;

}
/// @nodoc
class __$CourseDetailCopyWithImpl<$Res>
    implements _$CourseDetailCopyWith<$Res> {
  __$CourseDetailCopyWithImpl(this._self, this._then);

  final _CourseDetail _self;
  final $Res Function(_CourseDetail) _then;

/// Create a copy of CourseDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? course = null,Object? syllabus = freezed,Object? materials = null,Object? news = null,Object? attendanceState = freezed,}) {
  return _then(_CourseDetail(
course: null == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as Course,syllabus: freezed == syllabus ? _self.syllabus : syllabus // ignore: cast_nullable_to_non_nullable
as Syllabus?,materials: null == materials ? _self._materials : materials // ignore: cast_nullable_to_non_nullable
as List<CourseMaterial>,news: null == news ? _self._news : news // ignore: cast_nullable_to_non_nullable
as List<CourseNews>,attendanceState: freezed == attendanceState ? _self.attendanceState : attendanceState // ignore: cast_nullable_to_non_nullable
as AttendanceState?,
  ));
}

/// Create a copy of CourseDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CourseCopyWith<$Res> get course {
  
  return $CourseCopyWith<$Res>(_self.course, (value) {
    return _then(_self.copyWith(course: value));
  });
}/// Create a copy of CourseDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SyllabusCopyWith<$Res>? get syllabus {
    if (_self.syllabus == null) {
    return null;
  }

  return $SyllabusCopyWith<$Res>(_self.syllabus!, (value) {
    return _then(_self.copyWith(syllabus: value));
  });
}/// Create a copy of CourseDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceStateCopyWith<$Res>? get attendanceState {
    if (_self.attendanceState == null) {
    return null;
  }

  return $AttendanceStateCopyWith<$Res>(_self.attendanceState!, (value) {
    return _then(_self.copyWith(attendanceState: value));
  });
}
}

// dart format on
