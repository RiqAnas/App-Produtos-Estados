class CartItem {
  final String id;
  final String productId;
  final String productName;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
  });
}
