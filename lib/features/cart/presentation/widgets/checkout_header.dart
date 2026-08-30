import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import 'checkout_stepper.dart';

class CheckoutHeader extends StatelessWidget {
  const CheckoutHeader({
    super.key,
    required this.title,
    required this.activeStep,
  });

  final String title;
  final int activeStep;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.burgundy,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: SvgPicture.asset(
                        IconPath.shopArrowLeft,
                        width: 24.w,
                        height: 24.w,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.marcellus(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              CheckoutStepper(activeStep: activeStep),
            ],
          ),
        ),
      ),
    );
  }
}
