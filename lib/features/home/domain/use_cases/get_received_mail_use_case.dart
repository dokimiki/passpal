import '../entities/mail_summary.dart';
import '../repositories/home_repository.dart';

class GetReceivedMailUseCase {
  final HomeRepository _repository;

  const GetReceivedMailUseCase(this._repository);

  Future<List<MailSummary>> execute({int? limit, int page = 1}) async {
    return await _repository.getReceivedMail(limit: limit, page: page);
  }
}
