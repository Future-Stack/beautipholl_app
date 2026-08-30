import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../presentation/widgets/auth_input.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController(text: 'user@email.com');
  final emailController = TextEditingController(text: 'user@email.com');
  final phoneController = TextEditingController(text: 'user@email.com');
  final passwordController = TextEditingController(text: '********');
  final confirmController = TextEditingController(text: '********');
  final agreed = true.obs;

  void toggleAgreed() => agreed.toggle();

  void submit() {
    if (!agreed.value) {
      showAuthMessage(
        'Please agree to the Terms of Service and Privacy Policy.',
      );
      return;
    }
    if (passwordController.text != confirmController.text) {
      showAuthMessage('Passwords do not match.');
      return;
    }
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty) {
      showAuthMessage('Fill in your name and email.');
      return;
    }
    Get.toNamed(AppRoute.otpVerifyScreen, arguments: {'from': 'signup'});
  }

  void goToSignIn() => Get.back();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.onClose();
  }
}
