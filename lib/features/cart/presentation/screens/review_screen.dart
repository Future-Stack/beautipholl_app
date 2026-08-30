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
import '../widgets/checkout_footer.dart';
import '../widgets/checkout_header.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CheckoutController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              const CheckoutHeader(title: 'Payment', activeStep: 3),
              Expanded(
                child: ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
                  children: [
                    _ReviewCard(
                      icon: IconPath.cartPin,
                      title: 'Ship To',
                      onEdit: c.editAddress,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c.recipientName,
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textBody,
                            ),
                          ),
                          Text(
                            c.streetLine,
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 14.sp,
                              color: AppColors.black400,
                            ),
                          ),
                          Text(
                            c.cityLine,
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 14.sp,
                              color: AppColors.black400,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.offWhite,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              c.instructionLine,
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 13.sp,
                                fontStyle: FontStyle.italic,
                                color: AppColors.black300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Obx(() {
                      final ship = c.selectedShipping;
                      return _ReviewCard(
                        icon: IconPath.cartReviewTruck,
                        title: 'Delivery',
                        onEdit: c.editDelivery,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ship.title,
                                    style: GoogleFonts.hankenGrotesk(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textBody,
                                    ),
                                  ),
                                  Text(
                                    ship.eta,
                                    style: GoogleFonts.hankenGrotesk(
                                      fontSize: 13.sp,
                                      color: AppColors.black400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              c.money(ship.price),
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textBody,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(height: 12.h),
                    _ReviewCard(
                      icon: IconPath.cartReviewCard,
                      title: 'Payment',
                      onEdit: c.editPayment,
                      child: Row(
                        children: [
                          Container(
                            width: 44.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              color: AppColors.burgundy,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'VISA',
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                                color: AppColors.gold,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.cardMask,
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textBody,
                                  ),
                                ),
                                Text(
                                  'Card · ${c.cardExpiryLabel}',
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 12.sp,
                                    color: AppColors.black400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 48.h,
                            padding: EdgeInsets.symmetric(horizontal: 13.w),
                            decoration: BoxDecoration(
                              color: AppColors.gold50,
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  IconPath.cartTag,
                                  width: 16.w,
                                  height: 16.w,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: TextField(
                                    controller: c.promo,
                                    decoration: InputDecoration(
                                      hintText: 'Promo code',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      hintStyle: GoogleFonts.hankenGrotesk(
                                        fontSize: 14.sp,
                                        color: AppColors.textBody.withValues(
                                          alpha: 0.5,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: c.applyPromo,
                          child: Container(
                            height: 48.h,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Apply',
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.gold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.all(17.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: AppColors.black50),
                      ),
                      child: Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Summary',
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textBody,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            _RowText(
                              'Subtotal (${c.itemsLabel})',
                              c.money(c.merchandiseTotal),
                            ),
                            SizedBox(height: 8.h),
                            _RowText(
                              'Shipping',
                              c.money(c.selectedShipping.price),
                            ),
                            if (c.promoApplied.value) ...[
                              SizedBox(height: 8.h),
                              _RowText(
                                'Promo',
                                '- ${c.money(c.promoOff.value)}',
                              ),
                            ],
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
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
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textBody,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  c.money(c.reviewTotal),
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.5,
                                    color: AppColors.maroonAccent,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
              CheckoutFooter(
                inset: true,
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
                              color: AppColors.black400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    CartGoldButton(label: 'Place Order', onTap: c.placeOrder),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.icon,
    required this.title,
    required this.onEdit,
    required this.child,
  });

  final String icon;
  final String title;
  final VoidCallback onEdit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.black50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: AppColors.maroon50,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(icon, width: 16.w, height: 16.w),
              ),
              SizedBox(width: 8.w),
              Text(
                title,
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBody,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onEdit,
                child: Text(
                  'Edit',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.maroonDark,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }
}

class _RowText extends StatelessWidget {
  const _RowText(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              color: AppColors.black400,
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.hankenGrotesk(
            fontSize: 14.sp,
            color: AppColors.textBody,
          ),
        ),
      ],
    );
  }
}
