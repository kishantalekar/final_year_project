import 'package:final_year_project/features/home/controller/booking_controller.dart';
import 'package:final_year_project/features/home/screens/booking/widgets/scrap_items_row.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/custom_enums.dart';
import '../../../models/scrap_item.dart';

List<ScrapItem> paperSubcategories = [
  ScrapItem(id: 1, title: "Newspaper", categoryType: Categories.Paper),
  ScrapItem(id: 2, title: "Magazines", categoryType: Categories.Paper),
  ScrapItem(id: 3, title: "Cardboard", categoryType: Categories.Paper),
  ScrapItem(id: 4, title: "Office Paper", categoryType: Categories.Paper),
  ScrapItem(id: 5, title: "Books", categoryType: Categories.Paper),
  ScrapItem(
      id: 6, title: "Paperboard Packaging", categoryType: Categories.Paper),
];

List<ScrapItem> plasticSubcategories = [
  ScrapItem(id: 7, title: "Soft Plastic", categoryType: Categories.PLASTIC),
  ScrapItem(
      id: 8,
      title: "Plastic Jar (15ltr)",
      categoryType: Categories.PLASTIC,
      unitType: UnitType.pcs),
  ScrapItem(id: 9, title: "Polythene mix", categoryType: Categories.PLASTIC),
  ScrapItem(
      id: 10,
      title: "Plastic Jar (5ltr)",
      categoryType: Categories.PLASTIC,
      unitType: UnitType.pcs),
  ScrapItem(
      id: 12, title: "Water/oil covers", categoryType: Categories.PLASTIC),
];

List<ScrapItem> metalSubcategories = [
  ScrapItem(id: 13, title: "Aluminum Cans", categoryType: Categories.METALS),
  ScrapItem(id: 14, title: "Copper", categoryType: Categories.METALS),
  ScrapItem(id: 15, title: "Steel Scrap", categoryType: Categories.METALS),
  ScrapItem(id: 16, title: "Brass", categoryType: Categories.METALS),
  ScrapItem(id: 17, title: "Iron", categoryType: Categories.METALS),
];

List<ScrapItem> ewasteSubcategories = [
  ScrapItem(id: 19, title: "E-Waste", categoryType: Categories.E_WASTE),
];

List<ScrapItem> otherSubcategories = [
  ScrapItem(
      id: 27,
      title: "Glass Bottles",
      categoryType: Categories.Other,
      unitType: UnitType.pcs),
  ScrapItem(id: 28, title: "Used Clothes", categoryType: Categories.Other),
  ScrapItem(id: 29, title: "Used Tires", categoryType: Categories.Other),
  ScrapItem(id: 30, title: "Cooking Oil", categoryType: Categories.Other),
  ScrapItem(id: 31, title: "Batteries", categoryType: Categories.Other),
];

class ScrapItemSelectionPage extends StatelessWidget {
  const ScrapItemSelectionPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = BookingController.instance;
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Select scrap items for pickup ',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const Gap(5),
            Text(
              '*Enter approximate qty',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const Gap(20),
            if (controller.selectedCategories.contains(Categories.PLASTIC))
              ScrapItemsRow(
                list: plasticSubcategories,
                title: "Soft plastic ",
                subTitle: "12/kg",
                isSelected: true,
                mainTitle: "Plastic",
              ),
            const Gap(TSizes.spaceBtwItems),
            if (controller.selectedCategories.contains(Categories.Paper))
              ScrapItemsRow(
                list: paperSubcategories,
                title: "E-waste",
                subTitle: "12/kg",
                isSelected: false,
                mainTitle: "paper",
              ),
            const Gap(TSizes.spaceBtwItems),
            if (controller.selectedCategories.contains(Categories.METALS))
              ScrapItemsRow(
                list: metalSubcategories,
                title: "Metals",
                subTitle: "12/kg",
                isSelected: false,
                mainTitle: "metal",
              ),
            const Gap(TSizes.spaceBtwItems),
            if (controller.selectedCategories.contains(Categories.E_WASTE))
              ScrapItemsRow(
                list: ewasteSubcategories,
                title: "E-waste",
                subTitle: "12/kg",
                isSelected: false,
                mainTitle: "E-waste",
              ),
            const Gap(TSizes.spaceBtwItems),
            if (controller.selectedCategories.contains(Categories.Other))
              ScrapItemsRow(
                list: otherSubcategories,
                title: "others",
                subTitle: "12/kg",
                isSelected: false,
                mainTitle: "others",
              ),
          ],
        ),
      ],
    );
  }
}
