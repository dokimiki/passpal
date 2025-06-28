import 'package:html/parser.dart' as html_parser;
import '../models/albo_news_dto.dart';
import '../../domain/entities/albo_news_item.dart';

class AlboNewsParser {
  /// ALBOお知らせのHTMLをパース
  List<AlboNewsDto> parseNewsList(String htmlContent) {
    final document = html_parser.parse(htmlContent);

    final List<AlboNewsDto> allNews = [];

    // 重要なお知らせを取得
    final importantNews = _parseImportantNews(document);
    allNews.addAll(importantNews);

    // 通常のお知らせを取得
    final regularNews = _parseRegularNews(document);
    allNews.addAll(regularNews);

    return allNews;
  }

  List<AlboNewsDto> _parseImportantNews(document) {
    final pickupBox = document.querySelector('.pickup-box ul');
    if (pickupBox == null) return [];

    final List<AlboNewsDto> news = [];
    final items = pickupBox.querySelectorAll('li');

    for (final item in items) {
      try {
        final link = item.querySelector('a');
        if (link == null) continue;

        final title = link.text.trim();
        final onclick = link.attributes['onclick'] ?? '';
        final isUnread = item.classes.contains('unread');

        // onclickからURLを抽出
        final detailUrl = _extractUrlFromOnclick(onclick);

        news.add(
          AlboNewsDto(
            id: _generateId(title),
            title: title,
            publishedAt: _extractDateFromTitle(title),
            category: AlboNewsCategory.kyoumu, // 重要なお知らせはデフォルトで教務
            isImportant: true,
            isRead: !isUnread,
            detailUrl: detailUrl,
            hasAttachment: false,
          ),
        );
      } catch (e) {
        continue;
      }
    }

    return news;
  }

  List<AlboNewsDto> _parseRegularNews(document) {
    final List<AlboNewsDto> news = [];

    // タブ付きニュースリストを取得
    final newsListBox = document.querySelector('.tab-newslist-box');
    if (newsListBox == null) return [];

    // 各タブのテーブルを処理
    final tables = newsListBox.querySelectorAll('table');

    for (final table in tables) {
      final rows = table.querySelectorAll('tbody tr');

      for (final row in rows) {
        try {
          final newsItem = _parseRegularNewsRow(row);
          if (newsItem != null) {
            news.add(newsItem);
          }
        } catch (e) {
          continue;
        }
      }
    }

    return news;
  }

  AlboNewsDto? _parseRegularNewsRow(row) {
    // カテゴリを取得
    final categoryImg = row.querySelector('th.category img');
    final categoryAlt = categoryImg?.attributes['alt'] ?? '';
    final category = _mapCategoryFromAlt(categoryAlt);

    // ステータス（既読/未読）を取得
    final statusImg = row.querySelector('td.status img');
    final statusAlt = statusImg?.attributes['alt'] ?? '';
    final isRead = statusAlt.contains('既読');
    final hasAttachment = statusAlt.contains('添付');

    // タイトルとリンクを取得
    final link = row.querySelector('td.headline a');
    if (link == null) return null;

    final title = link.text.trim();
    final onclick = link.attributes['onclick'] ?? '';
    final detailUrl = _extractUrlFromOnclick(onclick);

    return AlboNewsDto(
      id: _generateId(title),
      title: title,
      publishedAt: _extractDateFromTitle(title),
      category: category,
      isImportant: false,
      isRead: isRead,
      detailUrl: detailUrl,
      hasAttachment: hasAttachment,
    );
  }

  AlboNewsCategory _mapCategoryFromAlt(String alt) {
    switch (alt) {
      case '教務':
        return AlboNewsCategory.kyoumu;
      case '学生生活':
        return AlboNewsCategory.studentLife;
      case '教職':
        return AlboNewsCategory.kyoshoku;
      case 'キャリア・資格':
      case 'ｷｬﾘｱ・資格':
        return AlboNewsCategory.career;
      case '国際・留学':
        return AlboNewsCategory.international;
      default:
        return AlboNewsCategory.kyoumu; // デフォルト
    }
  }

  String _extractUrlFromOnclick(String onclick) {
    // javascript:location.href='/uniprove_pt/UnFunctionJump?...' からURLを抽出
    final match = RegExp(r"location\.href='([^']+)'").firstMatch(onclick);
    if (match != null) {
      return match.group(1)!;
    }
    return '';
  }

  DateTime _extractDateFromTitle(String title) {
    // タイトルから日付を抽出 (例: "06/13 小説創作指導講座のお知らせ")
    final dateMatch = RegExp(r'(\d{2})/(\d{2})').firstMatch(title);
    if (dateMatch != null) {
      final month = int.parse(dateMatch.group(1)!);
      final day = int.parse(dateMatch.group(2)!);
      final currentYear = DateTime.now().year;

      return DateTime(currentYear, month, day);
    }

    // 年度付きの場合 (例: "(2025/06/16)")
    final yearDateMatch = RegExp(
      r'\((\d{4})/(\d{2})/(\d{2})\)',
    ).firstMatch(title);
    if (yearDateMatch != null) {
      final year = int.parse(yearDateMatch.group(1)!);
      final month = int.parse(yearDateMatch.group(2)!);
      final day = int.parse(yearDateMatch.group(3)!);

      return DateTime(year, month, day);
    }

    return DateTime.now();
  }

  String _generateId(String title) {
    return title.hashCode.toString();
  }
}
