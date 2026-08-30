import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';

class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.filled = false,
    this.enabled = true,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.45,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 330.w),
          child: Container(
            width: double.infinity,
            height: 52.h,
            decoration: BoxDecoration(
              color: filled ? AppColors.maroonAccent : AppColors.burgundy,
              borderRadius: BorderRadius.circular(16.r),
              border: Border(
                top: BorderSide(color: AppColors.burgundy100, width: 0.75),
                left: BorderSide(color: AppColors.burgundy100, width: 0.75),
                right: BorderSide(color: AppColors.burgundy100, width: 0.75),
                bottom: BorderSide(color: AppColors.burgundy100, width: 4.h),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      color: AppColors.burgundy50,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: Center(
                    child: SvgPicture.asset(
                      IconPath.arrowRightDouble,
                      width: 13.w,
                      height: 12.h,
                      colorFilter: const ColorFilter.mode(
                        AppColors.burgundy50,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
