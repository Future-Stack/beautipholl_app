import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../controllers/sign_up_controller.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_input.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<SignUpController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AuthThemeScope(
        child: Scaffold(
          backgroundColor: AppColors.burgundy,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthCard(
                    child: Column(
                      children: [
                        const AuthLogo(),
                        Text(
                          'Create Your Account',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.marcellus(
                            fontSize: 32.sp,
                            height: 1.2,
                            color: AppColors.maroon50,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        AuthTextField(
                          controller: c.nameController,
                          hint: 'Full name',
                        ),
                        SizedBox(height: 12.h),
                        AuthTextField(
                          controller: c.emailController,
                          hint: 'Email',
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 80.w,
                              height: 44.h,
                              padding: EdgeInsets.symmetric(horizontal: 11.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '🇺🇸',
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    '+1',
                                    style: GoogleFonts.hankenGrotesk(
                                      fontSize: 14.sp,
                                      height: 1.5,
                                      color: AppColors.textBlack,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  SvgPicture.asset(
                                    IconPath.chevronDown,
                                    width: 10.w,
                                    height: 10.w,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: AuthTextField(
                                borderWidth: 1,
                                controller: c.phoneController,
                                hint: 'Phone number',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        AuthTextField(
                          controller: c.passwordController,
                          hint: 'Password',
                          obscure: true,
                        ),
                        SizedBox(height: 12.h),
                        AuthTextField(
                          controller: c.confirmController,
                          hint: 'Confirm password',
                          obscure: true,
                        ),
                        SizedBox(height: 20.h),
                        Obx(
                          () => GestureDetector(
                            onTap: c.toggleAgreed,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 16.w,
                                  height: 16.w,
                                  child: c.agreed.value
                                      ? SvgPicture.asset(IconPath.checkbox)
                                      : Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.gold,
                                            ),
                                          ),
                                        ),
                                ),
                                SizedBox(width: 4.w),
                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'I agree to the ',
                                      style: GoogleFonts.hankenGrotesk(
                                        fontSize: 14.sp,
                                        height: 1.5,
                                        color: AppColors.maroon50,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Terms of Service',
                                          style: GoogleFonts.hankenGrotesk(
                                            fontSize: 14.sp,
                                            color: AppColors.gold,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: AppColors.gold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' and ',
                                          style: GoogleFonts.hankenGrotesk(
                                            fontSize: 14.sp,
                                            color: AppColors.burgundy50,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Privacy Policy',
                                          style: GoogleFonts.hankenGrotesk(
                                            fontSize: 14.sp,
                                            color: AppColors.gold,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: AppColors.gold,
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
                        SizedBox(height: 32.h),
                        AuthPrimaryButton(label: 'Sign In', onTap: c.submit),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 16.sp,
                        height: 1.6,
                        color: AppColors.black100,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.burgundy500,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.burgundy500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = c.goToSignIn,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
