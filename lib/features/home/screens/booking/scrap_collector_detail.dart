import 'package:final_year_project/features/home/controller/booking_controller.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';

class ScrapCollectorDetailPage extends StatelessWidget {
  const ScrapCollectorDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BookingController.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scrap collector",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(TSizes.spaceBtwSections),
              const Image(
                image: AssetImage(TImages.user),
                width: 50,
                height: 50,
              ),
              const Text('Ravi'),
              const Gap(TSizes.spaceBtwSections),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.location4,
                  ),
                  const Gap(TSizes.spaceBtwItems),
                  Text(
                    'sadashivgad,karwar 581328',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const Gap(TSizes.spaceBtwItems),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.call,
                  ),
                  const Gap(TSizes.spaceBtwItems),
                  Text(
                    '+91 987654321',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const Gap(TSizes.spaceBtwItems),
              const Row(
                children: [
                  Text('Ravi accepts all items on your cart'),
                  Gap(20),
                  Icon(
                    Iconsax.tick_circle,
                    color: TColors.primary,
                  )
                ],
              ),
              Column(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'List of items accepted here',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                        ),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Rates of purchase ',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                        ),
                      )),
                ],
              ),
              const Gap(TSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.ScheduleScrapCollection("1233"),
                    child: const Text("Schedule scrap collection")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
