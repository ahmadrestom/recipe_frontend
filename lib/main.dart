import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:recipe_app/pages/notifications.dart';
import 'Providers/NotificationProvider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recipe_app/Providers/ChefSpecialityProvider.dart';
import 'package:recipe_app/Providers/FollowingProvider.dart';
import 'package:recipe_app/Providers/UserProvider.dart';
import 'package:recipe_app/pages/NavPage.dart';
import 'package:recipe_app/pages/landing.dart';
import 'package:recipe_app/pages/login.dart';
import 'package:recipe_app/pages/recentSearches.dart';
import 'package:recipe_app/pages/reviews.dart';
import 'package:recipe_app/pages/signup.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/services/UserServices/AuthService.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Notification/push_notification_handler.dart';
import 'Providers/RecipeProvider.dart';
import 'Providers/ReviewProvider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://sxpalpizikeaddvwyecg.supabase.co",
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN4cGFscGl6aWtlYWRkdnd5ZWNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzU5NDI5NzEsImV4cCI6MjA1MTUxODk3MX0.p_LKb68dZSwG2cwmeWb8s9NWOFS2IxJ9C28hSguJkpA"
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Message clicked! ${message.notification?.title}');
    navigatorKey.currentState?.pushNamed('/notifications');
  });
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => FollowingProvider()),
          ChangeNotifierProvider(create: (_) => RecipeProvider()),
          ChangeNotifierProvider(create: (_) => ReviewProvider()),
          ChangeNotifierProvider(create: (_) => NotificationProvider()),
          ChangeNotifierProvider(create: (_) => ChefSpecialityProvider())
        ],
          child: const MyApp()
      )
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    PushNotificationHandler().initialize(context);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); //to hide upper and lower bars
    return MaterialApp(
      navigatorKey: navigatorKey,
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
          case '/notifications':
            return PageTransition(
              child:  const Notifications(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 350),
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
            if(args is String) {
              return PageTransition(
                child: Reviews(recipeId: args),
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