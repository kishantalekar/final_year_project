import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/features/authentication/models/user_model.dart';
import 'package:final_year_project/features/partner/model/partner_model.dart';
import 'package:final_year_project/utils/exceptions/firebase_exceptions.dart';
import 'package:final_year_project/utils/exceptions/format_exceptions.dart';
import 'package:final_year_project/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../auth/auth_repository.dart';

class PartnerRepository extends GetxController {
  static PartnerRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //save user data to firestore
  saveUserData(PartnerModel user) async {
    try {
      await _db.collection('Partner').doc(user.id).set(user.toMap());
      await FirebaseAuth.instance.currentUser?.updateDisplayName('Partner');
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

  Future<PartnerModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Partner')
          .doc(AuthenticationRepository.instance.currentUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        return PartnerModel.fromMap(documentSnapshot.data()!);
      } else {
        return PartnerModel.empty();
      }
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

  Future<List<PartnerModel>> fetchAllPartners() async {
    try {
      final querySnapshot = await _db.collection('Partner').get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((doc) => PartnerModel.fromMap(doc.data()))
            .toList();
      } else {
        return [];
      }
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

  //update user detail

  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection('Customer')
          .doc(updatedUser.id)
          .update(updatedUser.toMap());
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

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Partner')
          .doc(AuthenticationRepository.instance.currentUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      print("Partner repository error : $e");
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      print("Partner repository error : $e");
      throw TPlatformException(e.code).message;
    } catch (e) {
      print("Partner repository error : $e");
      throw "Something went wrong";
    }
  }

  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
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
