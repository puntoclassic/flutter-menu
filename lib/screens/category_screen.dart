import 'package:flutter/material.dart';
import 'package:menu/models/category_item.dart';
import 'package:menu/widgets/menu_appbarheader.dart';
import 'package:menu/widgets/menu_body.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryItem categoryItem =
        ModalRoute.of(context)!.settings.arguments as CategoryItem;

    return Scaffold(
      appBar: AppBar(
        title: const MenuAppBarHeader(),
      ),
      body: MenuBody(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  Hero(
                    tag: categoryItem.id,
                    child: Container(
                      decoration: BoxDecoration(
                        image: categoryItem.imageUrl != null
                            ? DecorationImage(
                                image:
                                    Image.network(categoryItem.imageUrl!).image,
                                fit: BoxFit.cover)
                            : null,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
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
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
