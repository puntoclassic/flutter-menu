part of 'foods_by_category_bloc.dart';

@immutable
abstract class FoodsByCategoryEvent {}

class FoodsByCategoryFetchEvent extends FoodsByCategoryEvent {
  final String categoryId;

  FoodsByCategoryFetchEvent({required this.categoryId});
}
