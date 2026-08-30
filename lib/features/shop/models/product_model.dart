import '../../../core/utils/constants/image_path.dart';

enum ProductBadge { licensed, limitedDrop, membersOnly }

class ShopProduct {
  const ShopProduct({
    required this.id,
    required this.title,
    required this.priceLabel,
    required this.image,
    required this.badge,
    this.category = 'Men',
    this.membersOnly = false,
    this.unlockLabel = 'Unlocks July 28',
  });

  final String id;
  final String title;
  final String priceLabel;
  final String image;
  final ProductBadge badge;
  final String category;
  final bool membersOnly;
  final String unlockLabel;
}

class ShopCatalog {
  ShopCatalog._();

  static const List<ShopProduct> products = [
    ShopProduct(
      id: 'p1',
      title: 'Purple & Gold Crewneck',
      priceLabel: '\$58',
      image: ImagePath.shopProduct,
      badge: ProductBadge.licensed,
    ),
    ShopProduct(
      id: 'p2',
      title: 'Purple & Gold Crewneck',
      priceLabel: '\$58',
      image: ImagePath.shopProduct2,
      badge: ProductBadge.limitedDrop,
    ),
    ShopProduct(
      id: 'p3',
      title: 'Purple & Gold Crewneck',
      priceLabel: '----- -----',
      image: ImagePath.shopProduct3,
      badge: ProductBadge.membersOnly,
      membersOnly: true,
    ),
    ShopProduct(
      id: 'p4',
      title: 'Purple & Gold Crewneck',
      priceLabel: '\$58',
      image: ImagePath.shopProduct,
      badge: ProductBadge.licensed,
      category: 'Women',
    ),
    ShopProduct(
      id: 'p5',
      title: 'Purple & Gold Crewneck',
      priceLabel: '\$58',
      image: ImagePath.shopProduct2,
      badge: ProductBadge.limitedDrop,
      category: 'Women',
    ),
    ShopProduct(
      id: 'p6',
      title: 'Purple & Gold Crewneck',
      priceLabel: '----- -----',
      image: ImagePath.shopProduct3,
      badge: ProductBadge.membersOnly,
      membersOnly: true,
      category: 'Children',
    ),
    ShopProduct(
      id: 'p7',
      title: 'Purple & Gold Crewneck',
      priceLabel: '\$58',
      image: ImagePath.shopProduct,
      badge: ProductBadge.licensed,
    ),
    ShopProduct(
      id: 'p8',
      title: 'Purple & Gold Crewneck',
      priceLabel: '\$58',
      image: ImagePath.shopProduct2,
      badge: ProductBadge.limitedDrop,
      category: 'Women',
    ),
    ShopProduct(
      id: 'p9',
      title: 'Purple & Gold Crewneck',
      priceLabel: '----- -----',
      image: ImagePath.shopProduct3,
      badge: ProductBadge.membersOnly,
      membersOnly: true,
    ),
    ShopProduct(
      id: 'p10',
      title: 'Purple & Gold Crewneck',
      priceLabel: '\$58',
      image: ImagePath.shopProduct,
      badge: ProductBadge.licensed,
      category: 'Children',
    ),
    ShopProduct(
      id: 'p11',
      title: 'Purple & Gold Crewneck',
      priceLabel: '\$58',
      image: ImagePath.shopProduct2,
      badge: ProductBadge.limitedDrop,
    ),
    ShopProduct(
      id: 'p12',
      title: 'Purple & Gold Crewneck',
      priceLabel: '\$58',
      image: ImagePath.shopProduct,
      badge: ProductBadge.licensed,
      category: 'Women',
    ),
  ];
}

class OrganizationLetters {
  OrganizationLetters._();

  static String fromName(String? name) {
    final value = name ?? '';
    if (value.contains('Alpha Phi Alpha')) return 'ΑΦΑ';
    if (value.contains('Alpha Kappa Alpha')) return 'ΑΚΑ';
    if (value.contains('Omega Psi Phi')) return 'ΩΨΦ';
    if (value.contains('Delta Sigma Theta')) return 'ΔΣΘ';
    if (value.contains('Phi Beta Sigma')) return 'ΦΒΣ';
    if (value.contains('Zeta Phi Beta')) return 'ΖΦΒ';
    if (value.contains('Sigma Gamma Rho')) return 'ΣΓΡ';
    return 'ΩΨΦ';
  }

  static String shortName(String? name) {
    final value = name ?? '';
    if (value.contains('Omega Psi Phi')) return 'Omega';
    if (value.contains('Alpha Phi Alpha')) return 'Alpha';
    if (value.contains('Alpha Kappa Alpha')) return 'AKA';
    if (value.contains('Delta Sigma Theta')) return 'Delta';
    if (value.contains('Phi Beta Sigma')) return 'Sigma';
    if (value.contains('Zeta Phi Beta')) return 'Zeta';
    if (value.contains('Sigma Gamma Rho')) return 'SGRho';
    return 'Omega';
  }
}
