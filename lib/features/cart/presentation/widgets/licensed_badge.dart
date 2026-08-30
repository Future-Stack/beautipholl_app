import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';

class LicensedBadge extends StatelessWidget {
  const LicensedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.gold50,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(IconPath.cartLicensed, width: 10.w, height: 10.w),
          SizedBox(width: 4.w),
          Text(
            'Licensed',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              height: 1.5,
              color: AppColors.goldDeep,
            ),
          ),
        ],
      ),
    );
  }
}
