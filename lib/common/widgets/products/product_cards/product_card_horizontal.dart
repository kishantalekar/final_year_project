import 'package:final_year_project/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:final_year_project/common/widgets/image/rounded_image.dart';
import 'package:final_year_project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:final_year_project/common/widgets/texts/brand_title_text_with_verification.dart';
import 'package:final_year_project/common/widgets/texts/product_price_text.dart';
import 'package:final_year_project/common/widgets/texts/product_title_text.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/helpers/helper_functions.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        // boxShadow: [TShadowStyles.horizontalProductShape],
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: dark ? TColors.darkerGrey : TColors.lightContainer,
      ),
      child: Row(
        children: [
          ///thumdnail
          RoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(TSizes.md),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Stack(children: [
              //thumbnail image
              const SizedBox(
                height: 120,
                width: 120,
                child: TRoundedImage(
                  imageUrl: TImages.productImage1,
                  applyImageRadius: true,
                ),
              ),

              //sale tag
              Positioned(
                top: 12,
                child: RoundedContainer(
                  radius: TSizes.sm,
                  backgroundColor: TColors.secondary.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.sm, vertical: TSizes.xs),
                  child: Text(
                    "25%",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: TColors.black),
                  ),
                ),
              ),
              //favorite icon
              const Positioned(
                right: 0,
                top: 0,
                child: TCircularIcon(
                  icon: Iconsax.heart5,
                  color: Colors.red,
                ),
              )
            ]),
          ),

          //details

          SizedBox(
            width: 140,
            child: Padding(
              padding: const EdgeInsets.only(left: TSizes.sm, top: TSizes.sm),
              child: Column(
                children: [
                  const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductTitleText(
                          title: "Green nike shoes half sleeves shirt",
                          smallSize: true,
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems / 2,
                        ),
                        TBrandTitleTextWithVerification(title: 'Nike')
                      ]),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //pricing
                      const Flexible(
                          child: TProductPriceText(price: '256.0 - 245.6')),

                      //add to cart
                      Container(
                        decoration: const BoxDecoration(
                          color: TColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(TSizes.cardRadiusMd),
                            bottomRight: Radius.circular(
                              TSizes.productImageRadius,
                            ),
                          ),
                        ),
                        child: const SizedBox(
                          width: TSizes.iconLg * 1.2,
                          height: TSizes.iconLg * 1.2,
                          child: Center(
                            child: Icon(
                              Iconsax.add,
                              color: TColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
