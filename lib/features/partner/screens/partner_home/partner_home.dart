import 'package:final_year_project/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:final_year_project/features/partner/controller/partner_controller.dart';
import 'package:final_year_project/features/partner/screens/partner_home/widgets/request_card.dart';
import 'package:final_year_project/features/partner/screens/partner_home/widgets/summary_card.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:final_year_project/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PartnerHome extends StatelessWidget {
  const PartnerHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = PartnerController.instance;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "welcome,",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Obx(
              () => Text(
                controller.partner.value.username,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            )
          ],
        ),
        actions: const [
          Image(
            image: AssetImage(
              TImages.user,
            ),
            fit: BoxFit.contain,
            width: 40,
            height: 40,
          ),
          Gap(10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const Gap(20),
              const Gap(20),
              Row(
                children: [
                  RoundedContainer(
                    showBorder: true,
                    borderColor: TColors.black,
                    width: THelperFunctions.screenWidth() * 0.4,
                    height: 100,
                    child: GestureDetector(
                      onTap: () =>
                          Get.to(() => const PartnerPickupRequestScreen()),
                      child: const Center(
                          child: Text(
                        "Pickup request",
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
                  const Gap(20),
                  RoundedContainer(
                    showBorder: true,
                    borderColor: TColors.black,
                    width: THelperFunctions.screenWidth() * 0.4,
                    height: 100,
                    child: const Center(
                        child: Text(
                      "Ongoing request",
                      textAlign: TextAlign.center,
                    )),
                  ),
                ],
              ),
              const Gap(20),
              const SummaryCard()
            ],
          ),
        ),
      ),
    );
  }
}

class PartnerPickupRequestScreen extends StatelessWidget {
  const PartnerPickupRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick up request"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                separatorBuilder: (_, __) => const Gap(TSizes.spaceBtwItems),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) => const RequestCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
