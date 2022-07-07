import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:menu/app_options.dart';
import 'package:menu/models/category_item.dart';

part 'home_categories_event.dart';
part 'home_categories_state.dart';

class HomeCategoriesBloc
    extends Bloc<HomeCategoriesEvent, HomeCategoriesState> {
  late final GraphQLClient client;

  HomeCategoriesBloc() : super(HomeCategoriesInitial()) {
    client = GraphQLClient(
      link: HttpLink('$apiBaseUrl/graphql'),
      cache: GraphQLCache(),
    );

    on<HomeCategoriesEvent>((event, emit) async {
      if (event is HomeCategoriesFetchEvent) {
        var qlResponse = await client.query(
          QueryOptions(
            document: gql(r'''
 {
  categories {
    id
    name
    imageUrl
  }
 }
'''),
          ),
        );

        var items = qlResponse.data!["categories"]
            ?.map<CategoryItem>(
              (e) => CategoryItem.fromJson(e),
            )
            .toList();

        emit(HomeCategoriesFetchState(items: items));
      }
    });
  }
}
