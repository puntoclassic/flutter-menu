import 'package:bloc/bloc.dart';
import 'package:menu/models/cart_item.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartItem> items = [];

  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {});
  }
}
