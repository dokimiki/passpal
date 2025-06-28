import 'package:passpal/core/error/app_exception.dart';
import 'package:passpal/core/network/error_mapper.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/entities/news_item.dart';
import '../../domain/entities/mail_summary.dart';
import '../../domain/entities/mail_body.dart';
import '../../domain/entities/albo_news_item.dart';
import '../datasources/manabo_system_news_remote_ds.dart';
import '../datasources/manabo_received_mail_remote_ds.dart';
import '../datasources/manabo_mail_view_remote_ds.dart';
import '../datasources/albo_news_remote_ds.dart';
import '../parsers/manabo_news_parser.dart';
import '../parsers/manabo_mail_parser.dart';
import '../parsers/albo_news_parser.dart';
import '../models/system_news_dto.dart';
import '../models/mail_summary_dto.dart';
import '../models/mail_body_dto.dart';
import '../models/albo_news_dto.dart';
import 'package:dio/dio.dart';

/// キャッシュTTL定数
class HomeCacheConstants {
  static const Duration systemNewsTtl = Duration(minutes: 5);
  static const Duration receivedMailTtl = Duration(minutes: 2);
  static const Duration alboNewsTtl = Duration(minutes: 10);
  // メール本文はキャッシュしない（プライバシー考慮）
  static const Duration mailBodyTtl = Duration.zero;
}

class HomeRepositoryImpl implements HomeRepository {
  final ManaboSystemNewsRemoteDs _systemNewsDs;
  final ManaboReceivedMailRemoteDs _receivedMailDs;
  final ManaboMailViewRemoteDs _mailViewDs;
  final AlboNewsRemoteDs _alboNewsDs;
  final ManaboNewsParser _newsParser;
  final ManaboMailParser _mailParser;
  final AlboNewsParser _alboParser;

  HomeRepositoryImpl({
    required ManaboSystemNewsRemoteDs systemNewsDs,
    required ManaboReceivedMailRemoteDs receivedMailDs,
    required ManaboMailViewRemoteDs mailViewDs,
    required AlboNewsRemoteDs alboNewsDs,
    ManaboNewsParser? newsParser,
    ManaboMailParser? mailParser,
    AlboNewsParser? alboParser,
  })  : _systemNewsDs = systemNewsDs,
        _receivedMailDs = receivedMailDs,
        _mailViewDs = mailViewDs,
        _alboNewsDs = alboNewsDs,
        _newsParser = newsParser ?? ManaboNewsParser(),
        _mailParser = mailParser ?? ManaboMailParser(),
        _alboParser = alboParser ?? AlboNewsParser();

  @override
  Future<List<NewsItem>> getSystemNews() async {
    try {
      // 常に最新データを取得（キャッシュロジックは簡略化）
      return await _fetchSystemNews();
    } on AppException {
      rethrow;
    } catch (error, stackTrace) {
      throw NetworkFailure.server(
        message: 'システムお知らせの取得に失敗しました',
        stack: stackTrace,
      );
    }
  }

  @override
  Future<List<MailSummary>> getReceivedMail({int? limit, int page = 1}) async {
    try {
      // 常に最新データを取得（キャッシュロジックは簡略化）
      return await _fetchReceivedMail(page, limit);
    } on AppException {
      rethrow;
    } catch (error, stackTrace) {
      throw NetworkFailure.server(
        message: '受信メールの取得に失敗しました',
        stack: stackTrace,
      );
    }
  }

  @override
  Future<MailBody> getMailBody(String mailId) async {
    // メール本文はキャッシュしない（プライバシー考慮）
    try {
      final html = await _mailViewDs.fetchMailView(mailId);
      final dto = _mailParser.parseMailView(html, mailId);
      return dto.toDomain();
      
    } on DioException catch (e) {
      throw NetworkErrorMapper.mapDioException(e);
    } catch (error, stackTrace) {
      throw NetworkFailure.server(
        message: 'メール詳細の取得に失敗しました',
        stack: stackTrace,
      );
    }
  }

  @override
  Future<List<AlboNewsItem>> getAlboNews({int? limit}) async {
    try {
      // 常に最新データを取得（キャッシュロジックは簡略化）
      return await _fetchAlboNews(limit);
    } on AppException {
      rethrow;
    } catch (error, stackTrace) {
      throw NetworkFailure.server(
        message: 'ALBOお知らせの取得に失敗しました',
        stack: stackTrace,
      );
    }
  }

  // Private helper methods

  Future<List<NewsItem>> _fetchSystemNews() async {
    try {
      final html = await _systemNewsDs.fetchSystemNews();
      final dtos = _newsParser.parseNewsList(html);
      final entities = dtos.map((dto) => dto.toDomain()).toList();
      return entities;
    } on DioException catch (e) {
      throw NetworkErrorMapper.mapDioException(e);
    }
  }

  Future<List<MailSummary>> _fetchReceivedMail(int page, int? limit) async {
    try {
      final html = await _receivedMailDs.fetchReceivedMail(page: page);
      final dtos = _mailParser.parseMailList(html);
      var entities = dtos.map((dto) => dto.toDomain()).toList();
      
      // limitが指定されている場合は制限
      if (limit != null && entities.length > limit) {
        entities = entities.take(limit).toList();
      }
      
      return entities;
    } on DioException catch (e) {
      throw NetworkErrorMapper.mapDioException(e);
    }
  }

  Future<List<AlboNewsItem>> _fetchAlboNews(int? limit) async {
    try {
      final html = await _alboNewsDs.fetchAlboNews();
      final dtos = _alboParser.parseNewsList(html);
      var entities = dtos.map((dto) => dto.toDomain()).toList();
      
      // limitが指定されている場合は制限
      if (limit != null && entities.length > limit) {
        entities = entities.take(limit).toList();
      }
      
      return entities;
    } on DioException catch (e) {
      throw NetworkErrorMapper.mapDioException(e);
    }
  }
}
