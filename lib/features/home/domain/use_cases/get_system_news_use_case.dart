import '../entities/news_item.dart';
import '../repositories/home_repository.dart';

class GetSystemNewsUseCase {
  final HomeRepository _repository;

  const GetSystemNewsUseCase(this._repository);

  Future<List<NewsItem>> execute() async {
    return await _repository.getSystemNews();
  }
}
