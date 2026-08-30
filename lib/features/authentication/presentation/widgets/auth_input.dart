import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';

void showAuthMessage(String message) {
  Get.closeAllSnackbars();
  Get.snackbar(
    '',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.maroon800,
    colorText: AppColors.maroon50,
    margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
    titleText: const SizedBox.shrink(),
    messageText: Text(
      message,
      textAlign: TextAlign.center,
      style: GoogleFonts.hankenGrotesk(
        fontSize: 14,
        height: 1.4,
        color: AppColors.maroon50,
      ),
    ),
  );
}

InputDecoration authBareDecoration({
  String? hint,
  Color hintColor = AppColors.black300,
  bool collapsed = true,
}) {
  return InputDecoration(
    isDense: true,
    isCollapsed: collapsed,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintText: hint,
    hintStyle: GoogleFonts.hankenGrotesk(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.6,
      color: hintColor,
    ),
    counterText: '',
    filled: false,
    contentPadding: EdgeInsets.zero,
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
  );
}

class AuthThemeScope extends StatelessWidget {
  const AuthThemeScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          filled: false,
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
      child: child,
    );
  }
}
