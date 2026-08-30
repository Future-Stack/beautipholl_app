import 'package:get/get.dart';

import '../../../core/services/storage_service.dart';
import '../../../core/utils/constants/icon_path.dart';
import '../../../routes/app_routes.dart';
import '../models/interest_model.dart';

class InterestController extends GetxController {
  final selected = <String>{}.obs;

  final items = const [
    InterestModel(id: 'apparel', label: 'Apparel', icon: IconPath.shirt),
    InterestModel(
      id: 'accessories',
      label: 'Accessories',
      icon: IconPath.accessories,
    ),
    InterestModel(
      id: 'jewellery',
      label: 'Jewellery',
      icon: IconPath.jewellery,
    ),
    InterestModel(id: 'shoes', label: 'Shoes', icon: IconPath.shoes),
    InterestModel(
      id: 'homeDecor',
      label: 'Home Decor',
      icon: IconPath.homeDecor,
    ),
    InterestModel(id: 'bags', label: 'Bags', icon: IconPath.bags),
    InterestModel(id: 'crossing', label: 'Crossing', icon: IconPath.crossing),
    InterestModel(id: 'founder', label: 'Founder Day', icon: IconPath.shirt),
    InterestModel(
      id: 'homecoming',
      label: 'Homecoming',
      icon: IconPath.homecoming,
    ),
    InterestModel(id: 'stepShow', label: 'Step Show', icon: IconPath.other),
    InterestModel(id: 'gifts', label: 'Gifts', icon: IconPath.gifts),
    InterestModel(id: 'other', label: 'Other', icon: IconPath.other),
  ];

  @override
  void onInit() {
    super.onInit();
    final saved = StorageService.interests;
    selected.addAll(
      saved.isEmpty ? const ['apparel', 'accessories', 'gifts'] : saved,
    );
  }

  bool isSelected(String id) => selected.contains(id);

  void toggle(String id) {
    if (selected.contains(id)) {
      selected.remove(id);
    } else {
      selected.add(id);
    }
    selected.refresh();
  }

  Future<void> continueNext() async {
    await StorageService.setInterests(selected.toList());
    Get.toNamed(AppRoute.notificationScreen);
  }
}
