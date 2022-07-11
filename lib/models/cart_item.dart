class CartItem {
  int? id;
  String? name;
  double? price;
  int? quantity;

  CartItem(
      {required this.name,
      required this.price,
      required this.quantity,
      required this.id});
}
