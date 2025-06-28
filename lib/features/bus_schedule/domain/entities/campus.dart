import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects.dart';

part 'campus.freezed.dart';
part 'campus.g.dart';

/// Campus entity representing university campus locations
@freezed
abstract class CampusEntity with _$CampusEntity {
  const factory CampusEntity({
    required Campus id,
    required String name,
    required String description,
    required List<LineId> availableLines,
  }) = _CampusEntity;

  factory CampusEntity.fromJson(Map<String, dynamic> json) =>
      _$CampusEntityFromJson(json);

  // Predefined campus entities
  static const toyota = CampusEntity(
    id: Campus.toyota,
    name: '豊田キャンパス',
    description: '中京大学豊田キャンパス',
    availableLines: [LineId.toyota, LineId.campus, LineId.kaizu, LineId.josui],
  );

  static const yagoto = CampusEntity(
    id: Campus.yagoto,
    name: '八事キャンパス',
    description: '中京大学八事キャンパス',
    availableLines: [LineId.campus, LineId.yagoToT, LineId.yagoToM],
  );
}
