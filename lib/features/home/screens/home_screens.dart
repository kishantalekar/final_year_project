import 'package:final_year_project/common/widgets/login_signup/t_form_divider.dart';
import 'package:final_year_project/data/repo/auth/auth_repository.dart';
import 'package:final_year_project/features/home/controller/booking_controller.dart';
import 'package:final_year_project/features/home/controller/user_controller.dart';
import 'package:final_year_project/features/home/screens/booking/booking.dart';
import 'package:final_year_project/features/home/screens/profile/customer_profile_screen.dart';
import 'package:final_year_project/features/home/screens/request/pickup_request.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/custom_enums.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final bookingController = Get.put(BookingController());
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        backgroundColor: TColors.primary,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Iconsax.menu_14),
            color: TColors.white,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: TColors.white),
            ),
            Gap(10),
            Obx(
              () => Text(
                controller.user.value.username,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: TColors.white),
              ),
            ),
          ],
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       modelsheet(context);
        //     },
        //     icon: const Icon(Iconsax.arrow_down_14),
        //     color: TColors.white,
        //   ),
        //   const SizedBox(
        //     width: 20,
        //   )
        // ],
      ),
      drawer: Drawer(
        backgroundColor: TColors.primary,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage(TImages.user),
                  ),
                  const Gap(TSizes.spaceBtwItems),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: TColors.white),
                      ),
                      Obx(
                        () => Text(
                          controller.user.value.username,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: TColors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Pickup Requests',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: TColors.white),
              ),
              // selected: _selectedIndex == 2,
              onTap: () {
                Get.to(() => const PickupRequestScreen());
              },
            ),
            ListTile(
              title: Text(
                'Profile',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: TColors.white),
              ),
              // selected: _selectedIndex == 2,
              onTap: () => Get.to(ProfileScreen()),
            ),
            ListTile(
              title: Text(
                'Log out',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: TColors.white),
              ),
              // selected: _selectedIndex == 2,
              onTap: () {
                AuthenticationRepository.instance.logout();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // Text(
              //   'Good evening, kishan',
              //   style: Theme.of(context).textTheme.bodyMedium,
              // ),
              const Gap(10),
              Text(
                "What would you like to sell?",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Wrap(
                  spacing: TSizes.spaceBtwItems / 2,
                  runSpacing: TSizes.spaceBtwItems,
                  children: [
                    WasteSelectionItem(
                      text: "Newspaper",
                      asset: TImages.recycleImage1,
                      isSelected: bookingController.selectedCategories
                          .contains(Categories.Paper),
                      onPressed: () =>
                          bookingController.toggleCategories(Categories.Paper),
                    ),
                    WasteSelectionItem(
                      text: "E-waste",
                      asset: TImages.recycleImage2,
                      isSelected: bookingController.selectedCategories
                          .contains(Categories.E_WASTE),
                      onPressed: () => bookingController
                          .toggleCategories(Categories.E_WASTE),
                    ),
                    WasteSelectionItem(
                      text: "Metals",
                      asset: TImages.recycleImage3,
                      isSelected: bookingController.selectedCategories
                          .contains(Categories.METALS),
                      onPressed: () =>
                          bookingController.toggleCategories(Categories.METALS),
                    ),
                    WasteSelectionItem(
                      text: "Plasitc",
                      asset: TImages.recycleImage4,
                      isSelected: bookingController.selectedCategories
                          .contains(Categories.PLASTIC),
                      onPressed: () => bookingController
                          .toggleCategories(Categories.PLASTIC),
                    ),
                    WasteSelectionItem(
                      text: "Other items",
                      asset: TImages.recycleImage4,
                      isSelected: bookingController.selectedCategories
                          .contains(Categories.Other),
                      onPressed: () =>
                          bookingController.toggleCategories(Categories.Other),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: bookingController.selectedCategories.value.length > 0
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                  ),
                  onPressed: () {
                    Get.to(() => const BookingScreen());
                  },
                  child: Text("Raise pickup request"))
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary.withOpacity(0.4),
                      side: BorderSide(color: Colors.transparent)),
                  onPressed: () {},
                  child: Text("Raise pickup request")),
        ),
      ),
    );
  }

  Future<dynamic> modelsheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select pickup address",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: TColors.primary, width: 2)),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Home',
                            ),
                            Text('sadashivgad,karwar-581328')
                          ],
                        ),
                      );
                    }),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                const TFormDivider(
                  dark: false,
                  dividerText: "or",
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                const Align(
                  child: Text(
                    'Add new address',
                    style: TextStyle(color: TColors.primary),
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
              ],
            ),
          );
        });
  }
}

class WasteSelectionItem extends StatelessWidget {
  const WasteSelectionItem({
    super.key,
    required this.text,
    required this.asset,
    this.isSelected = false,
    required this.onPressed,
  });

  final String text;
  final String asset;
  final bool isSelected;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: TSizes.defaultSpace / 2, vertical: 10),
          decoration: BoxDecoration(
            border:
                Border.all(color: isSelected ? TColors.primary : TColors.dark),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            onTap: onPressed,
            child: Column(
              children: [
                Image(
                  // fit: BoxFit.fitWidth,
                  image: AssetImage(asset),
                  width: 80,
                  height: 80,
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.labelLarge,
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 10,
          child: Icon(
            Icons.check_circle_outline,
            color: isSelected ? TColors.primary : TColors.grey,
          ),
        )
      ],
    );
  }
}
