import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/app_texts.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../controllers/onboarding_controller.dart';
import '../../models/onboarding_model.dart';
import 'onboarding_greek_letters.dart';
import 'onboarding_next_button.dart';

class OnboardingPageBody extends StatelessWidget {
  const OnboardingPageBody({super.key, required this.page});

  final OnboardingModel page;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return ColoredBox(
      color: AppColors.maroon700,
      child: Stack(
        children: [
          OnboardingGreekLetters(left: page.greekLeft, top: page.greekTop),
          Positioned(
            left: 16.w,
            top: 48.h,
            width: page.titleWidth.w,
            child: Text(
              page.title,
              textAlign: TextAlign.left,
              style: GoogleFonts.marcellus(
                fontSize: 64.sp,
                fontWeight: FontWeight.w400,
                height: 1,
                letterSpacing: -1.92,
                color: AppColors.gold,
              ),
            ),
          ),
          if (page.showSkip)
            Positioned(
              top: 16.h,
              right: 15.w,
              child: GestureDetector(
                onTap: controller.skipOnboarding,
                child: Text(
                  AppText.skip,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    color: AppColors.maroon300,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.maroon300,
                    decorationThickness: 1,
                  ),
                ),
              ),
            ),
          Positioned(
            top: (page.imageTop - 32).h,
            left: 0,
            right: 0,
            child: Center(
              child: Transform.rotate(
                angle: page.imageRotation * 3.1415926535 / 180,
                child: Image.asset(
                  page.image,
                  width: page.imageWidth.w,
                  height: page.imageHeight.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            left: 16.w,
            width: 370.w,
            bottom: 40.h + bottomInset,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    page.subtitle,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                      color: AppColors.maroon50,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                OnboardingNextButton(onTap: controller.nextPage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
