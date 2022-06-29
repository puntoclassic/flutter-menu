class CategoryItem {
  int id = 0;
  String name = "";
  String? imageUrl;

  CategoryItem({required this.id, required this.name, this.imageUrl});

  static CategoryItem fromJson(e) {
    return CategoryItem(id: e["id"], name: e["name"], imageUrl: e["image"]);
  }
}
