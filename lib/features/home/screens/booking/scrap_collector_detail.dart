import 'package:final_year_project/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:final_year_project/core/custom_enums.dart';
import 'package:final_year_project/features/home/controller/booking_controller.dart';
import 'package:final_year_project/features/home/models/scrap_item.dart';
import 'package:final_year_project/features/partner/model/partner_model.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:final_year_project/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../partner/screens/manage/widgets/add_material.dart';

class ScrapCollectorDetailPage extends StatelessWidget {
  const ScrapCollectorDetailPage({super.key, required this.pickupPartner});
  final PartnerModel pickupPartner;
  @override
  Widget build(BuildContext context) {
    final controller = BookingController.instance;
    List<ScrapItem> acceptedItems = controller.selectedSubCategories
        .where((item) => pickupPartner.scrapItems
            .any((partnerItem) => partnerItem.title == item.title))
        .toList();
    bool isAccepted =
        acceptedItems.length == controller.selectedSubCategories.length;
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
              Container(
                width: 150,
                height: 120,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image(
                  image: pickupPartner.profilePicture.length > 5
                      ? NetworkImage(pickupPartner.profilePicture)
                          as ImageProvider
                      : const AssetImage(TImages.user),
                ),
              ),
              const Gap(TSizes.spaceBtwSections),
              Text(pickupPartner.username),
              const Gap(TSizes.spaceBtwSections),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.location4,
                  ),
                  const Gap(TSizes.spaceBtwItems),
                  Text(
                    pickupPartner.address,
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
                    pickupPartner.phoneNumber,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const Gap(TSizes.spaceBtwItems),
              isAccepted
                  ? Row(
                      children: [
                        SizedBox(
                          width: THelperFunctions.screenWidth()*0.7,
                          child: Text(
                              '${pickupPartner.username} accepts all items on your cart',style: TextStyle(),overflow: TextOverflow.ellipsis,),
                        ),
                        Gap(20),
                        Icon(
                          Iconsax.tick_circle,
                          color: TColors.primary,
                        )
                      ],
                    )
                  : Row(
                      children: [
                        SizedBox(
                          width: THelperFunctions.screenWidth()*0.7,
                          child: Text(
                              '${pickupPartner.username} Does not accept some items from your cart',maxLines: 2,),
                        ),
                        Gap(20),
                        Icon(
                          Iconsax.close_circle,
                          color: TColors.error,
                        )
                      ],
                    ),
              Column(
                children: [
                  TextButton(
                      onPressed: () {
                        showMaterialModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.all(
                                    TSizes.defaultSpace / 2),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "All materials",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                          ),
                                          IconButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              icon: const Icon(Icons.close))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: TSizes.spaceBtwItems,
                                      ),
                                      ListView.separated(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                                height: TSizes.spaceBtwItems,
                                              ),
                                          shrinkWrap: true,
                                          itemCount:
                                              pickupPartner.scrapItems.length,
                                          itemBuilder: (context, index) {
                                            final item =
                                                pickupPartner.scrapItems[index];
                                            final selected =
                                                acceptedItems.contains(item);
                                            final cost = item.cost;
                                            final title =
                                                "${item.title}  ₹$cost/${item.unitType.name}";
                                            return ListTile(
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: selected
                                                          ? TColors.primary
                                                          : TColors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              title: Text(title),
                                              subtitle: Text(item
                                                  .categoryType.displayName),
                                              trailing: selected
                                                  ? Icon(
                                                      Icons.close,
                                                      color: TColors.error,
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .check_circle_rounded,
                                                      color: TColors.primary,
                                                    ),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(
                        'See all the material ${pickupPartner.username} accepts',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                        ),
                      )),
                  // TextButton(
                  //     onPressed: () {},
                  //     child: const Text(
                  //       'Rates of purchase ',
                  //       style: TextStyle(
                  //         decoration: TextDecoration.underline,
                  //         fontSize: 15,
                  //       ),
                  //     )),
                ],
              ),
              const Gap(TSizes.spaceBtwSections),
              isAccepted
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () =>
                              controller.ScheduleScrapCollection(pickupPartner),
                          child: const Text("Schedule scrap collection")),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(color: TColors.error)),
                          onPressed: () {},
                          child: const Text(
                            "cannot schedule  scrap collection",
                            style: TextStyle(color: TColors.error),
                          )),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
