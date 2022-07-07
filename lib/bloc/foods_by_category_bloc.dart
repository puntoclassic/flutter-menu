import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:menu/models/food_item.dart';
import 'package:meta/meta.dart';

import '../app_options.dart';

part 'foods_by_category_event.dart';
part 'foods_by_category_state.dart';

class FoodsByCategoryBloc
    extends Bloc<FoodsByCategoryEvent, FoodsByCategoryState> {
  late final GraphQLClient client;

  FoodsByCategoryBloc() : super(FoodsByCategoryInitial()) {
    client = GraphQLClient(
      link: HttpLink('$apiBaseUrl/graphql'),
      cache: GraphQLCache(),
    );
    on<FoodsByCategoryEvent>((event, emit) async {
      if (event is FoodsByCategoryFetchEvent) {
        final categoryId = event.categoryId;

        var query = """
 {
  foodsByCategory(categoryId:$categoryId) {
    pk
    name
    ingredients
    price
  }
 }
""";

        var qlResponse = await client.query(
          QueryOptions(document: gql(query)),
        );

        var items = qlResponse.data!["foodsByCategory"]
            ?.map<FoodItem>(
              (e) => FoodItem.fromJson(e),
            )
            .toList();

        emit(FoodsByCategoryFetchState(items: items));
      }
    });
  }
}
