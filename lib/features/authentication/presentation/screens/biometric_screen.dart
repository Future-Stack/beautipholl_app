import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../controllers/biometric_controller.dart';
import '../widgets/auth_pinned_scaffold.dart';
import '../widgets/auth_primary_button.dart';

class BiometricScreen extends StatelessWidget {
  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<BiometricController>();

    return AuthPinnedScaffold(
      backgroundColor: Colors.black,
      header: Column(
        children: [
          Text(
            'One more step!',
            textAlign: TextAlign.center,
            style: GoogleFonts.marcellus(
              fontSize: 32.sp,
              height: 1.2,
              color: AppColors.gold,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Enable face ID for faster, secure access to your account.',
            textAlign: TextAlign.center,
            style: GoogleFonts.hankenGrotesk(
              fontSize: 16.sp,
              height: 1.6,
              color: AppColors.burgundy100,
            ),
          ),
          SizedBox(height: 64.h),
          Container(
            padding: EdgeInsets.all(32.w),
            decoration: BoxDecoration(
              color: AppColors.black900,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                SvgPicture.asset(IconPath.faceId, width: 72.w, height: 72.w),
                SizedBox(height: 5.h),
                Text(
                  'Face ID',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      footer: Column(
        children: [
          Obx(
            () => AuthPrimaryButton(
              label: 'Enable Face ID',
              filled: true,
              enabled: !c.isBusy.value,
              onTap: c.enable,
            ),
          ),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: c.later,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enable later',
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      color: AppColors.gold,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  SvgPicture.asset(
                    IconPath.arrowSmall,
                    width: 15.w,
                    height: 8.h,
                    colorFilter: const ColorFilter.mode(
                      AppColors.gold,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(IconPath.lock, width: 24.w, height: 24.w),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  'Your data is safe and secure with us.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 12.sp,
                    height: 1.4,
                    color: AppColors.black100,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
