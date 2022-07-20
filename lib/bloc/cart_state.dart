part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartUpdatedState extends CartState {
  final List<CartItem> items;

  CartUpdatedState({required this.items});
}
