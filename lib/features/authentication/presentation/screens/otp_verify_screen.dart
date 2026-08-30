import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../controllers/otp_controller.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_input.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_primary_button.dart';

class OtpVerifyScreen extends StatelessWidget {
  const OtpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<OtpController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AuthThemeScope(
        child: Scaffold(
          backgroundColor: AppColors.burgundy,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: AuthCard(
                  child: Column(
                    children: [
                      const AuthLogo(),
                      Text(
                        'Verify your account',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.marcellus(
                          fontSize: 32.sp,
                          height: 1.2,
                          color: AppColors.maroon50,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text.rich(
                        TextSpan(
                          text: 'We sent a 6-digit code to ',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 16.sp,
                            height: 1.6,
                            color: AppColors.black200,
                          ),
                          children: [
                            TextSpan(
                              text: '***@email.com',
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 16.sp,
                                height: 1.6,
                                color: AppColors.gold,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40.h),
                      Row(
                        children: List.generate(6, (i) {
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: i == 0 ? 0 : 6.w),
                              child: Container(
                                height: 56.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                alignment: Alignment.center,
                                child: TextField(
                                  controller: c.boxes[i],
                                  focusNode: c.focusNodes[i],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                  ],
                                  onChanged: (v) => c.onChanged(i, v),
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 20.sp,
                                    color: AppColors.black900,
                                  ),
                                  decoration: authBareDecoration(),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 24.h),
                      Obx(
                        () => GestureDetector(
                          onTap: c.resend,
                          child: Text.rich(
                            TextSpan(
                              text: "Didn't get a code? ",
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 16.sp,
                                height: 1.6,
                                color: AppColors.maroon100,
                              ),
                              children: [
                                TextSpan(
                                  text: c.timerLabel,
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 16.sp,
                                    height: 1.6,
                                    color: AppColors.gold,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      AuthPrimaryButton(label: 'Verify', onTap: c.verify),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
