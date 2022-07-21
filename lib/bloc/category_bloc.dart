import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:menu/models/category_item.dart';
import 'package:meta/meta.dart';

import '../app_options.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is CategoryFetchHomeCategoriesEvent) {
        emit(CategoryHomeCategoriesFetchPendingState());
        var response = await Dio().get("$apiBaseUrl/api/categories/");
        var items = response.data!
            ?.map<CategoryItem>(
              (e) => CategoryItem.fromJson(e),
            )
            .toList();
        emit(CategoryHomeCategoriesFetchResponseState(items: items));
      }
    });
  }
}
