// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetAppSettingsCollection on Isar {
  IsarCollection<AppSettings> get appSettings => this.collection();
}

const AppSettingsSchema = CollectionSchema(
  name: r'AppSettings',
  id: -5633561779022347008,
  properties: {
    r'customGradeWeightsJson': PropertySchema(
      id: 0,
      name: r'customGradeWeightsJson',
      type: IsarType.string,
    ),
    r'eventNotificationEnabled': PropertySchema(
      id: 1,
      name: r'eventNotificationEnabled',
      type: IsarType.bool,
    ),
    r'eventReminderOffsetMinutes': PropertySchema(
      id: 2,
      name: r'eventReminderOffsetMinutes',
      type: IsarType.long,
    ),
    r'hideAcademicScores': PropertySchema(
      id: 3,
      name: r'hideAcademicScores',
      type: IsarType.bool,
    ),
    r'lastBackupAt': PropertySchema(
      id: 4,
      name: r'lastBackupAt',
      type: IsarType.dateTime,
    ),
    r'localeCode': PropertySchema(
      id: 5,
      name: r'localeCode',
      type: IsarType.string,
    ),
    r'minPassingGrade': PropertySchema(
      id: 6,
      name: r'minPassingGrade',
      type: IsarType.string,
    ),
    r'onboardingCompleted': PropertySchema(
      id: 7,
      name: r'onboardingCompleted',
      type: IsarType.bool,
    ),
    r'retakeRule': PropertySchema(
      id: 8,
      name: r'retakeRule',
      type: IsarType.string,
      enumMap: _AppSettingsretakeRuleEnumValueMap,
    ),
    r'scheduleNotificationEnabled': PropertySchema(
      id: 9,
      name: r'scheduleNotificationEnabled',
      type: IsarType.bool,
    ),
    r'scheduleReminderOffsetMinutes': PropertySchema(
      id: 10,
      name: r'scheduleReminderOffsetMinutes',
      type: IsarType.long,
    ),
    r'taskNotificationEnabled': PropertySchema(
      id: 11,
      name: r'taskNotificationEnabled',
      type: IsarType.bool,
    ),
    r'taskReminderOffsetMinutes': PropertySchema(
      id: 12,
      name: r'taskReminderOffsetMinutes',
      type: IsarType.long,
    ),
    r'themeMode': PropertySchema(
      id: 13,
      name: r'themeMode',
      type: IsarType.string,
    ),
    r'weightA': PropertySchema(id: 14, name: r'weightA', type: IsarType.double),
    r'weightAB': PropertySchema(
      id: 15,
      name: r'weightAB',
      type: IsarType.double,
    ),
    r'weightB': PropertySchema(id: 16, name: r'weightB', type: IsarType.double),
    r'weightBC': PropertySchema(
      id: 17,
      name: r'weightBC',
      type: IsarType.double,
    ),
    r'weightC': PropertySchema(id: 18, name: r'weightC', type: IsarType.double),
    r'weightD': PropertySchema(id: 19, name: r'weightD', type: IsarType.double),
    r'weightE': PropertySchema(id: 20, name: r'weightE', type: IsarType.double),
  },

  estimateSize: _appSettingsEstimateSize,
  serialize: _appSettingsSerialize,
  deserialize: _appSettingsDeserialize,
  deserializeProp: _appSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _appSettingsGetId,
  getLinks: _appSettingsGetLinks,
  attach: _appSettingsAttach,
  version: '3.4.1',
);

int _appSettingsEstimateSize(
  AppSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.customGradeWeightsJson.length * 3;
  bytesCount += 3 + object.localeCode.length * 3;
  bytesCount += 3 + object.minPassingGrade.length * 3;
  bytesCount += 3 + object.retakeRule.name.length * 3;
  bytesCount += 3 + object.themeMode.length * 3;
  return bytesCount;
}

void _appSettingsSerialize(
  AppSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.customGradeWeightsJson);
  writer.writeBool(offsets[1], object.eventNotificationEnabled);
  writer.writeLong(offsets[2], object.eventReminderOffsetMinutes);
  writer.writeBool(offsets[3], object.hideAcademicScores);
  writer.writeDateTime(offsets[4], object.lastBackupAt);
  writer.writeString(offsets[5], object.localeCode);
  writer.writeString(offsets[6], object.minPassingGrade);
  writer.writeBool(offsets[7], object.onboardingCompleted);
  writer.writeString(offsets[8], object.retakeRule.name);
  writer.writeBool(offsets[9], object.scheduleNotificationEnabled);
  writer.writeLong(offsets[10], object.scheduleReminderOffsetMinutes);
  writer.writeBool(offsets[11], object.taskNotificationEnabled);
  writer.writeLong(offsets[12], object.taskReminderOffsetMinutes);
  writer.writeString(offsets[13], object.themeMode);
  writer.writeDouble(offsets[14], object.weightA);
  writer.writeDouble(offsets[15], object.weightAB);
  writer.writeDouble(offsets[16], object.weightB);
  writer.writeDouble(offsets[17], object.weightBC);
  writer.writeDouble(offsets[18], object.weightC);
  writer.writeDouble(offsets[19], object.weightD);
  writer.writeDouble(offsets[20], object.weightE);
}

AppSettings _appSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppSettings(
    customGradeWeightsJson: reader.readStringOrNull(offsets[0]) ?? '',
    eventNotificationEnabled: reader.readBoolOrNull(offsets[1]) ?? true,
    eventReminderOffsetMinutes: reader.readLongOrNull(offsets[2]) ?? 60,
    hideAcademicScores: reader.readBoolOrNull(offsets[3]) ?? false,
    id: id,
    lastBackupAt: reader.readDateTimeOrNull(offsets[4]),
    localeCode: reader.readStringOrNull(offsets[5]) ?? 'id',
    minPassingGrade: reader.readStringOrNull(offsets[6]) ?? 'D',
    onboardingCompleted: reader.readBoolOrNull(offsets[7]) ?? false,
    retakeRule:
        _AppSettingsretakeRuleValueEnumMap[reader.readStringOrNull(
          offsets[8],
        )] ??
        RetakeRule.latest,
    scheduleNotificationEnabled: reader.readBoolOrNull(offsets[9]) ?? true,
    scheduleReminderOffsetMinutes: reader.readLongOrNull(offsets[10]) ?? 30,
    taskNotificationEnabled: reader.readBoolOrNull(offsets[11]) ?? true,
    taskReminderOffsetMinutes: reader.readLongOrNull(offsets[12]) ?? 60,
    themeMode: reader.readStringOrNull(offsets[13]) ?? 'light',
    weightA: reader.readDoubleOrNull(offsets[14]) ?? 4.0,
    weightAB: reader.readDoubleOrNull(offsets[15]) ?? 3.5,
    weightB: reader.readDoubleOrNull(offsets[16]) ?? 3.0,
    weightBC: reader.readDoubleOrNull(offsets[17]) ?? 2.5,
    weightC: reader.readDoubleOrNull(offsets[18]) ?? 2.0,
    weightD: reader.readDoubleOrNull(offsets[19]) ?? 1.0,
    weightE: reader.readDoubleOrNull(offsets[20]) ?? 0.0,
  );
  return object;
}

P _appSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 60) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? 'id') as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? 'D') as P;
    case 7:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 8:
      return (_AppSettingsretakeRuleValueEnumMap[reader.readStringOrNull(
                offset,
              )] ??
              RetakeRule.latest)
          as P;
    case 9:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 10:
      return (reader.readLongOrNull(offset) ?? 30) as P;
    case 11:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 12:
      return (reader.readLongOrNull(offset) ?? 60) as P;
    case 13:
      return (reader.readStringOrNull(offset) ?? 'light') as P;
    case 14:
      return (reader.readDoubleOrNull(offset) ?? 4.0) as P;
    case 15:
      return (reader.readDoubleOrNull(offset) ?? 3.5) as P;
    case 16:
      return (reader.readDoubleOrNull(offset) ?? 3.0) as P;
    case 17:
      return (reader.readDoubleOrNull(offset) ?? 2.5) as P;
    case 18:
      return (reader.readDoubleOrNull(offset) ?? 2.0) as P;
    case 19:
      return (reader.readDoubleOrNull(offset) ?? 1.0) as P;
    case 20:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AppSettingsretakeRuleEnumValueMap = {
  r'highest': r'highest',
  r'latest': r'latest',
};
const _AppSettingsretakeRuleValueEnumMap = {
  r'highest': RetakeRule.highest,
  r'latest': RetakeRule.latest,
};

Id _appSettingsGetId(AppSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appSettingsGetLinks(AppSettings object) {
  return [];
}

void _appSettingsAttach(
  IsarCollection<dynamic> col,
  Id id,
  AppSettings object,
) {
  object.id = id;
}

extension AppSettingsQueryWhereSort
    on QueryBuilder<AppSettings, AppSettings, QWhere> {
  QueryBuilder<AppSettings, AppSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppSettingsQueryWhere
    on QueryBuilder<AppSettings, AppSettings, QWhereClause> {
  QueryBuilder<AppSettings, AppSettings, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<AppSettings, AppSettings, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterWhereClause> idBetween(
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
}

extension AppSettingsQueryFilter
    on QueryBuilder<AppSettings, AppSettings, QFilterCondition> {
  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  customGradeWeightsJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'customGradeWeightsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  customGradeWeightsJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'customGradeWeightsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  customGradeWeightsJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'customGradeWeightsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  customGradeWeightsJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'customGradeWeightsJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  customGradeWeightsJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'customGradeWeightsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  customGradeWeightsJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'customGradeWeightsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  customGradeWeightsJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'customGradeWeightsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  customGradeWeightsJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'customGradeWeightsJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  customGradeWeightsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'customGradeWeightsJson', value: ''),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  customGradeWeightsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'customGradeWeightsJson',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  eventNotificationEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'eventNotificationEnabled',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  eventReminderOffsetMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'eventReminderOffsetMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  eventReminderOffsetMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'eventReminderOffsetMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  eventReminderOffsetMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'eventReminderOffsetMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  eventReminderOffsetMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'eventReminderOffsetMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  hideAcademicScoresEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hideAcademicScores', value: value),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
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

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
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

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> idBetween(
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

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  lastBackupAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastBackupAt'),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  lastBackupAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastBackupAt'),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  lastBackupAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastBackupAt', value: value),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  lastBackupAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastBackupAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  lastBackupAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastBackupAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  lastBackupAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastBackupAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  localeCodeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'localeCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  localeCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'localeCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  localeCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'localeCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  localeCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'localeCode',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  localeCodeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'localeCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  localeCodeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'localeCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  localeCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'localeCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  localeCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'localeCode',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  localeCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'localeCode', value: ''),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  localeCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'localeCode', value: ''),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  minPassingGradeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'minPassingGrade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  minPassingGradeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'minPassingGrade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  minPassingGradeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'minPassingGrade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  minPassingGradeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'minPassingGrade',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  minPassingGradeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'minPassingGrade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  minPassingGradeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'minPassingGrade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  minPassingGradeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'minPassingGrade',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  minPassingGradeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'minPassingGrade',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  minPassingGradeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'minPassingGrade', value: ''),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  minPassingGradeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'minPassingGrade', value: ''),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  onboardingCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'onboardingCompleted', value: value),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  retakeRuleEqualTo(RetakeRule value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'retakeRule',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  retakeRuleGreaterThan(
    RetakeRule value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'retakeRule',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  retakeRuleLessThan(
    RetakeRule value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'retakeRule',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  retakeRuleBetween(
    RetakeRule lower,
    RetakeRule upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'retakeRule',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  retakeRuleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'retakeRule',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  retakeRuleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'retakeRule',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  retakeRuleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'retakeRule',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  retakeRuleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'retakeRule',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  retakeRuleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'retakeRule', value: ''),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  retakeRuleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'retakeRule', value: ''),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  scheduleNotificationEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'scheduleNotificationEnabled',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  scheduleReminderOffsetMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'scheduleReminderOffsetMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  scheduleReminderOffsetMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scheduleReminderOffsetMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  scheduleReminderOffsetMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scheduleReminderOffsetMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  scheduleReminderOffsetMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scheduleReminderOffsetMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  taskNotificationEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'taskNotificationEnabled',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  taskReminderOffsetMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'taskReminderOffsetMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  taskReminderOffsetMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'taskReminderOffsetMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  taskReminderOffsetMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'taskReminderOffsetMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  taskReminderOffsetMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'taskReminderOffsetMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  themeModeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'themeMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  themeModeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'themeMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  themeModeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'themeMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  themeModeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'themeMode',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  themeModeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'themeMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  themeModeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'themeMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  themeModeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'themeMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  themeModeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'themeMode',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  themeModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'themeMode', value: ''),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  themeModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'themeMode', value: ''),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightAEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'weightA',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  weightAGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'weightA',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightALessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'weightA',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightABetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'weightA',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightABEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'weightAB',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  weightABGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'weightAB',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  weightABLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'weightAB',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightABBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'weightAB',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightBEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'weightB',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  weightBGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'weightB',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightBLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'weightB',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightBBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'weightB',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightBCEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'weightBC',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  weightBCGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'weightBC',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  weightBCLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'weightBC',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightBCBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'weightBC',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightCEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'weightC',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  weightCGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'weightC',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightCLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'weightC',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightCBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'weightC',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightDEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'weightD',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  weightDGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'weightD',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightDLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'weightD',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightDBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'weightD',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightEEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'weightE',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
  weightEGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'weightE',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightELessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'weightE',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> weightEBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'weightE',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }
}

extension AppSettingsQueryObject
    on QueryBuilder<AppSettings, AppSettings, QFilterCondition> {}

extension AppSettingsQueryLinks
    on QueryBuilder<AppSettings, AppSettings, QFilterCondition> {}

extension AppSettingsQuerySortBy
    on QueryBuilder<AppSettings, AppSettings, QSortBy> {
  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByCustomGradeWeightsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customGradeWeightsJson', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByCustomGradeWeightsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customGradeWeightsJson', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByEventNotificationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventNotificationEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByEventNotificationEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventNotificationEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByEventReminderOffsetMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventReminderOffsetMinutes', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByEventReminderOffsetMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventReminderOffsetMinutes', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByHideAcademicScores() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hideAcademicScores', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByHideAcademicScoresDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hideAcademicScores', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByLastBackupAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastBackupAt', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByLastBackupAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastBackupAt', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByLocaleCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localeCode', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByLocaleCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localeCode', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByMinPassingGrade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minPassingGrade', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByMinPassingGradeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minPassingGrade', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByOnboardingCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByRetakeRule() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retakeRule', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByRetakeRuleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retakeRule', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByScheduleNotificationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleNotificationEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByScheduleNotificationEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleNotificationEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByScheduleReminderOffsetMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleReminderOffsetMinutes', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByScheduleReminderOffsetMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleReminderOffsetMinutes', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByTaskNotificationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskNotificationEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByTaskNotificationEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskNotificationEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByTaskReminderOffsetMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskReminderOffsetMinutes', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  sortByTaskReminderOffsetMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskReminderOffsetMinutes', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByWeightA() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightA', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByWeightADesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightA', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByWeightAB() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightAB', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByWeightABDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightAB', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByWeightB() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightB', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByWeightBDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightB', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByWeightBC() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightBC', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByWeightBCDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightBC', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByWeightC() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightC', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByWeightCDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightC', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByWeightD() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightD', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByWeightDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightD', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByWeightE() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightE', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByWeightEDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightE', Sort.desc);
    });
  }
}

extension AppSettingsQuerySortThenBy
    on QueryBuilder<AppSettings, AppSettings, QSortThenBy> {
  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByCustomGradeWeightsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customGradeWeightsJson', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByCustomGradeWeightsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customGradeWeightsJson', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByEventNotificationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventNotificationEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByEventNotificationEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventNotificationEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByEventReminderOffsetMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventReminderOffsetMinutes', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByEventReminderOffsetMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventReminderOffsetMinutes', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByHideAcademicScores() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hideAcademicScores', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByHideAcademicScoresDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hideAcademicScores', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByLastBackupAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastBackupAt', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByLastBackupAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastBackupAt', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByLocaleCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localeCode', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByLocaleCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localeCode', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByMinPassingGrade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minPassingGrade', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByMinPassingGradeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minPassingGrade', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByOnboardingCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByRetakeRule() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retakeRule', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByRetakeRuleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retakeRule', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByScheduleNotificationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleNotificationEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByScheduleNotificationEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleNotificationEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByScheduleReminderOffsetMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleReminderOffsetMinutes', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByScheduleReminderOffsetMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleReminderOffsetMinutes', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByTaskNotificationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskNotificationEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByTaskNotificationEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskNotificationEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByTaskReminderOffsetMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskReminderOffsetMinutes', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
  thenByTaskReminderOffsetMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskReminderOffsetMinutes', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByWeightA() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightA', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByWeightADesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightA', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByWeightAB() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightAB', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByWeightABDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightAB', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByWeightB() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightB', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByWeightBDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightB', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByWeightBC() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightBC', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByWeightBCDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightBC', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByWeightC() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightC', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByWeightCDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightC', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByWeightD() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightD', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByWeightDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightD', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByWeightE() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightE', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByWeightEDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightE', Sort.desc);
    });
  }
}

extension AppSettingsQueryWhereDistinct
    on QueryBuilder<AppSettings, AppSettings, QDistinct> {
  QueryBuilder<AppSettings, AppSettings, QDistinct>
  distinctByCustomGradeWeightsJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'customGradeWeightsJson',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct>
  distinctByEventNotificationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventNotificationEnabled');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct>
  distinctByEventReminderOffsetMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventReminderOffsetMinutes');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct>
  distinctByHideAcademicScores() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hideAcademicScores');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByLastBackupAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastBackupAt');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByLocaleCode({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localeCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByMinPassingGrade({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'minPassingGrade',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct>
  distinctByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onboardingCompleted');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByRetakeRule({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'retakeRule', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct>
  distinctByScheduleNotificationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduleNotificationEnabled');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct>
  distinctByScheduleReminderOffsetMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduleReminderOffsetMinutes');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct>
  distinctByTaskNotificationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taskNotificationEnabled');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct>
  distinctByTaskReminderOffsetMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taskReminderOffsetMinutes');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByThemeMode({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'themeMode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByWeightA() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightA');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByWeightAB() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightAB');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByWeightB() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightB');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByWeightBC() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightBC');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByWeightC() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightC');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByWeightD() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightD');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByWeightE() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightE');
    });
  }
}

extension AppSettingsQueryProperty
    on QueryBuilder<AppSettings, AppSettings, QQueryProperty> {
  QueryBuilder<AppSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppSettings, String, QQueryOperations>
  customGradeWeightsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customGradeWeightsJson');
    });
  }

  QueryBuilder<AppSettings, bool, QQueryOperations>
  eventNotificationEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventNotificationEnabled');
    });
  }

  QueryBuilder<AppSettings, int, QQueryOperations>
  eventReminderOffsetMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventReminderOffsetMinutes');
    });
  }

  QueryBuilder<AppSettings, bool, QQueryOperations>
  hideAcademicScoresProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hideAcademicScores');
    });
  }

  QueryBuilder<AppSettings, DateTime?, QQueryOperations>
  lastBackupAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastBackupAt');
    });
  }

  QueryBuilder<AppSettings, String, QQueryOperations> localeCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localeCode');
    });
  }

  QueryBuilder<AppSettings, String, QQueryOperations>
  minPassingGradeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minPassingGrade');
    });
  }

  QueryBuilder<AppSettings, bool, QQueryOperations>
  onboardingCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onboardingCompleted');
    });
  }

  QueryBuilder<AppSettings, RetakeRule, QQueryOperations> retakeRuleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'retakeRule');
    });
  }

  QueryBuilder<AppSettings, bool, QQueryOperations>
  scheduleNotificationEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduleNotificationEnabled');
    });
  }

  QueryBuilder<AppSettings, int, QQueryOperations>
  scheduleReminderOffsetMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduleReminderOffsetMinutes');
    });
  }

  QueryBuilder<AppSettings, bool, QQueryOperations>
  taskNotificationEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskNotificationEnabled');
    });
  }

  QueryBuilder<AppSettings, int, QQueryOperations>
  taskReminderOffsetMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskReminderOffsetMinutes');
    });
  }

  QueryBuilder<AppSettings, String, QQueryOperations> themeModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'themeMode');
    });
  }

  QueryBuilder<AppSettings, double, QQueryOperations> weightAProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightA');
    });
  }

  QueryBuilder<AppSettings, double, QQueryOperations> weightABProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightAB');
    });
  }

  QueryBuilder<AppSettings, double, QQueryOperations> weightBProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightB');
    });
  }

  QueryBuilder<AppSettings, double, QQueryOperations> weightBCProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightBC');
    });
  }

  QueryBuilder<AppSettings, double, QQueryOperations> weightCProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightC');
    });
  }

  QueryBuilder<AppSettings, double, QQueryOperations> weightDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightD');
    });
  }

  QueryBuilder<AppSettings, double, QQueryOperations> weightEProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightE');
    });
  }
}
