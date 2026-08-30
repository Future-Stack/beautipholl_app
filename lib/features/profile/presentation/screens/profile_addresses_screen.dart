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
import '../../../../features/cart/presentation/widgets/checkout_footer.dart';
import '../../controllers/profile_controller.dart';
import '../../models/profile_models.dart';
import '../widgets/profile_app_bar.dart';

class ProfileAddressesScreen extends StatelessWidget {
  const ProfileAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              const ProfileAppBar(title: 'Delivery Address'),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    _MapPreview(controller: c),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(13.w, 9.h, 13.w, 9.h),
                        decoration: BoxDecoration(
                          color: AppColors.gold50,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(color: const Color(0xFFE8C97A)),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              IconPath.cartHandPin,
                              width: 14.w,
                              height: 14.w,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'Drag the map to move the pin to your exact delivery location',
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                  color: AppColors.goldDeep,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(color: AppColors.black50),
                        ),
                        child: Obx(() {
                          final selected = c.selectedAddressIndex.value;
                          final addresses = c.savedAddresses;
                          if (addresses.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Text(
                                'No saved addresses yet. Add one below.',
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 14.sp,
                                  color: AppColors.black400,
                                ),
                              ),
                            );
                          }
                          return Column(
                            children: [
                              for (var i = 0; i < addresses.length; i++) ...[
                                if (i > 0) SizedBox(height: 12.h),
                                _SavedAddress(
                                  address: addresses[i],
                                  selected: selected == i,
                                  onSelect: () => c.selectAddress(i),
                                  onChange: () => c.editAddress(i),
                                ),
                              ],
                            ],
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(17.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(color: AppColors.black50),
                        ),
                        child: Column(
                          key: c.addressFormKey,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                c.editingIndex.value >= 0
                                    ? 'Edit Delivery Address'
                                    : 'Add New Delivery Address',
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 1.6,
                                  color: AppColors.textBody,
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            _Field(
                              hint: 'Street Address *',
                              controller: c.street,
                              focusNode: c.streetFocus,
                            ),
                            SizedBox(height: 12.h),
                            _Field(
                              hint: 'Apt / Suite / Floor',
                              controller: c.apt,
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: _Field(
                                    hint: 'City',
                                    controller: c.city,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: _Field(
                                    hint: 'State',
                                    controller: c.state,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  flex: 2,
                                  child: _Field(
                                    hint: 'ZIP',
                                    controller: c.zip,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CheckoutFooter(
                child: CartGoldButton(
                  label: 'Save Changes',
                  onTap: c.saveAddress,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MapPreview extends StatelessWidget {
  const _MapPreview({required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(
            child: InteractiveViewer(
              transformationController: controller.mapTransform,
              constrained: false,
              minScale: 1,
              maxScale: 4,
              child: Image.asset(
                ImagePath.cartMap,
                width: 640.w,
                height: 320.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          IgnorePointer(
            child: Center(
            child: SizedBox(
              width: 64.w,
              height: 64.w,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 64.w,
                    height: 64.w,
                    decoration: BoxDecoration(
                      color: AppColors.maroonAccent.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.maroonAccent.withValues(alpha: 0.22),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -10.h,
                    child: Container(
                      width: 38.w,
                      height: 38.w,
                      decoration: BoxDecoration(
                        color: AppColors.maroonAccent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.maroonAccent.withValues(
                              alpha: 0.48,
                            ),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        IconPath.cartPinWhite,
                        width: 20.w,
                        height: 20.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ),
          ),
          Positioned(
            top: 12.h,
            right: 12.w,
            child: Container(
              width: 34.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.14),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => controller.zoomMap(1.25),
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      height: 28.h,
                      width: 34.w,
                      child: Center(
                        child: SvgPicture.asset(
                          IconPath.cartPlus,
                          width: 16.w,
                          height: 16.w,
                        ),
                      ),
                    ),
                  ),
                  Container(height: 1, color: AppColors.black50),
                  GestureDetector(
                    onTap: () => controller.zoomMap(0.8),
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      height: 28.h,
                      width: 34.w,
                      child: Center(
                        child: SvgPicture.asset(
                          IconPath.cartMinus,
                          width: 16.w,
                          height: 16.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 12.w,
            right: 12.w,
            bottom: 12.h,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.14),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          IconPath.cartMapPin,
                          width: 13.w,
                          height: 13.w,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Obx(() {
                            if (controller.savedAddresses.isEmpty) {
                              return Text(
                                'Set your delivery location',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.hankenGrotesk(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                  color: AppColors.black300,
                                ),
                              );
                            }
                            final index = controller.selectedAddressIndex.value
                                .clamp(
                                  0,
                                  controller.savedAddresses.length - 1,
                                );
                            final address = controller.savedAddresses[index];
                            return Text(
                              address.chipLine,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.hankenGrotesk(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                color: AppColors.black300,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                GestureDetector(
                  onTap: controller.resetMap,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.14),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      IconPath.cartLocate,
                      width: 16.w,
                      height: 16.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SavedAddress extends StatelessWidget {
  const _SavedAddress({
    required this.address,
    required this.selected,
    required this.onSelect,
    required this.onChange,
  });

  final SavedAddress address;
  final bool selected;
  final VoidCallback onSelect;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(16.w, selected ? 8.h : 8.h, 16.w, 16.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.offWhite300 : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: selected
              ? Border.all(color: AppColors.burgundy100)
              : Border.all(color: Colors.transparent),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selected)
              Container(
                width: 24.w,
                height: 24.w,
                decoration: const BoxDecoration(
                  color: AppColors.maroonAccent,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  IconPath.checkCircle,
                  width: 14.w,
                  height: 14.w,
                ),
              )
            else
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.black100, width: 1.5),
                ),
              ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: AppColors.maroon50,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    IconPath.profilePin,
                    width: 18.w,
                    height: 18.w,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    address.label,
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                      color: AppColors.textBody,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onChange,
                  behavior: HitTestBehavior.opaque,
                  child: Text(
                    'Change',
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: AppColors.maroonDark,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              address.name,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                height: 1.4,
                color: AppColors.textBody,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              address.streetLine,
              style: GoogleFonts.hankenGrotesk(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: AppColors.black400,
              ),
            ),
            Text(
              address.cityLine,
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

class _Field extends StatelessWidget {
  const _Field({
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.focusNode,
  });

  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.h),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(14.r),
      ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
        cursorColor: AppColors.gold,
        style: GoogleFonts.hankenGrotesk(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textBody,
        ),
        decoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.hankenGrotesk(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textBody.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}
