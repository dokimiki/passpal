// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NewsItem _$NewsItemFromJson(Map<String, dynamic> json) => _NewsItem(
  id: json['id'] as String,
  title: json['title'] as String,
  publishedAt: DateTime.parse(json['publishedAt'] as String),
  bodyHtml: json['bodyHtml'] as String,
  detailUrl: json['detailUrl'] == null
      ? null
      : Uri.parse(json['detailUrl'] as String),
);

Map<String, dynamic> _$NewsItemToJson(_NewsItem instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'publishedAt': instance.publishedAt.toIso8601String(),
  'bodyHtml': instance.bodyHtml,
  'detailUrl': instance.detailUrl?.toString(),
};
