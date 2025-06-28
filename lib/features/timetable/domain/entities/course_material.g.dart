// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourseMaterial _$CourseMaterialFromJson(Map<String, dynamic> json) =>
    _CourseMaterial(
      id: json['id'] as String,
      title: json['title'] as String,
      type: $enumDecode(_$MaterialTypeEnumMap, json['type']),
      downloadUrl: json['downloadUrl'] as String?,
      fileSize: (json['fileSize'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CourseMaterialToJson(_CourseMaterial instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': _$MaterialTypeEnumMap[instance.type]!,
      'downloadUrl': instance.downloadUrl,
      'fileSize': instance.fileSize,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'description': instance.description,
    };

const _$MaterialTypeEnumMap = {
  MaterialType.document: 'document',
  MaterialType.video: 'video',
  MaterialType.audio: 'audio',
  MaterialType.link: 'link',
  MaterialType.quiz: 'quiz',
  MaterialType.assignment: 'assignment',
};

_CourseNews _$CourseNewsFromJson(Map<String, dynamic> json) => _CourseNews(
  id: json['id'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  postedAt: DateTime.parse(json['postedAt'] as String),
  importance:
      $enumDecodeNullable(_$NewsImportanceEnumMap, json['importance']) ??
      NewsImportance.normal,
  attachments:
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => CourseMaterial.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$CourseNewsToJson(_CourseNews instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'postedAt': instance.postedAt.toIso8601String(),
      'importance': _$NewsImportanceEnumMap[instance.importance]!,
      'attachments': instance.attachments,
    };

const _$NewsImportanceEnumMap = {
  NewsImportance.low: 'low',
  NewsImportance.normal: 'normal',
  NewsImportance.high: 'high',
  NewsImportance.urgent: 'urgent',
};
