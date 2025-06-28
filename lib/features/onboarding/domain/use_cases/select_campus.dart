import 'package:passpal/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:passpal/features/__shared__/models/campus.dart';
import 'package:passpal/core/error/app_exception.dart';

/// ユースケース：キャンパスを選択する
class SelectCampusUseCase {
  const SelectCampusUseCase(this._repository);

  final OnboardingRepository _repository;

  /// キャンパスを選択して保存
  Future<void> call(Campus campus) async {
    try {
      await _repository.saveCampus(campus);
    } catch (e) {
      throw UnknownException(
        message: 'キャンパス情報の保存に失敗しました',
        originalException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
}
