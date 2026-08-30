import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/storage_service.dart';
import '../../../features/authentication/presentation/widgets/auth_input.dart';
import '../../../routes/app_routes.dart';
import '../../cart/controllers/checkout_controller.dart';
import '../models/product_model.dart';
import 'product_controller.dart';

class ShopController extends GetxController {
  final tabIndex = 0.obs;
  final homeCategory = ''.obs;
  final shopCategory = 'All'.obs;
  final vendorCategory = 'All'.obs;
  final searchQuery = ''.obs;
  final cartCount = 2.obs;
  final savedIds = <String>{}.obs;
  final showSavedOnly = false.obs;
  final searchController = TextEditingController();

  String get orgLetters =>
      OrganizationLetters.fromName(StorageService.organizationName);

  String get orgShort =>
      OrganizationLetters.shortName(StorageService.organizationName);

  List<ShopProduct> get shopProducts {
    final query = searchQuery.value.trim().toLowerCase();
    return ShopCatalog.products.where((product) {
      final matchesCategory = shopCategory.value == 'All' ||
          product.category == shopCategory.value;
      final matchesQuery =
          query.isEmpty || product.title.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  List<ShopProduct> get savedProducts {
    return ShopCatalog.products
        .where((product) => savedIds.contains(product.id))
        .toList();
  }

  List<ShopProduct> get vendorProducts {
    final selected = vendorCategory.value;
    return ShopCatalog.products.where((product) {
      if (selected == 'All') return true;
      if (selected == 'Accessories') return product.category == 'Children';
      return product.category == selected;
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    cartCount.value = StorageService.cartCount;
    savedIds.addAll(StorageService.savedIds);
  }

  void selectTab(int index) {
    if (index == 2) {
      showSavedOnly.value = true;
      tabIndex.value = 2;
      return;
    }
    showSavedOnly.value = false;
    if (index == 3) {
      tabIndex.value = 3;
      return;
    }
    if (index == 4) {
      tabIndex.value = 4;
      return;
    }
    tabIndex.value = index;
  }

  void setHomeCategory(String value) {
    homeCategory.value = homeCategory.value == value ? '' : value;
    shopCategory.value = homeCategory.value.isEmpty ? 'All' : value;
    showSavedOnly.value = false;
    tabIndex.value = 1;
  }

  void setShopCategory(String value) => shopCategory.value = value;

  void setVendorCategory(String value) => vendorCategory.value = value;

  void onSearchChanged(String value) {
    searchQuery.value = value;
    if (value.trim().isNotEmpty && tabIndex.value != 2) {
      showSavedOnly.value = false;
      tabIndex.value = 1;
    }
  }

  Future<void> toggleSaved(String id) async {
    if (savedIds.contains(id)) {
      savedIds.remove(id);
    } else {
      savedIds.add(id);
    }
    savedIds.refresh();
    await StorageService.setSavedIds(savedIds.toList());
  }

  Future<void> addToCart() async {
    if (!Get.isRegistered<CheckoutController>()) {
      Get.put(CheckoutController(), permanent: true);
    }
    final checkout = Get.find<CheckoutController>();
    final product = Get.isRegistered<ProductController>()
        ? Get.find<ProductController>()
        : null;
    final catalogId = product?.productId.value;
    final catalog = ShopCatalog.products.firstWhere(
      (item) => item.id == catalogId,
      orElse: () => ShopCatalog.products.first,
    );
    checkout.addLine(
      title: catalog.title,
      variant: 'Size ${product?.selectedSize.value ?? 'M'} · Purple',
      unitPrice: 58,
      image: catalog.image,
      qty: product?.quantity.value ?? 1,
    );
    showAuthMessage('Added to cart');
  }

  void openCart() {
    showSavedOnly.value = false;
    tabIndex.value = 3;
    if (Get.currentRoute != AppRoute.homeScreen) {
      Get.until((route) => route.settings.name == AppRoute.homeScreen);
    }
  }

  void openShop() {
    showSavedOnly.value = false;
    tabIndex.value = 1;
    if (Get.currentRoute == AppRoute.vendorScreen ||
        Get.currentRoute == AppRoute.productDetailsScreen ||
        Get.currentRoute == AppRoute.contactVendorScreen ||
        Get.currentRoute == AppRoute.contactInquiryScreen) {
      Get.until((route) => route.settings.name == AppRoute.homeScreen);
    }
  }

  void openProduct(ShopProduct product) {
    Get.toNamed(
      AppRoute.productDetailsScreen,
      arguments: {
        'isElite': product.membersOnly,
        'productId': product.id,
      },
    );
  }

  void openVendor() => Get.toNamed(AppRoute.vendorScreen);

  void openContactVendor() => Get.toNamed(AppRoute.contactVendorScreen);

  void changeOrganization() => Get.toNamed(AppRoute.organizationScreen);

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
