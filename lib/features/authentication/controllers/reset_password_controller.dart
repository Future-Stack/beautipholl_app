import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../presentation/widgets/auth_input.dart';

class ResetPasswordController extends GetxController {
  final contactController = TextEditingController();

  void sendCode() {
    if (contactController.text.trim().isEmpty) {
      showAuthMessage(
        'Enter the email or phone number linked to your account.',
      );
      return;
    }
    Get.toNamed(AppRoute.otpVerifyScreen, arguments: {'from': 'reset'});
  }

  @override
  void onClose() {
    contactController.dispose();
    super.onClose();
  }
}
