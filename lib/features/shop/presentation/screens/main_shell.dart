import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../controllers/shop_controller.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../widgets/shop_header.dart';
import '../widgets/shop_nav_bar.dart';
import 'home_screen.dart';
import 'saved_screen.dart';
import 'shop_screen.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ShopController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Column(
          children: [
            Obx(() {
              if (c.tabIndex.value == 2 ||
                  c.tabIndex.value == 3 ||
                  c.tabIndex.value == 4) {
                return const SizedBox.shrink();
              }
              return const ShopHeader();
            }),
            Expanded(
              child: Obx(() {
                if (c.tabIndex.value == 4) {
                  return const ProfileScreen();
                }
                if (c.tabIndex.value == 3) {
                  return const CartScreen();
                }
                if (c.tabIndex.value == 2) {
                  return const SavedScreen();
                }
                return IndexedStack(
                  index: c.tabIndex.value.clamp(0, 1),
                  children: const [
                    HomeScreen(),
                    ShopScreen(),
                  ],
                );
              }),
            ),
            const ShopNavBar(),
          ],
        ),
      ),
    );
  }
}
