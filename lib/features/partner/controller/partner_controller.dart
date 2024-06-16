import 'package:final_year_project/data/repo/auth/auth_repository.dart';
import 'package:final_year_project/data/repo/partner/partner_repository.dart';
import 'package:final_year_project/features/partner/model/partner_model.dart';
import 'package:final_year_project/utils/popups/loaders.dart';
import 'package:get/get.dart';

class PartnerController extends GetxController {
  // void logu

  static PartnerController get instance => Get.find();

  final authRepository = AuthenticationRepository.instance;
  final partnerRepository = Get.put(PartnerRepository());

  Rx<PartnerModel> partner = PartnerModel.empty().obs;
  var profileLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
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

  void logout() async {
    try {
      await authRepository.logout();
    } catch (e) {
      TFullScreenLoader.errorSnackBar(
          title: "error in ", message: e.toString());
    }
  }
}
