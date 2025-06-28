import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_permission.freezed.dart';
part 'notification_permission.g.dart';

/// Represents the state of notification permission
@freezed
abstract class NotificationPermission with _$NotificationPermission {
  const factory NotificationPermission.granted() = _Granted;
  const factory NotificationPermission.denied() = _Denied;
  const factory NotificationPermission.provisional() = _Provisional;

  factory NotificationPermission.fromJson(Map<String, dynamic> json) =>
      _$NotificationPermissionFromJson(json);
}

extension NotificationPermissionExtension on NotificationPermission {
  bool get isAllowed => switch (this) {
    _Granted() => true,
    _Denied() => false,
    _Provisional() => true,
    NotificationPermission() => false, // Fallback for unknown cases
  };

  String get displayText {
    return switch (this) {
      _Granted() => '許可済み',
      _Denied() => '拒否',
      _Provisional() => '仮許可',
      NotificationPermission() => '不明', // Fallback for unknown cases
    };
  }
}
