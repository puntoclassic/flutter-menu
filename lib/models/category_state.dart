import 'category_item.dart';

class CategoryState {
  List<CategoryItem> homeCategories;

  CategoryState({required this.homeCategories});

  CategoryState copyWith({List<CategoryItem>? homeCategories}) {
    return CategoryState(homeCategories: homeCategories ?? this.homeCategories);
  }
}
