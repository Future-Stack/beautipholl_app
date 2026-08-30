import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../controllers/shop_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/shop_chip.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ShopController>();

    return ColoredBox(
      color: AppColors.offWhite,
      child: Obx(() {
        final products = c.shopProducts;
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ShopChip(
                                  label: 'All',
                                  width: 81.w,
                                  selected: c.shopCategory.value == 'All',
                                  onTap: () => c.setShopCategory('All'),
                                ),
                                SizedBox(width: 8.w),
                                ShopChip(
                                  label: 'Men',
                                  width: 81.w,
                                  selected: c.shopCategory.value == 'Men',
                                  onTap: () => c.setShopCategory('Men'),
                                ),
                                SizedBox(width: 8.w),
                                ShopChip(
                                  label: 'Women',
                                  width: 104.w,
                                  selected: c.shopCategory.value == 'Women',
                                  onTap: () => c.setShopCategory('Women'),
                                ),
                                SizedBox(width: 8.w),
                                ShopChip(
                                  label: 'Children',
                                  width: 104.w,
                                  selected: c.shopCategory.value == 'Children',
                                  onTap: () => c.setShopCategory('Children'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        const ShopFilterButton(),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${products.length}',
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                  color: AppColors.textBody,
                                ),
                              ),
                              TextSpan(
                                text: ' Results',
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  color: AppColors.black300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Short: ',
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  color: AppColors.black300,
                                ),
                              ),
                              TextSpan(
                                text: 'Popular',
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                  color: AppColors.textBody,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        SvgPicture.asset(
                          IconPath.shopChevron,
                          width: 16.w,
                          height: 16.w,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (products.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'No products match your search.',
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 14.sp,
                      color: AppColors.black400,
                    ),
                  ),
                ),
              )
            else
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.h,
                  crossAxisSpacing: 8.w,
                  mainAxisExtent: 268.h,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ProductCard(
                    product: products[index],
                    expand: true,
                  ),
                  childCount: products.length,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
