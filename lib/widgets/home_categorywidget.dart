import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/category_item.dart';

class HomeCategoryWidget extends StatelessWidget {
  final CategoryItem item;
  const HomeCategoryWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/category", arguments: item);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                spreadRadius: 1,
                color: Colors.black.withOpacity(0.3),
              )
            ],
          ),
          child: Stack(children: [
            Hero(
              tag: item.id,
              child: Container(
                decoration: BoxDecoration(
                    image: item.imageUrl != null
                        ? DecorationImage(
                            image: Image.network(item.imageUrl!).image,
                            fit: BoxFit.cover)
                        : null,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5)),
            ),
            Center(
              child: Text(
                item.name,
                style: GoogleFonts.smooch(fontSize: 30, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
