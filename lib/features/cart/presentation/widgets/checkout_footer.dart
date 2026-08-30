import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutFooter extends StatelessWidget {
  const CheckoutFooter({
    super.key,
    required this.child,
    this.inset = false,
    this.safeBottom = true,
  });

  final Widget child;
  final bool inset;
  final bool safeBottom;

  @override
  Widget build(BuildContext context) {
    final box = Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: inset ? BorderRadius.circular(16.r) : BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 2.2,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: child,
    );

    final padded = inset
        ? Padding(padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h), child: box)
        : box;

    if (!safeBottom) return padded;
    return SafeArea(top: false, child: padded);
  }
}
