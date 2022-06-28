import 'package:flutter/material.dart';
import 'package:menu/screens/home_screen.dart';
import 'package:menu/screens/spash_screen.dart';
import 'package:menu/theme_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pizzeria Fittizzio',
        debugShowCheckedModeBanner: false,
        theme: appLightTheme,
        darkTheme: appDarkTheme,
        initialRoute: '/splash',
        routes: {
          '/': (context) => const HomeScreen(),
          '/splash': (context) => const SplashScreen()
        });
  }
}
