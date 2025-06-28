import '../entities/news_item.dart';
import '../entities/mail_summary.dart';
import '../entities/mail_body.dart';
import '../entities/albo_news_item.dart';

abstract class HomeRepository {
  /// システムお知らせ一覧を取得
  Future<List<NewsItem>> getSystemNews();

  /// 受信メール一覧を取得
  Future<List<MailSummary>> getReceivedMail({int? limit, int page = 1});

  /// メール本文を取得
  Future<MailBody> getMailBody(String mailId);

  /// ALBOお知らせ一覧を取得
  Future<List<AlboNewsItem>> getAlboNews({int? limit});
}
