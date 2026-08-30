import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/storage_service.dart';
import '../../../routes/app_routes.dart';
import '../presentation/widgets/auth_input.dart';

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rememberMe = true.obs;

  @override
  void onInit() {
    super.onInit();
    final saved = StorageService.rememberedEmail;
    if (saved != null && saved.isNotEmpty) {
      emailController.text = saved;
      rememberMe.value = true;
    } else {
      emailController.text = 'user@email.com';
    }
    passwordController.text = '********';
  }

  void toggleRememberMe() => rememberMe.toggle();

  Future<void> signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      showAuthMessage('Enter your email and password.');
      return;
    }
    if (rememberMe.value) {
      await StorageService.setRememberedEmail(email);
    } else {
      await StorageService.setRememberedEmail(null);
    }
    await StorageService.setLoggedIn(true);
    Get.offAllNamed(AppRoute.homeScreen);
  }

  void goToSignUp() => Get.toNamed(AppRoute.signUpScreen);

  void goToForgotPassword() => Get.toNamed(AppRoute.resetPasswordScreen);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
