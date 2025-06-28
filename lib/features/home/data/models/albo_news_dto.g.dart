// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albo_news_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AlboNewsDto _$AlboNewsDtoFromJson(Map<String, dynamic> json) => _AlboNewsDto(
  id: json['id'] as String,
  title: json['title'] as String,
  publishedAt: DateTime.parse(json['publishedAt'] as String),
  category: $enumDecode(_$AlboNewsCategoryEnumMap, json['category']),
  isImportant: json['isImportant'] as bool,
  isRead: json['isRead'] as bool,
  detailUrl: json['detailUrl'] as String,
  hasAttachment: json['hasAttachment'] as bool?,
);

Map<String, dynamic> _$AlboNewsDtoToJson(_AlboNewsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'category': _$AlboNewsCategoryEnumMap[instance.category]!,
      'isImportant': instance.isImportant,
      'isRead': instance.isRead,
      'detailUrl': instance.detailUrl,
      'hasAttachment': instance.hasAttachment,
    };

const _$AlboNewsCategoryEnumMap = {
  AlboNewsCategory.kyoumu: 'kyoumu',
  AlboNewsCategory.studentLife: 'studentLife',
  AlboNewsCategory.kyoshoku: 'kyoshoku',
  AlboNewsCategory.career: 'career',
  AlboNewsCategory.international: 'international',
};
