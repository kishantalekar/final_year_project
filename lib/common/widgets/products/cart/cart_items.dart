import 'package:final_year_project/common/widgets/products/cart/product_quantity_with_add_remove.dart';
import 'package:final_year_project/common/widgets/texts/product_price_text.dart';
// import 'package:final_year_project/features/personalization/screens/cart/widgets/cart_item.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButton = true,
  });
  final bool showAddRemoveButton;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(
        height: TSizes.spaceBtwSections,
      ),
      itemCount: 4,
      itemBuilder: (_, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            // const TCartItem(),

            if (showAddRemoveButton)
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
            if (showAddRemoveButton)
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 70,
                      ),
                      TProductQuantityWithAddRemove(),
                    ],
                  ),
                  TProductPriceText(price: '256')
                ],
              )
          ],
        );
      },
    );
  }
}
