import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../controllers/onboarding_controller.dart';
import '../widgets/onboarding_page_body.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.maroon700,
      ),
      child: Scaffold(
        backgroundColor: AppColors.maroon700,
        body: SafeArea(
          bottom: false,
          child: PageView.builder(
            controller: controller.pageController,
            itemCount: controller.pages.length,
            onPageChanged: controller.onPageChanged,
            itemBuilder: (context, index) {
              return OnboardingPageBody(page: controller.pages[index]);
            },
          ),
        ),
      ),
    );
  }
}
