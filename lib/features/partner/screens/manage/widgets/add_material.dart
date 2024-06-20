import 'package:final_year_project/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:final_year_project/features/home/models/scrap_item.dart';
import 'package:final_year_project/features/partner/controller/manage_material_controller.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../core/custom_enums.dart';
import '../../../../../utils/constants/colors.dart';

class AddMaterialScreen extends StatelessWidget {
  const AddMaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MaterialManageController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add materials"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select material type"),
            const Gap(12),
            RoundedContainer(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              showBorder: true,
              borderColor: Colors.black,
              radius: 12,
              child: GestureDetector(
                onTap: () {
                  showMaterialModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding:
                              const EdgeInsets.all(TSizes.defaultSpace / 2),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Select material",
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
                                    itemCount: TMaterials.materials.length,
                                    itemBuilder: (context, index) {
                                      final item = TMaterials.materials[index];
                                      return MaterialCard(
                                        index: index,
                                        item: item,
                                      );
                                    }),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() =>
                        Text(controller.selectedMaterialTitle.toString())),
                    const Icon(CupertinoIcons.chevron_down),
                  ],
                ),
              ),
            ),
            const Gap(18),
            const Text("Unit type"),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Text(
                        'Kilogram',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      leading: Radio<UnitType>(
                        activeColor: TColors.primary,
                        value: UnitType.kg,
                        groupValue:
                            controller.selectedMaterialItem.value.unitType,
                        onChanged: (UnitType? value) {
                          // setState(() {
                          // _character = value;
                          // });
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Text(
                        'Pieces',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      leading: Radio<UnitType>(
                        activeColor: TColors.primary,
                        value: UnitType.pcs,
                        groupValue:
                            controller.selectedMaterialItem.value.unitType,
                        onChanged: (UnitType? value) {
                          // setState(() {
                          //   _character = value;
                          // });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() => Text(
                controller.selectedMaterialItem.value.unitType == UnitType.kg
                    ? 'Rate per kg'
                    : "Rate per piece")),
            const Gap(18),
            TextFormField(
              controller: controller.rate,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(label: Icon(Icons.currency_rupee)),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () => controller.addMaterialToPartner(),
          child: const Text("Save"),
        ),
      ),
    );
  }

  // Future<dynamic> modelsheet(BuildContext context) {
  //   return showMaterialModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Padding(
  //           padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
  //           child: SingleChildScrollView(
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       "Select material",
  //                       style: Theme.of(context).textTheme.headlineMedium,
  //                     ),
  //                     IconButton(
  //                         onPressed: () => Navigator.of(context).pop(),
  //                         icon: const Icon(Icons.close))
  //                   ],
  //                 ),
  //                 const SizedBox(
  //                   height: TSizes.spaceBtwItems,
  //                 ),
  //                 ListView.separated(
  //                     physics: const NeverScrollableScrollPhysics(),
  //                     separatorBuilder: (context, index) => const SizedBox(
  //                           height: TSizes.spaceBtwItems,
  //                         ),
  //                     shrinkWrap: true,
  //                     itemCount: TMaterials.materials.length,
  //                     itemBuilder: (context, index) {
  //                       final item = TMaterials.materials[index];
  //                       return MaterialCard(
  //                         selected:,
  //                         item: item,
  //                       );
  //                     }),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
}

class MaterialCard extends StatelessWidget {
  const MaterialCard({
    super.key,
    required this.item,
    required this.index,
  });

  final ScrapItem item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = MaterialManageController.instance;
    final selected = controller.selectedMaterialTitle.value == item.title;
    return ListTile(
      onTap: () {
        controller.updateSelectedMaterial(item.title, index);
        Navigator.pop(context);
      },
      tileColor: selected ? TColors.primary.withOpacity(0.2) : null,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: selected ? TColors.primary : TColors.grey),
          borderRadius: BorderRadius.circular(12)),
      title: Text(item.title),
      subtitle: Text(item.categoryType.displayName),
      trailing: RoundedContainer(
        height: 30,
        width: 30,
        borderColor: selected ? TColors.primary : TColors.black,
        showBorder: true,
        backgroundColor:
            selected ? TColors.primary.withOpacity(0.2) : TColors.white,
        child: RoundedContainer(
          margin: const EdgeInsets.all(2),
          height: 30,
          width: 30,
          backgroundColor: selected ? TColors.primary : TColors.white,
        ),
      ),
    );
  }
}
