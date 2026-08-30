import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/storage_service.dart';
import '../../../core/utils/constants/image_path.dart';
import '../../../features/authentication/presentation/widgets/auth_input.dart';
import '../../../routes/app_routes.dart';
import '../../shop/controllers/shop_controller.dart';
import '../models/cart_models.dart';

class CheckoutController extends GetxController {
  final groups = <CartVendorGroup>[].obs;
  final shippingIndex = 0.obs;
  final saveCard = true.obs;
  final showCvv = false.obs;
  final disputeDropdownOpen = false.obs;
  final vendorDropdownOpen = false.obs;
  final disputeReason = ''.obs;
  final vendorCategory = ''.obs;
  final detailsFilled = false.obs;
  final messageFilled = false.obs;
  final promoApplied = false.obs;
  final promoOff = 0.0.obs;
  final disputeFiles = <String>[].obs;
  final vendorFiles = <String>[].obs;

  final street = TextEditingController(text: '1247 Brotherhood Lane');
  final apt = TextEditingController();
  final city = TextEditingController(text: 'Atlanta');
  final state = TextEditingController(text: 'GA');
  final zip = TextEditingController(text: '30301');
  final instructions = TextEditingController();
  final cardNumber = TextEditingController();
  final expiry = TextEditingController();
  final cvv = TextEditingController();
  final cardName = TextEditingController();
  final promo = TextEditingController();
  final disputeDetails = TextEditingController();
  final vendorMessage = TextEditingController();

  static const disputeReasons = [
    'Order never arrived',
    'Item damaged or defective',
    'Wrong item received',
    'Vendor unresponsive',
    'Unauthorized charge',
    'Other',
  ];

  static const vendorCategories = [
    'Order Question',
    'Shipping Inquiry',
    'Product Question',
    'Return / Refund Request',
    'Customization Request',
    'Other',
  ];

  static const shippingOptions = [
    ShippingOption(
      title: 'Standard Shipping',
      eta: 'Arrives Fri, Jul 24 – Mon, Jul 27',
      price: 5.99,
    ),
    ShippingOption(
      title: 'Express Shipping',
      eta: 'Arrives Thu, Jul 23',
      price: 12.99,
    ),
    ShippingOption(
      title: 'Overnight',
      eta: 'Arrives Wed, Jul 22 by 10am',
      price: 19.99,
    ),
  ];

  static const _stateNames = {
    'AL': 'Alabama',
    'AK': 'Alaska',
    'AZ': 'Arizona',
    'CA': 'California',
    'CO': 'Colorado',
    'FL': 'Florida',
    'GA': 'Georgia',
    'IL': 'Illinois',
    'NY': 'New York',
    'TX': 'Texas',
  };

  @override
  void onInit() {
    super.onInit();
    groups.assignAll(_seedGroups());
    _syncCartCount();
  }

  List<CartVendorGroup> _seedGroups() {
    return [
      CartVendorGroup(
        vendor: 'OmegaPsi Official Store',
        shipping: 0,
        lines: [
          const CartLine(
            id: 'c1',
            title: 'Purple & Gold Crewneck',
            variant: 'Size M · Purple',
            unitPrice: 58,
            image: ImagePath.cartCrewneck,
            qty: 1,
          ),
          const CartLine(
            id: 'c2',
            title: 'Omega Shield Tee',
            variant: 'Size L · Gold',
            unitPrice: 84,
            image: ImagePath.cartTee,
            qty: 2,
          ),
        ],
      ),
      CartVendorGroup(
        vendor: 'Greek Threads Co.',
        shipping: 5.99,
        lines: [
          const CartLine(
            id: 'c3',
            title: 'Divine Nine Cap',
            variant: 'One Size · Black',
            unitPrice: 32,
            image: ImagePath.cartCrewneck,
            qty: 1,
          ),
        ],
      ),
    ];
  }

  int get itemCount => groups.fold(
    0,
    (sum, group) =>
        sum + group.lines.fold(0, (inner, line) => inner + line.qty),
  );

  String get itemsLabel => itemCount == 1 ? '1 item' : '$itemCount items';

  double get merchandiseTotal =>
      groups.fold(0, (sum, group) => sum + group.subtotal);

  double get cartShipping =>
      groups.fold(0, (sum, group) => sum + group.shipping);

  double get cartTotal => merchandiseTotal + cartShipping;

  ShippingOption get selectedShipping => shippingOptions[shippingIndex.value];

  double get reviewTotal {
    final total = merchandiseTotal + selectedShipping.price - promoOff.value;
    return total < 0 ? 0 : total;
  }

  String money(double value) => '\$${value.toStringAsFixed(2)}';

  String get recipientName {
    final name = cardName.text.trim();
    return name.isEmpty ? 'Marcus Johnson' : name;
  }

  String get streetLine {
    final aptText = apt.text.trim();
    final streetText = street.text.trim();
    if (aptText.isEmpty) return streetText;
    return '$streetText, $aptText';
  }

  String get cityLine {
    final code = state.text.trim().toUpperCase();
    final long = _stateNames[code] ?? code;
    final zipText = zip.text.trim();
    final cityText = city.text.trim();
    if (code.isEmpty)
      return [cityText, zipText].where((p) => p.isNotEmpty).join(' ');
    return '$cityText, $long ($code)${zipText.isEmpty ? '' : ' $zipText'}';
  }

  String get fullAddressLine {
    return [
      streetLine,
      cityLine,
      'United States',
    ].where((p) => p.trim().isNotEmpty).join(', ');
  }

  String get instructionLine {
    final note = instructions.text.trim();
    return note.isEmpty ? 'Leave at front door. Signature not required.' : note;
  }

  String get cardLast4 {
    final digits = cardNumber.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 4) return '3456';
    return digits.substring(digits.length - 4);
  }

  String get cardMask => '•••• •••• •••• $cardLast4';

  String get cardExpiryLabel {
    final value = expiry.text.trim();
    return value.isEmpty ? '01/29' : value;
  }

  void changeQty(String id, int delta) {
    final next = <CartVendorGroup>[];
    for (final group in groups) {
      final lines = <CartLine>[];
      for (final line in group.lines) {
        if (line.id != id) {
          lines.add(line);
          continue;
        }
        final qty = line.qty + delta;
        if (qty >= 1) {
          lines.add(line.copyWith(qty: qty.clamp(1, 99)));
        }
      }
      if (lines.isNotEmpty) {
        next.add(
          CartVendorGroup(
            vendor: group.vendor,
            shipping: group.shipping,
            lines: lines,
          ),
        );
      }
    }
    groups.assignAll(next);
    _syncCartCount();
  }

  void addLine({
    required String title,
    required String variant,
    required double unitPrice,
    required String image,
    int qty = 1,
  }) {
    var matched = false;
    final updated = groups.map((group) {
      final hasMatch = group.lines.any(
        (line) => line.title == title && line.variant == variant,
      );
      if (!hasMatch) return group;
      matched = true;
      return CartVendorGroup(
        vendor: group.vendor,
        shipping: group.shipping,
        lines: group.lines
            .map(
              (line) => line.title == title && line.variant == variant
                  ? line.copyWith(qty: line.qty + qty)
                  : line,
            )
            .toList(),
      );
    }).toList();

    if (matched) {
      groups.assignAll(updated);
    } else {
      final line = CartLine(
        id: 'c${DateTime.now().millisecondsSinceEpoch}',
        title: title,
        variant: variant,
        unitPrice: unitPrice,
        image: image,
        qty: qty,
      );
      if (groups.isEmpty) {
        groups.add(
          CartVendorGroup(
            vendor: 'OmegaPsi Official Store',
            shipping: 0,
            lines: [line],
          ),
        );
      } else {
        final first = groups.first;
        groups[0] = CartVendorGroup(
          vendor: first.vendor,
          shipping: first.shipping,
          lines: [...first.lines, line],
        );
      }
    }
    _syncCartCount();
  }

  Future<void> _syncCartCount() async {
    if (!Get.isRegistered<ShopController>()) return;
    final shop = Get.find<ShopController>();
    shop.cartCount.value = itemCount;
    await StorageService.setCartCount(itemCount);
  }

  void selectShipping(int index) => shippingIndex.value = index;

  void goCheckout() {
    if (itemCount == 0) {
      showAuthMessage('Your cart is empty');
      return;
    }
    Get.toNamed(AppRoute.deliveryAddressScreen);
  }

  void confirmLocation() {
    if (street.text.trim().isEmpty ||
        city.text.trim().isEmpty ||
        state.text.trim().isEmpty ||
        zip.text.trim().isEmpty) {
      showAuthMessage('Please complete your delivery address');
      return;
    }
    Get.toNamed(AppRoute.deliveryScreen);
  }

  void continueToPayment() => Get.toNamed(AppRoute.paymentScreen);

  void reviewOrder() => Get.toNamed(AppRoute.reviewScreen);

  void applyPromo() {
    final code = promo.text.trim();
    if (code.isEmpty) {
      showAuthMessage('Enter a promo code');
      return;
    }
    promoOff.value = 10;
    promoApplied.value = true;
    showAuthMessage('Promo applied');
  }

  void attachDisputeFile() {
    disputeFiles.add('evidence_${disputeFiles.length + 1}.jpg');
  }

  void attachVendorFile() {
    vendorFiles.add('attachment_${vendorFiles.length + 1}.jpg');
  }

  void placeOrder() {
    Get.offNamedUntil(
      AppRoute.orderConfirmedScreen,
      (route) => route.settings.name == AppRoute.homeScreen,
    );
  }

  void trackOrder() => Get.offNamed(AppRoute.orderDetailsScreen);

  void continueShopping() {
    if (Get.isRegistered<ShopController>()) {
      Get.find<ShopController>().selectTab(0);
    }
    Get.until((route) => route.settings.name == AppRoute.homeScreen);
  }

  void openDispute() => Get.toNamed(AppRoute.disputeScreen);

  void openVendorContact() => Get.toNamed(AppRoute.orderVendorScreen);

  void openReturns() => Get.toNamed(AppRoute.returnListScreen);

  void openReturnDetails() => Get.toNamed(AppRoute.returnDetailsScreen);

  void selectDisputeReason(String value) {
    disputeReason.value = value == 'Select a dispute reason' ? '' : value;
    disputeDropdownOpen.value = false;
  }

  void selectVendorCategory(String value) {
    vendorCategory.value = value == 'Select a category' ? '' : value;
    vendorDropdownOpen.value = false;
  }

  bool get canSubmitDispute =>
      disputeReason.value.isNotEmpty && detailsFilled.value;

  bool get canSendVendor =>
      vendorCategory.value.isNotEmpty && messageFilled.value;

  void submitDispute() {
    if (!canSubmitDispute) return;
    Get.toNamed(AppRoute.disputeSubmitScreen);
  }

  void sendToVendor() {
    if (!canSendVendor) return;
    Get.toNamed(AppRoute.vendorSentScreen);
  }

  void backToOrderDetails() {
    Get.offNamedUntil(
      AppRoute.orderDetailsScreen,
      (route) =>
          route.settings.name == AppRoute.homeScreen ||
          route.settings.name == AppRoute.orderDetailsScreen,
    );
  }

  void editAddress() => _popToOrOpen(AppRoute.deliveryAddressScreen);

  void editDelivery() => _popToOrOpen(AppRoute.deliveryScreen);

  void editPayment() => _popToOrOpen(AppRoute.paymentScreen);

  void _popToOrOpen(String name) {
    if (Get.currentRoute == name) return;
    Get.until(
      (route) =>
          route.settings.name == name ||
          route.settings.name == AppRoute.homeScreen,
    );
    if (Get.currentRoute != name) {
      Get.toNamed(name);
    }
  }

  @override
  void onClose() {
    street.dispose();
    apt.dispose();
    city.dispose();
    state.dispose();
    zip.dispose();
    instructions.dispose();
    cardNumber.dispose();
    expiry.dispose();
    cvv.dispose();
    cardName.dispose();
    promo.dispose();
    disputeDetails.dispose();
    vendorMessage.dispose();
    super.onClose();
  }
}
