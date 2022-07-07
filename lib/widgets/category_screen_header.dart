import 'package:flutter/material.dart';

import '../models/category_item.dart';

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
