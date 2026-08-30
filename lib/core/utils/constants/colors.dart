import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors (Figma: Customer Mobile App)
  static const Color primary = Color(0xFF51131F);
  static const Color maroon700 = Color(0xFF51131F);
  static const Color gold = Color(0xFFC9A84C);
  static const Color maroon50 = Color(0xFFF9E7E8);
  static const Color maroon300 = Color(0xFFE55970);
  static const Color burgundy = Color(0xFF1A0A0E);
  static const Color burgundy50 = Color(0xFFEDDFE2);
  static const Color burgundy100 = Color(0xFFDEC2C8);
  static const Color burgundy300 = Color(0xFF935262);
  static const Color burgundy400 = Color(0xFF522B35);
  static const Color burgundy500 = Color(0xFFC45A6E);
  static const Color burgundy900 = Color(0xFF080203);
  static const Color burgundyDark = Color(0xFF4E1018);
  static const Color maroon800 = Color(0xFF3C0C15);
  static const Color maroon600 = Color(0xFF671B29);
  static const Color maroonAccent = Color(0xFF7B2233);
  static const Color maroon400 = Color(0xFFB6374F);
  static const Color creamMap = Color(0xFFFDF9F2);
  static const Color maroon100 = Color(0xFFF4CED2);
  static const Color maroon200 = Color(0xFFEB96A1);
  static const Color maroon950 = Color(0xFF1C0306);
  static const Color gold50 = Color(0xFFFDF6E8);
  static const Color gold100 = Color(0xFFFCECCF);
  static const Color gold200 = Color(0xFFF9D990);
  static const Color gold300 = Color(0xFFEFC85C);
  static const Color gold400 = Color(0xFFDBB854);
  static const Color gold600 = Color(0xFF9E833A);
  static const Color gold700 = Color(0xFF756129);
  static const Color goldDeep = Color(0xFF7A5E1A);
  static const Color gold800 = Color(0xFF4F4119);
  static const Color goldBright = Color(0xFFD4A843);
  static const Color offWhite = Color(0xFFF5F4F0);
  static const Color offWhite400 = Color(0xFFF7F6F3);
  static const Color maroonDark = Color(0xFF5C1520);
  static const Color textBody = Color(0xFF333333);
  static const Color black50 = Color(0xFFE8E8E8);
  static const Color black400 = Color(0xFF575757);
  static const Color black500 = Color(0xFF333333);
  static const Color successGreen = Color(0xFF029F51);
  static const Color completedGreen = Color(0xFF08AF26);
  static const Color logoutRed = Color(0xFFE8002C);
  static const Color offWhite300 = Color(0xFFFAF9F7);
  static const Color vendorRose = Color(0xFF6F2A36);
  static const Color burgundy200 = Color(0xFFE3B5BD);
  static const Color black900 = Color(0xFF0E0E0E);
  static const Color black100 = Color(0xFFD1D1D1);
  static const Color black200 = Color(0xFFA6A6A6);
  static const Color black300 = Color(0xFF7F7F7F);
  static const Color textBlack = Color(0xFF222222);
  static const Color secondary = Color(0xFFC9A84C);
  static const Color accent = Color(0xFFE55970);
  static const Color cream = Color(0xFFF9E7E8);

  // Gradient Colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [Color(0xFFFFF9A9), Color(0xFFFAD0C4), Color(0xFFFAD0C4)],
  );
  // Text Colors
  static const Color textPrimary = Color(
    0xFF212121,
  ); // Darker shade for better readability
  static const Color textSecondary = Color(
    0xFF757575,
  ); // Neutral grey for secondary text
  static const Color textWhite = Colors.white;

  // Background Colors
  static const Color backgroundLight = Color(
    0xFFF9FAFB,
  ); // Light neutral for clean look
  static const Color backgroundDark = Color(
    0xFF121212,
  ); // Dark background for contrast in dark mode
  static const Color primaryBackground = Color(
    0xFFFFFFFF,
  ); // Pure white for primary content areas

  // Surface Colors
  static const Color surfaceLight = Color(
    0xFFE0E0E0,
  ); // Light grey for elevated surfaces
  static const Color surfaceDark = Color(
    0xFF2C2C2C,
  ); // Dark grey for elevated surfaces in dark mode

  // Container Colors
  static const Color lightContainer = Color(
    0xFFF1F8E9,
  ); // Soft green for a subtle highlight

  // Utility Colors
  static const Color success = Color(0xFF4CAF50); // Green for success messages
  static const Color warning = Color(0xFFFFA726); // Orange for warnings
  static const Color error = Color(0xFFF44336); // Red for error messages
  static const Color info = Color(
    0xFF29B6F6,
  ); // Blue for informational messages
}
