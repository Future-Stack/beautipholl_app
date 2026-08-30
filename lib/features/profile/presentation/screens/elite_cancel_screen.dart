import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../features/cart/presentation/widgets/cart_gold_button.dart';
import '../../controllers/profile_controller.dart';

class EliteCancelScreen extends StatelessWidget {
  const EliteCancelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 16.h),
                  child: Column(
                    children: [
                      Container(
                        width: 96.w,
                        height: 96.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.black50,
                            width: 6,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          IconPath.eliteCancelWarn,
                          width: 32.w,
                          height: 32.w,
                        ),
                      ),
                      SizedBox(height: 48.h),
                      Text(
                        'Cancel Elite Membership?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.marcellus(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          color: AppColors.textBody,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'If you cancel, your Elite benefits shipping credits, early access, and member discounts remain active until the end of your current billing period.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.hankenGrotesk(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          color: AppColors.black400,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(17.w),
                        decoration: BoxDecoration(
                          color: AppColors.burgundy50,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(color: AppColors.burgundy100),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: BoxDecoration(
                                color: AppColors.burgundy,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.burgundy100,
                                  width: 3,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                IconPath.eliteCancelCrown,
                                width: 16.w,
                                height: 16.w,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Benefits stay active through ',
                                      style: GoogleFonts.hankenGrotesk(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5,
                                        color: AppColors.textBody,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Aug 20, 2026',
                                      style: GoogleFonts.hankenGrotesk(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5,
                                        color: AppColors.burgundy400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      CartGoldButton(label: 'Keep Membership', onTap: Get.back),
                      SizedBox(height: 12.h),
                      GestureDetector(
                        onTap: c.cancelMembership,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            color: AppColors.black50,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Cancel Anyway',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                              color: AppColors.black400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
