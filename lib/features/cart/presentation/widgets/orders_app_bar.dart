import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';

class OrdersAppBar extends StatelessWidget {
  const OrdersAppBar({super.key, required this.title, this.onBack});

  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.burgundy,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              GestureDetector(
                onTap: onBack ?? Get.back,
                child: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: SvgPicture.asset(
                    IconPath.shopArrowLeft,
                    width: 24.w,
                    height: 24.w,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.marcellus(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    color: Colors.white,
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

class BackToOrderLink extends StatelessWidget {
  const BackToOrderLink({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(IconPath.cartBackSm, width: 16.w, height: 16.w),
          SizedBox(width: 4.w),
          Text(
            label,
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              height: 1.3,
              color: AppColors.maroonAccent,
            ),
          ),
        ],
      ),
    );
  }
}
