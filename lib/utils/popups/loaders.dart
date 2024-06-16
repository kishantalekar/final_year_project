import 'package:final_year_project/common/widgets/loaders/animation_loader.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TFullScreenLoader {
  static void openLoadingPage(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!)
              ? TColors.dark
              : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                  height: 450,
                  child: TAnimationLoader(
                    text: text,
                    animation: animation,
                    showAction: false,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  static warningSnackBar({required title, message = ""}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: TColors.white,
        backgroundColor: Colors.orange,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
        icon: const Icon(
          Iconsax.warning_2,
          color: TColors.white,
        ));
  }

  static successSnackBar({required title, message = "", duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: TColors.white,
        backgroundColor: TColors.primary,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
        icon: const Icon(
          Iconsax.check,
          color: TColors.white,
        ));
  }

  static errorSnackBar({required title, message = "", duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: TColors.white,
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
        icon: const Icon(
          Iconsax.warning_2,
          color: TColors.white,
        ));
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
