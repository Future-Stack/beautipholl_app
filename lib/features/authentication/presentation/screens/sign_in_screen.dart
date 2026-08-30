import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../controllers/sign_in_controller.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_input.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<SignInController>();

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
                          'Sign In',
                          style: GoogleFonts.marcellus(
                            fontSize: 32.sp,
                            height: 1.2,
                            color: AppColors.maroon50,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        AuthTextField(
                          controller: c.emailController,
                          hint: 'Email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 12.h),
                        AuthTextField(
                          controller: c.passwordController,
                          hint: 'Password',
                          obscure: true,
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Obx(
                              () => GestureDetector(
                                onTap: c.toggleRememberMe,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 16.w,
                                      height: 16.w,
                                      child: c.rememberMe.value
                                          ? SvgPicture.asset(IconPath.checkbox)
                                          : Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2.r),
                                                border: Border.all(
                                                  color: AppColors.gold,
                                                ),
                                              ),
                                            ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      'Remember me',
                                      style: GoogleFonts.hankenGrotesk(
                                        fontSize: 14.sp,
                                        height: 1.5,
                                        color: AppColors.gold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: c.goToForgotPassword,
                              child: Text(
                                'Forgot password?',
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                  color: AppColors.gold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 32.h),
                        AuthPrimaryButton(label: 'Sign In', onTap: c.signIn),
                        SizedBox(height: 40.h),
                        Row(
                          children: [
                            Expanded(
                              child: SvgPicture.asset(
                                IconPath.divider,
                                fit: BoxFit.fill,
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 9.w),
                              child: Text(
                                'or',
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 14.sp,
                                  height: 1.5,
                                  color: AppColors.gold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: SvgPicture.asset(
                                IconPath.divider,
                                fit: BoxFit.fill,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        _SocialButton(
                          icon: ImagePath.google,
                          label: 'Continue With Google',
                        ),
                        SizedBox(height: 12.h),
                        _SocialButton(
                          icon: ImagePath.apple,
                          label: 'Continue With Apple',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text.rich(
                    TextSpan(
                      text: 'Don’t have an account? ',
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 16.sp,
                        height: 1.6,
                        color: AppColors.black100,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                            color: AppColors.burgundy500,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.burgundy500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = c.goToSignUp,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
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

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.icon, required this.label});

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.gold50,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, width: 16.w, height: 16.w),
          SizedBox(width: 8.w),
          Text(
            label,
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              height: 1.2,
              color: AppColors.textBlack,
            ),
          ),
        ],
      ),
    );
  }
}
