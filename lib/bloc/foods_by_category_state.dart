part of 'foods_by_category_bloc.dart';

@immutable
abstract class FoodsByCategoryState {}

class FoodsByCategoryInitial extends FoodsByCategoryState {}

class FoodsByCategoryFetchState extends FoodsByCategoryState {
  final List<FoodItem>? items;

  FoodsByCategoryFetchState({required this.items});
}
