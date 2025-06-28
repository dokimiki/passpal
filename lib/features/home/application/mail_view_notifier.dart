import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/entities/mail_body.dart';
import 'providers.dart';

part 'mail_view_notifier.g.dart';

@riverpod
class MailViewNotifier extends _$MailViewNotifier {
  @override
  Future<MailBody> build(String mailId) async {
    final useCase = ref.read(getMailBodyUseCaseProvider);
    return await useCase.execute(mailId);
  }
}
