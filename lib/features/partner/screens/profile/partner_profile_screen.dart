import 'package:final_year_project/features/partner/controller/partner_controller.dart';
import 'package:final_year_project/features/partner/screens/profile/change_name.dart';
import 'package:final_year_project/features/partner/screens/profile/widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/image/circular_image.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class PartnerProfileScreen extends StatelessWidget {
  const PartnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PartnerController.instance;

    return Scaffold(
      appBar: const TAppBar(
        title: Text("Profile"),
        showBackAction: true,
      ),

      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///profile picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const TCircularImage(
                      image: TImages.user,
                      width: 80,
                      height: 80,
                    ),
                    // TextButton(
                    //     onPressed: () {},
                    //     child: const Text('Change profile picture'))
                  ],
                ),
              ),

              ///details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Profile information', showAction: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              // TProfileMenu(
              //   title: "Name",
              //   value: controller.partner.value.username,
              //   onPressed: () => Get.to(ChangeNameScreen()),
              // ),
              TProfileMenu(
                title: "Username",
                value: controller.partner.value.username,
                onPressed: () => Get.to(ChangeNameScreen()),
              ),

              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              const TSectionHeading(
                  title: 'Personal information', showAction: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(
                title: "User id",
                value: controller.partner.value.id,
                onPressed: () {},
                icon: Iconsax.copy,
              ),
              TProfileMenu(
                title: "Email",
                value: controller.partner.value.email,
                onPressed: () {},
              ),
              TProfileMenu(
                title: "Phone number",
                value: controller.partner.value.phoneNumber,
                onPressed: () {},
              ),
              // TProfileMenu(
              //   title: "Gender ",
              //   value: "Male",
              //   onPressed: () {},
              // ),
              // TProfileMenu(
              //   title: "Date of birth",
              //   value: "7-5-2003",
              //   onPressed: () {},
              // ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Center(
                child: TextButton(
                    onPressed: () => controller.logout(),
                    child: const Text(
                      "log out",
                      style: TextStyle(color: Colors.red),
                    )),
              )
            ],
          ),
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Profile"),
    //   ),
    //   body: Column(
    //     children: [
    //       ElevatedButton(
    //           onPressed: () => controller.logout(), child: const Text("logout"))
    //     ],
    //   ),
    // );
  }
}
