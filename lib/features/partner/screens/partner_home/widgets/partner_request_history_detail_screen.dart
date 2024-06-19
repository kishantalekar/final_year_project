import 'package:final_year_project/core/custom_enums.dart';
import 'package:final_year_project/features/home/models/picup_request_model.dart';
import 'package:final_year_project/features/home/screens/booking/widgets/custom_app_bar.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:final_year_project/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

Map<PickupStatus, Map<String, dynamic>> pickupStatusDetails = {
  PickupStatus.PENDING: {
    'message': 'Your request is pending',
    'icon': Icons.hourglass_empty,
    'color': Colors.orange
  },
  PickupStatus.ACCEPTED: {
    'message': 'Your request has been accepted',
    'icon': Icons.check_circle,
    'color': Colors.blue
  },
  PickupStatus.COMPLETED: {
    'message': 'This pickup has been completed',
    'icon': Icons.done,
    'color': Colors.green
  },
  PickupStatus.CANCELLED: {
    'message': 'This pickup  has been cancelled',
    'icon': Icons.cancel,
    'color': Colors.red
  },
  PickupStatus.REJECTED: {
    'message': 'This pickup has been rejected',
    'icon': Icons.thumb_down,
    'color': Colors.red
  },
};

Map<String, dynamic> getStatusDetails(PickupStatus status) {
  return pickupStatusDetails[status] ??
      {
        'message': 'Unknown status',
        'icon': Icons.help_outline,
        'color': Colors.grey
      };
}

class PartnerRequestHistoryDetailScreen extends StatelessWidget {
  const PartnerRequestHistoryDetailScreen({super.key, required this.item});

  final PickupRequestModel item;
  @override
  Widget build(BuildContext context) {
    var statusDetails = getStatusDetails(item.pickupStatus);
    return Scaffold(
      backgroundColor: TColors.lightContainer,
      appBar: CustomAppBar(
        title: item.pickupStatus.status,
      ),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  statusDetails['icon'],
                  size: 25,
                  color: statusDetails['color'],
                ),
                const Gap(10),
                Text(
                  statusDetails['message'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: statusDetails['color']),
                ),
              ],
            ),
            // const Gap(TSizes.spaceBtwSections),
            // Container(
            //   padding: const EdgeInsets.all(
            //     TSizes.defaultSpace / 2,
            //   ),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12),
            //     color: TColors.white,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             "Schedule  time",
            //             style: Theme.of(context).textTheme.labelMedium,
            //           ),
            //           const Gap(8),
            //           Text(
            //             THelperFunctions.getFormattedDate(item.scheduledTime),
            //             style: Theme.of(context).textTheme.labelLarge,
            //           ),
            //         ],
            //       ),
            //       Column(
            //         children: [
            //           Text(
            //             "Request id",
            //             style: Theme.of(context).textTheme.labelMedium,
            //           ),
            //           const Gap(8),
            //           Text(
            //             item.id.substring(0, 8),
            //             style: Theme.of(context).textTheme.labelLarge,
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            const Gap(TSizes.spaceBtwSections),
            Container(
              padding: const EdgeInsets.all(
                TSizes.defaultSpace / 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: TColors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Placed by ${item.username}",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Gap(8),
                      Text(
                        THelperFunctions.getFormattedDate(item.scheduledTime),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "user id",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Gap(8),
                      Text(
                        item.userId.substring(0, 8),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Gap(TSizes.spaceBtwItems),
            Container(
              padding: const EdgeInsets.all(
                TSizes.defaultSpace / 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: TColors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'scrap items',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Gap(20),
                  ListView.separated(
                    separatorBuilder: (context, index) =>
                        const Gap(TSizes.spaceBtwItems),
                    shrinkWrap: true,
                    itemCount: item.items.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final scrap = item.items[index];
                      final msg = scrap.unitType == UnitType.kg
                          ? "${scrap.kg}/kg"
                          : "${scrap.pcs}/pcs";
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            scrap.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          Text(
                            msg,
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const Gap(TSizes.spaceBtwItems),
            Container(
              padding: const EdgeInsets.all(
                TSizes.defaultSpace / 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: TColors.white,
              ),
              child: Row(
                children: [
                  const Icon(Iconsax.location_tick),
                  const Gap(TSizes.spaceBtwItems),
                  Column(
                    children: [
                      Text(
                        "Address - Home",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Gap(8),
                      Text(
                        "${item.address}",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Gap(TSizes.spaceBtwItems),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "\t\t\t\t\t\tBill details",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            if (item.pickupStatus == PickupStatus.COMPLETED)
              FittedBox(
                child: DataTable(
                  border: TableBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.08);
                    }
                    return Colors.green.shade100; // Use the default value.
                  }),
                  columns: [
                    DataColumn(
                      label: Text(
                        "Material",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Rate",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Qty",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Amount",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                  rows: item.items
                      .map((item) => DataRow(cells: [
                            DataCell(Text(
                              item.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            )),
                            DataCell(
                              Text(
                                "${item.cost}",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            DataCell(Text(
                              item.unitType == UnitType.kg
                                  ? "${item.kg}/kg"
                                  : "${item.pcs}/pieces",
                              style: Theme.of(context).textTheme.titleMedium,
                            )),
                            DataCell(Text(
                              (item.cost * item.kg).toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                            )),
                          ]))
                      .toList(),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "₹${item.totalCost}",
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
