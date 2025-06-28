import 'package:freezed_annotation/freezed_annotation.dart';

part 'albo_news_item.freezed.dart';
part 'albo_news_item.g.dart';

enum AlboNewsCategory {
  @JsonValue('kyoumu')
  kyoumu, // 教務
  @JsonValue('studentLife')
  studentLife, // 学生生活
  @JsonValue('kyoshoku')
  kyoshoku, // 教職
  @JsonValue('career')
  career, // キャリア・資格
  @JsonValue('international')
  international, // 国際・留学
}

@freezed
abstract class AlboNewsItem with _$AlboNewsItem {
  const factory AlboNewsItem({
    required String id,
    required String title,
    required DateTime publishedAt,
    required AlboNewsCategory category,
    required bool isImportant,
    required bool isRead,
    required Uri detailUrl,
    bool? hasAttachment,
  }) = _AlboNewsItem;

  factory AlboNewsItem.fromJson(Map<String, dynamic> json) =>
      _$AlboNewsItemFromJson(json);
}
