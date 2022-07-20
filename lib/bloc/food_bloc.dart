import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../app_options.dart';
import '../models/food_item.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodInitial()) {
    on<FoodEvent>((event, emit) async {
      if (event is FoodFetchByCategoryEvent) {
        emit(FoodsFetchByCategoryPendingState());

        var response = await Dio()
            .get("$apiBaseUrl/api/categories/${event.categoryId}/foods");

        var items = response.data!
            ?.map<FoodItem>(
              (e) => FoodItem.fromJson(e),
            )
            .toList();

        emit(FoodsFetchByCategoryResponseState(foods: items));
      }
    });
  }
}
