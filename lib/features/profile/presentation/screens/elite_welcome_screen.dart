import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../features/cart/presentation/widgets/cart_gold_button.dart';
import '../../../../features/cart/presentation/widgets/checkout_footer.dart';
import '../../controllers/profile_controller.dart';

class EliteWelcomeScreen extends StatelessWidget {
  const EliteWelcomeScreen({super.key});

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
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 24.h),
                  children: [
                    Center(
                      child: Container(
                        width: 96.w,
                        height: 96.w,
                        decoration: BoxDecoration(
                          color: AppColors.burgundy,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.burgundy100,
                            width: 8,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          IconPath.eliteWelcomeCrown,
                          width: 40.w,
                          height: 40.w,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          IconPath.eliteWelcomeCheck,
                          width: 16.w,
                          height: 16.w,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "You're officially Elite",
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            color: AppColors.goldDeep,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Welcome to The Yard Elite',
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
                      'Your perks are live. Shipping credits refresh each billing cycle automatically.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: AppColors.black400,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(17.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: AppColors.black50),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 32.w,
                                height: 32.w,
                                decoration: BoxDecoration(
                                  color: AppColors.burgundy,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  IconPath.eliteWelcomeCrownSm,
                                  width: 16.w,
                                  height: 16.w,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Obx(
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      c.planName,
                                      style: GoogleFonts.hankenGrotesk(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2,
                                        color: AppColors.textBody,
                                      ),
                                    ),
                                    Text(
                                      c.planPrice,
                                      style: GoogleFonts.hankenGrotesk(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5,
                                        color: AppColors.black300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          const Divider(height: 1, color: AppColors.black50),
                          SizedBox(height: 12.h),
                          const _Kv(
                            label: 'Member since',
                            value: 'Jul 21, 2026',
                          ),
                          SizedBox(height: 12.h),
                          const _Kv(
                            label: 'Next billing',
                            value: 'Aug 21, 2026',
                          ),
                          SizedBox(height: 12.h),
                          const _Kv(
                            label: 'Shipping credits',
                            value: '\$10.00 / cycle',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CheckoutFooter(
                child: CartGoldButton(
                  label: 'Start Shopping',
                  onTap: c.startShopping,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Kv extends StatelessWidget {
  const _Kv({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.hankenGrotesk(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: AppColors.black400,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.hankenGrotesk(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            height: 1.2,
            color: AppColors.textBody,
          ),
        ),
      ],
    );
  }
}
