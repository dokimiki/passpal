import 'package:freezed_annotation/freezed_annotation.dart';

part 'campus.freezed.dart';
part 'campus.g.dart';

/// University campus locations for Chukyo University
@freezed
abstract class Campus with _$Campus {
  const factory Campus.nagoya() = _Nagoya;
  const factory Campus.toyota() = _Toyota;

  factory Campus.fromJson(Map<String, dynamic> json) => _$CampusFromJson(json);
}

extension CampusExtension on Campus {
  /// Display name for the campus
  String get displayName => switch (this) {
    _Nagoya() => '名古屋キャンパス',
    _Toyota() => '豊田キャンパス',
    Campus() => '???キャンパス'
  };

  /// Short code for the campus
  String get code => switch (this) {
    _Nagoya() => 'nagoya',
    _Toyota() => 'toyota',
    Campus() => 'unknown',
  };
}
