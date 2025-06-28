import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_state.freezed.dart';
part 'attendance_state.g.dart';

/// 出席状態を表すエンティティ
@freezed
abstract class AttendanceState with _$AttendanceState {
  const factory AttendanceState({
    /// クラスID
    required int classId,

    /// 出席状態
    required AttendanceStatus status,

    /// エラーメッセージ（失敗時）
    String? errorMessage,

    /// 最終更新時刻
    required DateTime lastUpdated,
  }) = _AttendanceState;

  factory AttendanceState.fromJson(Map<String, Object?> json) =>
      _$AttendanceStateFromJson(json);
}

/// 出席ステータス
enum AttendanceStatus {
  /// 出席受付なし
  @JsonValue('none')
  none,

  /// 出席受付中
  @JsonValue('open')
  open,

  /// 出席登録成功
  @JsonValue('success')
  success,

  /// 出席登録失敗
  @JsonValue('fail')
  fail;

  String get displayName {
    switch (this) {
      case AttendanceStatus.none:
        return '出席受付なし';
      case AttendanceStatus.open:
        return '出席受付中';
      case AttendanceStatus.success:
        return '出席済み';
      case AttendanceStatus.fail:
        return '出席失敗';
    }
  }

  /// JSONの`is_accepted`フィールドからステータスを判定
  static AttendanceStatus fromIsAccepted(int isAccepted) {
    return isAccepted == 1 ? AttendanceStatus.success : AttendanceStatus.open;
  }
}
