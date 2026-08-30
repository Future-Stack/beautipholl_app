import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../features/cart/presentation/widgets/orders_app_bar.dart';
import '../../controllers/profile_controller.dart';
import '../../models/profile_models.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

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
            const OrdersAppBar(title: 'My Orders'),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
                itemCount: ProfileController.orders.length,
                separatorBuilder: (_, _) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  return _OrderCard(
                    order: ProfileController.orders[index],
                    onTap: c.openOrderDetails,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order, required this.onTap});

  final ProfileOrder order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.id,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.hankenGrotesk(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                          color: AppColors.textBody,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        order.placed,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: order.inProgress
                        ? AppColors.gold50
                        : AppColors.completedGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Text(
                    order.status,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: order.inProgress
                          ? AppColors.goldDeep
                          : AppColors.completedGreen,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                SvgPicture.asset(
                  IconPath.shopArrowRight,
                  width: 24.w,
                  height: 24.w,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Container(height: 1, color: AppColors.black50),
            SizedBox(height: 12.h),
            Row(
              children: [
                Text(
                  'Total',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: AppColors.black400,
                  ),
                ),
                const Spacer(),
                Text(
                  '\$${order.total.toStringAsFixed(2)}',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    letterSpacing: -0.42,
                    color: AppColors.maroonAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
