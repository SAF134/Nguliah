// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_schedule_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetCourseScheduleCollection on Isar {
  IsarCollection<CourseSchedule> get courseSchedules => this.collection();
}

const CourseScheduleSchema = CollectionSchema(
  name: r'CourseSchedule',
  id: -2017845801701500755,
  properties: {
    r'courseName': PropertySchema(
      id: 0,
      name: r'courseName',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dayOfWeek': PropertySchema(
      id: 2,
      name: r'dayOfWeek',
      type: IsarType.long,
    ),
    r'endTimeMinutes': PropertySchema(
      id: 3,
      name: r'endTimeMinutes',
      type: IsarType.long,
    ),
    r'room': PropertySchema(id: 4, name: r'room', type: IsarType.string),
    r'startTimeMinutes': PropertySchema(
      id: 5,
      name: r'startTimeMinutes',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 6,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _courseScheduleEstimateSize,
  serialize: _courseScheduleSerialize,
  deserialize: _courseScheduleDeserialize,
  deserializeProp: _courseScheduleDeserializeProp,
  idName: r'id',
  indexes: {
    r'dayOfWeek': IndexSchema(
      id: -5516657708462385134,
      name: r'dayOfWeek',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dayOfWeek',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _courseScheduleGetId,
  getLinks: _courseScheduleGetLinks,
  attach: _courseScheduleAttach,
  version: '3.4.1',
);

int _courseScheduleEstimateSize(
  CourseSchedule object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.courseName.length * 3;
  bytesCount += 3 + object.room.length * 3;
  return bytesCount;
}

void _courseScheduleSerialize(
  CourseSchedule object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.courseName);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeLong(offsets[2], object.dayOfWeek);
  writer.writeLong(offsets[3], object.endTimeMinutes);
  writer.writeString(offsets[4], object.room);
  writer.writeLong(offsets[5], object.startTimeMinutes);
  writer.writeDateTime(offsets[6], object.updatedAt);
}

CourseSchedule _courseScheduleDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CourseSchedule(
    courseName: reader.readString(offsets[0]),
    createdAt: reader.readDateTime(offsets[1]),
    dayOfWeek: reader.readLong(offsets[2]),
    endTimeMinutes: reader.readLong(offsets[3]),
    id: id,
    room: reader.readString(offsets[4]),
    startTimeMinutes: reader.readLong(offsets[5]),
    updatedAt: reader.readDateTime(offsets[6]),
  );
  return object;
}

P _courseScheduleDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _courseScheduleGetId(CourseSchedule object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _courseScheduleGetLinks(CourseSchedule object) {
  return [];
}

void _courseScheduleAttach(
  IsarCollection<dynamic> col,
  Id id,
  CourseSchedule object,
) {
  object.id = id;
}

extension CourseScheduleQueryWhereSort
    on QueryBuilder<CourseSchedule, CourseSchedule, QWhere> {
  QueryBuilder<CourseSchedule, CourseSchedule, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterWhere> anyDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dayOfWeek'),
      );
    });
  }
}

extension CourseScheduleQueryWhere
    on QueryBuilder<CourseSchedule, CourseSchedule, QWhereClause> {
  QueryBuilder<CourseSchedule, CourseSchedule, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterWhereClause>
  dayOfWeekEqualTo(int dayOfWeek) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'dayOfWeek', value: [dayOfWeek]),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterWhereClause>
  dayOfWeekNotEqualTo(int dayOfWeek) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dayOfWeek',
                lower: [],
                upper: [dayOfWeek],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dayOfWeek',
                lower: [dayOfWeek],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dayOfWeek',
                lower: [dayOfWeek],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dayOfWeek',
                lower: [],
                upper: [dayOfWeek],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterWhereClause>
  dayOfWeekGreaterThan(int dayOfWeek, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'dayOfWeek',
          lower: [dayOfWeek],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterWhereClause>
  dayOfWeekLessThan(int dayOfWeek, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'dayOfWeek',
          lower: [],
          upper: [dayOfWeek],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterWhereClause>
  dayOfWeekBetween(
    int lowerDayOfWeek,
    int upperDayOfWeek, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'dayOfWeek',
          lower: [lowerDayOfWeek],
          includeLower: includeLower,
          upper: [upperDayOfWeek],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension CourseScheduleQueryFilter
    on QueryBuilder<CourseSchedule, CourseSchedule, QFilterCondition> {
  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  courseNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'courseName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  courseNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'courseName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  courseNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'courseName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  courseNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'courseName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  courseNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'courseName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  courseNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'courseName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  courseNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'courseName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  courseNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'courseName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  courseNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'courseName', value: ''),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  courseNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'courseName', value: ''),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  dayOfWeekEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dayOfWeek', value: value),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  dayOfWeekGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dayOfWeek',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  dayOfWeekLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dayOfWeek',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  dayOfWeekBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dayOfWeek',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  endTimeMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'endTimeMinutes', value: value),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  endTimeMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'endTimeMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  endTimeMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'endTimeMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  endTimeMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'endTimeMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  roomEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'room',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  roomGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'room',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  roomLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'room',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  roomBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'room',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  roomStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'room',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  roomEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'room',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  roomContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'room',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  roomMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'room',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  roomIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'room', value: ''),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  roomIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'room', value: ''),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  startTimeMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'startTimeMinutes', value: value),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  startTimeMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'startTimeMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  startTimeMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'startTimeMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  startTimeMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'startTimeMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  updatedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterFilterCondition>
  updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension CourseScheduleQueryObject
    on QueryBuilder<CourseSchedule, CourseSchedule, QFilterCondition> {}

extension CourseScheduleQueryLinks
    on QueryBuilder<CourseSchedule, CourseSchedule, QFilterCondition> {}

extension CourseScheduleQuerySortBy
    on QueryBuilder<CourseSchedule, CourseSchedule, QSortBy> {
  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  sortByCourseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseName', Sort.asc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  sortByCourseNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseName', Sort.desc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy> sortByDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfWeek', Sort.asc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  sortByDayOfWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfWeek', Sort.desc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  sortByEndTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  sortByEndTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTimeMinutes', Sort.desc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy> sortByRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'room', Sort.asc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy> sortByRoomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'room', Sort.desc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  sortByStartTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  sortByStartTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeMinutes', Sort.desc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CourseScheduleQuerySortThenBy
    on QueryBuilder<CourseSchedule, CourseSchedule, QSortThenBy> {
  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  thenByCourseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseName', Sort.asc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  thenByCourseNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseName', Sort.desc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy> thenByDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfWeek', Sort.asc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  thenByDayOfWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfWeek', Sort.desc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  thenByEndTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  thenByEndTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTimeMinutes', Sort.desc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy> thenByRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'room', Sort.asc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy> thenByRoomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'room', Sort.desc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  thenByStartTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  thenByStartTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeMinutes', Sort.desc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CourseScheduleQueryWhereDistinct
    on QueryBuilder<CourseSchedule, CourseSchedule, QDistinct> {
  QueryBuilder<CourseSchedule, CourseSchedule, QDistinct> distinctByCourseName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'courseName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QDistinct>
  distinctByDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayOfWeek');
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QDistinct>
  distinctByEndTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTimeMinutes');
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QDistinct> distinctByRoom({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'room', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QDistinct>
  distinctByStartTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTimeMinutes');
    });
  }

  QueryBuilder<CourseSchedule, CourseSchedule, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension CourseScheduleQueryProperty
    on QueryBuilder<CourseSchedule, CourseSchedule, QQueryProperty> {
  QueryBuilder<CourseSchedule, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CourseSchedule, String, QQueryOperations> courseNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'courseName');
    });
  }

  QueryBuilder<CourseSchedule, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CourseSchedule, int, QQueryOperations> dayOfWeekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayOfWeek');
    });
  }

  QueryBuilder<CourseSchedule, int, QQueryOperations> endTimeMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTimeMinutes');
    });
  }

  QueryBuilder<CourseSchedule, String, QQueryOperations> roomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'room');
    });
  }

  QueryBuilder<CourseSchedule, int, QQueryOperations>
  startTimeMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTimeMinutes');
    });
  }

  QueryBuilder<CourseSchedule, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
