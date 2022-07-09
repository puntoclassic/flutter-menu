import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu/bloc/foods_by_category_bloc.dart';
import 'package:menu/models/category_item.dart';
import 'package:menu/widgets/menu_body.dart';

import '../widgets/category_screen_header.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryItem categoryItem =
        ModalRoute.of(context)!.settings.arguments as CategoryItem;

    context
        .read<FoodsByCategoryBloc>()
        .add(FoodsByCategoryFetchEvent(categoryId: categoryItem.id.toString()));

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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<FoodsByCategoryBloc, FoodsByCategoryState>(
        builder: (context, state) {
          if (state is FoodsByCategoryFetchState) {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.items!.elementAt(index).name),
                                  Text(
                                    state.items!.elementAt(index).ingredients,
                                    style:
                                        GoogleFonts.gentiumBasic(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("${state.items!.elementAt(index).price} €")
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add_shopping_cart),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    childCount: state.items!.length,
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

/**
 * Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        
                                       
                                      ],
                                    ),
                                  ),
                                  
                                ],
                              ),
                             
 */
