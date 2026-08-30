import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../../../routes/app_routes.dart';
import '../../controllers/contact_vendor_controller.dart';

class ContactInquiryScreen extends StatelessWidget {
  const ContactInquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ContactVendorController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.offWhite,
      ),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.burgundy,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16.r),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                  child: Row(
                    children: [
                      _HeaderCircle(
                        onTap: Get.back,
                        child: SvgPicture.asset(
                          IconPath.shopArrowLeft,
                          width: 18.w,
                          height: 18.w,
                          colorFilter: const ColorFilter.mode(
                            AppColors.burgundy,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Contact Vendor',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.marcellus(
                            fontSize: 20.sp,
                            height: 1.2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      _HeaderCircle(
                        onTap: () => Get.until(
                          (route) =>
                              route.settings.name ==
                                  AppRoute.productDetailsScreen ||
                              route.settings.name == AppRoute.homeScreen ||
                              route.isFirst,
                        ),
                        child: Icon(
                          Icons.close,
                          size: 18.w,
                          color: AppColors.burgundy,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.asset(
                              ImagePath.shopContactProduct,
                              width: 56.w,
                              height: 56.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'VENDOR: LEGACY GREEK OUTFITTERS',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.4,
                                    color: AppColors.maroonDark,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Purple & Gold Heritage Wool Varsity',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3,
                                    color: AppColors.textBody,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.info,
                                      size: 14.w,
                                      color: AppColors.gold300,
                                    ),
                                    SizedBox(width: 4.w),
                                    Expanded(
                                      child: Text(
                                        'Auto-attached item context · No need to re-add',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.hankenGrotesk(
                                          fontSize: 11.sp,
                                          height: 1.3,
                                          color: AppColors.black300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      "What's your question about?",
                      style: GoogleFonts.marcellus(
                        fontSize: 22.sp,
                        height: 1.2,
                        color: AppColors.textBody,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Choose a category so Legacy Greek Outfitters can respond accurately.',
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 14.sp,
                        height: 1.5,
                        color: AppColors.black300,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Obx(() {
                      return Column(
                        children: ContactVendorController.topics.map((topic) {
                          final selected = c.selectedTopic.value == topic;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: GestureDetector(
                              onTap: () => c.selectTopic(topic),
                              child: Container(
                                width: double.infinity,
                                height: 56.h,
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: selected
                                        ? AppColors.maroonAccent
                                        : AppColors.black50,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        topic,
                                        style: GoogleFonts.hankenGrotesk(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textBody,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 22.w,
                                      height: 22.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: selected
                                              ? AppColors.maroonAccent
                                              : AppColors.black100,
                                          width: 1.5,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: selected
                                          ? Container(
                                              width: 12.w,
                                              height: 12.w,
                                              decoration: const BoxDecoration(
                                                color: AppColors.maroonAccent,
                                                shape: BoxShape.circle,
                                              ),
                                            )
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCircle extends StatelessWidget {
  const _HeaderCircle({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
