import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/holiday.dart';
import '../value_objects.dart';

part 'pattern_resolver.g.dart';

/// Service for resolving the diagram pattern for today
class PatternResolver {
  const PatternResolver({required this.holidays});

  final HolidayCollection holidays;

  /// Determine the diagram ID for a given date and line
  DiagramId resolvePattern(DateTime date, LineId lineId, TransportMode mode) {
    switch (mode) {
      case TransportMode.bus:
        return _resolveBusPattern(date, lineId);
      case TransportMode.train:
        return _resolveTrainPattern(date);
    }
  }

  DiagramId _resolveBusPattern(DateTime date, LineId lineId) {
    // For buses, we need to check Remote Config or use special diagram data
    // This is a simplified implementation
    if (holidays.isWeekendOrHoliday(date)) {
      return DiagramId.c; // Holiday/Weekend pattern
    }

    // Weekday patterns (A, B, C based on university schedule)
    // This would normally come from Remote Config or special diagram API
    return DiagramId.a; // Default weekday pattern
  }

  DiagramId _resolveTrainPattern(DateTime date) {
    // For trains, simple weekday/holiday logic
    if (holidays.isWeekendOrHoliday(date)) {
      return DiagramId.holiday;
    }
    return DiagramId.weekday;
  }

  /// Check if there's no service on the given date
  bool isNoService(DateTime date, LineId lineId) {
    // This would check for special no-service dates
    // For now, just return false
    return false;
  }
}

@riverpod
PatternResolver patternResolver(Ref ref) {
  // This would get holidays from a repository
  // For now, create an empty collection
  final holidays = const HolidayCollection(holidays: {}, lastUpdated: null);

  return PatternResolver(holidays: holidays);
}
