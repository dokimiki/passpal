import 'package:passpal/features/onboarding/data/models/onboarding_status.dart';
import 'package:passpal/features/onboarding/data/sources/user_prefs_onboarding_ds.dart';
import 'package:passpal/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:passpal/features/__shared__/models/campus.dart';
import 'package:passpal/features/__shared__/models/notification_permission.dart';

/// Implementation of onboarding repository using UserPrefs
class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._dataSource);

  final UserPrefsOnboardingDataSource _dataSource;

  @override
  Future<OnboardingStatus> getStatus() async {
    return await _dataSource.read();
  }

  @override
  Future<void> saveCampus(Campus campus) async {
    final currentStatus = await _dataSource.read();
    final updatedStatus = currentStatus.copyWith(campus: campus);
    await _dataSource.save(updatedStatus);
  }

  @override
  Future<void> saveNotificationPermission(
    NotificationPermission permission,
  ) async {
    final currentStatus = await _dataSource.read();
    final updatedStatus = currentStatus.copyWith(
      notificationsGranted: permission,
    );
    await _dataSource.save(updatedStatus);
  }

  @override
  Future<void> completeOnboarding() async {
    final currentStatus = await _dataSource.read();
    final updatedStatus = currentStatus.copyWith(completed: true);
    await _dataSource.save(updatedStatus);
  }

  @override
  Future<void> resetOnboarding() async {
    await _dataSource.clear();
  }
}
