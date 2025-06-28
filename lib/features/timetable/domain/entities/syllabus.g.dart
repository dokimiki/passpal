// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syllabus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Syllabus _$SyllabusFromJson(Map<String, dynamic> json) => _Syllabus(
  id: json['id'] as String,
  courseName: json['courseName'] as String,
  instructor: json['instructor'] as String,
  overview: json['overview'] as String?,
  objectives: json['objectives'] as String?,
  lessonPlan:
      (json['lessonPlan'] as List<dynamic>?)
          ?.map((e) => LessonPlan.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  evaluationMethod: json['evaluationMethod'] as String?,
  textbook: json['textbook'] as String?,
  references: json['references'] as String?,
  notes: json['notes'] as String?,
  officeHours: json['officeHours'] as String?,
  credits: (json['credits'] as num?)?.toInt(),
  format: json['format'] as String?,
  academicYear: (json['academicYear'] as num?)?.toInt(),
  semester: json['semester'] as String?,
);

Map<String, dynamic> _$SyllabusToJson(_Syllabus instance) => <String, dynamic>{
  'id': instance.id,
  'courseName': instance.courseName,
  'instructor': instance.instructor,
  'overview': instance.overview,
  'objectives': instance.objectives,
  'lessonPlan': instance.lessonPlan,
  'evaluationMethod': instance.evaluationMethod,
  'textbook': instance.textbook,
  'references': instance.references,
  'notes': instance.notes,
  'officeHours': instance.officeHours,
  'credits': instance.credits,
  'format': instance.format,
  'academicYear': instance.academicYear,
  'semester': instance.semester,
};

_LessonPlan _$LessonPlanFromJson(Map<String, dynamic> json) => _LessonPlan(
  week: (json['week'] as num).toInt(),
  title: json['title'] as String,
  content: json['content'] as String?,
  preparation: json['preparation'] as String?,
  review: json['review'] as String?,
);

Map<String, dynamic> _$LessonPlanToJson(_LessonPlan instance) =>
    <String, dynamic>{
      'week': instance.week,
      'title': instance.title,
      'content': instance.content,
      'preparation': instance.preparation,
      'review': instance.review,
    };
