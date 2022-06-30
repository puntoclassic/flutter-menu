import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu/bloc/foods_by_category_bloc.dart';
import 'package:menu/models/category_item.dart';
import 'package:menu/widgets/menu_body.dart';

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
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          height: 40,
                          color: Colors.red,
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

class CategoryScreenHeader extends StatelessWidget {
  const CategoryScreenHeader({
    Key? key,
    required this.categoryItem,
  }) : super(key: key);

  final CategoryItem categoryItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Hero(
            tag: categoryItem.id,
            child: Container(
              decoration: BoxDecoration(
                image: categoryItem.imageUrl != null
                    ? DecorationImage(
                        image: Image.network(categoryItem.imageUrl!).image,
                        fit: BoxFit.cover)
                    : null,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top,
            ),
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon:
                            const Icon(Icons.arrow_back, color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryItem.name,
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
