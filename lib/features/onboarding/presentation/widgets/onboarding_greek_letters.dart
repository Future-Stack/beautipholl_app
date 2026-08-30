import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';

class OnboardingGreekLetters extends StatelessWidget {
  const OnboardingGreekLetters({
    super.key,
    required this.left,
    required this.top,
  });

  final double left;
  final double top;

  static const _columns = [
    ['ΑΦΑ', 'ΑΚΑ', 'ΚΑΨ'],
    ['ΩΨΦ', 'ΔΣΘ', 'ΦΒΣ'],
    ['ΖΦΒ', 'ΣΓΡ', 'ΙΦΘ'],
  ];

  @override
  Widget build(BuildContext context) {
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = AppColors.burgundy100.withValues(alpha: 0.62);

    return Positioned(
      left: left.w,
      top: (top - 32).h,
      width: 423.05.w,
      height: 360.58.h,
      child: IgnorePointer(
        child: ClipRect(
          child: Align(
            alignment: Alignment.center,
            child: Transform.rotate(
              angle: -10.46 * 3.1415926535 / 180,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: _columns.map((column) {
                  return SizedBox(
                    width: 100.w,
                    height: 148.52.h,
                    child: Stack(
                      children: [
                        for (var i = 0; i < column.length; i++)
                          Positioned(
                            left: (i * 19.8).w,
                            top: (i * 49.51).h,
                            child: Text(
                              column[i],
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 30.942.sp,
                                fontWeight: FontWeight.w100,
                                fontStyle: FontStyle.italic,
                                height: 1.6,
                                foreground: stroke,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
