part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartItemAddEvent extends CartEvent {
  final CartItem item;

  CartItemAddEvent({required this.item});
}

class CartItemDeleteEvent extends CartEvent {
  final CartItem item;

  CartItemDeleteEvent({required this.item});
}

class CartItemIncreaseQtyEvent extends CartEvent {
  final CartItem item;

  CartItemIncreaseQtyEvent({required this.item});
}

class CartItemDecreaseQtyEvent extends CartEvent {
  final CartItem item;

  CartItemDecreaseQtyEvent({required this.item});
}
