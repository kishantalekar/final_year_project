import 'package:final_year_project/features/home/controller/booking_controller.dart';
import 'package:final_year_project/features/home/screens/booking/scrap_collector_detail.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';

class ScrapCollectorSearch extends StatelessWidget {
  const ScrapCollectorSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BookingController.instance;
    return Scaffold(
      // bottomSheet: Text("botom sheet"),
      appBar: AppBar(
        title: const Text('Choose your scrap collector'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // const Text('Choose your scrap collector'),
              Obx(
                () => ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (_, __) => const Gap(TSizes.spaceBtwItems),
                  itemCount: controller.allPickupsPatnerGetter.length,
                  itemBuilder: (context, index) {
                    final pickupPartner =
                        controller.allPickupsPatnerGetter[index];
                    return GestureDetector(
                      onTap: () => Get.to(() => ScrapCollectorDetailPage(
                          pickupPartner: pickupPartner)),
                      child: Card(
                        elevation: TSizes.cardElevation,
                        color: TColors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: pickupPartner
                                                .profilePicture.length >
                                            4
                                        ? NetworkImage(
                                                pickupPartner.profilePicture)
                                            as ImageProvider
                                        : AssetImage(TImages.user),
                                  ),
                                  const Gap(TSizes.spaceBtwItems),
                                  Text(
                                    pickupPartner.username,
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
                                    pickupPartner.address,
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
                                    pickupPartner.phoneNumber,
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
