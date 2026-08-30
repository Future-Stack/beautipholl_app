import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../../../features/authentication/presentation/widgets/auth_input.dart';
import '../../../../routes/app_routes.dart';
import '../../controllers/profile_controller.dart';
import '../widgets/profile_app_bar.dart';

class EliteMembershipScreen extends StatelessWidget {
  const EliteMembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Column(
          children: [
            const ProfileAppBar(title: 'Your Membership'),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 32.h),
                children: [
                  Obx(() => _StatusCard(annual: c.annualSelected.value)),
                  SizedBox(height: 16.h),
                  const _CreditsCard(),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: AppColors.black50),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 13.h),
                          child: Text(
                            'Your Benefits',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              color: AppColors.textBody,
                            ),
                          ),
                        ),
                        const Divider(height: 1, color: AppColors.black50),
                        for (var i = 0; i < ProfileController.perks.length; i++)
                          _BenefitRow(
                            icon: ProfileController.perks[i].icon,
                            label: ProfileController.perks[i].label,
                            last: i == ProfileController.perks.length - 1,
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  const _BillingCard(),
                  SizedBox(height: 24.h),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoute.eliteCancelScreen),
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
                        'Cancel Membership',
                        style: GoogleFonts.hankenGrotesk(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          color: AppColors.black400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Your benefits stay active until Aug 20, 2026',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      color: AppColors.black300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.annual});

  final bool annual;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.burgundy,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: const BoxDecoration(
                  color: AppColors.maroonAccent,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  ImagePath.eliteCrown,
                  width: 24.w,
                  height: 24.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Elite Member',
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                            color: AppColors.gold300,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 9.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.gold300.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(
                              color: AppColors.gold300.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            annual ? 'ANNUAL' : 'MONTHLY',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                              color: AppColors.gold300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      annual ? '\$99/year' : '\$9.99/mo',
                      style: GoogleFonts.hankenGrotesk(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: AppColors.black100,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.1)),
          SizedBox(height: 12.h),
          _DarkKv(label: 'Current cycle', value: 'Jul 21, 2026 – Aug 20, 2026'),
          SizedBox(height: 8.h),
          _DarkKv(
            label: 'Renews',
            value: annual ? 'Aug 21, 2026 · \$99.00' : 'Aug 21, 2026 · \$9.99',
          ),
        ],
      ),
    );
  }
}

class _DarkKv extends StatelessWidget {
  const _DarkKv({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.hankenGrotesk(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: AppColors.black200,
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.hankenGrotesk(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              height: 1.3,
              color: AppColors.burgundy50,
            ),
          ),
        ),
      ],
    );
  }
}

class _CreditsCard extends StatelessWidget {
  const _CreditsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.black50),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Shipping Credits',
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  color: AppColors.textBody,
                ),
              ),
              const Spacer(),
              Text(
                '\$3.00 left',
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                  color: AppColors.maroonAccent,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: LinearProgressIndicator(
              value: 0.7,
              minHeight: 8.h,
              backgroundColor: AppColors.black50,
              color: AppColors.gold,
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Text(
                '\$7.00 of \$10.00 used',
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                  color: AppColors.black300,
                ),
              ),
              const Spacer(),
              Text(
                'Resets Aug 21, 2026',
                style: GoogleFonts.hankenGrotesk(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                  color: AppColors.black300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({
    required this.icon,
    required this.label,
    required this.last,
  });

  final String icon;
  final String label;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(bottom: BorderSide(color: AppColors.black50)),
      ),
      child: Row(
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              color: AppColors.offWhite400,
              borderRadius: BorderRadius.circular(10.r),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(icon, width: 15.w, height: 15.w),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              label,
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

class _BillingCard extends StatelessWidget {
  const _BillingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.black50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 13.h),
            child: Text(
              'Billing',
              style: GoogleFonts.hankenGrotesk(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                height: 1.5,
                color: AppColors.textBody,
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.black50),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Container(
                  width: 36.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: AppColors.burgundy,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'VISA',
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: AppColors.gold,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    '•••• 4242',
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: AppColors.textBody,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => showAuthMessage('Payment methods coming next.'),
                  behavior: HitTestBehavior.opaque,
                  child: Text(
                    'Change',
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      color: AppColors.maroonDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.black50),
          const _BillRow(
            date: 'Jul 21, 2026',
            plan: 'Elite Annual',
            amount: '\$9.99',
            status: 'Active',
            active: true,
          ),
          const Divider(height: 1, color: AppColors.black50),
          const _BillRow(
            date: 'Jun 21, 2026',
            plan: 'Elite Annual',
            amount: '\$9.99',
            status: 'Paid',
          ),
          const Divider(height: 1, color: AppColors.black50),
          const _BillRow(
            date: 'May 21, 2026',
            plan: 'Elite Annual',
            amount: '\$9.99',
            status: 'Paid',
          ),
        ],
      ),
    );
  }
}

class _BillRow extends StatelessWidget {
  const _BillRow({
    required this.date,
    required this.plan,
    required this.amount,
    required this.status,
    this.active = false,
  });

  final String date;
  final String plan;
  final String amount;
  final String status;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                    color: AppColors.textBody,
                  ),
                ),
                Text(
                  plan,
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    color: AppColors.black300,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.hankenGrotesk(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              height: 1.2,
              letterSpacing: -0.42,
              color: AppColors.textBody,
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: active ? AppColors.gold50 : AppColors.offWhite400,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Text(
              status,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: active ? AppColors.goldDeep : AppColors.black400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
