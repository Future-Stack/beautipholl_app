import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../features/cart/presentation/widgets/cart_gold_button.dart';
import '../../../../features/cart/presentation/widgets/checkout_footer.dart';
import '../../controllers/profile_controller.dart';
import '../widgets/profile_app_bar.dart';

class HelpTicketScreen extends StatelessWidget {
  const HelpTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              const ProfileAppBar(title: 'Open a Ticket'),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    Obx(() {
                      if (c.ticketRegarding.value.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 17.w,
                            vertical: 13.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.gold50,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(color: AppColors.gold),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Regarding: ${c.ticketRegarding.value}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                    color: AppColors.goldDeep,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: c.clearRegarding,
                                behavior: HitTestBehavior.opaque,
                                child: SvgPicture.asset(
                                  IconPath.helpTicketClose,
                                  width: 16.w,
                                  height: 16.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    Container(
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
                          _Input(controller: c.ticketSubject, hint: 'Subject'),
                          SizedBox(height: 16.h),
                          Obx(
                            () => _CategoryField(
                              value: c.ticketCategory.value,
                              onSelect: (value) {
                                c.ticketCategory.value = value;
                                c.ticketRegarding.value = value;
                              },
                            ),
                          ),
                          SizedBox(height: 16.h),
                          _Input(
                            controller: c.ticketOrder,
                            hint: 'Order number (optional)',
                          ),
                          SizedBox(height: 16.h),
                          _Input(
                            controller: c.ticketMessage,
                            hint:
                                'Describe your issue in as much detail as possible...',
                            maxLines: 6,
                          ),
                          SizedBox(height: 16.h),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Attachments ',
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                    color: AppColors.black400,
                                  ),
                                ),
                                TextSpan(
                                  text: '(optional — useful for damaged items)',
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                    color: AppColors.black300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          GestureDetector(
                            onTap: c.attachTicketFile,
                            behavior: HitTestBehavior.opaque,
                            child: CustomPaint(
                              painter: _DashedRRectPainter(
                                color: AppColors.black100,
                                radius: 14.r,
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 17.w,
                                  vertical: 11.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.offWhite,
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      IconPath.helpTicketAttach,
                                      width: 14.w,
                                      height: 14.w,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Attach Photo',
                                      style: GoogleFonts.hankenGrotesk(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5,
                                        color: AppColors.black400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Obx(() {
                            if (c.ticketFiles.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Wrap(
                                spacing: 8.w,
                                runSpacing: 8.h,
                                children: [
                                  for (final file in c.ticketFiles)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 6.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.offWhite,
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Text(
                                        file,
                                        style: GoogleFonts.hankenGrotesk(
                                          fontSize: 12.sp,
                                          color: AppColors.black400,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CheckoutFooter(
                child: Obx(
                  () => Opacity(
                    opacity: c.ticketReady.value ? 1 : 0.5,
                    child: CartGoldButton(
                      label: 'Submit',
                      onTap: c.submitTicket,
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
}

class _Input extends StatelessWidget {
  const _Input({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(13.w),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        cursorColor: AppColors.gold,
        style: GoogleFonts.hankenGrotesk(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          height: maxLines > 1 ? 1.6 : 1,
          color: AppColors.textBody,
        ),
        decoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.hankenGrotesk(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textBody.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}

class _CategoryField extends StatelessWidget {
  const _CategoryField({required this.value, required this.onSelect});

  final String value;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelect,
      offset: const Offset(0, 48),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      itemBuilder: (context) => [
        for (final option in ProfileController.ticketCategories)
          PopupMenuItem(
            value: option,
            child: Text(
              option,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 14.sp,
                color: AppColors.textBody,
              ),
            ),
          ),
      ],
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(13.w),
        decoration: BoxDecoration(
          color: AppColors.offWhite,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: AppColors.textBody,
                ),
              ),
            ),
            SvgPicture.asset(
              IconPath.helpTicketDown,
              width: 16.w,
              height: 16.w,
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  const _DashedRRectPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0.5, 0.5, size.width - 1, size.height - 1),
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const dash = 4.0;
    const gap = 3.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = (distance + dash).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}
