import 'package:html/parser.dart' as html_parser;
import '../models/mail_summary_dto.dart';
import '../models/mail_body_dto.dart';

class ManaboMailParser {
  /// 受信メール一覧のHTMLをパース
  List<MailSummaryDto> parseMailList(String htmlContent) {
    final document = html_parser.parse(htmlContent);
    
    final table = document.querySelector('table.table-default');
    if (table == null) {
      return [];
    }
    
    final rows = table.querySelectorAll('tbody tr');
    final List<MailSummaryDto> mails = [];
    
    for (final row in rows) {
      try {
        final mail = _parseMailRow(row);
        if (mail != null) {
          mails.add(mail);
        }
      } catch (e) {
        // パースエラーは無視して続行
        continue;
      }
    }
    
    return mails;
  }
  
  MailSummaryDto? _parseMailRow(element) {
    // チェックボックスからメールIDを取得
    final checkbox = element.querySelector('input[type="checkbox"]');
    final nameAttr = checkbox?.attributes['name'];
    if (nameAttr == null) return null;
    
    final mailIdMatch = RegExp(r'mail_id\[(\d+)\]').firstMatch(nameAttr);
    if (mailIdMatch == null) return null;
    final mailId = mailIdMatch.group(1)!;
    
    // タイトルを取得
    final titleElement = element.querySelector('a.a-mail-view');
    final title = titleElement?.text.trim() ?? '';
    
    // 送信者名を取得
    final senderElement = element.querySelector('span.margin-left-sm');
    final senderName = senderElement?.text.trim() ?? '';
    
    // 受信日を取得
    final dateElement = element.querySelector('span.date');
    final dateString = dateElement?.text.trim() ?? '';
    final receivedAt = _parseDate(dateString);
    
    // 既読状態を判定（既読アイコンの有無で判定）
    final isRead = element.querySelector('img[src*="mail_read.png"]') != null;
    
    // サムネイルURLを取得
    final thumbnailElement = element.querySelector('a.x-fancy img');
    final thumbnailUrl = thumbnailElement?.attributes['src'];
    
    return MailSummaryDto(
      mailId: mailId,
      title: title,
      senderName: senderName,
      receivedAt: receivedAt,
      isRead: isRead,
      senderThumbnailUrl: thumbnailUrl,
    );
  }
  
  /// メール詳細のHTMLをパース
  MailBodyDto parseMailView(String htmlContent, String mailId) {
    final document = html_parser.parse(htmlContent);
    
    final modal = document.querySelector('.modal-content');
    if (modal == null) {
      throw Exception('Modal content not found');
    }
    
    // タイトルを取得
    final title = modal.querySelector('.modal-title')?.text.trim() ?? '';
    
    // 送信者情報を取得
    final senderElement = modal.querySelector('b.margin-left-sm');
    final senderName = senderElement?.text.trim() ?? '';
    
    // 受信日を取得（送信者の後のテキストから）
    final senderContainer = modal.querySelector('.margin-top-lg.td-thumbnail');
    final dateText = senderContainer?.text.trim() ?? '';
    final receivedAt = _parseDateFromSenderContainer(dateText);
    
    // メール本文を取得（最後のmargin-top-lgクラス要素）
    final bodyElements = modal.querySelectorAll('.margin-top-lg');
    final bodyElement = bodyElements.isNotEmpty ? bodyElements.last : null;
    final bodyHtml = bodyElement?.innerHtml ?? '';
    
    // サムネイルURL
    final thumbnailElement = modal.querySelector('a.x-fancy img');
    final thumbnailUrl = thumbnailElement?.attributes['src'];
    
    return MailBodyDto(
      mailId: mailId,
      title: title,
      senderName: senderName,
      receivedAt: receivedAt,
      bodyHtml: bodyHtml,
      senderThumbnailUrl: thumbnailUrl,
      replyToMailId: null, // 必要に応じて実装
    );
  }
  
  DateTime _parseDate(String dateString) {
    try {
      // "2025年6月20日(金) 19:27" 形式をパース
      final dateRegex = RegExp(r'(\d{4})年(\d{1,2})月(\d{1,2})日\([^)]+\) (\d{1,2}):(\d{2})');
      final match = dateRegex.firstMatch(dateString);
      
      if (match != null) {
        final year = int.parse(match.group(1)!);
        final month = int.parse(match.group(2)!);
        final day = int.parse(match.group(3)!);
        final hour = int.parse(match.group(4)!);
        final minute = int.parse(match.group(5)!);
        
        return DateTime(year, month, day, hour, minute);
      }
    } catch (e) {
      // パースエラーの場合は現在時刻を返す
    }
    
    return DateTime.now();
  }
  
  DateTime _parseDateFromSenderContainer(String text) {
    // 送信者情報から日付部分を抽出
    final lines = text.split('\n');
    for (final line in lines) {
      final trimmedLine = line.trim();
      if (trimmedLine.contains('年') && trimmedLine.contains('月')) {
        return _parseDate(trimmedLine);
      }
    }
    return DateTime.now();
  }
}
