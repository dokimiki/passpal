import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passpal/features/__shared__/models/campus.dart';
import 'package:passpal/features/__shared__/models/notification_permission.dart';

part 'onboarding_status.freezed.dart';
part 'onboarding_status.g.dart';

/// Data model representing the current onboarding state
@freezed
abstract class OnboardingStatus with _$OnboardingStatus {
  const factory OnboardingStatus({
    Campus? campus,
    NotificationPermission? notificationsGranted,
    @Default(false) bool completed,
  }) = _OnboardingStatus;

  factory OnboardingStatus.fromJson(Map<String, dynamic> json) =>
      _$OnboardingStatusFromJson(json);
}

extension OnboardingStatusExtension on OnboardingStatus {
  /// Whether campus has been selected
  bool get hasCampusSelected => campus != null;

  /// Whether notification permission has been handled
  bool get hasNotificationHandled => notificationsGranted != null;

  /// Whether the user can proceed to the next step
  bool get canProceedFromCampus => hasCampusSelected;

  /// Whether the user can proceed from notification step
  bool get canProceedFromNotification => hasNotificationHandled;

  /// Whether onboarding is fully complete
  bool get isComplete => completed && hasCampusSelected;
}
