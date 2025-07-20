import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_version.freezed.dart';
part 'storage_version.g.dart';

@freezed
abstract class StorageVersion with _$StorageVersion {
  const factory StorageVersion({
    required int version,
    required String description,
    required DateTime createdAt,
    @Default(<String>[]) List<String> migrations,
  }) = _StorageVersion;

  factory StorageVersion.fromJson(Map<String, dynamic> json) =>
      _$StorageVersionFromJson(json);
}

@freezed
abstract class MigrationStep with _$MigrationStep {
  const factory MigrationStep({
    required String id,
    required int fromVersion,
    required int toVersion,
    required String description,
    required MigrationType type,
    required Map<String, dynamic> parameters,
  }) = _MigrationStep;

  factory MigrationStep.fromJson(Map<String, dynamic> json) =>
      _$MigrationStepFromJson(json);
}

enum MigrationType {
  @JsonValue('key_rename')
  keyRename,
  @JsonValue('data_transform')
  dataTransform,
  @JsonValue('schema_update')
  schemaUpdate,
  @JsonValue('data_migration')
  dataMigration,
}

@freezed
abstract class MigrationResult with _$MigrationResult {
  const factory MigrationResult({
    required bool success,
    required int fromVersion,
    required int toVersion,
    required List<String> appliedMigrations,
    String? error,
    @Default(<String, dynamic>{}) Map<String, dynamic> metadata,
  }) = _MigrationResult;

  factory MigrationResult.fromJson(Map<String, dynamic> json) =>
      _$MigrationResultFromJson(json);
}
