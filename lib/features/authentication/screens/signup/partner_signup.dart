import 'package:final_year_project/features/authentication/screens/signup/widgets/partner_sign_form.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:final_year_project/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class PartnerSignup extends StatelessWidget {
  const PartnerSignup({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //title
            Text(
              "Let's create your patner account",
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            //form
            PartnerSignupForm(dark: dark),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            // TFormDivider(
            //     dark: dark, dividerText: TTexts.orSignUpWith.capitalize!),
            // const SizedBox(
            //   height: TSizes.spaceBtwSections,
            // ),
            // const TSocialButtons(),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
          ]),
        ),
      ),
    );
  }
}
