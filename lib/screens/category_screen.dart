import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menu/models/category_item.dart';
import 'package:menu/providers/food_provider.dart';
import 'package:menu/widgets/menu_body.dart';

import '../widgets/category_screen_header.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CategoryItem categoryItem =
        ModalRoute.of(context)!.settings.arguments as CategoryItem;

    ref
        .read(foodProvider.notifier)
        .fetchFoodsByCategory(categoryItem.id.toString());

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

class CategoryScreenBody extends ConsumerWidget {
  const CategoryScreenBody({
    Key? key,
    required this.categoryItem,
  }) : super(key: key);

  final CategoryItem categoryItem;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items =
        ref.watch(foodProvider.select((value) => value.foodsByCategory));

    if (items.isNotEmpty) {
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
                            Text(items.elementAt(index).name),
                            Text(
                              items.elementAt(index).ingredients,
                              style: GoogleFonts.gentiumBasic(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Text("${items.elementAt(index).price} €")],
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
              childCount: items.length,
            ),
          )
        ],
      );
    } else {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
