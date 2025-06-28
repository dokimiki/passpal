import '../entities/albo_news_item.dart';
import '../repositories/home_repository.dart';

class GetAlboNewsUseCase {
  final HomeRepository _repository;

  const GetAlboNewsUseCase(this._repository);

  Future<List<AlboNewsItem>> execute({int? limit}) async {
    return await _repository.getAlboNews(limit: limit);
  }
}
