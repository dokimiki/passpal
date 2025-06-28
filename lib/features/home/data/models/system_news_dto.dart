import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/news_item.dart';

part 'system_news_dto.freezed.dart';
part 'system_news_dto.g.dart';

@freezed
abstract class SystemNewsDto with _$SystemNewsDto {
  const factory SystemNewsDto({
    required String id,
    required String title,
    required DateTime publishedAt,
    required String bodyHtml,
    String? detailUrl,
  }) = _SystemNewsDto;

  factory SystemNewsDto.fromJson(Map<String, dynamic> json) =>
      _$SystemNewsDtoFromJson(json);
}

extension SystemNewsDtoX on SystemNewsDto {
  NewsItem toDomain() {
    return NewsItem(
      id: id,
      title: title,
      publishedAt: publishedAt,
      bodyHtml: bodyHtml,
      detailUrl: detailUrl != null ? Uri.parse(detailUrl!) : null,
    );
  }
}
