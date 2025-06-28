import 'package:passpal/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:passpal/core/error/app_exception.dart';

/// ユースケース：オンボーディングを完了する
class CompleteOnboardingUseCase {
  const CompleteOnboardingUseCase(this._repository);

  final OnboardingRepository _repository;

  /// オンボーディングを完了としてマーク
  Future<void> call() async {
    try {
      await _repository.completeOnboarding();
    } catch (e) {
      throw UnknownException(
        message: 'オンボーディング完了の保存に失敗しました',
        originalException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
