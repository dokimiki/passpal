import 'package:freezed_annotation/freezed_annotation.dart';

part 'holiday_dto.freezed.dart';
part 'holiday_dto.g.dart';

@freezed
abstract class HolidayDto with _$HolidayDto {
  const factory HolidayDto({
    required String date,
    required String title,
    required String description,
  }) = _HolidayDto;

  factory HolidayDto.fromJson(Map<String, dynamic> json) =>
      _$HolidayDtoFromJson(json);
}

@freezed
abstract class HolidayResponseDto with _$HolidayResponseDto {
  const factory HolidayResponseDto({required List<HolidayDto> holidays}) =
      _HolidayResponseDto;

  factory HolidayResponseDto.fromJson(Map<String, dynamic> json) =>
      _$HolidayResponseDtoFromJson(json);
}
