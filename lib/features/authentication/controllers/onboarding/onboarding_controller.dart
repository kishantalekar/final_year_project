import 'package:final_year_project/features/authentication/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();

  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndicator(index) {
    currentPageIndex(index);
  }

  void dotNavigationOnClick(index) {
    currentPageIndex.value = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  void nextPage() {
    if (currentPageIndex.value == 2) {
      final deviceStorage = GetStorage();
      deviceStorage.write('IsFirstTime', false);
      Get.offAll(() => const LoginScreen());
    } else {
      currentPageIndex.value++;
      pageController.animateToPage(currentPageIndex.value,
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    }
  }

  void skipPage() {
    currentPageIndex.value = 2;
    pageController.animateToPage(2,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }
}
