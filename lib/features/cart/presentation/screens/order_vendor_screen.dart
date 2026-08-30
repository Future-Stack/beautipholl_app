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

class OrderVendorScreen extends StatelessWidget {
  const OrderVendorScreen({super.key});

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
                  SizedBox(height: 8.h),
                  Text(
                    'Contact Omega Gear Co.',
                    style: GoogleFonts.marcellus(
                      fontSize: 24.sp,
                      height: 1.2,
                      color: AppColors.burgundy,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const _VendorContextCard(),
                  SizedBox(height: 16.h),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Category ',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.burgundy,
                          ),
                        ),
                        TextSpan(
                          text: '*',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.maroonAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Obx(() {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => c.vendorDropdownOpen.toggle(),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 11.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: AppColors.black100),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    c.vendorCategory.value.isEmpty
                                        ? 'Select a Category'
                                        : c.vendorCategory.value,
                                    style: GoogleFonts.hankenGrotesk(
                                      fontSize: 14.sp,
                                      height: 1.5,
                                      color: c.vendorCategory.value.isEmpty
                                          ? AppColors.black200
                                          : AppColors.textBody,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 18.w,
                                  color: AppColors.black200,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (c.vendorDropdownOpen.value)
                          _VendorMenu(
                            selected: c.vendorCategory.value.isEmpty
                                ? 'Select a category'
                                : c.vendorCategory.value,
                            onSelect: c.selectVendorCategory,
                          ),
                      ],
                    );
                  }),
                  SizedBox(height: 16.h),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Message ',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.burgundy,
                          ),
                        ),
                        TextSpan(
                          text: '*',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.maroonAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TextField(
                    controller: c.vendorMessage,
                    onChanged: (value) =>
                        c.messageFilled.value = value.trim().isNotEmpty,
                    maxLines: 6,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 14.sp,
                      height: 1.5,
                      color: AppColors.textBody,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Write a message to Omega Gear co...',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintStyle: GoogleFonts.hankenGrotesk(
                        fontSize: 14.sp,
                        height: 1.5,
                        color: AppColors.black200,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(13.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Supporting Evidence ',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.burgundy,
                          ),
                        ),
                        TextSpan(
                          text: '(optional)',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 14.sp,
                            color: AppColors.black200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: c.attachVendorFile,
                    child: Container(
                      height: 39.5.h,
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.black100),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            IconPath.cartAttach,
                            width: 16.w,
                            height: 16.w,
                          ),
                          SizedBox(width: 8.w),
                          Flexible(
                            child: Text(
                              'Attach Photos or Files',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black400,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'JPG, PNG, PDF',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 12.sp,
                              color: AppColors.black200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(() {
                    if (c.vendorFiles.isEmpty) return const SizedBox.shrink();
                    return Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: [
                          for (final file in c.vendorFiles)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.burgundy50,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                file,
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 12.sp,
                                  color: AppColors.burgundy400,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 16.h),
                  Obx(() {
                    final enabled = c.canSendVendor;
                    return GestureDetector(
                      onTap: c.sendToVendor,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: enabled
                              ? AppColors.burgundy
                              : AppColors.black100,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Send to Vendor',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: enabled ? Colors.white : AppColors.black300,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VendorContextCard extends StatelessWidget {
  const _VendorContextCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.burgundy50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.burgundy100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Number',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black300,
            ),
          ),
          Text(
            'ORD-2841',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.42,
              color: AppColors.burgundy,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Order Date',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black300,
            ),
          ),
          Text(
            'Jul 18, 2026',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              color: AppColors.textBody,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Vendor',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black300,
            ),
          ),
          Text(
            'Omega Gear Co.',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.42,
              color: AppColors.burgundy,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Items',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black300,
            ),
          ),
          Text(
            'Omega Psi Phi Bomber Jacket ×1',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              height: 1.5,
              color: AppColors.textBody,
            ),
          ),
          Text(
            'Q-Dog Shield Pin ×2',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              height: 1.5,
              color: AppColors.textBody,
            ),
          ),
        ],
      ),
    );
  }
}

class _VendorMenu extends StatelessWidget {
  const _VendorMenu({required this.selected, required this.onSelect});

  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.black100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final option in [
            'Select a category',
            ...CheckoutController.vendorCategories,
          ])
            GestureDetector(
              onTap: () => onSelect(option),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                color: selected == option
                    ? AppColors.maroon400
                    : Colors.transparent,
                child: Text(
                  option,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    height: 1.5,
                    color: selected == option
                        ? AppColors.black50
                        : AppColors.black200,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
