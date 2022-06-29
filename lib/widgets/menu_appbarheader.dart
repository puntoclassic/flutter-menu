import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuAppBarHeader extends StatelessWidget {
  const MenuAppBarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text(
        "RISTORANTE PIZZERIA",
      ),
      Text(
        "Fittizzio",
        style: TextStyle(
            fontFamily: GoogleFonts.smooch().fontFamily, fontSize: 30),
      )
    ]);
  }
}
