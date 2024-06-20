import 'package:final_year_project/features/authentication/controllers/sign_up/partner_sign_up_controller.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:final_year_project/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class PartnerSignupForm extends StatelessWidget {
  const PartnerSignupForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PartnerSignupController());
    return Form(
      // key: controller.partnerSignupFormKey,
      child: Column(
        children: [
          // Row(
          //   children: [
          //     Expanded(
          //       child: TextFormField(
          //         controller: controller.firstname,
          //         validator: (value) =>
          //             TValidator.validateEmptyText('First name', value),
          //         expands: false,
          //         decoration: const InputDecoration(
          //           labelText: TTexts.firstName,
          //           prefixIcon: Icon(Iconsax.user),
          //         ),
          //       ),
          //     ),
          //     const SizedBox(
          //       width: TSizes.spaceBtwInputFields,
          //     ),
          //     Expanded(
          //       child: TextFormField(
          //         validator: (value) =>
          //             TValidator.validateEmptyText('Last name', value),
          //         controller: controller.lastname,
          //         expands: false,
          //         decoration: const InputDecoration(
          //           labelText: TTexts.lastName,
          //           prefixIcon: Icon(Iconsax.user),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            // validator: (value) =>
            //     TValidator.validateEmptyText('User name', value),
            controller: controller.username,
            decoration: const InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            // validator: (value) => TValidator.validateEmail(value),
            controller: controller.email,
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            // validator: (value) => TValidator.validatePhoneNumber(value),
            controller: controller.phoneNumber,
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          Obx(
            () => TextFormField(
              // validator: (value) => TValidator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                      icon: Icon(controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye))),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            // validator: (value) =>
            //     TValidator.validateEmptyText('User name', value),
            controller: controller.address,
            decoration: const InputDecoration(
              labelText: "Address",
              prefixIcon: Icon(Iconsax.location),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signUp(),
              child: const Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
