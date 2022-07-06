import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu/bloc/account_bloc.dart';
import 'package:menu/bloc/foods_by_category_bloc.dart';
import 'package:menu/bloc/home_categories_bloc.dart';
import 'package:menu/bloc/signin_bloc.dart';
import 'package:menu/screens/account_screen.dart';
import 'package:menu/screens/category_screen.dart';
import 'package:menu/screens/home_screen.dart';
import 'package:menu/screens/login_screen.dart';
import 'package:menu/screens/signin_screen.dart';
import 'package:menu/screens/spash_screen.dart';
import 'package:menu/theme_options.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => HomeCategoriesBloc(),
    ),
    BlocProvider(
      create: (context) => FoodsByCategoryBloc(),
    ),
    BlocProvider(
      create: (context) => AccountBloc(),
    ),
    BlocProvider(
      create: (context) => SigninBloc(),
    )
  ], child: const MyApp()));
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
        '/account/login': (context) => LoginScreen()
      },
    );
  }
}
