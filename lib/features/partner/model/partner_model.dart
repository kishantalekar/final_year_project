// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:final_year_project/features/home/models/scrap_item.dart';

class PartnerModel {
  final String id;
  String username;
  final String email;
  final String phoneNumber;
  final String profilePicture;
  final String address;
  final bool isPartner;
  final List<ScrapItem> scrapItems;
  PartnerModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    this.address = "",
    this.isPartner = true,
    required this.scrapItems,
  });

  PartnerModel copyWith({
    String? id,
    String? username,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    String? address,
    bool? isPartner,
    List<ScrapItem>? scrapItems,
  }) {
    return PartnerModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      address: address ?? this.address,
      isPartner: isPartner ?? this.isPartner,
      scrapItems: scrapItems ?? this.scrapItems,
    );
  }

  static PartnerModel empty() => PartnerModel(
      id: '',
      username: '',
      email: '',
      phoneNumber: '',
      profilePicture: '',
      address: '',
      isPartner: false,
      scrapItems: []);
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'address': address,
      'isPartner': isPartner,
      'scrapItems': scrapItems.map((x) => x.toMap()).toList(),
    };
  }

  factory PartnerModel.fromMap(Map<String, dynamic> map) {
    return PartnerModel(
      id: map['id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      profilePicture: map['profilePicture'] as String,
      address: map['address'] as String,
      isPartner: map['isPartner'] as bool,
      scrapItems: List<ScrapItem>.from(
        (map['scrapItems'] as List<dynamic>).map<ScrapItem>(
          (x) => ScrapItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PartnerModel.fromJson(String source) =>
      PartnerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PartnerModel(id: $id, username: $username, email: $email, phoneNumber: $phoneNumber, profilePicture: $profilePicture, address: $address, isPartner: $isPartner, scrapItems: $scrapItems)';
  }

  @override
  bool operator ==(covariant PartnerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.profilePicture == profilePicture &&
        other.address == address &&
        other.isPartner == isPartner &&
        listEquals(other.scrapItems, scrapItems);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        profilePicture.hashCode ^
        address.hashCode ^
        isPartner.hashCode ^
        scrapItems.hashCode;
  }
}
