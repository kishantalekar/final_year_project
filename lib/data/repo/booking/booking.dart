import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/core/custom_enums.dart';
import 'package:final_year_project/features/home/models/picup_request_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class BookingRepository extends GetxController {
  static BookingRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> schedulePickupRequest(PickupRequestModel pickup) async {
    try {
      await _db.collection('Pickup').doc().set(pickup.toMap());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong";
    }
  }

  Future<List<PickupRequestModel>> getScheduleScrapsById(String id) async {
    try {
      QuerySnapshot querySnapshot =
          await _db.collection('Pickup').where('userId', isEqualTo: id).get();
      List<PickupRequestModel> pickupRequests = querySnapshot.docs.map((doc) {
        return PickupRequestModel.fromMap({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });
      }).toList();

      return pickupRequests;
    } on FirebaseException catch (e) {
      print("getScheduleScrapsById $e");
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      print("getScheduleScrapsById $e");
      throw TPlatformException(e.code).message;
    } catch (e) {
      print("getScheduleScrapsById $e");
      throw "Something went wrong";
    }
  }

  Future<List<PickupRequestModel>> getPickupsForPartner(
      String partnerId) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection('Pickup')
          .where('partnerId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get();

      List<PickupRequestModel> pickupRequests = querySnapshot.docs.map((doc) {
        log(doc.data().toString());

        return PickupRequestModel.fromMap({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });
      }).toList();
      print('object');

      return pickupRequests;
    } on FirebaseException catch (e) {
      print("getPickupsForPartner error : $e");
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      print("getPickupsForPartner error : $e");

      throw TPlatformException(e.code).message;
    } catch (e) {
      print("getPickupsForPartner error : $e");
      throw "Something went wrong";
    }
  }

  Future<void> updatePickupStatus(String id, PickupStatus status) async {
    try {
      final docRef = _db.collection('Pickup').doc(id);
      await docRef.update({
        'pickupStatus': status.status, // Assuming you store status as a string
      });
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong";
    }
  }

  Future<void> updatePickupDetails(PickupRequestModel pickup) async {
    try {
      await _db.collection('Pickup').doc(pickup.id).update(pickup.toMap());
    } on FirebaseException catch (e) {
      print("updatePickupDetails error  : $e");
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      print("updatePickupDetails error  : $e");
      throw TPlatformException(e.code).message;
    } catch (e) {
      print("updatePickupDetails error  : $e");

      throw "Something went wrong";
    }
  }
}
