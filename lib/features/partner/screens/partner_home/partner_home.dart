import 'package:final_year_project/core/custom_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:final_year_project/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:final_year_project/features/partner/controller/partner_controller.dart';
import 'package:final_year_project/features/partner/screens/partner_home/widgets/request_card.dart';
import 'package:final_year_project/features/partner/screens/partner_home/widgets/summary_card.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:final_year_project/utils/helpers/helper_functions.dart';

import '../../../home/models/picup_request_model.dart';

class PartnerHome extends StatelessWidget {
  const PartnerHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PartnerController());
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
      body: RefreshIndicator(
        onRefresh: () => controller.getAllSchedules(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                const Gap(20),
                const Gap(20),
                Row(
                  children: [
                    Obx(
                      () => GestureDetector(
                        onTap: () => Get.to(() => PartnerPickupRequestScreen(
                            requests: controller.pickupsPending)),
                        child: RoundedContainer(
                          showBorder: true,
                          borderColor: TColors.black,
                          width: THelperFunctions.screenWidth() * 0.4,
                          height: 100,
                          child: Center(
                              child: Text(
                            "Pickup request ${controller.pickupsPending.length}",
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ),
                    ),
                    const Gap(20),
                    Obx(
                      () => GestureDetector(
                        onTap: () => Get.to(() => PartnerPickupRequestScreen(
                            requests: controller.pickupsOngoing)),
                        child: RoundedContainer(
                          showBorder: true,
                          borderColor: TColors.black,
                          width: THelperFunctions.screenWidth() * 0.4,
                          height: 100,
                          child: Center(
                              child: Text(
                            "Ongoing request ${controller.pickupsOngoing.length}",
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Obx(() => SummaryCard(
                    completed: controller.pickupsCompleted.length,
                    rejected: controller.pickupsOnRejected.length,
                    cancelled: controller.pickupsCancelled.length))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PartnerPickupRequestScreen extends StatelessWidget {
  const PartnerPickupRequestScreen({super.key, required this.requests});

  final List<PickupRequestModel> requests;
  @override
  Widget build(BuildContext context) {
    // final controller = PartnerController.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick up request"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (requests.length == 0)
                SizedBox(
                  height: THelperFunctions.screenHeight() * 0.7,
                  child: Center(child: Text("List is empty")),
                ),
              ListView.separated(
                separatorBuilder: (_, __) => const Gap(TSizes.spaceBtwItems),
                shrinkWrap: true,
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return RequestCard(
                    request: request,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
