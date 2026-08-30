import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../widgets/orders_app_bar.dart';

class ReturnDetailsScreen extends StatelessWidget {
  const ReturnDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
                children: [
                  Text(
                    'Orders',
                    style: GoogleFonts.marcellus(
                      fontSize: 32.sp,
                      height: 1.2,
                      color: AppColors.burgundy,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  BackToOrderLink(label: 'Back to Returns', onTap: Get.back),
                  SizedBox(height: 16.h),
                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _ApprovedBadge(),
                        SizedBox(height: 8.h),
                        Text(
                          'Return — ORD-2795',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            color: AppColors.burgundy,
                          ),
                        ),
                        Text(
                          'Alpha Phi Alpha Fitted Cap · Submitted Jul 12, 2026',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            height: 1.5,
                            color: AppColors.black400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Return Reason',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.burgundy,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Item received damaged brim had a crease that wasn't shown in product photos.",
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            height: 1.6,
                            color: AppColors.black400,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'No photos attached.',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 12.sp,
                            color: AppColors.black200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vendor Response',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.burgundy,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Approved. Please ship item back within 5 business days.',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            height: 1.6,
                            color: AppColors.black400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Return Shipping',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.burgundy,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'FedEx prepaid label emailed to james@example.com. Drop off by Jul 19.',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            height: 1.6,
                            color: AppColors.black400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Refund',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.burgundy,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        const _ApprovedBadge(),
                        SizedBox(height: 8.h),
                        Text(
                          '\$60.00',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.maroonAccent,
                          ),
                        ),
                        Text(
                          'Refund will appear on your original payment method within 5–7 business days after item is received.',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 12.sp,
                            height: 1.5,
                            color: AppColors.black200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Need help with this return?',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            color: AppColors.black400,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Contact Support',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.maroonAccent,
                            decoration: TextDecoration.underline,
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

class _ApprovedBadge extends StatelessWidget {
  const _ApprovedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
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
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: child,
    );
  }
}
