import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../../../features/cart/presentation/widgets/cart_gold_button.dart';
import '../../controllers/profile_controller.dart';
import '../../models/profile_models.dart';

class EliteJoinScreen extends StatelessWidget {
  const EliteJoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                color: AppColors.burgundy,
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: Get.back,
                              behavior: HitTestBehavior.opaque,
                              child: SizedBox(
                                width: 24.w,
                                height: 24.w,
                                child: SvgPicture.asset(
                                  IconPath.shopArrowLeft,
                                  width: 24.w,
                                  height: 24.w,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Text(
                                'The Yard Elite',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.marcellus(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Image.asset(
                          ImagePath.eliteEmblem,
                          width: 160.w,
                          height: 160.w,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Shop Smarter. Shop First.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.marcellus(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.2,
                            color: AppColors.gold,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Exclusive perks for Divine Nine community members who shop The Yard.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.6,
                            color: AppColors.burgundy50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 24.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Obx(() {
                    final annual = c.annualSelected.value;
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: AppColors.black50),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _PlanTab(
                              title: 'Monthly',
                              price: '\$9.99/mo',
                              selected: !annual,
                              onTap: () => c.selectAnnual(false),
                            ),
                          ),
                          Expanded(
                            child: _PlanTab(
                              title: 'Annual',
                              price: '\$99/yr',
                              selected: annual,
                              badge: 'SAVE \$21',
                              onTap: () => c.selectAnnual(true),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 12.h),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: AppColors.black50),
                    ),
                    child: Column(
                      children: [
                        for (var i = 0; i < ProfileController.perks.length; i++)
                          _PerkRow(
                            perk: ProfileController.perks[i],
                            last: i == ProfileController.perks.length - 1,
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Unused shipping credits expire each billing cycle. Cancel anytime benefits continue through your current billing period.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      color: AppColors.black400,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Obx(
                    () => CartGoldButton(
                      label: c.joinPriceLabel,
                      onTap: c.joinElite,
                      leading: SvgPicture.asset(
                        IconPath.eliteJoinCrown,
                        width: 24.w,
                        height: 24.w,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: Get.back,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: AppColors.black50,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Not now',
                        style: GoogleFonts.hankenGrotesk(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          color: AppColors.black400,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanTab extends StatelessWidget {
  const _PlanTab({
    required this.title,
    required this.price,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  final String title;
  final String price;
  final bool selected;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: selected ? AppColors.gold : const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    color: selected
                        ? AppColors.burgundy
                        : AppColors.offWhite300,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  price,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: selected
                        ? AppColors.burgundy400
                        : AppColors.offWhite400,
                  ),
                ),
              ],
            ),
          ),
          if (badge != null)
            Positioned(
              right: 8.w,
              top: -8.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.maroonAccent,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Text(
                  badge!,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    color: AppColors.gold300,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PerkRow extends StatelessWidget {
  const _PerkRow({required this.perk, required this.last});

  final ElitePerk perk;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(bottom: BorderSide(color: AppColors.black50)),
      ),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: AppColors.offWhite400,
              borderRadius: BorderRadius.circular(10.r),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(perk.icon, width: 16.w, height: 16.w),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              perk.label,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 1.6,
                color: AppColors.textBody,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
