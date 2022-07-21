import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/cart_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartItem> items = [];
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      if (event is CartItemAddEvent) {
        items.add(event.item);
        emit(CartUpdatedState(items: items));
      }
      if (event is CartItemDeleteEvent) {
        items.remove(event.item);
        emit(CartUpdatedState(items: items));
      }
      if (event is CartItemIncreaseQtyEvent) {
        event.item.quantity = event.item.quantity + 1;
        int index = items.indexOf(event.item);
        items.replaceRange(index, index, [event.item]);
        emit(CartUpdatedState(items: items));
      }
      if (event is CartItemDecreaseQtyEvent) {
        if (event.item.quantity == 1) {
          add(CartItemDeleteEvent(item: event.item));
        } else {
          event.item.quantity = event.item.quantity - 1;
          int index = items.indexOf(event.item);
          items.replaceRange(index, index, [event.item]);
          emit(CartUpdatedState(items: items));
        }
      }
    });
  }
}
