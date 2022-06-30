class FoodItem {
  int id = 0;
  String name = "";
  String ingredients = "";
  String? imageUrl;
  double price = 0.00;

  FoodItem(
      {required this.id,
      required this.name,
      this.imageUrl,
      required this.ingredients,
      required this.price});

  static FoodItem fromJson(e) {
    return FoodItem(
        id: e["id"],
        name: e["name"],
        imageUrl: e["image"],
        ingredients: e["ingredients"] ?? "",
        price: double.parse(e["price"]));
  }
}
