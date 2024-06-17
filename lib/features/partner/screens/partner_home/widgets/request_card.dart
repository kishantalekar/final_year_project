import 'package:final_year_project/features/home/models/picup_request_model.dart';
import 'package:final_year_project/features/partner/screens/partner_home/widgets/request_detail.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:final_year_project/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.request,
  });

  final PickupRequestModel request;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: TColors.primary,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Request received',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(TSizes.spaceBtwItems / 2),
          SizedBox(
            width: THelperFunctions.screenWidth() * 0.8,
            child: Row(
              children: [
                Icon(
                  Iconsax.location,
                  color: Colors.green.shade800,
                ),
                const Gap(TSizes.spaceBtwItems),
                Expanded(
                  child: Text(
                    maxLines: 2,
                    request.address,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              ],
            ),
          ),
          const Gap(TSizes.spaceBtwItems),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade800),
              onPressed: () {
                Get.to(() => RequestDetailScreen(request: request));
              },
              child: const Text("Take action ->"),
            ),
          )
        ],
      ),
    );
  }
}
