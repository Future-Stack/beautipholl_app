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

class DisputeScreen extends StatelessWidget {
  const DisputeScreen({super.key});

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
                    'Open a Dispute',
                    style: GoogleFonts.marcellus(
                      fontSize: 24.sp,
                      height: 1.2,
                      color: AppColors.burgundy,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const _OrderContextCard(),
                  SizedBox(height: 16.h),
                  Obx(() {
                    return Column(
                      children: [
                        _DropdownField(
                          value: c.disputeReason.value.isEmpty
                              ? 'Select a dispute reason'
                              : c.disputeReason.value,
                          placeholder: c.disputeReason.value.isEmpty,
                          onTap: () => c.disputeDropdownOpen.toggle(),
                        ),
                        if (c.disputeDropdownOpen.value)
                          _ReasonMenu(
                            options: const [
                              'Select a dispute reason',
                              ...CheckoutController.disputeReasons,
                            ],
                            selected: c.disputeReason.value.isEmpty
                                ? 'Select a dispute reason'
                                : c.disputeReason.value,
                            onSelect: c.selectDisputeReason,
                          ),
                      ],
                    );
                  }),
                  SizedBox(height: 16.h),
                  _TextArea(
                    controller: c.disputeDetails,
                    hint:
                        'Tell us what happened. Include dates, amounts, or any communication with the vendor…',
                    onChanged: (value) =>
                        c.detailsFilled.value = value.trim().isNotEmpty,
                  ),
                  SizedBox(height: 16.h),
                  const _EvidenceBlock(),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.burgundy50,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.burgundy100),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          IconPath.cartInfo,
                          width: 18.w,
                          height: 18.w,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Vendor has 48 hours to respond. ',
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                    letterSpacing: -0.42,
                                    color: AppColors.burgundy400,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'If the dispute is unresolved after that window, our team will step in and review the case directly.',
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                    color: AppColors.burgundy400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Obx(() {
                    final enabled = c.canSubmitDispute;
                    return GestureDetector(
                      onTap: c.submitDispute,
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
                          'Submit Dispute',
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

class _OrderContextCard extends StatelessWidget {
  const _OrderContextCard();

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
          _meta('Order Number', 'ORD-2841', boldValue: true),
          SizedBox(height: 16.h),
          _meta('Order Date', 'Jul 18, 2026'),
          SizedBox(height: 16.h),
          _meta('Vendor', 'Omega Gear Co.', boldValue: true),
          SizedBox(height: 16.h),
          Text(
            'Items',
            style: GoogleFonts.hankenGrotesk(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black300,
            ),
          ),
          SizedBox(height: 4.h),
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

  Widget _meta(String label, String value, {bool boldValue = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.hankenGrotesk(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black300,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.hankenGrotesk(
            fontSize: 14.sp,
            fontWeight: boldValue ? FontWeight.w600 : FontWeight.w400,
            letterSpacing: boldValue ? -0.42 : 0,
            color: boldValue ? AppColors.burgundy : AppColors.textBody,
          ),
        ),
      ],
    );
  }
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.value,
    required this.placeholder,
    required this.onTap,
  });

  final String value;
  final bool placeholder;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 14.sp,
                  height: 1.5,
                  color: placeholder ? AppColors.black200 : AppColors.textBody,
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
    );
  }
}

class _ReasonMenu extends StatelessWidget {
  const _ReasonMenu({
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  final List<String> options;
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
          for (final option in options)
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

class _TextArea extends StatelessWidget {
  const _TextArea({
    required this.controller,
    required this.hint,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: 6,
      style: GoogleFonts.hankenGrotesk(
        fontSize: 14.sp,
        height: 1.5,
        color: AppColors.textBody,
      ),
      decoration: InputDecoration(
        hintText: hint,
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
    );
  }
}

class _EvidenceBlock extends StatelessWidget {
  const _EvidenceBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  fontWeight: FontWeight.w500,
                  color: AppColors.black200,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: Get.find<CheckoutController>().attachDisputeFile,
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
          final files = Get.find<CheckoutController>().disputeFiles;
          if (files.isEmpty) return const SizedBox.shrink();
          return Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                for (final file in files)
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
      ],
    );
  }
}
