import '../entities/mail_body.dart';
import '../repositories/home_repository.dart';

class GetMailBodyUseCase {
  final HomeRepository _repository;

  const GetMailBodyUseCase(this._repository);

  Future<MailBody> execute(String mailId) async {
    return await _repository.getMailBody(mailId);
  }
}
