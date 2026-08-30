import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../controllers/reset_password_controller.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_input.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ResetPasswordController>();

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
                      SizedBox(height: 0),
                      Text(
                        'Reset your password',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.marcellus(
                          fontSize: 32.sp,
                          height: 1.2,
                          color: AppColors.maroon50,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Enter the email or phone number linked to your account',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.hankenGrotesk(
                          fontSize: 16.sp,
                          height: 1.6,
                          color: AppColors.black200,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      AuthTextField(
                        controller: c.contactController,
                        hint: 'Email or phone number',
                      ),
                      SizedBox(height: 40.h),
                      AuthPrimaryButton(label: 'Send Code', onTap: c.sendCode),
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
