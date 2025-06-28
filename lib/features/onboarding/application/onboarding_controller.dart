import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/features/__shared__/models/campus.dart';
import 'package:passpal/features/onboarding/data/models/onboarding_status.dart';
import 'package:passpal/features/onboarding/application/onboarding_providers.dart';
import 'package:passpal/features/__shared__/models/notification_permission.dart';
import 'package:passpal/features/onboarding/application/post_onboarding_tasks.dart';

/// Controller for managing onboarding state and actions
class OnboardingController extends AutoDisposeAsyncNotifier<OnboardingStatus> {
  @override
  FutureOr<OnboardingStatus> build() async {
    // Get dependencies from providers
    final repository = ref.read(onboardingRepositoryProvider);
    return await repository.getStatus();
  }

  /// Select a campus during onboarding
  Future<void> selectCampus(Campus campus) async {
    await _updateWith((status) => status.copyWith(campus: campus));
    
    // Save to repository
    final selectCampusUseCase = ref.read(selectCampusUseCaseProvider);
    await selectCampusUseCase(campus);
  }

  /// Request notification permission
  Future<void> requestNotificationPermission() async {
    final requestPermissionUseCase = ref.read(requestNotificationPermissionUseCaseProvider);
    try {
      final permission = await requestPermissionUseCase();
      await _updateWith((status) => status.copyWith(notificationsGranted: permission));
    } catch (e) {
      // Handle permission request failure - set to denied
      await _updateWith((status) => status.copyWith(
        notificationsGranted: const NotificationPermission.denied(),
      ));
    }
  }

  /// Skip notification permission
  Future<void> skipNotificationPermission() async {
    await _updateWith((status) => status.copyWith(
      notificationsGranted: const NotificationPermission.denied(),
    ));
  }

  /// Complete the onboarding process
  Future<void> completeOnboarding() async {
    final completeUseCase = ref.read(completeOnboardingUseCaseProvider);
    await completeUseCase();
    
    await _updateWith((status) => status.copyWith(completed: true));
    
    // Schedule post-onboarding tasks
    final postTasks = ref.read(postOnboardingTasksProvider);
    await postTasks.scheduleAllTasks();
  }

  /// Helper to update state
  Future<void> _updateWith(OnboardingStatus Function(OnboardingStatus) updater) async {
    final currentValue = state.value;
    if (currentValue != null) {
      final newStatus = updater(currentValue);
      state = AsyncData(newStatus);
    }
  }
}

/// Provider for the onboarding controller
final onboardingControllerProvider = AutoDisposeAsyncNotifierProvider<OnboardingController, OnboardingStatus>(() {
  return OnboardingController();
});

/// Provider for setup completion status (used by routing guard)
final setupCompletedFromOnboardingProvider = Provider<bool>((ref) {
  return ref.watch(onboardingControllerProvider).when(
    data: (status) => status.isComplete,
    loading: () => false,
    error: (_, __) => false,
  );
});
