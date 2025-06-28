import 'package:freezed_annotation/freezed_annotation.dart';

part 'holiday.freezed.dart';
part 'holiday.g.dart';

/// Holiday entity representing Japanese holidays
@freezed
abstract class HolidayEntity with _$HolidayEntity {
  const factory HolidayEntity({required DateTime date, required String name}) =
      _HolidayEntity;

  factory HolidayEntity.fromJson(Map<String, dynamic> json) =>
      _$HolidayEntityFromJson(json);

  factory HolidayEntity.fromDateString(String dateStr, String name) {
    final date = DateTime.parse(dateStr);
    return HolidayEntity(date: date, name: name);
  }
}

/// Collection of holidays for efficient lookup
@freezed
abstract class HolidayCollection with _$HolidayCollection {
  const factory HolidayCollection({
    required Map<String, String> holidays,
    DateTime? lastUpdated,
  }) = _HolidayCollection;

  factory HolidayCollection.fromJson(Map<String, dynamic> json) =>
      _$HolidayCollectionFromJson(json);

  factory HolidayCollection.fromApiResponse(Map<String, dynamic> apiData) {
    return HolidayCollection(
      holidays: Map<String, String>.from(apiData),
      lastUpdated: DateTime.now(),
    );
  }
}

extension HolidayCollectionX on HolidayCollection {
  /// Check if a given date is a Japanese holiday
  bool isHoliday(DateTime date) {
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return holidays.containsKey(dateStr);
  }

  /// Check if a given date is a weekend
  bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  /// Check if a given date is a weekend or holiday
  bool isWeekendOrHoliday(DateTime date) {
    return isWeekend(date) || isHoliday(date);
  }

  /// Get holiday name for a given date, null if not a holiday
  String? getHolidayName(DateTime date) {
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return holidays[dateStr];
  }
}
