import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
    required this.title,
    this.trailing,
    this.onBack,
    this.centerTitle = false,
    this.bottom,
  });

  final String title;
  final Widget? trailing;
  final VoidCallback? onBack;
  final bool centerTitle;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.burgundy,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            16.w,
            12.h,
            16.w,
            bottom == null ? 12.h : 8.h,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: onBack ?? Get.back,
                    behavior: HitTestBehavior.opaque,
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
                  if (centerTitle) ...[
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.marcellus(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 24.w, height: 24.w, child: trailing),
                  ] else ...[
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.marcellus(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (trailing != null) ...[
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: trailing,
                          ),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
              if (bottom != null) ...[SizedBox(height: 12.h), bottom!],
            ],
          ),
        ),
      ),
    );
  }
}
