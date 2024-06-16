import 'package:final_year_project/data/repo/booking/booking.dart';
import 'package:final_year_project/features/home/controller/user_controller.dart';
import 'package:get/get.dart';

import '../../../utils/popups/loaders.dart';
import '../models/picup_request_model.dart';

class PickupController extends GetxController {
  final UserController userController = UserController.instance;
  BookingRepository bookingRepo = BookingRepository.instance;

  @override
  void onInit() {
    super.onInit();
    getScheduleScrapsOfUser();
  }

  var pickupRequestList = <PickupRequestModel>[].obs;
  Future<void> getScheduleScrapsOfUser() async {
    try {
      final data =
          await bookingRepo.getScheduleScrapsById(userController.user.value.id);
      pickupRequestList.value = data;
    } catch (e) {
      TFullScreenLoader.errorSnackBar(
          title: "error while fetching requests", message: e.toString());
    }
  }
}
