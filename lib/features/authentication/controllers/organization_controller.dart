import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/storage_service.dart';
import '../../../core/utils/constants/image_path.dart';
import '../../../routes/app_routes.dart';
import '../models/organization_model.dart';

class OrganizationController extends GetxController {
  final searchController = TextEditingController();
  final selectedName = Rxn<String>();
  final query = ''.obs;

  final List<OrganizationModel> organizations = const [
    OrganizationModel(
      name: 'Alpha Phi Alpha Fraternity, Inc',
      meta: 'Est. 1906  .  Black & Old Gold',
      image: ImagePath.org1,
    ),
    OrganizationModel(
      name: 'Alpha Kappa Alpha Psi Fraternity, Inc',
      meta: 'Est. 1911  .  Crimson & Cream',
      image: ImagePath.org2,
    ),
    OrganizationModel(
      name: 'Omega Psi Phi Fraternity, Inc',
      meta: 'Est. 1911  .  Royal Purple & Gold',
      image: ImagePath.org3,
    ),
    OrganizationModel(
      name: 'Delta Sigma Theta Sorority, Inc',
      meta: 'Est. 1914  .  Royal Blue & Pure White',
      image: ImagePath.org4,
    ),
    OrganizationModel(
      name: 'Phi Beta Sigma Fraternity, Inc',
      meta: 'Est. 1963  .  Charcoal Brown & Gold',
      image: ImagePath.org5,
    ),
    OrganizationModel(
      name: 'Zeta Phi Beta Sorority, Inc',
      meta: 'Est. 1913  .  Crimson & Cream',
      image: ImagePath.org6,
    ),
    OrganizationModel(
      name: 'Sigma Gamma Rho Sorority, Inc',
      meta: 'Est. 1922  .  Royal Blue & Gold',
      image: ImagePath.org1,
    ),
    OrganizationModel(
      name: 'Lota Phi Theta Fraternity, Inc',
      meta: 'Est. 1920  .  Royal Blue & White',
      image: ImagePath.org7,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    selectedName.value = StorageService.organizationName;
  }

  List<OrganizationModel> get filtered {
    final q = query.value.trim().toLowerCase();
    if (q.isEmpty) return organizations;
    return organizations
        .where(
          (o) =>
              o.name.toLowerCase().contains(q) ||
              o.meta.toLowerCase().contains(q),
        )
        .toList();
  }

  void onSearch(String value) => query.value = value;

  void select(OrganizationModel org) {
    if (selectedName.value == org.name) {
      selectedName.value = null;
    } else {
      selectedName.value = org.name;
    }
  }

  bool isSelected(OrganizationModel org) => selectedName.value == org.name;

  Future<void> continueNext() async {
    await StorageService.setOrganizationName(selectedName.value);
    if (Get.previousRoute == AppRoute.homeScreen) {
      Get.back();
      return;
    }
    Get.toNamed(AppRoute.interestScreen);
  }

  Future<void> skip() async {
    selectedName.value = null;
    await StorageService.setOrganizationName(null);
    if (Get.previousRoute == AppRoute.homeScreen) {
      Get.back();
      return;
    }
    Get.toNamed(AppRoute.interestScreen);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
