import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:menu/app_options.dart';
import 'package:menu/models/category_item.dart';

part 'home_categories_event.dart';
part 'home_categories_state.dart';

class HomeCategoriesBloc
    extends Bloc<HomeCategoriesEvent, HomeCategoriesState> {
  HomeCategoriesBloc() : super(HomeCategoriesInitial()) {
    on<HomeCategoriesEvent>((event, emit) async {
      if (event is HomeCategoriesFetchEvent) {
        var response = await Dio().get("$apiBaseUrl/webapi/categories/");
        var items = response.data!
            ?.map<CategoryItem>(
              (e) => CategoryItem.fromJson(e),
            )
            .toList();

        emit(HomeCategoriesFetchState(items: items));
      }
    });
  }
}
