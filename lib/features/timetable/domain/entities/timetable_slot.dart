import 'package:freezed_annotation/freezed_annotation.dart';
import 'course.dart';
import '../value_objects/term.dart';

part 'timetable_slot.freezed.dart';
part 'timetable_slot.g.dart';

/// 時間割のスロットを表すエンティティ
@freezed
abstract class TimetableSlot with _$TimetableSlot {
  const factory TimetableSlot({
    /// スロットID
    required String id,

    /// 学期
    required Term term,

    /// 曜日
    required Weekday weekday,

    /// 時限
    required Period period,

    /// 授業情報
    Course? course,

    /// 教室
    String? room,

    /// 備考
    String? notes,
  }) = _TimetableSlot;

  factory TimetableSlot.fromJson(Map<String, Object?> json) =>
      _$TimetableSlotFromJson(json);
}

/// 曜日
enum Weekday {
  @JsonValue('monday')
  monday,
  @JsonValue('tuesday')
  tuesday,
  @JsonValue('wednesday')
  wednesday,
  @JsonValue('thursday')
  thursday,
  @JsonValue('friday')
  friday,
  @JsonValue('saturday')
  saturday,
  @JsonValue('sunday')
  sunday;

  String get displayName {
    switch (this) {
      case Weekday.monday:
        return '月';
      case Weekday.tuesday:
        return '火';
      case Weekday.wednesday:
        return '水';
      case Weekday.thursday:
        return '木';
      case Weekday.friday:
        return '金';
      case Weekday.saturday:
        return '土';
      case Weekday.sunday:
        return '日';
    }
  }

  String get fullName {
    switch (this) {
      case Weekday.monday:
        return '月曜日';
      case Weekday.tuesday:
        return '火曜日';
      case Weekday.wednesday:
        return '水曜日';
      case Weekday.thursday:
        return '木曜日';
      case Weekday.friday:
        return '金曜日';
      case Weekday.saturday:
        return '土曜日';
      case Weekday.sunday:
        return '日曜日';
    }
  }
}

/// 時限
enum Period {
  @JsonValue(1)
  first,
  @JsonValue(2)
  second,
  @JsonValue(3)
  third,
  @JsonValue(4)
  fourth,
  @JsonValue(5)
  fifth,
  @JsonValue(6)
  sixth,
  @JsonValue(7)
  seventh;

  int get number {
    switch (this) {
      case Period.first:
        return 1;
      case Period.second:
        return 2;
      case Period.third:
        return 3;
      case Period.fourth:
        return 4;
      case Period.fifth:
        return 5;
      case Period.sixth:
        return 6;
      case Period.seventh:
        return 7;
    }
  }

  String get displayName => '$number限';

  /// 時限の時間帯を取得
  String get timeRange {
    switch (this) {
      case Period.first:
        return '9:00-10:30';
      case Period.second:
        return '10:40-12:10';
      case Period.third:
        return '13:00-14:30';
      case Period.fourth:
        return '14:40-16:10';
      case Period.fifth:
        return '16:20-17:50';
      case Period.sixth:
        return '18:00-19:30';
      case Period.seventh:
        return '19:40-21:10';
    }
  }

  static Period? fromNumber(int number) {
    switch (number) {
      case 1:
        return Period.first;
      case 2:
        return Period.second;
      case 3:
        return Period.third;
      case 4:
        return Period.fourth;
      case 5:
        return Period.fifth;
      case 6:
        return Period.sixth;
      case 7:
        return Period.seventh;
      default:
        return null;
    }
  }
}
