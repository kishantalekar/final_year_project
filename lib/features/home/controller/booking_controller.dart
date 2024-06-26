import 'package:final_year_project/core/custom_enums.dart';
import 'package:final_year_project/data/repo/booking/booking.dart';
import 'package:final_year_project/data/repo/partner/partner_repository.dart';
import 'package:final_year_project/features/home/controller/user_controller.dart';
import 'package:final_year_project/features/home/models/picup_request_model.dart';
import 'package:final_year_project/features/home/models/scrap_item.dart';
import 'package:final_year_project/features/home/screens/home_screens.dart';
import 'package:final_year_project/features/partner/model/partner_model.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:final_year_project/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class BookingController extends GetxController {
  static BookingController get instance => Get.find();

  final UserController userController = UserController.instance;
  final BookingRepository bookingRepo = Get.put(BookingRepository());
  final TextEditingController addressController = TextEditingController();

  var selectedCategories = <Categories>[].obs;
  var selectedBookingDate = DateTime.now()
      .add(
        const Duration(hours: 24),
      )
      .obs;
  var selectedSubCategories = <ScrapItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllPickupPartners();
  }

  void toggleCategories(Categories val) {
    if (selectedCategories.contains(val)) {
      selectedCategories.remove(val);
    } else {
      selectedCategories.add(val);
    }
  }

  void addSubCategories(ScrapItem item) {
    int index =
        selectedSubCategories.indexWhere((element) => element.id == item.id);

    if (index != -1) {
      var existingItem = selectedSubCategories[index];
      var updatedItem = existingItem.copyWith(
        kg: item.unitType == UnitType.kg
            ? existingItem.kg + 0.5
            : existingItem.kg,
        pcs: item.unitType == UnitType.pcs
            ? existingItem.pcs + 1
            : existingItem.pcs,
      );
      // selectedSubCategories.insert(index, updatedItem);
      selectedSubCategories[index] = updatedItem;
    } else {
      var newItem = item.copyWith(
        kg: item.unitType == UnitType.kg ? item.kg + 0.5 : item.kg,
        pcs: item.unitType == UnitType.pcs ? item.pcs + 1 : item.pcs,
      );
      selectedSubCategories.add(newItem);
    }
    selectedSubCategories.refresh();
  }

  void decreaseSubCategories(ScrapItem item) {
    int index =
        selectedSubCategories.indexWhere((element) => element.id == item.id);

    if (index != -1) {
      var existingItem = selectedSubCategories[index];
      var updatedItem = existingItem.copyWith(
        kg: item.unitType == UnitType.kg
            ? existingItem.kg - 0.5
            : existingItem.kg,
        pcs: item.unitType == UnitType.pcs
            ? existingItem.pcs - 1
            : existingItem.pcs,
      );

      if ((updatedItem.unitType == UnitType.kg && updatedItem.kg <= 0) ||
          (updatedItem.unitType == UnitType.pcs && updatedItem.pcs <= 0)) {
        selectedSubCategories.removeAt(index);
      } else {
        selectedSubCategories[index] = updatedItem;
      }
      selectedSubCategories.refresh();
    }
  }

  void ScheduleScrapCollection(PartnerModel partner) async {
    try {
      TFullScreenLoader.openLoadingPage(
          "Scheduling Your requests", TImages.dockerAnimation);

      PickupRequestModel request = PickupRequestModel(
        id: "",
        items: List<ScrapItem>.from(selectedSubCategories),
        scheduledTime: selectedBookingDate.value,
        address: userController.user.value.address + addressController.text,
        userId: userController.user.value.id,
        email: userController.user.value.email,
        partnerId: partner.id,
        username: userController.user.value.username,
        partnername: partner.username,
        pickupTime: selectedBookingDate.value,
        number: userController.user.value.phoneNumber,
      );
      await bookingRepo.schedulePickupRequest(request);
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.successSnackBar(title: "Success schedule your pickup");
      selectedSubCategories.value = [];
      selectedCategories.value = [];
      selectedBookingDate.value = DateTime.now();
      Get.to(() => const HomeScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnackBar(
          title: 'Error while schedule ', message: e.toString());
    } finally {
      addressController.clear();
    }
  }

  var pickupRequestList = <PickupRequestModel>[].obs;
  void GetScheduleScrapsOfUser() async {
    try {
      final data =
          await bookingRepo.getScheduleScrapsById(userController.user.value.id);
      pickupRequestList.value = data;
    } catch (e) {
      TFullScreenLoader.errorSnackBar(
          title: "error while fetching requests", message: e.toString());
    }
  }

  final partnerRepository = Get.put(PartnerRepository());
  var allPickupPartners = <PartnerModel>[].obs;
  void getAllPickupPartners() async {
    try {
      final data = await partnerRepository.fetchAllPartners();
      allPickupPartners.value = data;
      print(allPickupPartners.value);
    } catch (e) {
      TFullScreenLoader.errorSnackBar(
          title: "error while fetching requests", message: e.toString());
    }
  }

  RxList<PartnerModel> get allPickupsPatnerGetter => allPickupPartners;
}
