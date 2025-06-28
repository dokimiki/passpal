import '../../domain/entities/holiday.dart';
import '../sources/holidays_remote_ds.dart';
import '../adapters/holiday_adapter.dart';
import '../dto/holiday_dto.dart';

abstract class HolidayRepository {
  Future<HolidayCollection> getHolidays();
  Future<bool> isHoliday(DateTime date);
}

class HolidayRepositoryImpl implements HolidayRepository {
  final HolidaysRemoteDataSource _remoteDataSource;
  HolidayCollection? _cachedHolidays;

  HolidayRepositoryImpl(this._remoteDataSource);

  @override
  Future<HolidayCollection> getHolidays() async {
    try {
      final response = await _remoteDataSource.fetchHolidays();

      // Convert raw response to HolidayResponseDto
      final holidayDtos = response.entries.map((entry) {
        return HolidayDto(
          date: entry.key,
          title: entry.value as String,
          description: entry.value as String,
        );
      }).toList();

      final holidayResponse = HolidayResponseDto(holidays: holidayDtos);
      final holidays = HolidayAdapter.fromDtoResponse(holidayResponse);
      _cachedHolidays = holidays;
      return holidays;
    } catch (e) {
      // Return cached holidays if available, otherwise rethrow
      if (_cachedHolidays != null) {
        return _cachedHolidays!;
      }
      rethrow;
    }
  }

  @override
  Future<bool> isHoliday(DateTime date) async {
    final holidays = _cachedHolidays ?? await getHolidays();
    final dateKey = date.toIso8601String().split('T')[0]; // YYYY-MM-DD format
    return holidays.holidays.containsKey(dateKey);
  }
}
