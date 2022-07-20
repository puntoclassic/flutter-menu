part of 'food_bloc.dart';

@immutable
abstract class FoodState {}

class FoodInitial extends FoodState {}

class FoodsFetchByCategoryPendingState extends FoodState {}

class FoodsFetchByCategoryResponseState extends FoodState {
  final List<FoodItem> foods;

  FoodsFetchByCategoryResponseState({required this.foods});
}
