import 'package:final_year_project/data/repo/auth/auth_repository.dart';
import 'package:final_year_project/data/repo/partner/partner_repository.dart';
import 'package:final_year_project/features/partner/controller/partner_controller.dart';
import 'package:final_year_project/features/partner/screens/manage/manage_screen.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:final_year_project/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/custom_enums.dart';
import '../../home/models/scrap_item.dart';

class TMaterials {
  static List<ScrapItem> materials = [
    ScrapItem(id: 1, title: "Newspaper", categoryType: Categories.Paper),
    ScrapItem(id: 2, title: "Magazines", categoryType: Categories.Paper),
    ScrapItem(id: 3, title: "Cardboard", categoryType: Categories.Paper),
    ScrapItem(id: 4, title: "Office Paper", categoryType: Categories.Paper),
    ScrapItem(id: 5, title: "Books", categoryType: Categories.Paper),
    ScrapItem(
        id: 6, title: "Paperboard Packaging", categoryType: Categories.Paper),
    ScrapItem(id: 7, title: "Soft Plastic", categoryType: Categories.PLASTIC),
    ScrapItem(
        id: 8,
        title: "Plastic Jar (15ltr)",
        categoryType: Categories.PLASTIC,
        unitType: UnitType.pcs),
    ScrapItem(id: 9, title: "Polythene mix", categoryType: Categories.PLASTIC),
    ScrapItem(
        id: 10,
        title: "Plastic Jar (5ltr)",
        categoryType: Categories.PLASTIC,
        unitType: UnitType.pcs),
    ScrapItem(
        id: 12, title: "Water/oil covers", categoryType: Categories.PLASTIC),
    ScrapItem(id: 13, title: "Aluminum Cans", categoryType: Categories.METALS),
    ScrapItem(id: 14, title: "Copper", categoryType: Categories.METALS),
    ScrapItem(id: 15, title: "Steel Scrap", categoryType: Categories.METALS),
    ScrapItem(id: 16, title: "Brass", categoryType: Categories.METALS),
    ScrapItem(id: 17, title: "Iron", categoryType: Categories.METALS),
    ScrapItem(id: 19, title: "E-Waste", categoryType: Categories.E_WASTE),
    ScrapItem(
        id: 27,
        title: "Glass Bottles",
        categoryType: Categories.Other,
        unitType: UnitType.pcs),
    ScrapItem(id: 28, title: "Used Clothes", categoryType: Categories.Other),
    ScrapItem(id: 29, title: "Used Tires", categoryType: Categories.Other),
    ScrapItem(id: 30, title: "Cooking Oil", categoryType: Categories.Other),
    ScrapItem(id: 31, title: "Batteries", categoryType: Categories.Other)
  ];
}

class MaterialManageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initializePartnerScrapItems();
  }

  final RxList<ScrapItem> partnerScrapItems = <ScrapItem>[].obs;

  void initializePartnerScrapItems() async {
    final data = await PartnerRepository.instance.fetchUserDetails();
    partnerScrapItems.value = data.scrapItems;
  }

  static MaterialManageController get instance => Get.find();
  final TextEditingController rate = TextEditingController();

  var selectedMaterialTitle = "Select".obs;
  var selectedMaterialItem = TMaterials.materials[0].obs;
  final partnerRepository = Get.put(PartnerRepository());

  void updateSelectedMaterial(String title, int index) {
    selectedMaterialTitle.value = title;
    selectedMaterialItem.value = TMaterials.materials[index];
  }

  void addMaterialToPartner() async {
    try {
      if (selectedMaterialTitle == "Select") {
        TFullScreenLoader.warningSnackBar(title: "select material");
        return;
      }
      if (rate.text.isEmpty) {
        TFullScreenLoader.warningSnackBar(title: "select rate");
        return;
      }
      TFullScreenLoader.openLoadingPage(
          "Adding item ", TImages.dockerAnimation);

      bool itemExists = false;

      // Check if the item already exists
      for (int i = 0; i < partnerScrapItems.length; i++) {
        if (partnerScrapItems[i].id == selectedMaterialItem.value.id) {
          // Update the existing item's cost
          partnerScrapItems[i] = partnerScrapItems[i]
              .copyWith(cost: double.parse(rate.text.trim()));
          itemExists = true;
          break;
        }
      }

      if (!itemExists) {
        // Add the new item if it doesn't exist
        partnerScrapItems.add(selectedMaterialItem.value
            .copyWith(cost: double.parse(rate.text.trim())));
      }
      var previousScrapItems =
          partnerScrapItems.value.map((e) => e.toMap()).toList();

      Map<String, dynamic> scrapItems = {
        'scrapItems': previousScrapItems,
      };
      await partnerRepository.updateSingleField(scrapItems);

      TFullScreenLoader.stopLoading();

      // Get.offAll(() => const ());
      Get.back();
      TFullScreenLoader.successSnackBar(
          title: "Item added ", message: "Material added successfully");
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnackBar(title: e.toString());
    } finally {
      selectedMaterialTitle.value = "select";
      selectedMaterialItem.value = TMaterials.materials[0];
      rate.clear();
    }
  }
}
