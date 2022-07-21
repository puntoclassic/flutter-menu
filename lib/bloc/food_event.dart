part of 'food_bloc.dart';

@immutable
abstract class FoodEvent {}

class FoodFetchByCategoryEvent extends FoodEvent {
  final String categoryId;

  FoodFetchByCategoryEvent({required this.categoryId});
}
