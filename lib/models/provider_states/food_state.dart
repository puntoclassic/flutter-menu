import 'package:menu/models/food_item.dart';

class FoodState {
  List<FoodItem> foodsByCategory;

  FoodState({required this.foodsByCategory});

  FoodState copyWith({List<FoodItem>? foodsByCategory}) {
    return FoodState(foodsByCategory: foodsByCategory ?? this.foodsByCategory);
  }
}
