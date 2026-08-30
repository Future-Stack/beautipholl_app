import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../controllers/checkout_controller.dart';
import '../widgets/cart_gold_button.dart';
import '../widgets/checkout_footer.dart';
import '../widgets/checkout_header.dart';

class DeliveryAddressScreen extends StatelessWidget {
  const DeliveryAddressScreen({super.key});

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
              const CheckoutHeader(title: 'Delivery Address', activeStep: 0),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    SizedBox(
                      height: 220.h,
                      width: double.infinity,
                      child: InteractiveViewer(
                        constrained: false,
                        minScale: 1,
                        maxScale: 4,
                        child: Image.asset(
                          ImagePath.cartMap,
                          width: 640.w,
                          height: 320.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.creamMap,
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.gold.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            IconPath.cartHandPin,
                            width: 16.w,
                            height: 16.w,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'Drag the map to move the pin to your exact delivery location',
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                color: AppColors.maroonDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          _WhiteCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Delivery Address',
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                    color: AppColors.textBody,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                _Field(
                                  controller: c.street,
                                  hint: 'Street Address *',
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(height: 12.h),
                                _Field(
                                  controller: c.apt,
                                  hint: 'Apt / Suite / Floor',
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: _Field(
                                        controller: c.city,
                                        hint: 'City',
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: _Field(
                                        controller: c.state,
                                        hint: 'State',
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(2),
                                          FilteringTextInputFormatter.allow(
                                            RegExp('[A-Za-z]'),
                                          ),
                                        ],
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: _Field(
                                        controller: c.zip,
                                        hint: 'ZIP',
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(5),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),
                          _WhiteCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Delivery Instructions',
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textBody,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Optional — leave a note for your carrier',
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black400,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                _Field(
                                  controller: c.instructions,
                                  hint:
                                      'e.g. Leave at door, buzz 3B on arrival...',
                                  maxLines: 3,
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
              CheckoutFooter(
                child: CartGoldButton(
                  label: 'Confirm Location',
                  onTap: c.confirmLocation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WhiteCard extends StatelessWidget {
  const _WhiteCard({required this.child});

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
      child: child,
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    this.hint,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String? hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      style: GoogleFonts.hankenGrotesk(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textBody,
      ),
      decoration: InputDecoration(
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: GoogleFonts.hankenGrotesk(
          fontSize: 14.sp,
          color: AppColors.textBody.withValues(alpha: 0.5),
        ),
        filled: true,
        fillColor: AppColors.offWhite,
        contentPadding: EdgeInsets.all(13.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
