import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/features/home/models/picup_request_model.dart';
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
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong";
    }
  }
}
