import '../dto/holiday_dto.dart';
import '../../domain/entities/holiday.dart';

class HolidayAdapter {
  static HolidayEntity fromDto(HolidayDto dto) {
    return HolidayEntity(date: DateTime.parse(dto.date), name: dto.title);
  }

  static HolidayDto toDto(HolidayEntity entity) {
    return HolidayDto(
      date: entity.date.toIso8601String().split('T')[0], // YYYY-MM-DD format
      title: entity.name,
      description: entity.name, // Use name as description if needed
    );
  }

  static HolidayCollection fromDtoResponse(HolidayResponseDto response) {
    final holidayMap = <String, String>{};
    for (final dto in response.holidays) {
      holidayMap[dto.date] = dto.title;
    }
    return HolidayCollection(holidays: holidayMap, lastUpdated: DateTime.now());
  }
}
