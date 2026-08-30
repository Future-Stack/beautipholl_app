class CartLine {
  const CartLine({
    required this.id,
    required this.title,
    required this.variant,
    required this.unitPrice,
    required this.image,
    required this.qty,
  });

  final String id;
  final String title;
  final String variant;
  final double unitPrice;
  final String image;
  final int qty;

  CartLine copyWith({int? qty}) => CartLine(
    id: id,
    title: title,
    variant: variant,
    unitPrice: unitPrice,
    image: image,
    qty: qty ?? this.qty,
  );

  double get lineTotal => unitPrice * qty;

  String get priceLabel => '\$${unitPrice.toStringAsFixed(2)}';
}

class CartVendorGroup {
  const CartVendorGroup({
    required this.vendor,
    required this.lines,
    required this.shipping,
  });

  final String vendor;
  final List<CartLine> lines;
  final double shipping;

  double get subtotal => lines.fold(0, (sum, line) => sum + line.lineTotal);

  bool get isFreeShipping => shipping == 0;
}

class ShippingOption {
  const ShippingOption({
    required this.title,
    required this.eta,
    required this.price,
  });

  final String title;
  final String eta;
  final double price;
}
