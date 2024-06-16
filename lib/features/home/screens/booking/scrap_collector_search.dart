import 'package:final_year_project/features/home/screens/booking/scrap_collector_detail.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ScrapCollectorSearch extends StatelessWidget {
  const ScrapCollectorSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomSheet: Text("botom sheet"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const Text('Choose your scrap collector'),
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Get.to(() => const ScrapCollectorDetailPage()),
                      child: Card(
                        elevation: TSizes.cardElevation,
                        color: TColors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Image(
                                    image: AssetImage(TImages.user),
                                    width: 40,
                                    height: 40,
                                  ),
                                  const Gap(TSizes.spaceBtwItems),
                                  Text(
                                    'Ravi',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                              const Gap(TSizes.spaceBtwItems),
                              Row(
                                children: [
                                  const Icon(
                                    Iconsax.location4,
                                  ),
                                  const Gap(TSizes.spaceBtwItems),
                                  Text(
                                    'sadashivgad,karwar 581328',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              const Gap(TSizes.spaceBtwItems),
                              Row(
                                children: [
                                  const Icon(
                                    Iconsax.call,
                                  ),
                                  const Gap(TSizes.spaceBtwItems),
                                  Text(
                                    '+91 987654321',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const Gap(TSizes.spaceBtwItems),
                  itemCount: 4)
            ],
          ),
        ),
      ),
    );
  }
}
