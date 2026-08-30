import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../presentation/widgets/auth_input.dart';

class SetPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final hidePassword = true.obs;
  final hideConfirm = true.obs;

  void updatePassword() {
    if (passwordController.text.isEmpty || confirmController.text.isEmpty) {
      showAuthMessage('Enter and confirm your new password.');
      return;
    }
    if (passwordController.text != confirmController.text) {
      showAuthMessage('Passwords do not match.');
      return;
    }
    Get.offAllNamed(AppRoute.signInScreen);
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmController.dispose();
    super.onClose();
  }
}
