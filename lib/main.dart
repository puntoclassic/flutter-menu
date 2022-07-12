import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menu/screens/account/account_not_verified_screen.dart';
import 'package:menu/screens/account_screen.dart';
import 'package:menu/screens/category_screen.dart';
import 'package:menu/screens/home_screen.dart';
import 'package:menu/screens/login_screen.dart';
import 'package:menu/screens/signin_screen.dart';
import 'package:menu/screens/spash_screen.dart';
import 'package:menu/theme_options.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
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
      initialRoute: "/splash",
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/category': (context) => const CategoryScreen(),
        '/account': (context) => const AccountScreen(),
        '/account/signin': (context) => SigninScreen(),
        '/account/login': (context) => const LoginScreen(),
        '/account/verifica-account': (context) =>
            const AccountNotVerifiedScreen()
      },
    );
  }
}
