import 'package:final_year_project/data/repo/auth/auth_repository.dart';
import 'package:final_year_project/data/repo/booking/booking.dart';
import 'package:final_year_project/data/repo/partner/partner_repository.dart';
import 'package:final_year_project/features/home/models/picup_request_model.dart';
import 'package:final_year_project/features/home/models/scrap_item.dart';
import 'package:final_year_project/features/partner/model/partner_model.dart';
import 'package:final_year_project/features/partner/partner_navigation_menu.dart';
import 'package:final_year_project/utils/constants/enums.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:final_year_project/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../core/custom_enums.dart';

class PartnerController extends GetxController {
  // void logu

  static PartnerController get instance => Get.find();

  final authRepository = AuthenticationRepository.instance;
  final partnerRepository = Get.put(PartnerRepository());
  final bookingRepository = Get.put(BookingRepository());

  Rx<PartnerModel> partner = PartnerModel.empty().obs;
  var profileLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
    getAllSchedules();
  }

  Future<void> fetchUserDetails() async {
    try {
      profileLoading.value = true;
      final data = await partnerRepository.fetchUserDetails();

      partner.value = data;
    } catch (e) {
      partner(PartnerModel.empty());
      TFullScreenLoader.errorSnackBar(title: e);
    } finally {
      profileLoading.value = false;
    }
  }

  var allPickupSchedules = <PickupRequestModel>[].obs;

  RxList<PickupRequestModel> get pickupsPending => allPickupSchedules
      .where((element) => element.pickupStatus == PickupStatus.PENDING)
      .toList()
      .obs;
  RxList<PickupRequestModel> get pickupsOngoing => allPickupSchedules
      .where((element) => element.pickupStatus == PickupStatus.ACCEPTED)
      .toList()
      .obs;
  RxList<PickupRequestModel> get pickupsCompleted => allPickupSchedules
      .where((element) => element.pickupStatus == PickupStatus.COMPLETED)
      .toList()
      .obs;
  RxList<PickupRequestModel> get pickupsOnRejected => allPickupSchedules
      .where((element) => element.pickupStatus == PickupStatus.REJECTED)
      .toList()
      .obs;
  RxList<PickupRequestModel> get pickupsCancelled => allPickupSchedules
      .where((element) => element.pickupStatus == PickupStatus.CANCELLED)
      .toList()
      .obs;

  RxList<PickupRequestModel> get filteredPickups {
    switch (selectedIndex.value) {
      case 1:
        return pickupsCompleted;
      case 2:
        return pickupsOnRejected;
      case 3:
        return pickupsCancelled;
      default:
        return [...pickupsCompleted, ...pickupsOnRejected, ...pickupsCancelled]
            .obs;
    }
  }

  RxInt selectedIndex = 0.obs;

  Future<void> getAllSchedules() async {
    try {
      final data =
          await bookingRepository.getPickupsForPartner(partner.value.id);

      allPickupSchedules.value = data;
    } catch (e) {
      TFullScreenLoader.errorSnackBar(title: e.toString());
    }
  }

  Future<void> updatePickStatus(
      PickupRequestModel request, PickupStatus status) async {
    try {
      TFullScreenLoader.openLoadingPage("", TImages.dockerAnimation);
      await bookingRepository.updatePickupStatus(request.id, status);
      // Update status in the local list
      final index =
          allPickupSchedules.indexWhere((item) => item.id == request.id);
      if (index != -1) {
        final updatedRequest = request.copyWith(pickupStatus: status);
        allPickupSchedules[index] = updatedRequest;
      }
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.successSnackBar(
          title: "${status.name} successfully",
          message: "Please check it out.");
      Get.to(() => PartnerNavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnackBar(title: e.toString());
    }
  }

  var paymentMethod = PaymentMethods.cod.obs;
  void updatePaymentMethod(PaymentMethods? val) {
    if (val != null) paymentMethod.value = val;
  }

  Future<void> completePickup(PickupRequestModel request) async {
    try {
      TFullScreenLoader.openLoadingPage("Waiting...", TImages.dockerAnimation);
      final index =
          allPickupSchedules.indexWhere((item) => item.id == request.id);
      var updatedRequest =
          request.copyWith(pickupStatus: PickupStatus.COMPLETED);
      await bookingRepository.updatePickupDetails(updatedRequest);

      allPickupSchedules[index] = updatedRequest;

      TFullScreenLoader.stopLoading();
      TFullScreenLoader.successSnackBar(
          title: "completed successfully", message: "Please check it out.");
      Get.offAll(() => PartnerNavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnackBar(title: e.toString());
    }
  }

  Future<void> paymentWithRazorPay(PickupRequestModel request) async {
    try {
      TFullScreenLoader.openLoadingPage("Waiting...", TImages.dockerAnimation);
      final index =
          allPickupSchedules.indexWhere((item) => item.id == request.id);
      var updatedRequest =
          request.copyWith(pickupStatus: PickupStatus.COMPLETED);
      await bookingRepository.updatePickupDetails(updatedRequest);

      allPickupSchedules[index] = updatedRequest;

      TFullScreenLoader.stopLoading();
      TFullScreenLoader.successSnackBar(
          title: "completed successfully", message: "Please check it out.");
      Get.offAll(() => PartnerNavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnackBar(title: e.toString());
    }
  }

  PickupRequestModel updatedScrapList(PickupRequestModel request) {
    List<ScrapItem> partnerScrapItems = partner.value.scrapItems;
    List<ScrapItem> customersScrapItems = request.items;

    // Calculate resultant scrap list with cost

    List<ScrapItem> resultantScrapList = [];
    double totalCost = 0;
    for (var customerItem in customersScrapItems) {
      var partnerItem = partnerScrapItems.firstWhere(
          (item) => item.id == customerItem.id,
          orElse: () => ScrapItem(
              id: customerItem.id,
              title: customerItem.title,
              categoryType: customerItem.categoryType,
              cost: 0,
              kg: customerItem.kg,
              pcs: customerItem.pcs));

      double cost = 0;
      if (customerItem.unitType == UnitType.kg) {
        cost = partnerItem.cost * customerItem.kg;
      } else {
        cost = partnerItem.cost * customerItem.pcs;
      }

      totalCost += cost;
      resultantScrapList.add(ScrapItem(
          id: customerItem.id,
          title: customerItem.title,
          categoryType: customerItem.categoryType,
          cost: cost,
          kg: customerItem.kg,
          pcs: customerItem.pcs));
    }

    return request.copyWith(
        items: resultantScrapList, totalCost: totalCost.floorToDouble());
  }

  void logout() async {
    try {
      await authRepository.logout();
    } catch (e) {
      TFullScreenLoader.errorSnackBar(
          title: "error in ", message: e.toString());
    }
  }
}
