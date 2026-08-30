import 'package:get/get.dart';

import '../../../core/services/storage_service.dart';
import '../../../routes/app_routes.dart';

class NotificationPrefsController extends GetxController {
  final drops = true.obs;
  final sales = true.obs;
  final orders = true.obs;
  final community = true.obs;

  @override
  void onInit() {
    super.onInit();
    drops.value = StorageService.notifDrops;
    sales.value = StorageService.notifSales;
    orders.value = StorageService.notifOrders;
    community.value = StorageService.notifCommunity;
  }

  Future<void> continueNext() async {
    await StorageService.setNotificationPrefs(
      drops: drops.value,
      sales: sales.value,
      orders: orders.value,
      community: community.value,
    );
    final args = Get.arguments;
    final fromProfile = args is Map && args['fromProfile'] == true;
    if (fromProfile) {
      Get.back();
      return;
    }
    Get.toNamed(AppRoute.biometricScreen);
  }
}
