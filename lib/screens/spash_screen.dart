import 'package:flutter/material.dart';
import 'package:menu/theme_options.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        print("Push screen");

        Navigator.of(context).pushReplacementNamed('/');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Splash screen build");

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "images/img_pizza.png",
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(color: Colors.white),
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
