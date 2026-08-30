import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../controllers/checkout_controller.dart';
import '../widgets/cart_gold_button.dart';

class OrderConfirmedScreen extends StatelessWidget {
  const OrderConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CheckoutController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.offWhite,
      ),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 24.h),
            children: [
              Center(
                child: Container(
                  width: 96.w,
                  height: 96.w,
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.burgundy,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.burgundy100, width: 8),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    IconPath.cartConfirmCheck,
                    width: 40.w,
                    height: 40.w,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                'Order Confirmed',
                textAlign: TextAlign.center,
                style: GoogleFonts.marcellus(
                  fontSize: 32.sp,
                  height: 1.2,
                  color: AppColors.textBody,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Thank you for supporting licensed Divine Nine vendors. Your order is on its way!',
                textAlign: TextAlign.center,
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                  color: AppColors.black300,
                ),
              ),
              SizedBox(height: 16.h),
              _Card(
                child: Column(
                  children: [
                    _Kv('Order #', 'D9-2024-88421'),
                    _divider(),
                    _Kv('Date', 'July 21, 2026'),
                    _divider(),
                    _Kv(
                      'Total',
                      c.money(c.reviewTotal),
                      valueColor: AppColors.maroonAccent,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              _Card(
                radius: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shipping information',
                      style: GoogleFonts.marcellus(
                        fontSize: 24.sp,
                        height: 1.2,
                        color: AppColors.textBody,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Delivery Address',
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBody,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      c.recipientName,
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                        color: AppColors.textBody,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      c.fullAddressLine,
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 14.sp,
                        height: 1.5,
                        color: AppColors.black400,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Shipping Details',
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBody,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _Kv('Carrier', 'DHL Express'),
                    SizedBox(height: 12.h),
                    _Kv(
                      'Tracking number',
                      '#98593656',
                      valueColor: AppColors.maroonAccent,
                      underline: true,
                    ),
                    SizedBox(height: 12.h),
                    _Kv('Estimated delivery', '26 july, 2026'),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.burgundy50,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: AppColors.burgundy,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.burgundy100,
                          width: 4,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        IconPath.cartPackage,
                        width: 16.w,
                        height: 16.w,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What happens next?',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.burgundy400,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "You'll receive a confirmation email. Each vendor will ship separately and you'll get tracking updates for each package.",
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 12.sp,
                              height: 1.5,
                              color: AppColors.textBody,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              CartGoldButton(label: 'Track Order', onTap: c.trackOrder),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: c.continueShopping,
                child: Container(
                  width: double.infinity,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.maroonDark),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Continue Shopping',
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.maroonDark,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() => Padding(
    padding: EdgeInsets.symmetric(vertical: 12.h),
    child: const Divider(height: 1, color: AppColors.black50),
  );
}

class _Card extends StatelessWidget {
  const _Card({required this.child, this.radius = 14});

  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius.r),
        border: Border.all(color: AppColors.black50),
      ),
      child: child,
    );
  }
}

class _Kv extends StatelessWidget {
  const _Kv(this.label, this.value, {this.valueColor, this.underline = false});

  final String label;
  final String value;
  final Color? valueColor;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.hankenGrotesk(
            fontSize: 16.sp,
            height: 1.6,
            color: AppColors.black300,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.hankenGrotesk(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              height: 1.2,
              color: valueColor ?? AppColors.textBody,
              decoration: underline ? TextDecoration.underline : null,
            ),
          ),
        ),
      ],
    );
  }
}
