import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(children: [
          Text("RISTORANTE PIZZERIA",
              style: Theme.of(context).textTheme.titleSmall),
          Text("Fittizzio", style: Theme.of(context).textTheme.titleMedium)
        ]),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.2))
          ],
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                "IN EVIDENZA",
                style: GoogleFonts.mulish(),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                "CATEGORIE",
                style: GoogleFonts.mulish(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
