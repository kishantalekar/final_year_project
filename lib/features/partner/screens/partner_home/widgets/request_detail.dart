import 'package:final_year_project/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:final_year_project/features/partner/screens/partner_home/widgets/billing_screen.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class RequestDetailScreen extends StatelessWidget {
  RequestDetailScreen({super.key});
  final list = [
    // ScrapItem('Brass', '300/kg'),
    // ScrapItem('Aluminium', '300/kg'),
    // ScrapItem('E-waste', '300/kg'),
    // ScrapItem('E-waste', '300/kg'),
    // ScrapItem('E-waste', '300/kg'),
    // ScrapItem('E-waste', '300/kg'),
  ];
  @override
  Widget build(BuildContext context) {
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Name'), Text('Vikram')],
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
                          '+919353167354',
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
                  const PickupRequestItem(
                    title: "Request Raised time",
                    subTitle: "12:57 pm",
                  ),
                  const Gap(TSizes.spaceBtwItems),
                  const PickupRequestItem(
                    title: "Pickup location ",
                    subTitle: "Near sadashivgad  581328 ",
                  ),
                  const Gap(TSizes.spaceBtwItems),
                  const PickupRequestItem(
                    title: "Request Id",
                    subTitle: "1234567891001",
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
                    children: list
                        .map((e) => Chip(
                              backgroundColor: Colors.white,
                              label: Column(
                                children: [
                                  Text(e.title),
                                  const Gap(10),
                                  Text(e.subtitle),
                                ],
                              ),
                            ))
                        .toList(),
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
          child: true
              ? ElevatedButton(
                  onPressed: () {
                    Get.to(() => const BillingScreen());
                  },
                  child: const Text("Generate bill"),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Gap(TSizes.defaultSpace),

                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red)),
                        onPressed: () {},
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
                        onPressed: () {},
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
