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

class DisputeSubmitScreen extends StatelessWidget {
  const DisputeSubmitScreen({super.key});

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
            const OrdersAppBar(title: 'Orders'),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
                children: [
                  BackToOrderLink(
                    label: 'Back to Order Details',
                    onTap: c.backToOrderDetails,
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(40.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 72.w,
                          height: 72.w,
                          decoration: const BoxDecoration(
                            color: AppColors.burgundy,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            IconPath.cartSuccessCheck,
                            width: 30.w,
                            height: 30.w,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Dispute Submitted',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.marcellus(
                            fontSize: 28.sp,
                            height: 1.5,
                            color: AppColors.burgundy,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Reference: DSP-85435',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            color: AppColors.maroonAccent,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "We'll notify you once the vendor responds. If they don't respond within 48 hours, our team will step in to help.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 15.sp,
                            height: 1.6,
                            color: AppColors.black400,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: c.backToOrderDetails,
                          child: Container(
                            width: 194.w,
                            height: 41.h,
                            decoration: BoxDecoration(
                              color: AppColors.burgundy,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Return to Order Details',
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 14.sp,
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
          ],
        ),
      ),
    );
  }
}
