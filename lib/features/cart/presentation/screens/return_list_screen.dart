import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../controllers/checkout_controller.dart';
import '../widgets/orders_app_bar.dart';

class ReturnListScreen extends StatelessWidget {
  const ReturnListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CheckoutController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.offWhite,
      ),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Column(
          children: [
            const OrdersAppBar(title: 'Returns'),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: AppColors.burgundy50,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          IconPath.cartCap,
                          width: 20.w,
                          height: 20.w,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alpha Phi Alpha Fitted Cap',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                color: AppColors.burgundy,
                              ),
                            ),
                            Text(
                              'ORD-2795 · Jul 12, 2026',
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 13.sp,
                                height: 1.5,
                                color: AppColors.black400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.burgundy100,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'Approved',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.burgundy400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: c.openReturnDetails,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.burgundy,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'View Details',
                        style: GoogleFonts.hankenGrotesk(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.burgundy50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
