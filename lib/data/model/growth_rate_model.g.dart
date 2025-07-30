// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_rate_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGrowthRateModelCollection on Isar {
  IsarCollection<GrowthRateModel> get growthRateModels => this.collection();
}

const GrowthRateModelSchema = CollectionSchema(
  name: r'GrowthRateModel',
  id: -4828723965517184103,
  properties: {
    r'levelToExp': PropertySchema(
      id: 0,
      name: r'levelToExp',
      type: IsarType.longList,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _growthRateModelEstimateSize,
  serialize: _growthRateModelSerialize,
  deserialize: _growthRateModelDeserialize,
  deserializeProp: _growthRateModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _growthRateModelGetId,
  getLinks: _growthRateModelGetLinks,
  attach: _growthRateModelAttach,
  version: '3.1.0+1',
);

int _growthRateModelEstimateSize(
  GrowthRateModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.levelToExp.length * 8;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _growthRateModelSerialize(
  GrowthRateModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.levelToExp);
  writer.writeString(offsets[1], object.name);
}

GrowthRateModel _growthRateModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GrowthRateModel(
    levelToExp: reader.readLongList(offsets[0]) ?? [],
    name: reader.readString(offsets[1]),
  );
  object.id = id;
  return object;
}

P _growthRateModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset) ?? []) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _growthRateModelGetId(GrowthRateModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _growthRateModelGetLinks(GrowthRateModel object) {
  return [];
}

void _growthRateModelAttach(
    IsarCollection<dynamic> col, Id id, GrowthRateModel object) {
  object.id = id;
}

extension GrowthRateModelQueryWhereSort
    on QueryBuilder<GrowthRateModel, GrowthRateModel, QWhere> {
  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GrowthRateModelQueryWhere
    on QueryBuilder<GrowthRateModel, GrowthRateModel, QWhereClause> {
  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterWhereClause> idBetween(
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
}

extension GrowthRateModelQueryFilter
    on QueryBuilder<GrowthRateModel, GrowthRateModel, QFilterCondition> {
  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      levelToExpElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'levelToExp',
        value: value,
      ));
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      levelToExpElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'levelToExp',
        value: value,
      ));
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      levelToExpElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'levelToExp',
        value: value,
      ));
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      levelToExpElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'levelToExp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      levelToExpLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'levelToExp',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      levelToExpIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'levelToExp',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      levelToExpIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'levelToExp',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      levelToExpLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'levelToExp',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      levelToExpLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'levelToExp',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      levelToExpLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'levelToExp',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension GrowthRateModelQueryObject
    on QueryBuilder<GrowthRateModel, GrowthRateModel, QFilterCondition> {}

extension GrowthRateModelQueryLinks
    on QueryBuilder<GrowthRateModel, GrowthRateModel, QFilterCondition> {}

extension GrowthRateModelQuerySortBy
    on QueryBuilder<GrowthRateModel, GrowthRateModel, QSortBy> {
  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension GrowthRateModelQuerySortThenBy
    on QueryBuilder<GrowthRateModel, GrowthRateModel, QSortThenBy> {
  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension GrowthRateModelQueryWhereDistinct
    on QueryBuilder<GrowthRateModel, GrowthRateModel, QDistinct> {
  QueryBuilder<GrowthRateModel, GrowthRateModel, QDistinct>
      distinctByLevelToExp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'levelToExp');
    });
  }

  QueryBuilder<GrowthRateModel, GrowthRateModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension GrowthRateModelQueryProperty
    on QueryBuilder<GrowthRateModel, GrowthRateModel, QQueryProperty> {
  QueryBuilder<GrowthRateModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GrowthRateModel, List<int>, QQueryOperations>
      levelToExpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'levelToExp');
    });
  }

  QueryBuilder<GrowthRateModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
