import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Categorie",
              style: GoogleFonts.mulish(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                height: 150,
                child: CustomScrollView(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  slivers: [
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 140,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        mainAxisExtent: 150,
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
            )
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Categorie",
            style: GoogleFonts.mulish(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              )
            ],
          )
        ],
      ),
    );
  }
}
