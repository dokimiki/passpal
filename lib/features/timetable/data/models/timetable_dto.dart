import 'package:freezed_annotation/freezed_annotation.dart';

part 'timetable_dto.freezed.dart';
part 'timetable_dto.g.dart';

/// MaNaBo時間割レスポンスDTO
@freezed
abstract class ManaboTimetableResponseDto with _$ManaboTimetableResponseDto {
  const factory ManaboTimetableResponseDto({
    /// HTMLコンテンツ
    required String html,

    /// レスポンス成功フラグ
    @Default(true) bool success,
  }) = _ManaboTimetableResponseDto;

  factory ManaboTimetableResponseDto.fromJson(Map<String, Object?> json) =>
      _$ManaboTimetableResponseDtoFromJson(json);
}

/// Cubics教室情報DTO
@freezed
abstract class CubicsRoomDto with _$CubicsRoomDto {
  const factory CubicsRoomDto({
    /// 建物名
    required String building,

    /// 教室番号
    required String room,

    /// キャンパス
    required String campus,
  }) = _CubicsRoomDto;

  factory CubicsRoomDto.fromJson(Map<String, Object?> json) =>
      _$CubicsRoomDtoFromJson(json);
}

/// MaNaBo授業スロットDTO
@freezed
abstract class ManaboSlotDto with _$ManaboSlotDto {
  const factory ManaboSlotDto({
    /// 曜日（1=月、2=火...）
    required int weekday,

    /// 時限
    required int period,

    /// 授業名
    String? courseName,

    /// 教員名
    String? teacher,

    /// 教室
    String? room,

    /// MaNaBoクラスID
    int? manaboClassId,

    /// 授業コード
    String? courseCode,
  }) = _ManaboSlotDto;

  factory ManaboSlotDto.fromJson(Map<String, Object?> json) =>
      _$ManaboSlotDtoFromJson(json);
}
