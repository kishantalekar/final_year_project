import 'package:final_year_project/features/home/screens/request/pickup_request.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class successBookingScreen extends StatelessWidget {
  const successBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(
              image: AssetImage(
                TImages.onBoardingImage3,
              ),
            ),
            const Gap(TSizes.spaceBtwSections),
            Text(
              "We will coming for your scrap pickup",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          child: const Text("Pickup Details"),
          onPressed: () {
            Get.off(
              () => const PickupRequestScreen(),
            );
          },
        ),
      ),
    );
  }
}
