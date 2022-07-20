import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menu/models/provider_states/category_state.dart';

import '../app_options.dart';
import '../models/category_item.dart';

class CategoryNotifier extends StateNotifier<CategoryState> {
  CategoryNotifier() : super(CategoryState(homeCategories: []));

  fetchHomeCategories() async {
    var response = await Dio().get("$apiBaseUrl/api/categories/");
    var items = response.data!
        ?.map<CategoryItem>(
          (e) => CategoryItem.fromJson(e),
        )
        .toList();

    state = state.copyWith(homeCategories: items);
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, CategoryState>((ref) {
  return CategoryNotifier();
});
