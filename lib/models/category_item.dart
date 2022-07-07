class CategoryItem {
  int id = 0;
  String name = "";
  String? imageUrl;

  CategoryItem({required this.id, required this.name, this.imageUrl});

  static CategoryItem fromJson(e) {
    return CategoryItem(
        id: int.parse(e["id"].toString()),
        name: e["name"],
        imageUrl: e["image"]);
  }
}
