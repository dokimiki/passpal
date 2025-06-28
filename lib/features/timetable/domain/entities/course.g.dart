// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Course _$CourseFromJson(Map<String, dynamic> json) => _Course(
  id: json['id'] as String,
  title: json['title'] as String,
  teacher: json['teacher'] as String,
  room: json['room'] as String?,
  manaboClassId: (json['manaboClassId'] as num).toInt(),
  courseCode: json['courseCode'] as String?,
  credits: (json['credits'] as num?)?.toInt(),
  format: json['format'] as String?,
);

Map<String, dynamic> _$CourseToJson(_Course instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'teacher': instance.teacher,
  'room': instance.room,
  'manaboClassId': instance.manaboClassId,
  'courseCode': instance.courseCode,
  'credits': instance.credits,
  'format': instance.format,
};

_CourseDetail _$CourseDetailFromJson(Map<String, dynamic> json) =>
    _CourseDetail(
      course: Course.fromJson(json['course'] as Map<String, dynamic>),
      syllabus: json['syllabus'] == null
          ? null
          : Syllabus.fromJson(json['syllabus'] as Map<String, dynamic>),
      materials:
          (json['materials'] as List<dynamic>?)
              ?.map((e) => CourseMaterial.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      news:
          (json['news'] as List<dynamic>?)
              ?.map((e) => CourseNews.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      attendanceState: json['attendanceState'] == null
          ? null
          : AttendanceState.fromJson(
              json['attendanceState'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$CourseDetailToJson(_CourseDetail instance) =>
    <String, dynamic>{
      'course': instance.course,
      'syllabus': instance.syllabus,
      'materials': instance.materials,
      'news': instance.news,
      'attendanceState': instance.attendanceState,
    };
