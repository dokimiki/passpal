import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/storage/storage_providers.dart';
import 'package:passpal/features/onboarding/data/sources/user_prefs_onboarding_ds.dart';
import 'package:passpal/features/onboarding/data/repository/onboarding_repository_impl.dart';
import 'package:passpal/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:passpal/features/onboarding/domain/use_cases/select_campus.dart';
import 'package:passpal/features/onboarding/domain/use_cases/request_notification_permission.dart';
import 'package:passpal/features/onboarding/domain/use_cases/complete_onboarding.dart';

/// Provider for onboarding data source
final onboardingDataSourceProvider = Provider<UserPrefsOnboardingDataSource>((
  ref,
) {
  final sharedPrefs = ref.watch(sharedPrefsProvider);
  return UserPrefsOnboardingDataSource(sharedPrefs);
});

/// Provider for onboarding repository
final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  final dataSource = ref.read(onboardingDataSourceProvider);
  return OnboardingRepositoryImpl(dataSource);
});

/// Provider for select campus use case
final selectCampusUseCaseProvider = Provider<SelectCampusUseCase>((ref) {
  final repository = ref.read(onboardingRepositoryProvider);
  return SelectCampusUseCase(repository);
});

/// Provider for request notification permission use case
final requestNotificationPermissionUseCaseProvider =
    Provider<RequestNotificationPermissionUseCase>((ref) {
      final repository = ref.read(onboardingRepositoryProvider);
      return RequestNotificationPermissionUseCase(repository);
    });

/// Provider for complete onboarding use case
final completeOnboardingUseCaseProvider = Provider<CompleteOnboardingUseCase>((
  ref,
) {
  final repository = ref.read(onboardingRepositoryProvider);
  return CompleteOnboardingUseCase(repository);
});
