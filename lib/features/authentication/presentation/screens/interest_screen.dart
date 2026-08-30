import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../controllers/interest_controller.dart';
import '../widgets/auth_pinned_scaffold.dart';
import '../widgets/auth_primary_button.dart';

class InterestScreen extends StatelessWidget {
  const InterestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<InterestController>();

    return AuthPinnedScaffold(
      backgroundColor: Colors.black,
      header: Column(
        children: [
          Text(
            'What are you\ninterested in?',
            textAlign: TextAlign.center,
            style: GoogleFonts.marcellus(
              fontSize: 32.sp,
              height: 1.2,
              color: AppColors.gold,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Select all that apply',
            textAlign: TextAlign.center,
            style: GoogleFonts.hankenGrotesk(
              fontSize: 16.sp,
              height: 1.6,
              color: AppColors.burgundy100,
            ),
          ),
          SizedBox(height: 40.h),
          LayoutBuilder(
            builder: (context, constraints) {
              final gap = 12.w;
              final tileW = (constraints.maxWidth - gap * 2) / 3;
              final tileH = tileW * 89 / 115;
              return Obx(() {
                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (final item in c.items)
                      SizedBox(
                        width: tileW,
                        height: tileH,
                        child: _InterestTile(
                          label: item.label,
                          icon: item.icon,
                          selected: c.isSelected(item.id),
                          onTap: () => c.toggle(item.id),
                        ),
                      ),
                  ],
                );
              });
            },
          ),
        ],
      ),
      footer: Column(
        children: [
          AuthPrimaryButton(
            label: 'Continue',
            filled: true,
            onTap: c.continueNext,
          ),
          SizedBox(height: 16.h),
          Text(
            'You can change this anytime',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 12.sp,
              height: 1.4,
              color: AppColors.black100,
            ),
          ),
        ],
      ),
    );
  }
}

class _InterestTile extends StatelessWidget {
  const _InterestTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? AppColors.maroon600 : AppColors.burgundy900,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected ? AppColors.maroon600 : AppColors.burgundy400,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(icon, width: 40.w, height: 40.w),
                    SizedBox(height: 4.h),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        label,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.hankenGrotesk(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                          color: selected
                              ? AppColors.maroon50
                              : AppColors.maroon100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (selected)
              Positioned(
                top: 6.h,
                right: 8.w,
                child: SvgPicture.asset(
                  IconPath.checkCircle,
                  width: 16.w,
                  height: 16.w,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
