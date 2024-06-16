// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:final_year_project/core/custom_enums.dart';
import 'package:flutter/foundation.dart';

import 'scrap_item.dart';

class PickupRequestModel {
  final String userId;
  final String partnerId;
  final List<ScrapItem> items;
  final DateTime scheduledTime;
  final String address;
  final String id;
  final PickupStatus pickupStatus;
  PickupRequestModel(
      {required this.id,
      required this.userId,
      required this.partnerId,
      required this.items,
      required this.scheduledTime,
      required this.address,
      this.pickupStatus = PickupStatus.PENDING});

  PickupRequestModel copyWith(
      {String? userId,
      String? partnerId,
      List<ScrapItem>? items,
      DateTime? scheduledTime,
      String? address,
      PickupStatus? pickupStatus}) {
    return PickupRequestModel(
        userId: userId ?? this.userId,
        partnerId: partnerId ?? this.partnerId,
        items: items ?? this.items,
        scheduledTime: scheduledTime ?? this.scheduledTime,
        address: address ?? this.address,
        id: "",
        pickupStatus: pickupStatus ?? this.pickupStatus);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'partnerId': partnerId,
      'items': items.map((x) => x.toMap()).toList(),
      'scheduledTime': scheduledTime.millisecondsSinceEpoch,
      'address': address,
      'id': id,
      'pickupStatus': pickupStatus.status
    };
  }

  factory PickupRequestModel.fromMap(Map<String, dynamic> map) {
    return PickupRequestModel(
        id: map['id'] as String,
        userId: map['userId'] as String,
        partnerId: map['partnerId'] as String,
        items: List<ScrapItem>.from(
          (map['items'] as List<dynamic>).map<ScrapItem>(
            (x) => ScrapItem.fromMap(x as Map<String, dynamic>),
          ),
        ),
        scheduledTime:
            DateTime.fromMillisecondsSinceEpoch(map['scheduledTime'] as int),
        address: map['address'],
        pickupStatus:
            PickupStatusName.fromString(map['pickupStatus'] as String));
  }

  String toJson() => json.encode(toMap());

  factory PickupRequestModel.fromJson(String source) =>
      PickupRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PickupRequestModel(userId: $userId, partnerId: $partnerId, items: $items, scheduledTime: $scheduledTime, address: $address ,id :$id)';
  }

  @override
  bool operator ==(covariant PickupRequestModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.partnerId == partnerId &&
        listEquals(other.items, items) &&
        other.scheduledTime == scheduledTime &&
        other.address == address;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        partnerId.hashCode ^
        items.hashCode ^
        scheduledTime.hashCode ^
        address.hashCode;
  }
}
