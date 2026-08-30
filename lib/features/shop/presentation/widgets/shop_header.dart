import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../features/authentication/presentation/widgets/auth_input.dart';
import '../../controllers/shop_controller.dart';

class ShopHeader extends StatelessWidget {
  const ShopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ShopController>();

    return Container(
      width: double.infinity,
      color: AppColors.burgundy,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: c.changeOrganization,
                    child: Container(
                      width: 98.w,
                      height: 36.h,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: const Color(0x1AC9A84C),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.gold100),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              c.orgLetters,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                                color: AppColors.gold300,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 20.w,
                            color: AppColors.gold300,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Obx(() {
                    final count = c.cartCount.value;
                    return GestureDetector(
                      onTap: c.openCart,
                      child: SizedBox(
                      width: 40.w,
                      height: 41.h,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: 1.h,
                            child: Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: AppColors.maroon50,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  IconPath.shopCart,
                                  width: 24.w,
                                  height: 24.w,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.maroonAccent,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: -7.w,
                            top: 0,
                            child: Container(
                              width: 16.w,
                              height: 16.w,
                              decoration: const BoxDecoration(
                                color: AppColors.gold300,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '$count',
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                  color: AppColors.maroonAccent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    );
                  }),
                ],
              ),
              SizedBox(height: 16.h),
              AuthThemeScope(
                child: Container(
                  width: double.infinity,
                  height: 54.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: AppColors.offWhite,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        IconPath.search,
                        width: 24.w,
                        height: 24.w,
                        color: AppColors.black400,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: TextField(
                          controller: c.searchController,
                          onChanged: c.onSearchChanged,
                          cursorColor: AppColors.gold,
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.6,
                            color: AppColors.textBody,
                          ),
                          decoration: authBareDecoration(
                            hint: 'Search apparel, gifts, drops...',
                            hintColor: AppColors.black400,
                          ),
                        ),
                      ),
                    ],
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
