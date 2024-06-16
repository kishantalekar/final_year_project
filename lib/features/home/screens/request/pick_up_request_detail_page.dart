import 'package:final_year_project/core/custom_enums.dart';
import 'package:final_year_project/features/home/models/picup_request_model.dart';
import 'package:final_year_project/features/home/screens/booking/widgets/custom_app_bar.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:final_year_project/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class PickupRequestDetailPage extends StatelessWidget {
  const PickupRequestDetailPage({super.key, required this.item});

  final PickupRequestModel item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.lightContainer,
      appBar: CustomAppBar(
        title: item.pickupStatus.status,
      ),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.settings,
                  size: 25,
                ),
                const Gap(10),
                Text(
                  "Request ${item.pickupStatus.status}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Gap(TSizes.spaceBtwSections),
            Container(
              padding: const EdgeInsets.all(
                TSizes.defaultSpace / 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: TColors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expected pickup",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Gap(8),
                      Text(
                        THelperFunctions.getFormattedDate(item.scheduledTime),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Request id",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Gap(8),
                      Text(
                        item.id.substring(0, 8),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Gap(TSizes.spaceBtwSections),
            Container(
              padding: const EdgeInsets.all(
                TSizes.defaultSpace / 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: TColors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "subhash",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Gap(8),
                      Text(
                        THelperFunctions.getFormattedDate(item.scheduledTime),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "parner id",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Gap(8),
                      Text(
                        item.id.substring(0, 8),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Gap(TSizes.spaceBtwItems),
            Container(
              padding: const EdgeInsets.all(
                TSizes.defaultSpace / 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: TColors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'scrap items',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Gap(20),
                  ListView.separated(
                    separatorBuilder: (context, index) =>
                        const Gap(TSizes.spaceBtwItems),
                    shrinkWrap: true,
                    itemCount: item.items.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final scrap = item.items[index];
                      final msg = scrap.unitType == UnitType.kg
                          ? "${scrap.kg}/kg"
                          : "${scrap.pcs}/pcs";
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            scrap.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          Text(
                            msg,
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const Gap(TSizes.spaceBtwItems),
            Container(
              padding: const EdgeInsets.all(
                TSizes.defaultSpace / 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: TColors.white,
              ),
              child: Row(
                children: [
                  const Icon(Iconsax.location_tick),
                  const Gap(TSizes.spaceBtwItems),
                  Column(
                    children: [
                      Text(
                        "Address - Home",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Gap(8),
                      Text(
                        "sadashivgad,karwar",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
