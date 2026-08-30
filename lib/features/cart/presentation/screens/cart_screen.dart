import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../controllers/checkout_controller.dart';
import '../../models/cart_models.dart';
import '../widgets/cart_gold_button.dart';
import '../widgets/checkout_footer.dart';
import '../widgets/licensed_badge.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CheckoutController>();

    return ColoredBox(
      color: AppColors.offWhite,
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
              child: Obx(
                () => Text(
                  'Your Cart · ${c.itemsLabel}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.marcellus(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    color: AppColors.textBody,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (c.groups.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Text(
                      'Your cart is empty. Add licensed merch from the shop to get started.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 14.sp,
                        height: 1.5,
                        color: AppColors.black400,
                      ),
                    ),
                  ),
                );
              }
              return ListView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                children: [
                  for (final group in c.groups) ...[
                    _VendorCard(group: group),
                    SizedBox(height: 16.h),
                  ],
                  if (c.groups.length > 1) ...[
                    _PackagesBanner(vendorCount: c.groups.length),
                    SizedBox(height: 16.h),
                  ],
                  const _OrderSummaryCard(),
                ],
              );
            }),
          ),
          CheckoutFooter(
            inset: true,
            safeBottom: false,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconPath.cartShield,
                      width: 14.w,
                      height: 14.w,
                    ),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: Text(
                        'Covered by Buyer Protection Guarantee',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.hankenGrotesk(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          color: AppColors.black400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Obx(
                  () => CartGoldButton(
                    label: 'Checkout · ${c.money(c.cartTotal)}',
                    onTap: c.goCheckout,
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

class _VendorCard extends StatelessWidget {
  const _VendorCard({required this.group});

  final CartVendorGroup group;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CheckoutController>();

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
                  child: Text(
                    'Ships from ${group.vendor}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                      color: AppColors.textBody,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                const LicensedBadge(),
              ],
            ),
          ),
          for (final line in group.lines) _LineRow(line: line),
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 13.h, 12.w, 8.h),
            child: Row(
              children: [
                Text(
                  'Subtotal',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: AppColors.black400,
                  ),
                ),
                const Spacer(),
                Text(
                  c.money(group.subtotal),
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.42,
                    color: AppColors.textBody,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
            child: Row(
              children: [
                Text(
                  'Shipping',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: AppColors.black400,
                  ),
                ),
                const Spacer(),
                Text(
                  group.isFreeShipping ? 'Free' : c.money(group.shipping),
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    fontWeight: group.isFreeShipping
                        ? FontWeight.w400
                        : FontWeight.w600,
                    letterSpacing: group.isFreeShipping ? 0 : -0.42,
                    color: group.isFreeShipping
                        ? AppColors.goldDeep
                        : AppColors.textBody,
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

class _LineRow extends StatelessWidget {
  const _LineRow({required this.line});

  final CartLine line;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CheckoutController>();

    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              line.image,
              width: 64.w,
              height: 64.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  line.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                    color: AppColors.textBody,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  line.variant,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    color: AppColors.black400,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      line.priceLabel,
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        letterSpacing: -0.42,
                        color: AppColors.maroonAccent,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 78.w,
                      height: 31.h,
                      decoration: BoxDecoration(
                        color: AppColors.offWhite,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => c.changeQty(line.id, -1),
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: EdgeInsets.all(4.w),
                              child: SvgPicture.asset(
                                IconPath.cartMinus,
                                width: 14.w,
                                height: 14.w,
                              ),
                            ),
                          ),
                          Text(
                            '${line.qty}',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                              color: AppColors.textBody,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => c.changeQty(line.id, 1),
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: EdgeInsets.all(4.w),
                              child: SvgPicture.asset(
                                IconPath.cartPlus,
                                width: 14.w,
                                height: 14.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PackagesBanner extends StatelessWidget {
  const _PackagesBanner({required this.vendorCount});

  final int vendorCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.maroon50,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              color: AppColors.burgundy,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              IconPath.cartBox,
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
                  'Multiple Packages',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                    color: AppColors.burgundy400,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Your order ships from $vendorCount licensed vendors. You'll receive separate tracking for each package.",
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    color: AppColors.textBody,
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

class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CheckoutController>();

    return Container(
      padding: EdgeInsets.all(17.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.black50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              height: 1.6,
              color: AppColors.textBody,
            ),
          ),
          SizedBox(height: 12.h),
          _SummaryRow(label: 'Subtotal', value: c.money(c.merchandiseTotal)),
          SizedBox(height: 8.h),
          _SummaryRow(label: 'Shipping', value: c.money(c.cartShipping)),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: const Divider(height: 1, color: AppColors.black50),
          ),
          Row(
            children: [
              Text(
                'Total',
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  color: AppColors.textBody,
                ),
              ),
              const Spacer(),
              Text(
                c.money(c.cartTotal),
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  color: AppColors.maroonAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.hankenGrotesk(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: AppColors.black400,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.hankenGrotesk(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.42,
            color: AppColors.textBody,
          ),
        ),
      ],
    );
  }
}
