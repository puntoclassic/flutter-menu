import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/cart_item.dart';
import '../models/provider_states/cart_state.dart';

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState(items: []));

  addToCart(CartItem item) {
    var list = state.items;
    list.add(item);
    state = CartState(items: list);
  }

  removeFromCart(CartItem item) {
    var list = state.items;
    list.removeAt(list.indexOf(item));
    state = CartState(items: list);
  }

  increaseQty(CartItem item) {
    var list = state.items;
    item.quantity = item.quantity + 1;
    int index = list.indexOf(item);
    list.replaceRange(index, index, [item]);

    state = CartState(items: list);
  }

  decreaseQty(CartItem item) {
    if (item.quantity == 1) {
      removeFromCart(item);
    } else {
      var list = state.items;
      item.quantity = item.quantity - 1;
      int index = list.indexOf(item);
      list.replaceRange(index, index, [item]);

      state = CartState(items: list);
    }
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});
