// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:final_year_project/data/repositories/auth/authentication_repository.dart';
// import 'package:final_year_project/data/repositories/user/user_repository.dart';
import 'package:final_year_project/data/repo/auth/auth_repository.dart';
import 'package:final_year_project/data/repo/user/user_repository.dart';
import 'package:final_year_project/features/authentication/models/user_model.dart';
import 'package:final_year_project/features/authentication/screens/login/login.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:final_year_project/utils/helpers/network_manager.dart';
import 'package:final_year_project/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;

  final email = TextEditingController();
  final lastname = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstname = TextEditingController();
  final phoneNumber = TextEditingController();
  final address = TextEditingController();

  GlobalKey<FormState> signFormKey =
      GlobalKey<FormState>(debugLabel: "singformkey");

  Future<void> signUp() async {
    try {
      TFullScreenLoader.openLoadingPage(
          'We are processing your information', TImages.dockerAnimation);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TFullScreenLoader.warningSnackBar(
            title: 'Internet connection not available');
        return;
      }

      if (!signFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //register user
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // save authencticated user to firestore

      final newUser = UserModel(
          id: userCredential.user!.uid,
          username: username.text,
          email: email.text,
          phoneNumber: phoneNumber.text,
          profilePicture: '',
          address: address.text);
      final UserRepository userRepository = Get.put(UserRepository());
      await userRepository.saveUserData(newUser);
      TFullScreenLoader.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! verify email to continue');

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnackBar(title: 'oh Snap!', message: e.toString());
    }
  }
}
