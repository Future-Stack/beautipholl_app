import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../../core/services/storage_service.dart';
import '../../../routes/app_routes.dart';
import '../presentation/widgets/auth_input.dart';

class BiometricController extends GetxController {
  final _auth = LocalAuthentication();
  final isBusy = false.obs;

  Future<void> enable() async {
    if (isBusy.value) return;
    isBusy.value = true;
    try {
      final supported = await _auth.isDeviceSupported();
      final canCheck = await _auth.canCheckBiometrics;
      if (!supported && !canCheck) {
        await StorageService.setBiometricEnabled(true);
        Get.toNamed(AppRoute.welcomeScreen);
        return;
      }

      final ok = await _auth.authenticate(
        localizedReason:
            'Enable face ID for faster, secure access to your account.',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
      if (ok) {
        await StorageService.setBiometricEnabled(true);
        Get.toNamed(AppRoute.welcomeScreen);
      }
    } on PlatformException {
      showAuthMessage(
        'Biometric authentication is not available on this device.',
      );
    } finally {
      isBusy.value = false;
    }
  }

  Future<void> later() async {
    await StorageService.setBiometricEnabled(false);
    Get.toNamed(AppRoute.welcomeScreen);
  }
}
