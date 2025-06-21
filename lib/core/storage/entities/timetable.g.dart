// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTimetableCollection on Isar {
  IsarCollection<Timetable> get timetables => this.collection();
}

const TimetableSchema = CollectionSchema(
  name: r'Timetable',
  id: 6380985727860081250,
  properties: {
    r'campusId': PropertySchema(
      id: 0,
      name: r'campusId',
      type: IsarType.string,
    ),
    r'courseName': PropertySchema(
      id: 1,
      name: r'courseName',
      type: IsarType.string,
    ),
    r'instructor': PropertySchema(
      id: 2,
      name: r'instructor',
      type: IsarType.string,
    ),
    r'period': PropertySchema(
      id: 3,
      name: r'period',
      type: IsarType.long,
    ),
    r'searchKey': PropertySchema(
      id: 4,
      name: r'searchKey',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 5,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'weekday': PropertySchema(
      id: 6,
      name: r'weekday',
      type: IsarType.long,
    )
  },
  estimateSize: _timetableEstimateSize,
  serialize: _timetableSerialize,
  deserialize: _timetableDeserialize,
  deserializeProp: _timetableDeserializeProp,
  idName: r'id',
  indexes: {
    r'searchKey_campusId_weekday_period': IndexSchema(
      id: -3622736872967362300,
      name: r'searchKey_campusId_weekday_period',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'searchKey',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'campusId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'weekday',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'period',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _timetableGetId,
  getLinks: _timetableGetLinks,
  attach: _timetableAttach,
  version: '3.1.0+1',
);

int _timetableEstimateSize(
  Timetable object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.campusId.length * 3;
  bytesCount += 3 + object.courseName.length * 3;
  bytesCount += 3 + object.instructor.length * 3;
  bytesCount += 3 + object.searchKey.length * 3;
  return bytesCount;
}

void _timetableSerialize(
  Timetable object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.campusId);
  writer.writeString(offsets[1], object.courseName);
  writer.writeString(offsets[2], object.instructor);
  writer.writeLong(offsets[3], object.period);
  writer.writeString(offsets[4], object.searchKey);
  writer.writeDateTime(offsets[5], object.updatedAt);
  writer.writeLong(offsets[6], object.weekday);
}

Timetable _timetableDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Timetable(
    campusId: reader.readString(offsets[0]),
    courseName: reader.readString(offsets[1]),
    instructor: reader.readString(offsets[2]),
    period: reader.readLong(offsets[3]),
    weekday: reader.readLong(offsets[6]),
  );
  object.id = id;
  object.updatedAt = reader.readDateTime(offsets[5]);
  return object;
}

P _timetableDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _timetableGetId(Timetable object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _timetableGetLinks(Timetable object) {
  return [];
}

void _timetableAttach(IsarCollection<dynamic> col, Id id, Timetable object) {
  object.id = id;
}

extension TimetableQueryWhereSort
    on QueryBuilder<Timetable, Timetable, QWhere> {
  QueryBuilder<Timetable, Timetable, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TimetableQueryWhere
    on QueryBuilder<Timetable, Timetable, QWhereClause> {
  QueryBuilder<Timetable, Timetable, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause>
      searchKeyEqualToAnyCampusIdWeekdayPeriod(String searchKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'searchKey_campusId_weekday_period',
        value: [searchKey],
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause>
      searchKeyNotEqualToAnyCampusIdWeekdayPeriod(String searchKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey_campusId_weekday_period',
              lower: [],
              upper: [searchKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey_campusId_weekday_period',
              lower: [searchKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey_campusId_weekday_period',
              lower: [searchKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey_campusId_weekday_period',
              lower: [],
              upper: [searchKey],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause>
      searchKeyCampusIdEqualToAnyWeekdayPeriod(
          String searchKey, String campusId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'searchKey_campusId_weekday_period',
        value: [searchKey, campusId],
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause>
      searchKeyEqualToCampusIdNotEqualToAnyWeekdayPeriod(
          String searchKey, String campusId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey_campusId_weekday_period',
              lower: [searchKey],
              upper: [searchKey, campusId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey_campusId_weekday_period',
              lower: [searchKey, campusId],
              includeLower: false,
              upper: [searchKey],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey_campusId_weekday_period',
              lower: [searchKey, campusId],
              includeLower: false,
              upper: [searchKey],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey_campusId_weekday_period',
              lower: [searchKey],
              upper: [searchKey, campusId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause>
      searchKeyCampusIdWeekdayEqualToAnyPeriod(
          String searchKey, String campusId, int weekday) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'searchKey_campusId_weekday_period',
        value: [searchKey, campusId, weekday],
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause>
      searchKeyCampusIdEqualToWeekdayNotEqualToAnyPeriod(
          String searchKey, String campusId, int weekday) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey_campusId_weekday_period',
              lower: [searchKey, campusId],
              upper: [searchKey, campusId, weekday],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey_campusId_weekday_period',
              lower: [searchKey, campusId, weekday],
              includeLower: false,
              upper: [searchKey, campusId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey_campusId_weekday_period',
              lower: [searchKey, campusId, weekday],
              includeLower: false,
              upper: [searchKey, campusId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey_campusId_weekday_period',
              lower: [searchKey, campusId],
              upper: [searchKey, campusId, weekday],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause>
      searchKeyCampusIdEqualToWeekdayGreaterThanAnyPeriod(
    String searchKey,
    String campusId,
    int weekday, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchKey_campusId_weekday_period',
        lower: [searchKey, campusId, weekday],
        includeLower: include,
        upper: [searchKey, campusId],
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause>
      searchKeyCampusIdEqualToWeekdayLessThanAnyPeriod(
    String searchKey,
    String campusId,
    int weekday, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchKey_campusId_weekday_period',
        lower: [searchKey, campusId],
        upper: [searchKey, campusId, weekday],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause>
      searchKeyCampusIdEqualToWeekdayBetweenAnyPeriod(
    String searchKey,
    String campusId,
    int lowerWeekday,
    int upperWeekday, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchKey_campusId_weekday_period',
        lower: [searchKey, campusId, lowerWeekday],
        includeLower: includeLower,
        upper: [searchKey, campusId, upperWeekday],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause>
      searchKeyCampusIdWeekdayPeriodEqualTo(
          String searchKey, String campusId, int weekday, int period) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'searchKey_campusId_weekday_period',
        value: [searchKey, campusId, weekday, period],
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause>
      searchKeyCampusIdWeekdayEqualToPeriodNotEqualTo(
          String searchKey, String campusId, int weekday, int period) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey_campusId_weekday_period',
              lower: [searchKey, campusId, weekday],
              upper: [searchKey, campusId, weekday, period],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey_campusId_weekday_period',
              lower: [searchKey, campusId, weekday, period],
              includeLower: false,
              upper: [searchKey, campusId, weekday],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey_campusId_weekday_period',
              lower: [searchKey, campusId, weekday, period],
              includeLower: false,
              upper: [searchKey, campusId, weekday],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchKey_campusId_weekday_period',
              lower: [searchKey, campusId, weekday],
              upper: [searchKey, campusId, weekday, period],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause>
      searchKeyCampusIdWeekdayEqualToPeriodGreaterThan(
    String searchKey,
    String campusId,
    int weekday,
    int period, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchKey_campusId_weekday_period',
        lower: [searchKey, campusId, weekday, period],
        includeLower: include,
        upper: [searchKey, campusId, weekday],
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause>
      searchKeyCampusIdWeekdayEqualToPeriodLessThan(
    String searchKey,
    String campusId,
    int weekday,
    int period, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchKey_campusId_weekday_period',
        lower: [searchKey, campusId, weekday],
        upper: [searchKey, campusId, weekday, period],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterWhereClause>
      searchKeyCampusIdWeekdayEqualToPeriodBetween(
    String searchKey,
    String campusId,
    int weekday,
    int lowerPeriod,
    int upperPeriod, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'searchKey_campusId_weekday_period',
        lower: [searchKey, campusId, weekday, lowerPeriod],
        includeLower: includeLower,
        upper: [searchKey, campusId, weekday, upperPeriod],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TimetableQueryFilter
    on QueryBuilder<Timetable, Timetable, QFilterCondition> {
  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> campusIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'campusId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> campusIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'campusId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> campusIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'campusId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> campusIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'campusId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> campusIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'campusId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> campusIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'campusId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> campusIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'campusId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> campusIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'campusId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> campusIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'campusId',
        value: '',
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition>
      campusIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'campusId',
        value: '',
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> courseNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'courseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition>
      courseNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'courseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> courseNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'courseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> courseNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'courseName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition>
      courseNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'courseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> courseNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'courseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> courseNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'courseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> courseNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'courseName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition>
      courseNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'courseName',
        value: '',
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition>
      courseNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'courseName',
        value: '',
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> instructorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'instructor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition>
      instructorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'instructor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> instructorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'instructor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> instructorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'instructor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition>
      instructorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'instructor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> instructorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'instructor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> instructorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'instructor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> instructorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'instructor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition>
      instructorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'instructor',
        value: '',
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition>
      instructorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'instructor',
        value: '',
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> periodEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'period',
        value: value,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> periodGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'period',
        value: value,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> periodLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'period',
        value: value,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> periodBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'period',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> searchKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition>
      searchKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> searchKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> searchKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'searchKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> searchKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> searchKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> searchKeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'searchKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> searchKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'searchKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> searchKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchKey',
        value: '',
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition>
      searchKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'searchKey',
        value: '',
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> weekdayEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekday',
        value: value,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> weekdayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weekday',
        value: value,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> weekdayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weekday',
        value: value,
      ));
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterFilterCondition> weekdayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weekday',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TimetableQueryObject
    on QueryBuilder<Timetable, Timetable, QFilterCondition> {}

extension TimetableQueryLinks
    on QueryBuilder<Timetable, Timetable, QFilterCondition> {}

extension TimetableQuerySortBy on QueryBuilder<Timetable, Timetable, QSortBy> {
  QueryBuilder<Timetable, Timetable, QAfterSortBy> sortByCampusId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'campusId', Sort.asc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> sortByCampusIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'campusId', Sort.desc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> sortByCourseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseName', Sort.asc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> sortByCourseNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseName', Sort.desc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> sortByInstructor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructor', Sort.asc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> sortByInstructorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructor', Sort.desc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> sortByPeriod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'period', Sort.asc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> sortByPeriodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'period', Sort.desc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> sortBySearchKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchKey', Sort.asc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> sortBySearchKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchKey', Sort.desc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> sortByWeekday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekday', Sort.asc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> sortByWeekdayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekday', Sort.desc);
    });
  }
}

extension TimetableQuerySortThenBy
    on QueryBuilder<Timetable, Timetable, QSortThenBy> {
  QueryBuilder<Timetable, Timetable, QAfterSortBy> thenByCampusId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'campusId', Sort.asc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> thenByCampusIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'campusId', Sort.desc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> thenByCourseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseName', Sort.asc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> thenByCourseNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseName', Sort.desc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> thenByInstructor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructor', Sort.asc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> thenByInstructorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructor', Sort.desc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> thenByPeriod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'period', Sort.asc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> thenByPeriodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'period', Sort.desc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> thenBySearchKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchKey', Sort.asc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> thenBySearchKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchKey', Sort.desc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> thenByWeekday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekday', Sort.asc);
    });
  }

  QueryBuilder<Timetable, Timetable, QAfterSortBy> thenByWeekdayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekday', Sort.desc);
    });
  }
}

extension TimetableQueryWhereDistinct
    on QueryBuilder<Timetable, Timetable, QDistinct> {
  QueryBuilder<Timetable, Timetable, QDistinct> distinctByCampusId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'campusId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Timetable, Timetable, QDistinct> distinctByCourseName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'courseName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Timetable, Timetable, QDistinct> distinctByInstructor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'instructor', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Timetable, Timetable, QDistinct> distinctByPeriod() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'period');
    });
  }

  QueryBuilder<Timetable, Timetable, QDistinct> distinctBySearchKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'searchKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Timetable, Timetable, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<Timetable, Timetable, QDistinct> distinctByWeekday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekday');
    });
  }
}

extension TimetableQueryProperty
    on QueryBuilder<Timetable, Timetable, QQueryProperty> {
  QueryBuilder<Timetable, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Timetable, String, QQueryOperations> campusIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'campusId');
    });
  }

  QueryBuilder<Timetable, String, QQueryOperations> courseNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'courseName');
    });
  }

  QueryBuilder<Timetable, String, QQueryOperations> instructorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'instructor');
    });
  }

  QueryBuilder<Timetable, int, QQueryOperations> periodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'period');
    });
  }

  QueryBuilder<Timetable, String, QQueryOperations> searchKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'searchKey');
    });
  }

  QueryBuilder<Timetable, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<Timetable, int, QQueryOperations> weekdayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekday');
    });
  }
}
