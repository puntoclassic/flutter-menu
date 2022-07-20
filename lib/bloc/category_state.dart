part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryHomeCategoriesFetchPendingState extends CategoryState {}

class CategoryHomeCategoriesFetchResponseState extends CategoryState {
  final List<CategoryItem> items;

  CategoryHomeCategoriesFetchResponseState({required this.items});
}
