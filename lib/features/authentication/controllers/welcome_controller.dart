import 'package:get/get.dart';

import '../../../core/services/storage_service.dart';
import '../../../routes/app_routes.dart';

class WelcomeController extends GetxController {
  Future<void> startShopping() async {
    await StorageService.setLoggedIn(true);
    Get.offAllNamed(AppRoute.homeScreen);
  }

  Future<void> exploreAccount() async {
    await StorageService.setLoggedIn(true);
    Get.offAllNamed(AppRoute.homeScreen);
  }
}
