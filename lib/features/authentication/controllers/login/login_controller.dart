import 'package:final_year_project/data/repo/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/loaders.dart';

class LoginController extends GetxController {
//variables
  final rememberMe = false.obs;
  final hidePassword = false.obs;
  final localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? "";
    password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? "";
  }

  GlobalKey<FormState> loginFormKey =
      GlobalKey<FormState>(debugLabel: "_loginformKey");
  Future<void> signIn() async {
    try {
      TFullScreenLoader.openLoadingPage(
          'Logging you in...', TImages.dockerAnimation);

      //check internet connectivity

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // if (!privacyPolicy.value) {
      //   TFullScreenLoader.warningSnackBar(
      //       title: 'Accept privaciy policy',
      //       message: 'In order to create account ');
      //   return;
      // }
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      //register user
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      TFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();

      // TFullScreenLoader.successSnackBar(
      //     title: 'Congratulations',
      //     message: 'Your account has been created! verify email to continue');
    } catch (e) {
      print("Login controller error : $e");
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnackBar(title: 'oh Snap!', message: e.toString());
    }
  }
}
