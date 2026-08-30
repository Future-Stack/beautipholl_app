import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          width: 80.w,
          height: 52.h,
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.burgundy,
            borderRadius: BorderRadius.circular(16.r),
            border: Border(
              top: BorderSide(color: AppColors.burgundy100, width: 0.75.w),
              left: BorderSide(color: AppColors.burgundy100, width: 0.75.w),
              right: BorderSide(color: AppColors.burgundy100, width: 0.75.w),
              bottom: BorderSide(color: AppColors.burgundy100, width: 4.h),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _arrow(),
              SizedBox(width: 10.w),
              _arrow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _arrow() {
    return SizedBox(
      width: 24.w,
      height: 24.h,
      child: Center(
        child: SvgPicture.asset(
          IconPath.arrowRightDouble,
          width: 13.04.w,
          height: 12.h,
          colorFilter: const ColorFilter.mode(
            AppColors.burgundy50,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
