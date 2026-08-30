import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/storage_service.dart';
import '../../../core/utils/constants/app_texts.dart';
import '../../../core/utils/constants/image_path.dart';
import '../../../routes/app_routes.dart';
import '../models/onboarding_model.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentIndex = 0.obs;

  final List<OnboardingModel> pages = const [
    OnboardingModel(
      image: ImagePath.onboarding1,
      title: AppText.onboardingTitle1,
      subtitle: AppText.onboardingSubtitle1,
      imageWidth: 279,
      imageHeight: 365,
      imageTop: 273,
      imageRotation: 0,
      titleWidth: 370,
      greekLeft: 11,
      greekTop: 239,
      showSkip: true,
    ),
    OnboardingModel(
      image: ImagePath.onboarding2,
      title: AppText.onboardingTitle2,
      subtitle: AppText.onboardingSubtitle2,
      imageWidth: 266,
      imageHeight: 267,
      imageTop: 340,
      imageRotation: -6.64,
      titleWidth: 370,
      greekLeft: 11,
      greekTop: 239,
      showSkip: true,
    ),
    OnboardingModel(
      image: ImagePath.onboarding3,
      title: AppText.onboardingTitle3,
      subtitle: AppText.onboardingSubtitle3,
      imageWidth: 266,
      imageHeight: 267,
      imageTop: 341,
      imageRotation: -5.84,
      titleWidth: 291,
      greekLeft: 54.91,
      greekTop: 257,
      showSkip: false,
    ),
  ];

  bool get isLastPage => currentIndex.value == pages.length - 1;

  OnboardingModel get currentPage => pages[currentIndex.value];

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void nextPage() {
    if (isLastPage) {
      completeOnboarding();
      return;
    }

    pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void skipOnboarding() {
    completeOnboarding();
  }

  Future<void> completeOnboarding() async {
    await StorageService.setOnboardingSeen();
    Get.offAllNamed(AppRoute.loginScreen);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
