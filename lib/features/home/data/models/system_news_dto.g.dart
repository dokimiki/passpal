// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_news_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SystemNewsDto _$SystemNewsDtoFromJson(Map<String, dynamic> json) =>
    _SystemNewsDto(
      id: json['id'] as String,
      title: json['title'] as String,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      bodyHtml: json['bodyHtml'] as String,
      detailUrl: json['detailUrl'] as String?,
    );

Map<String, dynamic> _$SystemNewsDtoToJson(_SystemNewsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'bodyHtml': instance.bodyHtml,
      'detailUrl': instance.detailUrl,
    };
