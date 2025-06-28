import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_dto.freezed.dart';
part 'attendance_dto.g.dart';

/// MaNaBo出席確認レスポンスDTO
@freezed
abstract class ManaboAttendanceResponseDto with _$ManaboAttendanceResponseDto {
  const factory ManaboAttendanceResponseDto({
    /// 成功フラグ
    required bool success,

    /// HTMLコンテンツ（エラー時）
    String? html,

    /// エラーメッセージ
    String? error,

    /// メッセージ
    String? message,

    /// データ
    ManaboAttendanceDataDto? data,
  }) = _ManaboAttendanceResponseDto;

  factory ManaboAttendanceResponseDto.fromJson(Map<String, Object?> json) =>
      _$ManaboAttendanceResponseDtoFromJson(json);
}

/// MaNaBo出席データDTO
@freezed
abstract class ManaboAttendanceDataDto with _$ManaboAttendanceDataDto {
  const factory ManaboAttendanceDataDto({
    /// 出席状態（0=未出席、1=出席済み）
    required int isAccepted,
  }) = _ManaboAttendanceDataDto;

  factory ManaboAttendanceDataDto.fromJson(Map<String, Object?> json) =>
      _$ManaboAttendanceDataDtoFromJson(json);
}

/// 出席登録フォーム情報DTO
@freezed
abstract class AttendanceFormDto with _$AttendanceFormDto {
  const factory AttendanceFormDto({
    /// エントリーID
    required String entryId,

    /// ユニークID
    required String uniqid,

    /// パスワード要求フラグ
    @Default(false) bool requiresPassword,
  }) = _AttendanceFormDto;

  factory AttendanceFormDto.fromJson(Map<String, Object?> json) =>
      _$AttendanceFormDtoFromJson(json);
}
