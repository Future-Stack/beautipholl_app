import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../presentation/widgets/auth_input.dart';

class OtpController extends GetxController {
  final boxes = List.generate(6, (_) => TextEditingController());
  final focusNodes = List.generate(6, (_) => FocusNode());
  final seconds = 43.obs;
  late final String from;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    from = (Get.arguments is Map ? Get.arguments['from'] : null) ?? 'signup';
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    seconds.value = 43;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds.value > 0) seconds.value--;
    });
  }

  void onChanged(int index, String value) {
    if (value.length > 1) {
      boxes[index].text = value.characters.last;
      boxes[index].selection = TextSelection.collapsed(offset: 1);
    }
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
    if (index == 5 && value.isNotEmpty && _code.length == 6) {
      verify();
    }
  }

  String get _code => boxes.map((b) => b.text).join();

  String get timerLabel {
    if (seconds.value <= 0) return 'Resend';
    final m = (seconds.value ~/ 60).toString().padLeft(2, '0');
    final s = (seconds.value % 60).toString().padLeft(2, '0');
    return 'Resend in $m:$s';
  }

  void resend() {
    if (seconds.value > 0) return;
    for (final box in boxes) {
      box.clear();
    }
    focusNodes.first.requestFocus();
    _startTimer();
  }

  void verify() {
    if (_code.length != 6) {
      showAuthMessage('Enter the 6-digit code.');
      return;
    }
    if (from == 'reset') {
      Get.toNamed(AppRoute.setPasswordScreen);
    } else {
      Get.toNamed(AppRoute.organizationScreen);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (final c in boxes) {
      c.dispose();
    }
    for (final n in focusNodes) {
      n.dispose();
    }
    super.onClose();
  }
}
