// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/core/custom_enums.dart';
import 'package:flutter/foundation.dart';

import 'scrap_item.dart';

class PickupRequestModel {
  final String userId;
  final String email;
  final String username;
  final String partnerId;
  final String partnername;
  final List<ScrapItem> items;
  final DateTime scheduledTime;
  final DateTime pickupTime;
  final String address;
  final String id;
  final PickupStatus pickupStatus;
  final double totalCost;
  final String number;
  PickupRequestModel(
      {required this.id,
      required this.username,
      required this.email,
      required this.userId,
      required this.partnerId,
      required this.partnername,
      required this.items,
      required this.scheduledTime,
      required this.pickupTime,
      required this.address,
      this.totalCost = 0,
      this.pickupStatus = PickupStatus.PENDING,
      required this.number});

  PickupRequestModel copyWith(
      {String? id,
      String? userId,
      String? email,
      String? partnerId,
      List<ScrapItem>? items,
      DateTime? scheduledTime,
      String? address,
      PickupStatus? pickupStatus,
      double? totalCost,
      String? username,
      DateTime? pickupTime,
      String? partnername,
      String? number}) {
    return PickupRequestModel(
        id: id ?? this.id,
        email: email ?? this.email,
        userId: userId ?? this.userId,
        username: username ?? this.username,
        partnerId: partnerId ?? this.partnerId,
        items: items ?? this.items,
        scheduledTime: scheduledTime ?? this.scheduledTime,
        address: address ?? this.address,
        pickupStatus: pickupStatus ?? this.pickupStatus,
        totalCost: totalCost ?? this.totalCost,
        partnername: partnername ?? this.partnername,
        pickupTime: pickupTime ?? this.pickupTime,
        number: number ?? this.number);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'email': email,
      'partnerId': partnerId,
      'items': items.map((x) => x.toMap()).toList(),
      'scheduledTime': scheduledTime.millisecondsSinceEpoch,
      'address': address,
      'id': id,
      'pickupStatus': pickupStatus.status,
      "totalCost": totalCost,
      "username": username,
      "partnername": partnername,
      "pickupTime": pickupTime.millisecondsSinceEpoch,
      "number": number
    };
  }

  factory PickupRequestModel.fromMap(Map<String, dynamic> map) {
    return PickupRequestModel(
      email: map['email'] as String,
      number: map['number'] as String,
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
      pickupStatus: PickupStatusName.fromString(
        map['pickupStatus'] as String,
      ),
      totalCost: map['totalCost'],
      username: map['username'] ?? "",
      partnername: map['partnername'] ?? "",
      pickupTime: DateTime.fromMillisecondsSinceEpoch(map['pickupTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory PickupRequestModel.fromJson(String source) =>
      PickupRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PickupRequestModel(userId: $userId, partnerId: $partnerId, items: $items, scheduledTime: $scheduledTime, address: $address ,id :$id) totalCost: $totalCost';
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
