class FoodItem {
  int id = 0;
  String name = "";
  String ingredients = "";
  String? imageUrl;
  num price = 0.00;

  FoodItem(
      {required this.id,
      required this.name,
      this.imageUrl,
      required this.ingredients,
      required this.price});

  static FoodItem fromJson(e) {
    return FoodItem(
        id: int.parse(e["pk"].toString()),
        name: e["name"],
        imageUrl: e["image"],
        ingredients: e["ingredients"] ?? "",
        price: num.tryParse(e["price"].toString())!);
  }
}
