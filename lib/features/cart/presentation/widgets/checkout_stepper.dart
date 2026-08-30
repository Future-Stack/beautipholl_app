import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';

class CheckoutStepper extends StatelessWidget {
  const CheckoutStepper({super.key, required this.activeStep});

  final int activeStep;

  static const _labels = ['Address', 'Delivery', 'Payment', 'Review'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < _labels.length; i++) ...[
          _StepDot(index: i, activeStep: activeStep, label: _labels[i]),
          if (i < _labels.length - 1)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.h, left: 8.w, right: 8.w),
                child: Container(
                  height: 2.h,
                  decoration: BoxDecoration(
                    color: i < activeStep ? AppColors.gold : AppColors.black50,
                    borderRadius: BorderRadius.circular(1.r),
                  ),
                ),
              ),
            ),
        ],
      ],
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({
    required this.index,
    required this.activeStep,
    required this.label,
  });

  final int index;
  final int activeStep;
  final String label;

  @override
  Widget build(BuildContext context) {
    final done = index < activeStep;
    final current = index == activeStep;
    final Color circle;
    final Color text;
    if (done) {
      circle = AppColors.gold;
      text = AppColors.gold;
    } else if (current) {
      circle = AppColors.maroon400;
      text = AppColors.maroon400;
    } else {
      circle = AppColors.burgundy50;
      text = AppColors.black200;
    }

    return Column(
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(color: circle, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: done
              ? SvgPicture.asset(
                  IconPath.cartStepCheck,
                  width: 11.w,
                  height: 11.w,
                )
              : Text(
                  '${index + 1}',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    color: current ? Colors.white : const Color(0xFFC48493),
                  ),
                ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.hankenGrotesk(
            fontSize: 12.sp,
            fontWeight: done || current ? FontWeight.w500 : FontWeight.w400,
            height: done || current ? 1.3 : 1.4,
            color: text,
          ),
        ),
      ],
    );
  }
}
