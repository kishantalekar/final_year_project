import 'package:final_year_project/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:final_year_project/core/custom_enums.dart';
import 'package:final_year_project/features/home/models/picup_request_model.dart';
import 'package:final_year_project/features/partner/controller/partner_controller.dart';
import 'package:final_year_project/features/partner/screens/partner_home/widgets/billing_screen.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:final_year_project/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class RequestDetailScreen extends StatelessWidget {
  const RequestDetailScreen({super.key, required this.request});
  final PickupRequestModel request;
  @override
  Widget build(BuildContext context) {
    final controller = PartnerController.instance;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Request details ",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //customer

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer details",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Gap(TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Name'), Text(request.username)],
                  ),
                  const Gap(TSizes.sm),
                  RoundedContainer(
                    backgroundColor: Colors.green.shade100,
                    padding: const EdgeInsets.all(TSizes.cardRadiusMd),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Iconsax.call_calling),
                        const Gap(TSizes.md),
                        Text(
                          'Call',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Spacer(),
                        Text(
                          '+91${request.number}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const Gap(TSizes.spaceBtwItems),
              const Divider(),
              const Gap(TSizes.spaceBtwItems),
              //pickup details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pickup request details',
                      style: Theme.of(context).textTheme.headlineSmall!),
                  const Gap(TSizes.spaceBtwItems),
                  PickupRequestItem(
                    title: "Request Raised time",
                    subTitle: THelperFunctions.getFormattedDate(
                        request.scheduledTime),
                  ),
                  const Gap(TSizes.spaceBtwItems),
                  PickupRequestItem(
                    title: "Pickup location ",
                    subTitle: request.address,
                  ),
                  const Gap(TSizes.spaceBtwItems),
                  PickupRequestItem(
                    title: "Request Id",
                    subTitle: request.id,
                  ),
                ],
              ),
              const Gap(TSizes.spaceBtwSections),
              const Divider(),
              const Gap(TSizes.spaceBtwItems),
              //material list
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Material list',
                      style: Theme.of(context).textTheme.headlineSmall!),
                  const Gap(TSizes.md),
                  Wrap(
                    spacing: TSizes
                        .spaceBtwInputFields, // gap between adjacent chips
                    runSpacing: TSizes.spaceBtwItems, // gap between lines
                    children: request.items.map((e) {
                      final quantity = e.unitType == UnitType.kg ? e.kg : e.pcs;
                      return RoundedContainer(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        showBorder: true,
                        child: Column(
                          children: [
                            Text(
                              "${e.title} ${quantity}/${e.unitType.name}",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),

              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
      //actions
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: TColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: request.pickupStatus != PickupStatus.PENDING
              ? ElevatedButton(
                  onPressed: () {
                    final updated = controller.updatedScrapList(request);
                    Get.to(() => BillingScreen(request: updated));
                  },
                  child: const Text("Got to Checkout"),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Gap(TSizes.defaultSpace),

                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red)),
                        onPressed: () => controller.updatePickStatus(
                            request, PickupStatus.REJECTED),
                        child: Text(
                          "Reject",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.red),
                        ),
                      ),
                    ),
                    const Gap(TSizes.defaultSpace),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => controller.updatePickStatus(
                            request, PickupStatus.ACCEPTED),
                        child: const Text("Accept"),
                      ),
                    ),
                    // Gap(TSizes.defaultSpace),
                  ],
                ),
        ),
      ),
    );
  }
}

class PickupRequestItem extends StatelessWidget {
  const PickupRequestItem({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        const Gap(2),
        Text(subTitle,
            maxLines: 3,
            // overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium!)
      ],
    );
  }
}
