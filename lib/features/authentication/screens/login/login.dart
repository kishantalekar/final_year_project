import 'package:final_year_project/common/styles/spacing_styles.dart';
import 'package:final_year_project/features/authentication/screens/login/widgets/login_form.dart';
import 'package:final_year_project/features/authentication/screens/login/widgets/login_header.dart';
import 'package:final_year_project/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: TSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          children: [
            TLoginHeader(dark: dark),
            const TLoginForm(),
            // TFormDivider(
            //   dark: dark,
            //   dividerText: TTexts.orSignInWith.capitalize!,
            // ),
            // const SizedBox(
            //   height: TSizes.spaceBtwSections,
            // ),
            // const TSocialButtons()
          ],
        ),
      ),
    ));
  }
}
