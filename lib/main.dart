import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu/screens/home_screen.dart';
import 'package:menu/screens/spash_screen.dart';

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
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 218, 212, 205),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          primaryColor: const Color.fromARGB(255, 218, 212, 205),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black),
          ),
        ),
        darkTheme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 141, 2, 39),
          ),
          primaryColor: const Color.fromARGB(255, 141, 2, 39),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          ),
        ),
        initialRoute: '/splash',
        routes: {
          '/': (context) => const HomeScreen(),
          '/splash': (context) => const SplashScreen()
        });
  }
}
