import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../controllers/checkout_controller.dart';
import '../widgets/licensed_badge.dart';
import '../widgets/orders_app_bar.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

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
            const OrdersAppBar(title: 'Order Details'),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.w),
                children: [
                  _Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'D9-2024-88421',
                                    style: GoogleFonts.hankenGrotesk(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textBody,
                                    ),
                                  ),
                                  Text(
                                    'Placed July 21, 2026',
                                    style: GoogleFonts.hankenGrotesk(
                                      fontSize: 12.sp,
                                      color: AppColors.black400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.gold100,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                'In Progress',
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.gold700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: const Divider(
                            height: 1,
                            color: AppColors.black50,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Total',
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 14.sp,
                                color: AppColors.textBody,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              c.money(c.reviewTotal),
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.maroonAccent,
                              ),
                            ),
                          ],
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
                          'Shipment Status',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textBody,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        const _ShipmentStepper(),
                        SizedBox(height: 16.h),
                        Text(
                          'Estimated delivery: Friday, July 25 – Monday, July 28',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 12.sp,
                            color: AppColors.black400,
                          ),
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
                            color: AppColors.textBody,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Delivery Address',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textBody,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          c.recipientName,
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textBody,
                          ),
                        ),
                        Text(
                          c.fullAddressLine,
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            color: AppColors.black400,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Shipping Details',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textBody,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        _shipRow('Carrier', 'DHL Express'),
                        _shipRow('Tracking number', '#98593656', accent: true),
                        _shipRow('Estimated delivery', '26 july, 2026'),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  for (var i = 0; i < c.groups.length; i++) ...[
                    _VendorOrderCard(
                      vendor: c.groups[i].vendor,
                      onVendorTap: c.openVendorContact,
                      items: [
                        for (final line in c.groups[i].lines)
                          _OrderItem(
                            title: line.title,
                            variant: line.variant,
                            price: line.qty > 1
                                ? '${line.priceLabel} × ${line.qty}'
                                : line.priceLabel,
                            image: line.image,
                          ),
                      ],
                      carrier: i == 0 ? 'UPS' : 'FedEx',
                      tracking: i == 0 ? '1Z999AA10123456784' : '789234567890',
                    ),
                    SizedBox(height: 16.h),
                  ],
                  SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: c.openReturns,
                    child: Container(
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: AppColors.maroonAccent),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            IconPath.cartStatusBox,
                            width: 16.w,
                            height: 16.w,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Start a Return',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.burgundy400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: c.openDispute,
                    child: Container(
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: AppColors.black50,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: AppColors.black100),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            IconPath.cartStatusPin,
                            width: 16.w,
                            height: 16.w,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Open a Dispute',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black500,
                            ),
                          ),
                        ],
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

  Widget _shipRow(String label, String value, {bool accent = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              color: AppColors.black300,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: accent ? AppColors.maroonAccent : AppColors.textBody,
                decoration: accent ? TextDecoration.underline : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
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

class _ShipmentStepper extends StatelessWidget {
  const _ShipmentStepper();

  @override
  Widget build(BuildContext context) {
    const steps = [
      ('Confirmed', IconPath.cartStatusCheck, Color(0xFF029F51), true),
      ('Processing', IconPath.cartStatusGear, Color(0xFF029F51), true),
      ('Shipped', IconPath.cartStatusBox, AppColors.gold, true),
      ('Delivered', IconPath.cartStatusPin, AppColors.black200, false),
    ];

    return SizedBox(
      height: 68.h,
      child: Stack(
        children: [
          Positioned(
            top: 19.w,
            left: 28.w,
            right: 28.w,
            child: Row(
              children: [
                for (var i = 0; i < steps.length - 1; i++)
                  Expanded(
                    child: Container(
                      height: 2.h,
                      color: steps[i + 1].$4 ? steps[i].$3 : AppColors.black50,
                    ),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              for (var i = 0; i < steps.length; i++)
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: steps[i].$4 ? steps[i].$3 : AppColors.black50,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          steps[i].$2,
                          width: 16.w,
                          height: 16.w,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        steps[i].$1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.hankenGrotesk(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: steps[i].$4 ? steps[i].$3 : AppColors.black200,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderItem {
  const _OrderItem({
    required this.title,
    required this.variant,
    required this.price,
    required this.image,
  });

  final String title;
  final String variant;
  final String price;
  final String image;
}

class _VendorOrderCard extends StatelessWidget {
  const _VendorOrderCard({
    required this.vendor,
    required this.items,
    required this.carrier,
    required this.tracking,
    required this.onVendorTap,
  });

  final String vendor;
  final List<_OrderItem> items;
  final String carrier;
  final String tracking;
  final VoidCallback onVendorTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.black50),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onVendorTap,
                    child: Text(
                      vendor,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBody,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                const LicensedBadge(),
              ],
            ),
          ),
          for (final item in items)
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      item.image,
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
                          item.title,
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textBody,
                          ),
                        ),
                        Text(
                          item.variant,
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 12.sp,
                            color: AppColors.black400,
                          ),
                        ),
                        Text(
                          item.price,
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.maroonAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(12.w, 13.h, 12.w, 12.h),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.black50)),
            ),
            child: Row(
              children: [
                SvgPicture.asset(IconPath.cartTruck, width: 14.w, height: 14.w),
                SizedBox(width: 8.w),
                Text(
                  carrier,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 12.sp,
                    color: AppColors.black400,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    tracking,
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.maroonDark,
                    ),
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
