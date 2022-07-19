import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/category_provider.dart';
import 'home_categorywidget.dart';

class HomeCategoryContent extends ConsumerWidget {
  const HomeCategoryContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeCategories =
        ref.watch(categoryProvider.select((value) => value.homeCategories));

    if (homeCategories.isNotEmpty) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            primary: false,
            slivers: [
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  mainAxisExtent: 200,
                  childAspectRatio: 1 / 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return HomeCategoryWidget(
                        item: homeCategories.elementAt(index));
                  },
                  childCount: homeCategories.length,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
