import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/news_item.dart';
import '../domain/entities/mail_summary.dart';
import '../domain/entities/albo_news_item.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(AsyncValue.loading()) AsyncValue<List<NewsItem>> systemNews,
    @Default(AsyncValue.loading()) AsyncValue<List<MailSummary>> receivedMail,
    @Default(AsyncValue.loading()) AsyncValue<List<AlboNewsItem>> alboNews,
  }) = _HomeState;
}
