import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../controllers/shop_controller.dart';
import '../widgets/product_card.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ShopController>();

    return ColoredBox(
      color: AppColors.offWhite,
      child: Obx(() {
        final products = c.savedProducts;
        if (products.isEmpty) {
          return const _SavedEmpty();
        }
        final tall = products.any((product) => product.membersOnly);
        return Column(
          children: [
            SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                child: Text(
                  'Saved Items',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.marcellus(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    color: AppColors.textBody,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.h,
                  crossAxisSpacing: 8.w,
                  mainAxisExtent: tall ? 268.h : 236.h,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) => ProductCard(
                  product: products[index],
                  expand: true,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _SavedEmpty extends StatelessWidget {
  const _SavedEmpty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 47.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: const BoxDecoration(
                color: AppColors.maroon50,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                IconPath.shopHeartEmpty,
                width: 32.w,
                height: 32.w,
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              'Nothing saved yet',
              textAlign: TextAlign.center,
              style: GoogleFonts.marcellus(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                height: 1.2,
                color: AppColors.textBody,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Tap the heart on any item to save it here for later.',
              textAlign: TextAlign.center,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: AppColors.black400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
