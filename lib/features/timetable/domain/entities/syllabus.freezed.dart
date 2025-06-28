// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'syllabus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Syllabus {

/// シラバスID
 String get id;/// 授業名
 String get courseName;/// 教員名
 String get instructor;/// 授業の概要
 String? get overview;/// 授業の目標
 String? get objectives;/// 授業計画
 List<LessonPlan> get lessonPlan;/// 評価方法
 String? get evaluationMethod;/// 教科書
 String? get textbook;/// 参考書
 String? get references;/// 履修上の注意
 String? get notes;/// オフィスアワー
 String? get officeHours;/// 単位数
 int? get credits;/// 授業形態
 String? get format;/// 開講年度
 int? get academicYear;/// 学期
 String? get semester;
/// Create a copy of Syllabus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyllabusCopyWith<Syllabus> get copyWith => _$SyllabusCopyWithImpl<Syllabus>(this as Syllabus, _$identity);

  /// Serializes this Syllabus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Syllabus&&(identical(other.id, id) || other.id == id)&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.instructor, instructor) || other.instructor == instructor)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.objectives, objectives) || other.objectives == objectives)&&const DeepCollectionEquality().equals(other.lessonPlan, lessonPlan)&&(identical(other.evaluationMethod, evaluationMethod) || other.evaluationMethod == evaluationMethod)&&(identical(other.textbook, textbook) || other.textbook == textbook)&&(identical(other.references, references) || other.references == references)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.officeHours, officeHours) || other.officeHours == officeHours)&&(identical(other.credits, credits) || other.credits == credits)&&(identical(other.format, format) || other.format == format)&&(identical(other.academicYear, academicYear) || other.academicYear == academicYear)&&(identical(other.semester, semester) || other.semester == semester));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,courseName,instructor,overview,objectives,const DeepCollectionEquality().hash(lessonPlan),evaluationMethod,textbook,references,notes,officeHours,credits,format,academicYear,semester);

@override
String toString() {
  return 'Syllabus(id: $id, courseName: $courseName, instructor: $instructor, overview: $overview, objectives: $objectives, lessonPlan: $lessonPlan, evaluationMethod: $evaluationMethod, textbook: $textbook, references: $references, notes: $notes, officeHours: $officeHours, credits: $credits, format: $format, academicYear: $academicYear, semester: $semester)';
}


}

/// @nodoc
abstract mixin class $SyllabusCopyWith<$Res>  {
  factory $SyllabusCopyWith(Syllabus value, $Res Function(Syllabus) _then) = _$SyllabusCopyWithImpl;
@useResult
$Res call({
 String id, String courseName, String instructor, String? overview, String? objectives, List<LessonPlan> lessonPlan, String? evaluationMethod, String? textbook, String? references, String? notes, String? officeHours, int? credits, String? format, int? academicYear, String? semester
});




}
/// @nodoc
class _$SyllabusCopyWithImpl<$Res>
    implements $SyllabusCopyWith<$Res> {
  _$SyllabusCopyWithImpl(this._self, this._then);

  final Syllabus _self;
  final $Res Function(Syllabus) _then;

/// Create a copy of Syllabus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? courseName = null,Object? instructor = null,Object? overview = freezed,Object? objectives = freezed,Object? lessonPlan = null,Object? evaluationMethod = freezed,Object? textbook = freezed,Object? references = freezed,Object? notes = freezed,Object? officeHours = freezed,Object? credits = freezed,Object? format = freezed,Object? academicYear = freezed,Object? semester = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,courseName: null == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String,instructor: null == instructor ? _self.instructor : instructor // ignore: cast_nullable_to_non_nullable
as String,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String?,objectives: freezed == objectives ? _self.objectives : objectives // ignore: cast_nullable_to_non_nullable
as String?,lessonPlan: null == lessonPlan ? _self.lessonPlan : lessonPlan // ignore: cast_nullable_to_non_nullable
as List<LessonPlan>,evaluationMethod: freezed == evaluationMethod ? _self.evaluationMethod : evaluationMethod // ignore: cast_nullable_to_non_nullable
as String?,textbook: freezed == textbook ? _self.textbook : textbook // ignore: cast_nullable_to_non_nullable
as String?,references: freezed == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,officeHours: freezed == officeHours ? _self.officeHours : officeHours // ignore: cast_nullable_to_non_nullable
as String?,credits: freezed == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as int?,format: freezed == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String?,academicYear: freezed == academicYear ? _self.academicYear : academicYear // ignore: cast_nullable_to_non_nullable
as int?,semester: freezed == semester ? _self.semester : semester // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Syllabus implements Syllabus {
  const _Syllabus({required this.id, required this.courseName, required this.instructor, this.overview, this.objectives, final  List<LessonPlan> lessonPlan = const [], this.evaluationMethod, this.textbook, this.references, this.notes, this.officeHours, this.credits, this.format, this.academicYear, this.semester}): _lessonPlan = lessonPlan;
  factory _Syllabus.fromJson(Map<String, dynamic> json) => _$SyllabusFromJson(json);

/// シラバスID
@override final  String id;
/// 授業名
@override final  String courseName;
/// 教員名
@override final  String instructor;
/// 授業の概要
@override final  String? overview;
/// 授業の目標
@override final  String? objectives;
/// 授業計画
 final  List<LessonPlan> _lessonPlan;
/// 授業計画
@override@JsonKey() List<LessonPlan> get lessonPlan {
  if (_lessonPlan is EqualUnmodifiableListView) return _lessonPlan;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lessonPlan);
}

/// 評価方法
@override final  String? evaluationMethod;
/// 教科書
@override final  String? textbook;
/// 参考書
@override final  String? references;
/// 履修上の注意
@override final  String? notes;
/// オフィスアワー
@override final  String? officeHours;
/// 単位数
@override final  int? credits;
/// 授業形態
@override final  String? format;
/// 開講年度
@override final  int? academicYear;
/// 学期
@override final  String? semester;

/// Create a copy of Syllabus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyllabusCopyWith<_Syllabus> get copyWith => __$SyllabusCopyWithImpl<_Syllabus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyllabusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Syllabus&&(identical(other.id, id) || other.id == id)&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.instructor, instructor) || other.instructor == instructor)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.objectives, objectives) || other.objectives == objectives)&&const DeepCollectionEquality().equals(other._lessonPlan, _lessonPlan)&&(identical(other.evaluationMethod, evaluationMethod) || other.evaluationMethod == evaluationMethod)&&(identical(other.textbook, textbook) || other.textbook == textbook)&&(identical(other.references, references) || other.references == references)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.officeHours, officeHours) || other.officeHours == officeHours)&&(identical(other.credits, credits) || other.credits == credits)&&(identical(other.format, format) || other.format == format)&&(identical(other.academicYear, academicYear) || other.academicYear == academicYear)&&(identical(other.semester, semester) || other.semester == semester));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,courseName,instructor,overview,objectives,const DeepCollectionEquality().hash(_lessonPlan),evaluationMethod,textbook,references,notes,officeHours,credits,format,academicYear,semester);

@override
String toString() {
  return 'Syllabus(id: $id, courseName: $courseName, instructor: $instructor, overview: $overview, objectives: $objectives, lessonPlan: $lessonPlan, evaluationMethod: $evaluationMethod, textbook: $textbook, references: $references, notes: $notes, officeHours: $officeHours, credits: $credits, format: $format, academicYear: $academicYear, semester: $semester)';
}


}

/// @nodoc
abstract mixin class _$SyllabusCopyWith<$Res> implements $SyllabusCopyWith<$Res> {
  factory _$SyllabusCopyWith(_Syllabus value, $Res Function(_Syllabus) _then) = __$SyllabusCopyWithImpl;
@override @useResult
$Res call({
 String id, String courseName, String instructor, String? overview, String? objectives, List<LessonPlan> lessonPlan, String? evaluationMethod, String? textbook, String? references, String? notes, String? officeHours, int? credits, String? format, int? academicYear, String? semester
});




}
/// @nodoc
class __$SyllabusCopyWithImpl<$Res>
    implements _$SyllabusCopyWith<$Res> {
  __$SyllabusCopyWithImpl(this._self, this._then);

  final _Syllabus _self;
  final $Res Function(_Syllabus) _then;

/// Create a copy of Syllabus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? courseName = null,Object? instructor = null,Object? overview = freezed,Object? objectives = freezed,Object? lessonPlan = null,Object? evaluationMethod = freezed,Object? textbook = freezed,Object? references = freezed,Object? notes = freezed,Object? officeHours = freezed,Object? credits = freezed,Object? format = freezed,Object? academicYear = freezed,Object? semester = freezed,}) {
  return _then(_Syllabus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,courseName: null == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String,instructor: null == instructor ? _self.instructor : instructor // ignore: cast_nullable_to_non_nullable
as String,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String?,objectives: freezed == objectives ? _self.objectives : objectives // ignore: cast_nullable_to_non_nullable
as String?,lessonPlan: null == lessonPlan ? _self._lessonPlan : lessonPlan // ignore: cast_nullable_to_non_nullable
as List<LessonPlan>,evaluationMethod: freezed == evaluationMethod ? _self.evaluationMethod : evaluationMethod // ignore: cast_nullable_to_non_nullable
as String?,textbook: freezed == textbook ? _self.textbook : textbook // ignore: cast_nullable_to_non_nullable
as String?,references: freezed == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,officeHours: freezed == officeHours ? _self.officeHours : officeHours // ignore: cast_nullable_to_non_nullable
as String?,credits: freezed == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as int?,format: freezed == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String?,academicYear: freezed == academicYear ? _self.academicYear : academicYear // ignore: cast_nullable_to_non_nullable
as int?,semester: freezed == semester ? _self.semester : semester // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LessonPlan {

/// 回数
 int get week;/// タイトル
 String get title;/// 内容
 String? get content;/// 事前学習
 String? get preparation;/// 事後学習
 String? get review;
/// Create a copy of LessonPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonPlanCopyWith<LessonPlan> get copyWith => _$LessonPlanCopyWithImpl<LessonPlan>(this as LessonPlan, _$identity);

  /// Serializes this LessonPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonPlan&&(identical(other.week, week) || other.week == week)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.preparation, preparation) || other.preparation == preparation)&&(identical(other.review, review) || other.review == review));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,week,title,content,preparation,review);

@override
String toString() {
  return 'LessonPlan(week: $week, title: $title, content: $content, preparation: $preparation, review: $review)';
}


}

/// @nodoc
abstract mixin class $LessonPlanCopyWith<$Res>  {
  factory $LessonPlanCopyWith(LessonPlan value, $Res Function(LessonPlan) _then) = _$LessonPlanCopyWithImpl;
@useResult
$Res call({
 int week, String title, String? content, String? preparation, String? review
});




}
/// @nodoc
class _$LessonPlanCopyWithImpl<$Res>
    implements $LessonPlanCopyWith<$Res> {
  _$LessonPlanCopyWithImpl(this._self, this._then);

  final LessonPlan _self;
  final $Res Function(LessonPlan) _then;

/// Create a copy of LessonPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? week = null,Object? title = null,Object? content = freezed,Object? preparation = freezed,Object? review = freezed,}) {
  return _then(_self.copyWith(
week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,preparation: freezed == preparation ? _self.preparation : preparation // ignore: cast_nullable_to_non_nullable
as String?,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LessonPlan implements LessonPlan {
  const _LessonPlan({required this.week, required this.title, this.content, this.preparation, this.review});
  factory _LessonPlan.fromJson(Map<String, dynamic> json) => _$LessonPlanFromJson(json);

/// 回数
@override final  int week;
/// タイトル
@override final  String title;
/// 内容
@override final  String? content;
/// 事前学習
@override final  String? preparation;
/// 事後学習
@override final  String? review;

/// Create a copy of LessonPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonPlanCopyWith<_LessonPlan> get copyWith => __$LessonPlanCopyWithImpl<_LessonPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LessonPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonPlan&&(identical(other.week, week) || other.week == week)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.preparation, preparation) || other.preparation == preparation)&&(identical(other.review, review) || other.review == review));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,week,title,content,preparation,review);

@override
String toString() {
  return 'LessonPlan(week: $week, title: $title, content: $content, preparation: $preparation, review: $review)';
}


}

/// @nodoc
abstract mixin class _$LessonPlanCopyWith<$Res> implements $LessonPlanCopyWith<$Res> {
  factory _$LessonPlanCopyWith(_LessonPlan value, $Res Function(_LessonPlan) _then) = __$LessonPlanCopyWithImpl;
@override @useResult
$Res call({
 int week, String title, String? content, String? preparation, String? review
});




}
/// @nodoc
class __$LessonPlanCopyWithImpl<$Res>
    implements _$LessonPlanCopyWith<$Res> {
  __$LessonPlanCopyWithImpl(this._self, this._then);

  final _LessonPlan _self;
  final $Res Function(_LessonPlan) _then;

/// Create a copy of LessonPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? week = null,Object? title = null,Object? content = freezed,Object? preparation = freezed,Object? review = freezed,}) {
  return _then(_LessonPlan(
week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,preparation: freezed == preparation ? _self.preparation : preparation // ignore: cast_nullable_to_non_nullable
as String?,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
