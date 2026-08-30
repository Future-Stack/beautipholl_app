import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../controllers/welcome_controller.dart';
import '../widgets/auth_pinned_scaffold.dart';
import '../widgets/auth_primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<WelcomeController>();

    return Stack(
      fit: StackFit.expand,
      children: [
        AuthPinnedScaffold(
          backgroundColor: AppColors.maroon950,
          header: Column(
            children: [
              Image.asset(
                ImagePath.welcomeLogo,
                width: 202.w,
                height: 202.w,
                fit: BoxFit.contain,
              ),
              Text(
                'Welcome to The Yard!',
                textAlign: TextAlign.center,
                style: GoogleFonts.marcellus(
                  fontSize: 32.sp,
                  height: 1.2,
                  color: AppColors.gold,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'You’re all set. Start exploring licensed products and support your community.',
                textAlign: TextAlign.center,
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 16.sp,
                  height: 1.6,
                  color: AppColors.burgundy100,
                ),
              ),
              SizedBox(height: 32.h),
              const _InfoCard(
                icon: IconPath.settings,
                title: 'Official Licensed',
                subtitle: 'Verified by organizations',
              ),
              SizedBox(height: 15.h),
              const _InfoCard(
                icon: IconPath.support,
                title: 'Support Communities',
                subtitle: 'A portion of every purchase gives back',
              ),
            ],
          ),
          footer: Column(
            children: [
              AuthPrimaryButton(
                label: 'Start Shopping',
                filled: true,
                onTap: c.startShopping,
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: c.exploreAccount,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Explore My Account',
                        style: GoogleFonts.hankenGrotesk(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                          color: AppColors.gold,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      SvgPicture.asset(
                        IconPath.arrowSmall,
                        width: 15.w,
                        height: 8.h,
                        colorFilter: const ColorFilter.mode(
                          AppColors.gold,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 47.h,
          child: IgnorePointer(
            child: Image.asset(
              ImagePath.welcomeConfetti,
              width: 231.w,
              height: 218.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final String icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 224.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.maroon800,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: AppColors.gold),
            ),
            child: Center(
              child: SvgPicture.asset(icon, width: 20.w, height: 20.w),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    color: AppColors.maroon50,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 12.sp,
                    height: 1.4,
                    color: AppColors.maroon200,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
