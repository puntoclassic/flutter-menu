import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu/bloc/home_categories_bloc.dart';
import 'package:menu/widgets/menu_body.dart';

import '../widgets/home_categorywidget.dart';
import '../widgets/menu_appbarheader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeCategoriesBloc>().add(HomeCategoriesFetchEvent());

    return Scaffold(
      appBar: AppBar(
        title: const MenuAppBarHeader(),
      ),
      body: MenuBody(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                "In evidenza",
                style: GoogleFonts.mulish(),
              ),
            ),
            BlocBuilder<HomeCategoriesBloc, HomeCategoriesState>(
              builder: (context, state) {
                if (state is HomeCategoriesFetchState) {
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
                                          item: state.items!.elementAt(index));
                                    },
                                    childCount: state.items!.length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
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
              },
            )
          ],
        ),
      ),
    );
  }
}
