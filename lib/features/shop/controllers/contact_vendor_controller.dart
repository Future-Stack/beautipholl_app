import 'package:get/get.dart';

import '../../../features/authentication/presentation/widgets/auth_input.dart';
import '../../../routes/app_routes.dart';

class ContactVendorController extends GetxController {
  final selectedTopic = Rxn<String>();

  static const topics = [
    'Product Question',
    'Sizing',
    'Customization',
    'Bulk / Chapter Order',
    'Shipping',
  ];

  void openInquiry() => Get.toNamed(AppRoute.contactInquiryScreen);

  void selectTopic(String topic) {
    selectedTopic.value = topic;
    showAuthMessage('Inquiry noted: $topic');
  }
}
