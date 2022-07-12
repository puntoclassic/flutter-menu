part of 'home_categories_bloc.dart';

@immutable
abstract class HomeCategoriesState {}

class HomeCategoriesInitial extends HomeCategoriesState {}

class HomeCategoriesFetchState extends HomeCategoriesState {
  final List<CategoryItem>? items;

  HomeCategoriesFetchState({required this.items});
}
