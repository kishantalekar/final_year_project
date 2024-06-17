import 'package:final_year_project/features/partner/controller/manage_material_controller.dart';
import 'package:final_year_project/features/partner/screens/manage/widgets/add_material.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MaterialsManageScreen extends StatefulWidget {
  const MaterialsManageScreen({super.key});

  @override
  State<MaterialsManageScreen> createState() => _MaterialsManageScreenState();
}

class _MaterialsManageScreenState extends State<MaterialsManageScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MaterialManageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("My materials"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                        '${controller.partnerScrapItems.value.length} materials ',
                        style: Theme.of(context).textTheme.bodyLarge!),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => const AddMaterialScreen()),
                    child: Row(
                      children: [
                        Text(
                          "Add material",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: TColors.primary),
                        ),
                        const Gap(10),
                        const Icon(
                          Icons.add_circle,
                          color: TColors.primary,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const Gap(18),
              Obx(
                () => ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.partnerScrapItems.value.length,
                    separatorBuilder: (context, index) => const Gap(10),
                    itemBuilder: (context, index) {
                      final item = controller.partnerScrapItems.value[index];
                      return ListTile(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: TColors.grey),
                            borderRadius: BorderRadius.circular(12)),
                        title: Text(item.title),
                        subtitle: Text(item.categoryType.name),
                        trailing: Text(" ${item.cost}/${item.unitType.name}"),
                      );
                    }),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
