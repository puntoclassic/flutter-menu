import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu/bloc/category_bloc.dart';

import 'home_categorywidget.dart';

class HomeCategoryContent extends StatelessWidget {
  const HomeCategoryContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryHomeCategoriesFetchResponseState) {
          if (state.items.isNotEmpty) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  slivers: [
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        mainAxisExtent: 200,
                        childAspectRatio: 1 / 1,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return HomeCategoryWidget(
                              item: state.items.elementAt(index));
                        },
                        childCount: state.items.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
