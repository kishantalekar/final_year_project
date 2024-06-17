import 'package:final_year_project/features/authentication/controllers/sign_up/sign_up_controller.dart';
import 'package:final_year_project/features/authentication/screens/signup/partner_signup.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:final_year_project/utils/constants/text_strings.dart';
import 'package:final_year_project/utils/validators/validation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Form(
      key: controller.signFormKey,
      child: Column(
        children: [
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            validator: (value) =>
                TValidator.validateEmptyText('User name', value),
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
            validator: (value) => TValidator.validateEmail(value),
            controller: controller.email,
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          Obx(
            () => TextFormField(
              validator: (value) => TValidator.validatePassword(value),
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
            validator: (value) => TValidator.validatePhoneNumber(value),
            controller: controller.phoneNumber,
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            validator: (value) =>
                TValidator.validateEmptyText("Address", value),
            controller: controller.address,
            decoration: const InputDecoration(
              labelText: "Address",
              prefixIcon: Icon(Iconsax.location),
            ),
          ),

          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          // Row(
          //   children: [
          //     SizedBox(
          //       width: 24,
          //       height: 24,
          //       child: Obx(
          //         () => Checkbox(
          //           value: controller.privacyPolicy.value,
          //           onChanged: (value) {
          //             controller.privacyPolicy.value = value!;
          //           },
          //         ),
          //       ),
          //     ),
          //     const SizedBox(
          //       width: TSizes.spaceBtwItems,
          //     ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: 'Want to become a partner? ',
                    style: Theme.of(context).textTheme.labelSmall),
                TextSpan(
                  text: 'Click here ',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.to(() => const PartnerSignup()),
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.white : TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark ? TColors.white : TColors.primary,
                        overflow: TextOverflow.clip,
                      ),
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
          )
          // ],
          // ),
          ,
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
