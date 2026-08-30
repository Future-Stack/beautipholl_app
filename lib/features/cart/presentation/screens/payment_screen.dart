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

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

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
              const CheckoutHeader(title: 'Payment', activeStep: 2),
              Expanded(
                child: ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
                  children: [
                    Container(
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
                            'Card Details',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              color: AppColors.textBody,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          _Input(
                            controller: c.cardNumber,
                            hint: 'Card number',
                            prefix: IconPath.cartCard,
                            keyboardType: TextInputType.number,
                            inputFormatters: const [_CardNumberFormatter()],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: _Input(
                                  controller: c.expiry,
                                  hint: 'Expiry (MM/YY)',
                                  keyboardType: TextInputType.number,
                                  inputFormatters: const [_ExpiryFormatter()],
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                flex: 3,
                                child: Obx(
                                  () => _Input(
                                    controller: c.cvv,
                                    hint: 'CVV',
                                    obscure: !c.showCvv.value,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(4),
                                    ],
                                    suffix: GestureDetector(
                                      onTap: () => c.showCvv.toggle(),
                                      child: SvgPicture.asset(
                                        IconPath.cartEye,
                                        width: 14.w,
                                        height: 14.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          _Input(
                            controller: c.cardName,
                            hint: 'Name on card',
                            textCapitalization: TextCapitalization.words,
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Save card for future orders',
                                      style: GoogleFonts.hankenGrotesk(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        height: 1.3,
                                        color: AppColors.textBody,
                                      ),
                                    ),
                                    Text(
                                      'Securely stored, never shared',
                                      style: GoogleFonts.hankenGrotesk(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        height: 1.4,
                                        color: AppColors.black400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Obx(
                                () => GestureDetector(
                                  onTap: c.saveCard.toggle,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    width: 44.w,
                                    height: 24.h,
                                    decoration: BoxDecoration(
                                      color: c.saveCard.value
                                          ? AppColors.maroonAccent
                                          : AppColors.black100,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Align(
                                      alignment: c.saveCard.value
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Container(
                                        margin: EdgeInsets.all(2.w),
                                        width: 20.w,
                                        height: 20.w,
                                        decoration: BoxDecoration(
                                          color: AppColors.burgundy50,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.2,
                                              ),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CheckoutFooter(
                child: CartGoldButton(
                  label: 'Review Order',
                  onTap: c.reviewOrder,
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
    this.prefix,
    this.suffix,
    this.obscure = false,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String hint;
  final String? prefix;
  final Widget? suffix;
  final bool obscure;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      style: GoogleFonts.hankenGrotesk(
        fontSize: 14.sp,
        color: AppColors.textBody,
      ),
      decoration: InputDecoration(
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: GoogleFonts.hankenGrotesk(
          fontSize: 14.sp,
          color: AppColors.textBody.withValues(alpha: 0.5),
        ),
        prefixIcon: prefix == null
            ? null
            : Padding(
                padding: EdgeInsets.all(13.w),
                child: SvgPicture.asset(prefix!, width: 16.w, height: 16.w),
              ),
        suffixIcon: suffix == null
            ? null
            : Padding(padding: EdgeInsets.all(13.w), child: suffix),
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

class _CardNumberFormatter extends TextInputFormatter {
  const _CardNumberFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limited = digits.length > 16 ? digits.substring(0, 16) : digits;
    final buffer = StringBuffer();
    for (var i = 0; i < limited.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(limited[i]);
    }
    final text = buffer.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class _ExpiryFormatter extends TextInputFormatter {
  const _ExpiryFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limited = digits.length > 4 ? digits.substring(0, 4) : digits;
    final text = limited.length <= 2
        ? limited
        : '${limited.substring(0, 2)}/${limited.substring(2)}';
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
