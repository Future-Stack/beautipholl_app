import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../controllers/organization_controller.dart';
import '../../models/organization_model.dart';
import '../widgets/auth_input.dart';
import '../widgets/auth_pinned_scaffold.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_search_field.dart';

class OrganizationScreen extends StatelessWidget {
  const OrganizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<OrganizationController>();

    return AuthThemeScope(
      child: AuthPinnedScaffold(
        backgroundColor: AppColors.burgundy,
        header: Column(
          children: [
            Text(
              'Which organization are you part of?',
              textAlign: TextAlign.center,
              style: GoogleFonts.marcellus(
                fontSize: 32.sp,
                height: 1.2,
                color: AppColors.gold,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'This helps us personalize your shop with your official colourways. You can change  this anytime.',
              textAlign: TextAlign.center,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 16.sp,
                height: 1.6,
                color: AppColors.burgundy100,
              ),
            ),
            SizedBox(height: 40.h),
            AuthSearchField(
              controller: c.searchController,
              onChanged: c.onSearch,
            ),
          ],
        ),
        middle: Obx(() {
          final list = c.filtered;
          if (list.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Text(
                'No organizations match your search.',
                textAlign: TextAlign.center,
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 16.sp,
                  height: 1.6,
                  color: AppColors.burgundy100,
                ),
              ),
            );
          }
          return Column(
            children: [
              for (var i = 0; i < list.length; i++) ...[
                if (i > 0) SizedBox(height: 12.h),
                _OrgCard(
                  org: list[i],
                  selected: c.isSelected(list[i]),
                  onTap: () => c.select(list[i]),
                ),
              ],
            ],
          );
        }),
        footer: Column(
          children: [
            GestureDetector(
              onTap: c.skip,
              child: Text(
                'Skip for now',
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  color: AppColors.gold,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            AuthPrimaryButton(label: 'Continue', onTap: c.continueNext),
            SizedBox(height: 16.h),
            Text(
              'You can update this anytime n your account settings',
              textAlign: TextAlign.center,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 12.sp,
                height: 1.4,
                color: AppColors.black100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrgCard extends StatelessWidget {
  const _OrgCard({
    required this.org,
    required this.selected,
    required this.onTap,
  });

  final OrganizationModel org;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.maroon800,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                org.image,
                width: 48.w,
                height: 48.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    org.name,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      color: AppColors.maroon50,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    org.meta,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 12.sp,
                      height: 1.4,
                      color: AppColors.maroon200,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.gold : AppColors.burgundy100,
                  width: 1.5,
                ),
                color: selected ? AppColors.gold : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
