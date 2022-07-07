import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:menu/models/food_item.dart';
import 'package:meta/meta.dart';

import '../app_options.dart';

part 'foods_by_category_event.dart';
part 'foods_by_category_state.dart';

class FoodsByCategoryBloc
    extends Bloc<FoodsByCategoryEvent, FoodsByCategoryState> {
  FoodsByCategoryBloc() : super(FoodsByCategoryInitial()) {
    on<FoodsByCategoryEvent>((event, emit) async {
      if (event is FoodsByCategoryFetchEvent) {
        final categoryId = event.categoryId;

        var response =
            await Dio().get("$apiBaseUrl/api/categories/$categoryId/foods");

        var items = response.data!
            ?.map<FoodItem>(
              (e) => FoodItem.fromJson(e),
            )
            .toList();

        emit(FoodsByCategoryFetchState(items: items));
      }
    });
  }
}
