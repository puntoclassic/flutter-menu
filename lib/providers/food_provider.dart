import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menu/models/provider_states/food_state.dart';

import '../app_options.dart';
import '../models/food_item.dart';

class FoodNotifier extends StateNotifier<FoodState> {
  FoodNotifier() : super(FoodState(foodsByCategory: []));

  fetchFoodsByCategory(String categoryId) async {
    state = state.copyWith(foodsByCategory: []);

    var response =
        await Dio().get("$apiBaseUrl/api/categories/$categoryId/foods");

    var items = response.data!
        ?.map<FoodItem>(
          (e) => FoodItem.fromJson(e),
        )
        .toList();

    state = state.copyWith(foodsByCategory: items);
  }
}

final foodProvider = StateNotifierProvider<FoodNotifier, FoodState>((ref) {
  return FoodNotifier();
});
