// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOrderModelIsarCollection on Isar {
  IsarCollection<OrderModelIsar> get orderModelIsars => this.collection();
}

const OrderModelIsarSchema = CollectionSchema(
  name: r'OrderModelIsar',
  id: -295339540588025128,
  properties: {
    r'branchAddress': PropertySchema(
      id: 0,
      name: r'branchAddress',
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
    r'branchName': PropertySchema(
      id: 3,
      name: r'branchName',
      type: IsarType.string,
    ),
    r'branchPhoneNumber': PropertySchema(
      id: 4,
      name: r'branchPhoneNumber',
      type: IsarType.string,
    ),
    r'cartItems': PropertySchema(
      id: 5,
      name: r'cartItems',
      type: IsarType.objectList,
      target: r'CartModelIsar',
    ),
    r'changeAmount': PropertySchema(
      id: 6,
      name: r'changeAmount',
      type: IsarType.long,
    ),
    r'customerName': PropertySchema(
      id: 7,
      name: r'customerName',
      type: IsarType.string,
    ),
    r'customerPhoneNumber': PropertySchema(
      id: 8,
      name: r'customerPhoneNumber',
      type: IsarType.string,
    ),
    r'deliveryAddress': PropertySchema(
      id: 9,
      name: r'deliveryAddress',
      type: IsarType.string,
    ),
    r'deliveryBoyName': PropertySchema(
      id: 10,
      name: r'deliveryBoyName',
      type: IsarType.string,
    ),
    r'deliveryDateAndTime': PropertySchema(
      id: 11,
      name: r'deliveryDateAndTime',
      type: IsarType.string,
    ),
    r'deliveryFee': PropertySchema(
      id: 12,
      name: r'deliveryFee',
      type: IsarType.long,
    ),
    r'discountAmount': PropertySchema(
      id: 13,
      name: r'discountAmount',
      type: IsarType.long,
    ),
    r'invoiceNumber': PropertySchema(
      id: 14,
      name: r'invoiceNumber',
      type: IsarType.string,
    ),
    r'managerId': PropertySchema(
      id: 15,
      name: r'managerId',
      type: IsarType.string,
    ),
    r'managerName': PropertySchema(
      id: 16,
      name: r'managerName',
      type: IsarType.string,
    ),
    r'netPayableAmount': PropertySchema(
      id: 17,
      name: r'netPayableAmount',
      type: IsarType.long,
    ),
    r'note': PropertySchema(
      id: 18,
      name: r'note',
      type: IsarType.string,
    ),
    r'orderDate': PropertySchema(
      id: 19,
      name: r'orderDate',
      type: IsarType.dateTime,
    ),
    r'orderStatus': PropertySchema(
      id: 20,
      name: r'orderStatus',
      type: IsarType.string,
    ),
    r'orderType': PropertySchema(
      id: 21,
      name: r'orderType',
      type: IsarType.string,
    ),
    r'paidAmount': PropertySchema(
      id: 22,
      name: r'paidAmount',
      type: IsarType.long,
    ),
    r'paymentMode': PropertySchema(
      id: 23,
      name: r'paymentMode',
      type: IsarType.string,
    ),
    r'paymentStatus': PropertySchema(
      id: 24,
      name: r'paymentStatus',
      type: IsarType.string,
    ),
    r'serialNumber': PropertySchema(
      id: 25,
      name: r'serialNumber',
      type: IsarType.string,
    ),
    r'subtotalAmount': PropertySchema(
      id: 26,
      name: r'subtotalAmount',
      type: IsarType.long,
    ),
    r'tableNumber': PropertySchema(
      id: 27,
      name: r'tableNumber',
      type: IsarType.string,
    )
  },
  estimateSize: _orderModelIsarEstimateSize,
  serialize: _orderModelIsarSerialize,
  deserialize: _orderModelIsarDeserialize,
  deserializeProp: _orderModelIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'CartModelIsar': CartModelIsarSchema},
  getId: _orderModelIsarGetId,
  getLinks: _orderModelIsarGetLinks,
  attach: _orderModelIsarAttach,
  version: '3.1.0+1',
);

int _orderModelIsarEstimateSize(
  OrderModelIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.branchAddress.length * 3;
  bytesCount += 3 + object.branchBinNumber.length * 3;
  bytesCount += 3 + object.branchId.length * 3;
  bytesCount += 3 + object.branchName.length * 3;
  bytesCount += 3 + object.branchPhoneNumber.length * 3;
  bytesCount += 3 + object.cartItems.length * 3;
  {
    final offsets = allOffsets[CartModelIsar]!;
    for (var i = 0; i < object.cartItems.length; i++) {
      final value = object.cartItems[i];
      bytesCount +=
          CartModelIsarSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.customerName.length * 3;
  bytesCount += 3 + object.customerPhoneNumber.length * 3;
  bytesCount += 3 + object.deliveryAddress.length * 3;
  bytesCount += 3 + object.deliveryBoyName.length * 3;
  bytesCount += 3 + object.deliveryDateAndTime.length * 3;
  bytesCount += 3 + object.invoiceNumber.length * 3;
  bytesCount += 3 + object.managerId.length * 3;
  bytesCount += 3 + object.managerName.length * 3;
  bytesCount += 3 + object.note.length * 3;
  bytesCount += 3 + object.orderStatus.length * 3;
  bytesCount += 3 + object.orderType.length * 3;
  bytesCount += 3 + object.paymentMode.length * 3;
  bytesCount += 3 + object.paymentStatus.length * 3;
  bytesCount += 3 + object.serialNumber.length * 3;
  bytesCount += 3 + object.tableNumber.length * 3;
  return bytesCount;
}

void _orderModelIsarSerialize(
  OrderModelIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.branchAddress);
  writer.writeString(offsets[1], object.branchBinNumber);
  writer.writeString(offsets[2], object.branchId);
  writer.writeString(offsets[3], object.branchName);
  writer.writeString(offsets[4], object.branchPhoneNumber);
  writer.writeObjectList<CartModelIsar>(
    offsets[5],
    allOffsets,
    CartModelIsarSchema.serialize,
    object.cartItems,
  );
  writer.writeLong(offsets[6], object.changeAmount);
  writer.writeString(offsets[7], object.customerName);
  writer.writeString(offsets[8], object.customerPhoneNumber);
  writer.writeString(offsets[9], object.deliveryAddress);
  writer.writeString(offsets[10], object.deliveryBoyName);
  writer.writeString(offsets[11], object.deliveryDateAndTime);
  writer.writeLong(offsets[12], object.deliveryFee);
  writer.writeLong(offsets[13], object.discountAmount);
  writer.writeString(offsets[14], object.invoiceNumber);
  writer.writeString(offsets[15], object.managerId);
  writer.writeString(offsets[16], object.managerName);
  writer.writeLong(offsets[17], object.netPayableAmount);
  writer.writeString(offsets[18], object.note);
  writer.writeDateTime(offsets[19], object.orderDate);
  writer.writeString(offsets[20], object.orderStatus);
  writer.writeString(offsets[21], object.orderType);
  writer.writeLong(offsets[22], object.paidAmount);
  writer.writeString(offsets[23], object.paymentMode);
  writer.writeString(offsets[24], object.paymentStatus);
  writer.writeString(offsets[25], object.serialNumber);
  writer.writeLong(offsets[26], object.subtotalAmount);
  writer.writeString(offsets[27], object.tableNumber);
}

OrderModelIsar _orderModelIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OrderModelIsar(
    branchAddress: reader.readString(offsets[0]),
    branchBinNumber: reader.readString(offsets[1]),
    branchId: reader.readString(offsets[2]),
    branchName: reader.readString(offsets[3]),
    branchPhoneNumber: reader.readString(offsets[4]),
    cartItems: reader.readObjectList<CartModelIsar>(
          offsets[5],
          CartModelIsarSchema.deserialize,
          allOffsets,
          CartModelIsar(),
        ) ??
        [],
    changeAmount: reader.readLong(offsets[6]),
    customerName: reader.readString(offsets[7]),
    customerPhoneNumber: reader.readString(offsets[8]),
    deliveryAddress: reader.readString(offsets[9]),
    deliveryBoyName: reader.readString(offsets[10]),
    deliveryDateAndTime: reader.readString(offsets[11]),
    deliveryFee: reader.readLong(offsets[12]),
    discountAmount: reader.readLong(offsets[13]),
    id: id,
    invoiceNumber: reader.readString(offsets[14]),
    managerId: reader.readString(offsets[15]),
    managerName: reader.readString(offsets[16]),
    netPayableAmount: reader.readLong(offsets[17]),
    note: reader.readString(offsets[18]),
    orderDate: reader.readDateTime(offsets[19]),
    orderStatus: reader.readString(offsets[20]),
    orderType: reader.readString(offsets[21]),
    paidAmount: reader.readLong(offsets[22]),
    paymentMode: reader.readString(offsets[23]),
    paymentStatus: reader.readString(offsets[24]),
    serialNumber: reader.readString(offsets[25]),
    subtotalAmount: reader.readLong(offsets[26]),
    tableNumber: reader.readString(offsets[27]),
  );
  return object;
}

P _orderModelIsarDeserializeProp<P>(
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
      return (reader.readObjectList<CartModelIsar>(
            offset,
            CartModelIsarSchema.deserialize,
            allOffsets,
            CartModelIsar(),
          ) ??
          []) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readLong(offset)) as P;
    case 18:
      return (reader.readString(offset)) as P;
    case 19:
      return (reader.readDateTime(offset)) as P;
    case 20:
      return (reader.readString(offset)) as P;
    case 21:
      return (reader.readString(offset)) as P;
    case 22:
      return (reader.readLong(offset)) as P;
    case 23:
      return (reader.readString(offset)) as P;
    case 24:
      return (reader.readString(offset)) as P;
    case 25:
      return (reader.readString(offset)) as P;
    case 26:
      return (reader.readLong(offset)) as P;
    case 27:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _orderModelIsarGetId(OrderModelIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _orderModelIsarGetLinks(OrderModelIsar object) {
  return [];
}

void _orderModelIsarAttach(
    IsarCollection<dynamic> col, Id id, OrderModelIsar object) {
  object.id = id;
}

extension OrderModelIsarQueryWhereSort
    on QueryBuilder<OrderModelIsar, OrderModelIsar, QWhere> {
  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension OrderModelIsarQueryWhere
    on QueryBuilder<OrderModelIsar, OrderModelIsar, QWhereClause> {
  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterWhereClause> idBetween(
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

extension OrderModelIsarQueryFilter
    on QueryBuilder<OrderModelIsar, OrderModelIsar, QFilterCondition> {
  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchAddressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branchAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchAddressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'branchAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchAddressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'branchAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchAddressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'branchAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'branchAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'branchAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'branchAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchAddressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'branchAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branchAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'branchAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchBinNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'branchBinNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchBinNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'branchBinNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchBinNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branchBinNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchBinNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'branchBinNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'branchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'branchId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branchId',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'branchId',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branchName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'branchName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'branchName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'branchName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'branchName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'branchName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'branchName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'branchName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branchName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'branchName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchPhoneNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'branchPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchPhoneNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'branchPhoneNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchPhoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branchPhoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      branchPhoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'branchPhoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      cartItemsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cartItems',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      cartItemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cartItems',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      cartItemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cartItems',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      cartItemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cartItems',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      cartItemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cartItems',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      cartItemsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cartItems',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      changeAmountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'changeAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      changeAmountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'changeAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      changeAmountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'changeAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      changeAmountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'changeAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customerName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerPhoneNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerPhoneNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customerPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerPhoneNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customerPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerPhoneNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customerPhoneNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerPhoneNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customerPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerPhoneNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customerPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerPhoneNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customerPhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerPhoneNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customerPhoneNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerPhoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerPhoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      customerPhoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customerPhoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryAddressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryAddressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deliveryAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryAddressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deliveryAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryAddressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deliveryAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deliveryAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deliveryAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deliveryAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryAddressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deliveryAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deliveryAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryBoyNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryBoyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryBoyNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deliveryBoyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryBoyNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deliveryBoyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryBoyNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deliveryBoyName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryBoyNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deliveryBoyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryBoyNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deliveryBoyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryBoyNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deliveryBoyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryBoyNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deliveryBoyName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryBoyNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryBoyName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryBoyNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deliveryBoyName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryDateAndTimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryDateAndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryDateAndTimeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deliveryDateAndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryDateAndTimeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deliveryDateAndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryDateAndTimeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deliveryDateAndTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryDateAndTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deliveryDateAndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryDateAndTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deliveryDateAndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryDateAndTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deliveryDateAndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryDateAndTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deliveryDateAndTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryDateAndTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryDateAndTime',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryDateAndTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deliveryDateAndTime',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryFeeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryFee',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryFeeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deliveryFee',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryFeeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deliveryFee',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      deliveryFeeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deliveryFee',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      discountAmountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'discountAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      discountAmountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'discountAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      discountAmountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'discountAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      discountAmountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'discountAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition> idBetween(
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      invoiceNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invoiceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      invoiceNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'invoiceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      invoiceNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'invoiceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      invoiceNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'invoiceNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      invoiceNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'invoiceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      invoiceNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'invoiceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      invoiceNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'invoiceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      invoiceNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'invoiceNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      invoiceNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invoiceNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      invoiceNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'invoiceNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      managerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'managerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      managerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'managerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      managerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'managerId',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      managerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'managerId',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
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

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      managerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'managerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      managerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'managerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      managerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'managerName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      managerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'managerName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      netPayableAmountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'netPayableAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      netPayableAmountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'netPayableAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      netPayableAmountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'netPayableAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      netPayableAmountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'netPayableAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      noteEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      noteGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      noteLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      noteBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      noteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      noteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderDate',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orderDate',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orderDate',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orderDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderStatusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderStatusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orderStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderStatusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orderStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderStatusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orderStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'orderStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'orderStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'orderStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'orderStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'orderStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orderType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'orderType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderType',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      orderTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'orderType',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paidAmountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paidAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paidAmountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paidAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paidAmountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paidAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paidAmountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paidAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentModeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentModeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentModeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentModeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paymentMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paymentMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentModeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paymentMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentModeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paymentMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentMode',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paymentMode',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentStatusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentStatusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentStatusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentStatusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paymentStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paymentStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paymentStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paymentStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      paymentStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paymentStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      serialNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serialNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      serialNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serialNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      serialNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serialNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      serialNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serialNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      serialNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'serialNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      serialNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'serialNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      serialNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'serialNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      serialNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'serialNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      serialNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serialNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      serialNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'serialNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      subtotalAmountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subtotalAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      subtotalAmountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subtotalAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      subtotalAmountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subtotalAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      subtotalAmountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subtotalAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      tableNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tableNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      tableNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tableNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      tableNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tableNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      tableNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tableNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      tableNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tableNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      tableNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tableNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      tableNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tableNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      tableNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tableNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      tableNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tableNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      tableNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tableNumber',
        value: '',
      ));
    });
  }
}

extension OrderModelIsarQueryObject
    on QueryBuilder<OrderModelIsar, OrderModelIsar, QFilterCondition> {
  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterFilterCondition>
      cartItemsElement(FilterQuery<CartModelIsar> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'cartItems');
    });
  }
}

extension OrderModelIsarQueryLinks
    on QueryBuilder<OrderModelIsar, OrderModelIsar, QFilterCondition> {}

extension OrderModelIsarQuerySortBy
    on QueryBuilder<OrderModelIsar, OrderModelIsar, QSortBy> {
  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByBranchAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchAddress', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByBranchAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchAddress', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByBranchBinNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchBinNumber', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByBranchBinNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchBinNumber', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy> sortByBranchId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchId', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByBranchIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchId', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByBranchName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchName', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByBranchNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchName', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByBranchPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchPhoneNumber', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByBranchPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchPhoneNumber', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByChangeAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'changeAmount', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByChangeAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'changeAmount', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByCustomerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByCustomerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByCustomerPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerPhoneNumber', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByCustomerPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerPhoneNumber', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByDeliveryAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryAddress', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByDeliveryAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryAddress', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByDeliveryBoyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryBoyName', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByDeliveryBoyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryBoyName', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByDeliveryDateAndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryDateAndTime', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByDeliveryDateAndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryDateAndTime', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByDeliveryFee() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryFee', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByDeliveryFeeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryFee', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByDiscountAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discountAmount', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByDiscountAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discountAmount', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByInvoiceNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceNumber', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByInvoiceNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceNumber', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy> sortByManagerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerId', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByManagerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerId', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByManagerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerName', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByManagerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerName', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByNetPayableAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'netPayableAmount', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByNetPayableAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'netPayableAmount', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy> sortByOrderDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderDate', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByOrderDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderDate', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByOrderStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderStatus', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByOrderStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderStatus', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy> sortByOrderType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderType', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByOrderTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderType', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByPaidAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAmount', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByPaidAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAmount', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByPaymentMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMode', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByPaymentModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMode', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByPaymentStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentStatus', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByPaymentStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentStatus', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortBySerialNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serialNumber', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortBySerialNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serialNumber', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortBySubtotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtotalAmount', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortBySubtotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtotalAmount', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByTableNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableNumber', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      sortByTableNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableNumber', Sort.desc);
    });
  }
}

extension OrderModelIsarQuerySortThenBy
    on QueryBuilder<OrderModelIsar, OrderModelIsar, QSortThenBy> {
  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByBranchAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchAddress', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByBranchAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchAddress', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByBranchBinNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchBinNumber', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByBranchBinNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchBinNumber', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy> thenByBranchId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchId', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByBranchIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchId', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByBranchName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchName', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByBranchNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchName', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByBranchPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchPhoneNumber', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByBranchPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchPhoneNumber', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByChangeAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'changeAmount', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByChangeAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'changeAmount', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByCustomerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByCustomerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByCustomerPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerPhoneNumber', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByCustomerPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerPhoneNumber', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByDeliveryAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryAddress', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByDeliveryAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryAddress', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByDeliveryBoyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryBoyName', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByDeliveryBoyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryBoyName', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByDeliveryDateAndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryDateAndTime', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByDeliveryDateAndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryDateAndTime', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByDeliveryFee() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryFee', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByDeliveryFeeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryFee', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByDiscountAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discountAmount', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByDiscountAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discountAmount', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByInvoiceNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceNumber', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByInvoiceNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceNumber', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy> thenByManagerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerId', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByManagerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerId', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByManagerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerName', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByManagerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerName', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByNetPayableAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'netPayableAmount', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByNetPayableAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'netPayableAmount', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy> thenByOrderDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderDate', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByOrderDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderDate', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByOrderStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderStatus', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByOrderStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderStatus', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy> thenByOrderType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderType', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByOrderTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderType', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByPaidAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAmount', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByPaidAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAmount', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByPaymentMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMode', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByPaymentModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMode', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByPaymentStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentStatus', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByPaymentStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentStatus', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenBySerialNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serialNumber', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenBySerialNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serialNumber', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenBySubtotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtotalAmount', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenBySubtotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtotalAmount', Sort.desc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByTableNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableNumber', Sort.asc);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QAfterSortBy>
      thenByTableNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableNumber', Sort.desc);
    });
  }
}

extension OrderModelIsarQueryWhereDistinct
    on QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct> {
  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctByBranchAddress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'branchAddress',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctByBranchBinNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'branchBinNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct> distinctByBranchId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'branchId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct> distinctByBranchName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'branchName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctByBranchPhoneNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'branchPhoneNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctByChangeAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'changeAmount');
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctByCustomerName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctByCustomerPhoneNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerPhoneNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctByDeliveryAddress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deliveryAddress',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctByDeliveryBoyName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deliveryBoyName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctByDeliveryDateAndTime({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deliveryDateAndTime',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctByDeliveryFee() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deliveryFee');
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctByDiscountAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'discountAmount');
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctByInvoiceNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'invoiceNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct> distinctByManagerId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'managerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct> distinctByManagerName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'managerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctByNetPayableAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'netPayableAmount');
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctByOrderDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderDate');
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct> distinctByOrderStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderStatus', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct> distinctByOrderType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctByPaidAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paidAmount');
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct> distinctByPaymentMode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentMode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctByPaymentStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentStatus',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctBySerialNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serialNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct>
      distinctBySubtotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subtotalAmount');
    });
  }

  QueryBuilder<OrderModelIsar, OrderModelIsar, QDistinct> distinctByTableNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tableNumber', caseSensitive: caseSensitive);
    });
  }
}

extension OrderModelIsarQueryProperty
    on QueryBuilder<OrderModelIsar, OrderModelIsar, QQueryProperty> {
  QueryBuilder<OrderModelIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations>
      branchAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'branchAddress');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations>
      branchBinNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'branchBinNumber');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations> branchIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'branchId');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations> branchNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'branchName');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations>
      branchPhoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'branchPhoneNumber');
    });
  }

  QueryBuilder<OrderModelIsar, List<CartModelIsar>, QQueryOperations>
      cartItemsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cartItems');
    });
  }

  QueryBuilder<OrderModelIsar, int, QQueryOperations> changeAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'changeAmount');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations>
      customerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerName');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations>
      customerPhoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerPhoneNumber');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations>
      deliveryAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deliveryAddress');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations>
      deliveryBoyNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deliveryBoyName');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations>
      deliveryDateAndTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deliveryDateAndTime');
    });
  }

  QueryBuilder<OrderModelIsar, int, QQueryOperations> deliveryFeeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deliveryFee');
    });
  }

  QueryBuilder<OrderModelIsar, int, QQueryOperations> discountAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'discountAmount');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations>
      invoiceNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'invoiceNumber');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations> managerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'managerId');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations> managerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'managerName');
    });
  }

  QueryBuilder<OrderModelIsar, int, QQueryOperations>
      netPayableAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'netPayableAmount');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<OrderModelIsar, DateTime, QQueryOperations> orderDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderDate');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations> orderStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderStatus');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations> orderTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderType');
    });
  }

  QueryBuilder<OrderModelIsar, int, QQueryOperations> paidAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paidAmount');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations> paymentModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentMode');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations>
      paymentStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentStatus');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations>
      serialNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serialNumber');
    });
  }

  QueryBuilder<OrderModelIsar, int, QQueryOperations> subtotalAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subtotalAmount');
    });
  }

  QueryBuilder<OrderModelIsar, String, QQueryOperations> tableNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tableNumber');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CartModelIsarSchema = Schema(
  name: r'CartModelIsar',
  id: 7674079526825947159,
  properties: {
    r'price': PropertySchema(
      id: 0,
      name: r'price',
      type: IsarType.long,
    ),
    r'productID': PropertySchema(
      id: 1,
      name: r'productID',
      type: IsarType.string,
    ),
    r'productName': PropertySchema(
      id: 2,
      name: r'productName',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 3,
      name: r'quantity',
      type: IsarType.long,
    ),
    r'unitPrice': PropertySchema(
      id: 4,
      name: r'unitPrice',
      type: IsarType.long,
    )
  },
  estimateSize: _cartModelIsarEstimateSize,
  serialize: _cartModelIsarSerialize,
  deserialize: _cartModelIsarDeserialize,
  deserializeProp: _cartModelIsarDeserializeProp,
);

int _cartModelIsarEstimateSize(
  CartModelIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.productID;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.productName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _cartModelIsarSerialize(
  CartModelIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.price);
  writer.writeString(offsets[1], object.productID);
  writer.writeString(offsets[2], object.productName);
  writer.writeLong(offsets[3], object.quantity);
  writer.writeLong(offsets[4], object.unitPrice);
}

CartModelIsar _cartModelIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CartModelIsar(
    price: reader.readLongOrNull(offsets[0]),
    productID: reader.readStringOrNull(offsets[1]),
    productName: reader.readStringOrNull(offsets[2]),
    quantity: reader.readLongOrNull(offsets[3]),
    unitPrice: reader.readLongOrNull(offsets[4]),
  );
  return object;
}

P _cartModelIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CartModelIsarQueryFilter
    on QueryBuilder<CartModelIsar, CartModelIsar, QFilterCondition> {
  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      priceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      priceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      priceEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      priceGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      priceLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      priceBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'productID',
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'productID',
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productIDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productIDGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productIDLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productIDBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'productID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'productID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productID',
        value: '',
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productID',
        value: '',
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'productName',
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'productName',
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      productNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      quantityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      quantityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      quantityEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      quantityGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      quantityLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      quantityBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      unitPriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'unitPrice',
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      unitPriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'unitPrice',
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      unitPriceEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unitPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      unitPriceGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unitPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      unitPriceLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unitPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<CartModelIsar, CartModelIsar, QAfterFilterCondition>
      unitPriceBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unitPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CartModelIsarQueryObject
    on QueryBuilder<CartModelIsar, CartModelIsar, QFilterCondition> {}
