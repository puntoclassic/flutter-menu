import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu/bloc/food_bloc.dart';
import 'package:menu/models/category_item.dart';
import 'package:menu/widgets/menu_body.dart';

import '../widgets/category_screen_header.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryItem categoryItem =
        ModalRoute.of(context)!.settings.arguments as CategoryItem;

    context.read<FoodBloc>().add(
          FoodFetchByCategoryEvent(
            categoryId: categoryItem.id.toString(),
          ),
        );

    return Scaffold(
      body: MenuBody(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CategoryScreenHeader(categoryItem: categoryItem),
            Expanded(child: CategoryScreenBody(categoryItem: categoryItem))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/cart");
        },
        child: const Icon(Icons.shopping_bag),
      ),
    );
  }
}

class CategoryScreenBody extends StatelessWidget {
  const CategoryScreenBody({
    Key? key,
    required this.categoryItem,
  }) : super(key: key);

  final CategoryItem categoryItem;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        if (state is FoodsFetchByCategoryResponseState) {
          if (state.foods.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.foods.elementAt(index).name),
                                    Text(
                                      state.foods.elementAt(index).ingredients,
                                      style: GoogleFonts.gentiumBasic(
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      "${state.foods.elementAt(index).price} €")
                                ],
                              ),
                              IconButton(
                                alignment: Alignment.centerRight,
                                onPressed: () {},
                                icon: const Icon(Icons.add_shopping_cart),
                              )
                            ],
                          ),
                        );
                      },
                      childCount: state.foods.length,
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(16),
              child:
                  Center(child: Text("Non ci sono cibi per questa categoria")),
            );
          }
        }

        return const Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
