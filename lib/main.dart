import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recipe_app/pages/landing.dart';
import 'package:recipe_app/pages/login.dart';
import 'package:recipe_app/pages/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/signup',
      /*routes: {
        '/': (context) => const LandingPage(),
      },*/
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
            break;
          case '/signup':
            return PageTransition(
              child:  SignUpPage(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 350),
              reverseDuration: const Duration(milliseconds: 200),
              settings: settings,
            );
          default:
            return null;
        }
      },

    );
  }
}