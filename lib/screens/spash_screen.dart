import 'package:flutter/material.dart';
import 'package:menu/theme_options.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacementNamed('/');
      },
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "images/img_pizza.png",
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            Text(
              "Pizzeria Fittizzio",
              style: splashLogoFontStyle,
            ),
          ],
        ),
      ),
    );
  }
}
