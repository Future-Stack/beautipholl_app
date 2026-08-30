import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../controllers/notification_controller.dart';
import '../widgets/auth_pinned_scaffold.dart';
import '../widgets/auth_primary_button.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<NotificationPrefsController>();

    return AuthPinnedScaffold(
      backgroundColor: Colors.black,
      header: Column(
        children: [
          Text(
            'Stay in the know',
            textAlign: TextAlign.center,
            style: GoogleFonts.marcellus(
              fontSize: 32.sp,
              height: 1.2,
              color: AppColors.gold,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Turn on notification to get updates on new drops, sales, and more.',
            textAlign: TextAlign.center,
            style: GoogleFonts.hankenGrotesk(
              fontSize: 16.sp,
              height: 1.6,
              color: AppColors.burgundy100,
            ),
          ),
          SizedBox(height: 32.h),
          const _LockPreview(),
          SizedBox(height: 32.h),
          _ToggleRow(
            icon: IconPath.bag,
            label: 'New Drops & Releases',
            value: c.drops,
          ),
          SizedBox(height: 16.h),
          _ToggleRow(
            icon: IconPath.sales,
            label: 'Sales & Promotions',
            value: c.sales,
          ),
          SizedBox(height: 16.h),
          _ToggleRow(
            icon: IconPath.order,
            label: 'Order Updates',
            value: c.orders,
          ),
          SizedBox(height: 16.h),
          _ToggleRow(
            icon: IconPath.community,
            label: 'Community News',
            value: c.community,
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

class _LockPreview extends StatelessWidget {
  const _LockPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 241.w,
      height: 217.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.maroonAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(24.r),
                ),
                border: Border(
                  left: BorderSide(color: AppColors.gold),
                  right: BorderSide(color: AppColors.gold),
                  top: BorderSide(color: AppColors.gold),
                ),
              ),
            ),
          ),
          Positioned(
            top: 31.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  '9:41',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.marcellus(
                    fontSize: 48.sp,
                    height: 1.2,
                    letterSpacing: -0.96,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Monday, June 10',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: -12.w,
            right: -12.w,
            top: 111.h,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.gold100,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3.r),
                    child: Image.asset(
                      ImagePath.notifLogo,
                      width: 32.w,
                      height: 32.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'The Yard',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                            letterSpacing: -0.42,
                            color: AppColors.burgundy,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'New drop alert! Homecoming collection is live.',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 12.sp,
                            height: 1.4,
                            color: AppColors.burgundy,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final String icon;
  final String label;
  final RxBool value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 271.w),
        child: Row(
          children: [
            SvgPicture.asset(icon, width: 20.w, height: 20.w),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 12.sp,
                  height: 1.4,
                  color: Colors.white,
                ),
              ),
            ),
            Obx(
              () => GestureDetector(
                onTap: value.toggle,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 44,
                  height: 24,
                  decoration: BoxDecoration(
                    color: value.value
                        ? AppColors.goldBright
                        : AppColors.burgundy400,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  alignment: value.value
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
