class CartItem {
  int? id;
  String? name;
  double unitPrice;
  int quantity;

  double price() {
    return unitPrice * quantity;
  }

  CartItem(
      {required this.name,
      required this.quantity,
      required this.id,
      required this.unitPrice});
}
