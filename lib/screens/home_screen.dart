import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu/bloc/category_bloc.dart';
import 'package:menu/widgets/home_category_content.dart';
import 'package:menu/widgets/menu_body.dart';

import '../widgets/menu_appbarheader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CategoryBloc>().add(CategoryFetchHomeCategoriesEvent());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const MenuAppBarHeader(),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {
              Navigator.of(context).pushNamed('/account');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: MenuBody(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Expanded(
                child: HomeCategoryContent(),
              ),
            ],
          ),
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
