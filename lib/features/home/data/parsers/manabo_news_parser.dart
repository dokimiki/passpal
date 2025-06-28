import 'package:html/parser.dart' as html_parser;
import '../models/system_news_dto.dart';

class ManaboNewsParser {
  /// MaNaBoシステムお知らせのHTMLをパース
  List<SystemNewsDto> parseNewsList(String htmlContent) {
    final document = html_parser.parse(htmlContent);

    // panelからお知らせテーブルを検索
    final panel = document.querySelector('.panel.panel-default');
    if (panel == null) {
      return [];
    }

    // テーブルから行を取得
    final table = panel.querySelector('table.table-no-border');
    if (table == null) {
      return [];
    }

    final rows = table.querySelectorAll('tbody tr');
    final List<SystemNewsDto> news = [];

    for (final row in rows) {
      final cell = row.querySelector('td');
      if (cell == null) continue;

      final text = cell.text.trim();

      // "現在システムからのお知らせはありません"の場合はスキップ
      if (text.contains('現在システムからのお知らせはありません')) {
        continue;
      }

      // 実際のお知らせがある場合の処理
      // TODO: 実際のお知らせデータがある時のパース処理を実装
      // 現在のfixtureにはお知らせデータがないため、フォールバック処理
      if (text.isNotEmpty) {
        news.add(
          SystemNewsDto(
            id: _generateId(text),
            title: text,
            publishedAt: DateTime.now(),
            bodyHtml: text,
            detailUrl: null,
          ),
        );
      }
    }

    return news;
  }

  String _generateId(String content) {
    return content.hashCode.toString();
  }
}
