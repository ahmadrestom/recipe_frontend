import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recipe_app/Providers/UserProvider.dart';
import 'package:recipe_app/pages/NavPage.dart';
import 'package:recipe_app/pages/landing.dart';
import 'package:recipe_app/pages/login.dart';
import 'package:recipe_app/pages/recentSearches.dart';
import 'package:recipe_app/pages/signup.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/services/UserServices/AuthService.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Providers/RecipeProvider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://sxpalpizikeaddvwyecg.supabase.co",
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN4cGFscGl6aWtlYWRkdnd5ZWNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzU5NDI5NzEsImV4cCI6MjA1MTUxODk3MX0.p_LKb68dZSwG2cwmeWb8s9NWOFS2IxJ9C28hSguJkpA"
  );
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => RecipeProvider())
        ],
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); //to hide upper and lower bars
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(240, 240, 240, 1),
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LandingPage(),

      /*routes: {

        '/reviews': (context) => Reviews(recipe: recipes.recipes[1]),
      },*/
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            final AuthService authService = settings.arguments as AuthService;
            return PageTransition(
              child:  LoginPage(authService: authService),
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
          /*case '/reviews':
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
            }*/
          default:
            return null;
        }
      },

    );
  }
}