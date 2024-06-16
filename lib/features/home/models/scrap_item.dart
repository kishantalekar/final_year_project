// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../../../core/custom_enums.dart';

class ScrapItem {
  ScrapItem(
      {required this.title,
      required this.id,
      this.unitType = UnitType.kg,
      required this.categoryType,
      this.cost = 0,
      this.kg = 0,
      this.pcs = 0});
  final int id;
  final UnitType unitType;
  final String title;
  final Categories categoryType;
  double cost;
  double kg;
  int pcs;

  ScrapItem copyWith(
      {int? id,
      UnitType? unitType,
      String? title,
      Categories? categoryType,
      double? cost,
      double? kg,
      int? pcs}) {
    return ScrapItem(
        id: id ?? this.id,
        unitType: unitType ?? this.unitType,
        title: title ?? this.title,
        categoryType: categoryType ?? this.categoryType,
        cost: cost ?? this.cost,
        kg: kg ?? this.kg,
        pcs: pcs ?? this.pcs);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'unitType': unitType.name,
      'title': title,
      'categoryType': categoryType.displayName,
      'cost': cost,
      'kg': kg,
      'pcs': pcs
    };
  }

  factory ScrapItem.fromMap(Map<String, dynamic> map) {
    return ScrapItem(
      id: map['id'] as int,
      unitType: UnitType.values
          .firstWhere((element) => element.name == map['unitType']),
      title: map['title'] as String,
      categoryType: Categories.values
          .firstWhere((e) => e.displayName == map['categoryType']),
      cost: map['cost'] as double,
      kg: map['kg'] as double,
      pcs: map['pcs'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScrapItem.fromJson(String source) =>
      ScrapItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ScrapItem(id: $id, unitType: $unitType, title: $title, categoryType: $categoryType, cost: $cost, kg : $kg ,pcs : $pcs)';
  }

  @override
  bool operator ==(covariant ScrapItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.unitType == unitType &&
        other.title == title &&
        other.categoryType == categoryType &&
        other.cost == cost;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        unitType.hashCode ^
        title.hashCode ^
        categoryType.hashCode ^
        cost.hashCode;
  }
}
