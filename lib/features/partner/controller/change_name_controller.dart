import 'package:final_year_project/data/repo/partner/partner_repository.dart';
import 'package:final_year_project/features/partner/controller/partner_controller.dart';
import 'package:final_year_project/features/partner/screens/profile/partner_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/loaders.dart';

class ChangeNameController extends GetxController {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final userController = PartnerController.instance;
  final userReposity = Get.put(PartnerRepository());
  final GlobalKey<FormState> changeNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializeName();
  }

  Future<void> updateUsername() async {
    try {
      TFullScreenLoader.openLoadingPage(
          'We are updating info...', TImages.dockerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();
      print('internet connection is $isConnected');
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!changeNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      Map<String, dynamic> name = {
        'FirstName': firstname.text.trim(),
        'LastName': lastname.text.trim()
      };
      await userReposity.updateSingleField(name);
      userController.partner.value.username = firstname.text.trim();
      userController.partner.value.username = lastname.text.trim();
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.successSnackBar(
          title: 'Congratulations', message: "details updated successfully");
      Get.off(() => PartnerProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
    }
  }

  void initializeName() {
    firstname.text = userController.partner.value.username;
    lastname.text = userController.partner.value.username;
  }
}
