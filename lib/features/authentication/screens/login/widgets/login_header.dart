import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          child: Image(
            color: TColors.primary,
            image: AssetImage(
              dark ? TImages.appLogo : TImages.appLogo,
            ),
            height: 150,
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems + 20,
        ),
        // Text(
        //   // TTexts.loginTitle,
        //   "Got scrap? Sell it to us.",
        //   style: Theme.of(context).textTheme.headlineMedium,
        // ),
        // const SizedBox(
        //   height: TSizes.sm,
        // ),
        // Text(
        //   // TTexts.loginSubTitle,
        //   "Sell us your recyclable wastes and help contribute to the circular economy.",
        //   style: Theme.of(context).textTheme.bodyMedium,
        // )
      ],
    );
  }
}
