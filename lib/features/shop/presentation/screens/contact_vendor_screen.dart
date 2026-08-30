import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../controllers/contact_vendor_controller.dart';

class ContactVendorScreen extends StatelessWidget {
  const ContactVendorScreen({super.key});

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
              color: AppColors.burgundy,
              child: SafeArea(
                bottom: false,
                child: SizedBox(
                  height: 53.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: Get.back,
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
                        SizedBox(width: 16.w),
                        Flexible(
                          child: Text(
                            'Contact Vendor',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.marcellus(
                              fontSize: 24.sp,
                              height: 1.2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
              child: GestureDetector(
                onTap: c.openInquiry,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.black50),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.r),
                        child: Image.asset(
                          ImagePath.shopContactProduct,
                          width: 51.w,
                          height: 48.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vendor: The Fabric Haven',
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 14.sp,
                                height: 1.5,
                                color: AppColors.maroonDark,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Purple & Gold Crewneck Sweatshirt',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.3,
                                color: AppColors.textBody,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
