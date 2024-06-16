import 'package:final_year_project/features/home/controller/pickup_controller.dart';
import 'package:final_year_project/features/home/models/picup_request_model.dart';
import 'package:final_year_project/features/home/screens/home_screens.dart';
import 'package:final_year_project/features/home/screens/request/pick_up_request_detail_page.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:final_year_project/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/custom_enums.dart';
import '../../../../utils/constants/colors.dart';

class PickupRequestScreen extends StatelessWidget {
  const PickupRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PickupController());
    return Scaffold(
      backgroundColor: TColors.lightContainer,
      appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
          backgroundColor: TColors.primary,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Get.to(() => const HomeScreen()),
          ),
          title: Text(
            'Pickup requests',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: TColors.white),
          )),
      body: RefreshIndicator(
        onRefresh: () => controller.getScheduleScrapsOfUser(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your scrap pickups',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Gap(20),
                Obx(
                  () => RequestColumn(
                    title: "pending",
                    items: controller.pickupRequestList
                        .where((element) =>
                            element.pickupStatus == PickupStatus.PENDING)
                        .toList(),
                  ),
                ),
                const Gap(20),
                Obx(
                  () {
                    return RequestColumn(
                        title: "accepted",
                        items: controller.pickupRequestList
                            .where((element) =>
                                element.pickupStatus == PickupStatus.ACCEPTED)
                            .toList());
                  },
                ),
                const Gap(20),
                Obx(
                  () => RequestColumn(
                      title: "completed or cancelled",
                      items: controller.pickupRequestList
                          .where((element) => (element.pickupStatus ==
                                  PickupStatus.COMPLETED ||
                              element.pickupStatus == PickupStatus.CANCELLED))
                          .toList()),
                ),
                const SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RequestColumn extends StatelessWidget {
  const RequestColumn({super.key, required this.title, required this.items});
  final String title;
  final List<PickupRequestModel> items;
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const Gap(8),
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const Gap(10),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return RequestCard(item: item);
            })
      ],
    );
  }
}

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.item,
  });
  final PickupRequestModel item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PickupRequestDetailPage(item: item));
      },
      child: Card(
        color: TColors.light,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getIconForStatus(item.pickupStatus),
                    color: _getColorForStatus(item.pickupStatus),
                  ),
                  const Gap(4),
                  Text(
                    "id: ${item.id.substring(0, 8)}",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: THelperFunctions.screenWidth() * 0.3,
                    child: Text(
                      item.items.map((e) => e.title).join(""),
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    item.scheduledTime.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: TColors.darkGrey),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Function to determine icon based on status
  IconData _getIconForStatus(PickupStatus status) {
    switch (status) {
      case PickupStatus.PENDING:
        return Icons.schedule;
      case PickupStatus.ACCEPTED:
        return Icons.check_circle;
      case PickupStatus.COMPLETED:
        return Icons.done;
      case PickupStatus.CANCELLED:
        return Icons.cancel;
      case PickupStatus.REJECTED:
        return Icons.thumb_down;
      default:
        throw ArgumentError("Unknown pickup status: $status");
    }
  }

// Function to determine color based on status
  Color _getColorForStatus(PickupStatus status) {
    switch (status) {
      case PickupStatus.PENDING:
        return Colors.orange; // Example color for pending status
      case PickupStatus.ACCEPTED:
        return Colors.green; // Example color for accepted status
      case PickupStatus.COMPLETED:
        return Colors.blue; // Example color for completed status
      case PickupStatus.CANCELLED:
        return Colors.red; // Example color for cancelled status
      case PickupStatus.REJECTED:
        return Colors.red; // Example color for rejected status
      default:
        return Colors.black; // Default color (or any other fallback color)
    }
  }
}
