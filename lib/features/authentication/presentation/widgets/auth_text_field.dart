import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import 'auth_input.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.onToggleObscure,
    this.keyboardType,
    this.height,
    this.borderWidth = 2,
    this.radius,
  });

  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final VoidCallback? onToggleObscure;
  final TextInputType? keyboardType;
  final double? height;
  final double borderWidth;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (height ?? 42).h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular((radius ?? 8).r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              keyboardType: keyboardType,
              cursorColor: AppColors.burgundy,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 1.6,
                color: AppColors.black900,
              ),
              decoration: authBareDecoration(hint: hint),
            ),
          ),
          if (onToggleObscure != null) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: onToggleObscure,
              child: SvgPicture.asset(IconPath.eye, width: 24.w, height: 24.h),
            ),
          ],
        ],
      ),
    );
  }
}
