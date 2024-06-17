import 'package:final_year_project/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:final_year_project/features/partner/screens/partner_home/widgets/partner_request_history.dart';
import 'package:final_year_project/features/partner/screens/partner_home/widgets/summary_count_card.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.completed,
    required this.rejected,
    required this.cancelled,
  });

  final int completed;
  final int rejected;
  final int cancelled;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TSizes.cardRadiusMd),
      decoration: BoxDecoration(
          color: Colors.lightBlue.shade100.withOpacity(0.7),
          borderRadius: BorderRadius.circular(TSizes.borderRadiusMd)),
      child: GestureDetector(
        onTap: () => Get.to(() => const PartnerRequestHistory()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const RoundedContainer(
                    padding: EdgeInsets.all(4), child: Icon(Iconsax.clock)),
                const Gap(TSizes.spaceBtwItems),
                Text(
                  'Request history',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.blue.shade800, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward)
              ],
            ),
            const Gap(TSizes.spaceBtwItems),
            Text(
              'Summary',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Gap(TSizes.spaceBtwItems / 2),
            Row(
              children: [
                SummaryCountCard(title: 'Completed', count: completed),
                const Gap(10),
                SummaryCountCard(title: "Rejected", count: rejected),
                const Gap(10),
                SummaryCountCard(title: "Cancelled", count: cancelled),
              ],
            )
          ],
        ),
      ),
    );
  }
}
