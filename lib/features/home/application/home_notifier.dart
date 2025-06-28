import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'home_state.dart';
import '../domain/entities/news_item.dart';
import '../domain/entities/mail_summary.dart';
import '../domain/entities/albo_news_item.dart';
import 'providers.dart';

part 'home_notifier.g.dart';

@riverpod
class HomeNotifier extends _$HomeNotifier {
  @override
  Future<HomeState> build() async {
    // 並行してデータを取得
    final results = await Future.wait([
      _loadSystemNews(),
      _loadReceivedMail(),
      _loadAlboNews(),
    ]);

    return HomeState(
      systemNews: AsyncValue.data(results[0] as List<NewsItem>),
      receivedMail: AsyncValue.data(results[1] as List<MailSummary>),
      alboNews: AsyncValue.data(results[2] as List<AlboNewsItem>),
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }

  Future<List<NewsItem>> _loadSystemNews() async {
    final useCase = ref.read(getSystemNewsUseCaseProvider);
    return await useCase.execute();
  }

  Future<List<MailSummary>> _loadReceivedMail() async {
    final useCase = ref.read(getReceivedMailUseCaseProvider);
    return await useCase.execute(limit: 10); // ホーム画面は最新10件のみ
  }

  Future<List<AlboNewsItem>> _loadAlboNews() async {
    final useCase = ref.read(getAlboNewsUseCaseProvider);
    return await useCase.execute(limit: 10);
  }
}
