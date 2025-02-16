// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBranchModelIsarCollection on Isar {
  IsarCollection<BranchModelIsar> get branchModelIsars => this.collection();
}

const BranchModelIsarSchema = CollectionSchema(
  name: r'BranchModelIsar',
  id: -5684992062428544622,
  properties: {
    r'address': PropertySchema(
      id: 0,
      name: r'address',
      type: IsarType.string,
    ),
    r'branchBinNumber': PropertySchema(
      id: 1,
      name: r'branchBinNumber',
      type: IsarType.string,
    ),
    r'branchId': PropertySchema(
      id: 2,
      name: r'branchId',
      type: IsarType.string,
    ),
    r'branchPhoneNumber': PropertySchema(
      id: 3,
      name: r'branchPhoneNumber',
      type: IsarType.string,
    ),
    r'image': PropertySchema(
      id: 4,
      name: r'image',
      type: IsarType.string,
    ),
    r'managerId': PropertySchema(
      id: 5,
      name: r'managerId',
      type: IsarType.string,
    ),
    r'managerName': PropertySchema(
      id: 6,
      name: r'managerName',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 7,
      name: r'name',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 8,
      name: r'status',
      type: IsarType.bool,
    ),
    r'table': PropertySchema(
      id: 9,
      name: r'table',
      type: IsarType.long,
    )
  },
  estimateSize: _branchModelIsarEstimateSize,
  serialize: _branchModelIsarSerialize,
  deserialize: _branchModelIsarDeserialize,
  deserializeProp: _branchModelIsarDeserializeProp,
  idName: r'id',
  indexes: {
    r'branchId': IndexSchema(
      id: 2037049677925728410,
      name: r'branchId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'branchId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _branchModelIsarGetId,
  getLinks: _branchModelIsarGetLinks,
  attach: _branchModelIsarAttach,
  version: '3.1.0+1',
);

int _branchModelIsarEstimateSize(
  BranchModelIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.address.length * 3;
  bytesCount += 3 + object.branchBinNumber.length * 3;
  bytesCount += 3 + object.branchId.length * 3;
  bytesCount += 3 + object.branchPhoneNumber.length * 3;
  bytesCount += 3 + object.image.length * 3;
  bytesCount += 3 + object.managerId.length * 3;
  bytesCount += 3 + object.managerName.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _branchModelIsarSerialize(
  BranchModelIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.address);
  writer.writeString(offsets[1], object.branchBinNumber);
  writer.writeString(offsets[2], object.branchId);
  writer.writeString(offsets[3], object.branchPhoneNumber);
  writer.writeString(offsets[4], object.image);
  writer.writeString(offsets[5], object.managerId);
  writer.writeString(offsets[6], object.managerName);
  writer.writeString(offsets[7], object.name);
  writer.writeBool(offsets[8], object.status);
  writer.writeLong(offsets[9], object.table);
}

BranchModelIsar _branchModelIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BranchModelIsar(
    address: reader.readString(offsets[0]),
    branchBinNumber: reader.readString(offsets[1]),
    branchId: reader.readString(offsets[2]),
    branchPhoneNumber: reader.readString(offsets[3]),
    image: reader.readString(offsets[4]),
    managerId: reader.readString(offsets[5]),
    managerName: reader.readString(offsets[6]),
    name: reader.readString(offsets[7]),
    status: reader.readBool(offsets[8]),
    table: reader.readLong(offsets[9]),
  );
  object.id = id;
  return object;
}

P _branchModelIsarDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _branchModelIsarGetId(BranchModelIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _branchModelIsarGetLinks(BranchModelIsar object) {
  return [];
}

void _branchModelIsarAttach(
    IsarCollection<dynamic> col, Id id, BranchModelIsar object) {
  object.id = id;
}

extension BranchModelIsarByIndex on IsarCollection<BranchModelIsar> {
  Future<BranchModelIsar?> getByBranchId(String branchId) {
    return getByIndex(r'branchId', [branchId]);
  }

  BranchModelIsar? getByBranchIdSync(String branchId) {
    return getByIndexSync(r'branchId', [branchId]);
  }

  Future<bool> deleteByBranchId(String branchId) {
    return deleteByIndex(r'branchId', [branchId]);
  }

  bool deleteByBranchIdSync(String branchId) {
    return deleteByIndexSync(r'branchId', [branchId]);
  }

  Future<List<BranchModelIsar?>> getAllByBranchId(List<String> branchIdValues) {
    final values = branchIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'branchId', values);
  }

  List<BranchModelIsar?> getAllByBranchIdSync(List<String> branchIdValues) {
    final values = branchIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'branchId', values);
  }

  Future<int> deleteAllByBranchId(List<String> branchIdValues) {
    final values = branchIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'branchId', values);
  }

  int deleteAllByBranchIdSync(List<String> branchIdValues) {
    final values = branchIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'branchId', values);
  }

  Future<Id> putByBranchId(BranchModelIsar object) {
    return putByIndex(r'branchId', object);
  }

  Id putByBranchIdSync(BranchModelIsar object, {bool saveLinks = true}) {
    return putByIndexSync(r'branchId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByBranchId(List<BranchModelIsar> objects) {
    return putAllByIndex(r'branchId', objects);
  }

  List<Id> putAllByBranchIdSync(List<BranchModelIsar> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'branchId', objects, saveLinks: saveLinks);
  }
}

extension BranchModelIsarQueryWhereSort
    on QueryBuilder<BranchModelIsar, BranchModelIsar, QWhere> {
  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BranchModelIsarQueryWhere
    on QueryBuilder<BranchModelIsar, BranchModelIsar, QWhereClause> {
  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterWhereClause>
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

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterWhereClause> idBetween(
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

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterWhereClause>
      branchIdEqualTo(String branchId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'branchId',
        value: [branchId],
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterWhereClause>
      branchIdNotEqualTo(String branchId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'branchId',
              lower: [],
              upper: [branchId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'branchId',
              lower: [branchId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'branchId',
              lower: [branchId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'branchId',
              lower: [],
              upper: [branchId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension BranchModelIsarQueryFilter
    on QueryBuilder<BranchModelIsar, BranchModelIsar, QFilterCondition> {
  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      addressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      addressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      addressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      addressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'address',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      addressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      addressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchBinNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branchBinNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchBinNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'branchBinNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchBinNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'branchBinNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchBinNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'branchBinNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchBinNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'branchBinNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchBinNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'branchBinNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchBinNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'branchBinNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchBinNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'branchBinNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchBinNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branchBinNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchBinNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'branchBinNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'branchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'branchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'branchId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'branchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'branchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'branchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'branchId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branchId',
        value: '',
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'branchId',
        value: '',
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchPhoneNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branchPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchPhoneNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'branchPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchPhoneNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'branchPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchPhoneNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'branchPhoneNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchPhoneNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'branchPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchPhoneNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'branchPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchPhoneNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'branchPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchPhoneNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'branchPhoneNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchPhoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branchPhoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      branchPhoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'branchPhoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
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

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
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

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
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

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      imageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      imageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      imageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      imageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      imageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      imageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      imageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      imageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'managerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'managerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'managerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'managerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'managerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'managerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'managerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'managerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'managerId',
        value: '',
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'managerId',
        value: '',
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'managerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'managerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'managerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'managerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'managerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'managerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'managerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'managerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'managerName',
        value: '',
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      managerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'managerName',
        value: '',
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
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

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
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

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
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

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
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

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
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

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
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

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      statusEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      tableEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'table',
        value: value,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      tableGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'table',
        value: value,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      tableLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'table',
        value: value,
      ));
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterFilterCondition>
      tableBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'table',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BranchModelIsarQueryObject
    on QueryBuilder<BranchModelIsar, BranchModelIsar, QFilterCondition> {}

extension BranchModelIsarQueryLinks
    on QueryBuilder<BranchModelIsar, BranchModelIsar, QFilterCondition> {}

extension BranchModelIsarQuerySortBy
    on QueryBuilder<BranchModelIsar, BranchModelIsar, QSortBy> {
  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy> sortByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      sortByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      sortByBranchBinNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchBinNumber', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      sortByBranchBinNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchBinNumber', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      sortByBranchId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchId', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      sortByBranchIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchId', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      sortByBranchPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchPhoneNumber', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      sortByBranchPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchPhoneNumber', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy> sortByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      sortByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      sortByManagerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerId', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      sortByManagerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerId', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      sortByManagerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerName', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      sortByManagerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerName', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy> sortByTable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'table', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      sortByTableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'table', Sort.desc);
    });
  }
}

extension BranchModelIsarQuerySortThenBy
    on QueryBuilder<BranchModelIsar, BranchModelIsar, QSortThenBy> {
  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy> thenByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      thenByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      thenByBranchBinNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchBinNumber', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      thenByBranchBinNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchBinNumber', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      thenByBranchId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchId', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      thenByBranchIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchId', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      thenByBranchPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchPhoneNumber', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      thenByBranchPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchPhoneNumber', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy> thenByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      thenByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      thenByManagerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerId', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      thenByManagerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerId', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      thenByManagerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerName', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      thenByManagerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerName', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy> thenByTable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'table', Sort.asc);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QAfterSortBy>
      thenByTableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'table', Sort.desc);
    });
  }
}

extension BranchModelIsarQueryWhereDistinct
    on QueryBuilder<BranchModelIsar, BranchModelIsar, QDistinct> {
  QueryBuilder<BranchModelIsar, BranchModelIsar, QDistinct> distinctByAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'address', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QDistinct>
      distinctByBranchBinNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'branchBinNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QDistinct> distinctByBranchId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'branchId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QDistinct>
      distinctByBranchPhoneNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'branchPhoneNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QDistinct> distinctByImage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QDistinct> distinctByManagerId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'managerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QDistinct>
      distinctByManagerName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'managerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<BranchModelIsar, BranchModelIsar, QDistinct> distinctByTable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'table');
    });
  }
}

extension BranchModelIsarQueryProperty
    on QueryBuilder<BranchModelIsar, BranchModelIsar, QQueryProperty> {
  QueryBuilder<BranchModelIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BranchModelIsar, String, QQueryOperations> addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'address');
    });
  }

  QueryBuilder<BranchModelIsar, String, QQueryOperations>
      branchBinNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'branchBinNumber');
    });
  }

  QueryBuilder<BranchModelIsar, String, QQueryOperations> branchIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'branchId');
    });
  }

  QueryBuilder<BranchModelIsar, String, QQueryOperations>
      branchPhoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'branchPhoneNumber');
    });
  }

  QueryBuilder<BranchModelIsar, String, QQueryOperations> imageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image');
    });
  }

  QueryBuilder<BranchModelIsar, String, QQueryOperations> managerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'managerId');
    });
  }

  QueryBuilder<BranchModelIsar, String, QQueryOperations>
      managerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'managerName');
    });
  }

  QueryBuilder<BranchModelIsar, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<BranchModelIsar, bool, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<BranchModelIsar, int, QQueryOperations> tableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'table');
    });
  }
}
