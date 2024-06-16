import 'package:final_year_project/features/home/controller/booking_controller.dart';
import 'package:final_year_project/features/home/screens/booking/widgets/scrap_item_card.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

import '../../../models/scrap_item.dart';

class ScrapItemsRow extends StatelessWidget {
  const ScrapItemsRow(
      {super.key,
      this.isSelected = false,
      required this.title,
      required this.subTitle,
      required this.mainTitle,
      required this.list});
  final bool isSelected;
  final String title;
  final String subTitle;
  final String mainTitle;
  final List<ScrapItem> list;
  @override
  Widget build(BuildContext context) {
    final controller = BookingController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(mainTitle),
        const Gap(TSizes.sm),
        SizedBox(
          height: 80,
          child: ListView.separated(
            separatorBuilder: (context, index) =>
                const Gap(TSizes.spaceBtwItems),
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = list[index];

              return ScrapItemCard(
                item: item,
              );
            },
          ),
        ),
      ],
    );
  }
}
