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

class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({super.key});

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
        body: Column(
          children: [
            const CheckoutHeader(title: 'Delivery', activeStep: 1),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.w),
                children: [
                  Obx(() {
                    return Column(
                      children: [
                        for (
                          var i = 0;
                          i < CheckoutController.shippingOptions.length;
                          i++
                        ) ...[
                          _ShippingTile(
                            index: i,
                            selected: c.shippingIndex.value == i,
                            onTap: () => c.selectShipping(i),
                          ),
                          if (i < CheckoutController.shippingOptions.length - 1)
                            SizedBox(height: 8.h),
                        ],
                      ],
                    );
                  }),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.burgundy50,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: SvgPicture.asset(
                            IconPath.cartShieldSm,
                            width: 15.w,
                            height: 15.w,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            "All orders are tracked and covered by The Yard's Buyer Protection Guarantee.",
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              color: AppColors.maroonDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CheckoutFooter(
              child: CartGoldButton(
                label: 'Continue to Payment',
                onTap: c.continueToPayment,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShippingTile extends StatelessWidget {
  const _ShippingTile({
    required this.index,
    required this.selected,
    required this.onTap,
  });

  final int index;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final option = CheckoutController.shippingOptions[index];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(17.w),
        decoration: BoxDecoration(
          color: selected ? AppColors.creamMap : AppColors.burgundy400,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected ? AppColors.gold : AppColors.black50,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColors.maroonAccent : Colors.transparent,
                border: Border.all(
                  color: selected ? AppColors.maroonAccent : AppColors.black100,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: AppColors.burgundy50,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    )
                  : null,
            ),
            if (selected) ...[
              SizedBox(width: 12.w),
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.maroon50,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  IconPath.cartTruck,
                  width: 20.w,
                  height: 20.w,
                ),
              ),
            ],
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                      color: selected ? AppColors.textBody : Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    option.eta,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      color: selected ? AppColors.black400 : AppColors.black100,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '\$${option.price.toStringAsFixed(2)}',
              style: GoogleFonts.hankenGrotesk(
                fontSize: 14.sp,
                fontWeight: selected ? FontWeight.w500 : FontWeight.w600,
                color: selected ? AppColors.textBody : AppColors.gold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
