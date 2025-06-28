import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/albo_news_item.dart';

part 'albo_news_dto.freezed.dart';
part 'albo_news_dto.g.dart';

@freezed
abstract class AlboNewsDto with _$AlboNewsDto {
  const factory AlboNewsDto({
    required String id,
    required String title,
    required DateTime publishedAt,
    required AlboNewsCategory category,
    required bool isImportant,
    required bool isRead,
    required String detailUrl,
    bool? hasAttachment,
  }) = _AlboNewsDto;

  factory AlboNewsDto.fromJson(Map<String, dynamic> json) =>
      _$AlboNewsDtoFromJson(json);
}

extension AlboNewsDtoX on AlboNewsDto {
  AlboNewsItem toDomain() {
    return AlboNewsItem(
      id: id,
      title: title,
      publishedAt: publishedAt,
      category: category,
      isImportant: isImportant,
      isRead: isRead,
      detailUrl: Uri.parse(detailUrl),
      hasAttachment: hasAttachment,
    );
  }
}
