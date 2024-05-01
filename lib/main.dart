import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/pages/NavPage.dart';
import 'package:recipe_app/pages/landing.dart';
import 'package:recipe_app/pages/login.dart';
import 'package:recipe_app/pages/recentSearches.dart';
import 'package:recipe_app/pages/recipeInformation.dart';
import 'package:recipe_app/pages/reviews.dart';
import 'package:recipe_app/pages/signup.dart';
import 'package:recipe_app/pages/Data/recipes.dart' as recipes;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); //to hide upper and lower bars
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(240, 240, 240, 1),
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/reviews',
      routes: {
        '/': (context) => const LandingPage(),
        '/reviews': (context) => Reviews(recipe: recipes.recipes[1]),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return PageTransition(
              child: const LoginPage(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 400),
              reverseDuration: const Duration(milliseconds: 200),
              settings: settings,
            );
          case '/signup':
            return PageTransition(
              child:  const SignUpPage(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 350),
              reverseDuration: const Duration(milliseconds: 200),
              settings: settings,
            );
          case '/navPage':
            return PageTransition(
              child:  const NavPage(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 350),
              reverseDuration: const Duration(milliseconds: 200),
              settings: settings,
            );
          case '/recentSearches':
            return PageTransition(
              child:  const RecentSearches(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 350),
              reverseDuration: const Duration(milliseconds: 200),
              settings: settings,
            );
          case '/reviews':
            final args = settings.arguments;
            if(args is Recipe) {
              return PageTransition(
                child: Reviews(recipe: args),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 350),
                reverseDuration: const Duration(milliseconds: 200),
                settings: settings,
              );
            }else{
              return null;
            }
          case '/recipeInformation':
            final args = settings.arguments;
            if(args is Recipe) {
              return PageTransition(
                child: RecipeInformation(recipe: args),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 350),
                reverseDuration: const Duration(milliseconds: 200),
                settings: settings,
              );
            }else{
              return null;
            }
          default:
            return null;
        }
      },

    );
  }
}