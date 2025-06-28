import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/features/home/domain/entities/news_item.dart';
import 'package:passpal/features/home/domain/entities/albo_news_item.dart';
import 'package:passpal/features/home/application/home_state.dart';

void main() {
  group('Home Feature Domain Tests', () {
    test('NewsItem should be created correctly', () {
      final newsItem = NewsItem(
        id: 'test-1',
        title: 'Test News',
        publishedAt: DateTime.now(),
        bodyHtml: '<p>Test content</p>',
        detailUrl: Uri.parse('https://test.com'),
      );

      expect(newsItem.id, equals('test-1'));
      expect(newsItem.title, equals('Test News'));
      expect(newsItem.bodyHtml, equals('<p>Test content</p>'));
    });

    test('AlboNewsItem should handle categories correctly', () {
      final alboItem = AlboNewsItem(
        id: 'albo-1',
        title: 'ALBO Test',
        publishedAt: DateTime.now(),
        category: AlboNewsCategory.kyoumu,
        isImportant: true,
        isRead: false,
        detailUrl: Uri.parse('https://albo.test.com'),
      );

      expect(alboItem.category, equals(AlboNewsCategory.kyoumu));
      expect(alboItem.isImportant, isTrue);
      expect(alboItem.isRead, isFalse);
    });

    test('HomeState should initialize with loading states', () {
      final homeState = HomeState(
        systemNews: const AsyncValue.loading(),
        receivedMail: const AsyncValue.loading(),
        alboNews: const AsyncValue.loading(),
      );

      expect(homeState.systemNews.isLoading, isTrue);
      expect(homeState.receivedMail.isLoading, isTrue);
      expect(homeState.alboNews.isLoading, isTrue);
    });

    test('HomeState should handle data states', () {
      final mockNews = [
        NewsItem(
          id: '1',
          title: 'News 1',
          publishedAt: DateTime.now(),
          bodyHtml: 'Content 1',
          detailUrl: Uri.parse('https://test1.com'),
        )
      ];

      final homeState = HomeState(
        systemNews: AsyncValue.data(mockNews),
        receivedMail: const AsyncValue.data([]),
        alboNews: const AsyncValue.data([]),
      );

      expect(homeState.systemNews.hasValue, isTrue);
      expect(homeState.systemNews.value!.length, equals(1));
      expect(homeState.systemNews.value!.first.title, equals('News 1'));
    });
  });
}
