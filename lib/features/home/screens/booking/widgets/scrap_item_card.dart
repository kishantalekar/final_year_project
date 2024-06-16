import 'package:final_year_project/core/custom_enums.dart';
import 'package:final_year_project/features/home/controller/booking_controller.dart';
import 'package:final_year_project/features/home/models/scrap_item.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ScrapItemCard extends StatelessWidget {
  const ScrapItemCard({
    super.key,
    required this.item,
  });

  final ScrapItem item;

  @override
  Widget build(BuildContext context) {
    final controller = BookingController.instance;

    return Obx(
      () {
        final selectedItem = controller.selectedSubCategories
            .firstWhereOrNull((i) => i.id == item.id);
        final isSelected = selectedItem != null;
        final quantity = isSelected
            ? (item.unitType == UnitType.kg
                    ? selectedItem.kg
                    : selectedItem.pcs)
                .toString()
            : '0';
        return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: TSizes.defaultSpace / 2, vertical: 10),
          decoration: BoxDecoration(
            border:
                Border.all(color: isSelected ? TColors.primary : TColors.dark),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const Gap(TSizes.md / 2),
                    Icon(
                      Icons.check_circle_outline,
                      color: isSelected ? TColors.primary : TColors.grey,
                      size: TSizes.iconSm + 2,
                    )
                  ],
                ),
              ),
              // Gap(TSizes.spaceBtwItems),
              Expanded(
                child: !isSelected
                    ? TextButton(
                        onPressed: () => controller.addSubCategories(item),
                        child: const Text("Add +"))
                    // TextButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         isSelected = true;
                    //         quantity += 0.5;
                    //       });
                    //     },
                    //     child: Text("select"),
                    //   )
                    : Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () =>
                                controller.decreaseSubCategories(item),
                            icon: const Icon(
                              Iconsax.minus,
                              size: TSizes.iconSm,
                            ),
                          ),
                          // Gap(10),
                          Text('$quantity ${item.unitType.name}'),
                          // Gap(10),
                          IconButton(
                            onPressed: () => controller.addSubCategories(item),
                            icon: const Icon(
                              Iconsax.add,
                              size: TSizes.iconSm,
                            ),
                          ),
                        ],
                      ),
              ),

              // Text(widget.subTitle)
            ],
          ),
        );
      },
    );
  }
}
