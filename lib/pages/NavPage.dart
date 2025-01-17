import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/UserProvider.dart';
import 'package:recipe_app/pages/AddRecipe.dart';
import 'package:recipe_app/pages/home.dart';
import 'package:recipe_app/pages/notifications.dart';
import 'package:recipe_app/pages/profile.dart';
import 'package:recipe_app/pages/savedRecipes.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cherry_toast/cherry_toast.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {

  final bottomBarPages = [
    const HomePage(),
    const SavedRecipes(),
    const Notifications(),
    const Profile(),
  ];

  int selected = 0;
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        selected = pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: pageController,
        children: bottomBarPages.map((page) => page).toList(),
      ),
      bottomNavigationBar: StylishBottomBar(
        elevation: 30,
        option: AnimatedBarOptions(
          iconSize: 30,
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.Default,
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
        ),
        items: [
          BottomBarItem(
            icon: const Icon(Ionicons.home_outline),
            selectedColor: const Color.fromRGBO(18, 149, 117, 1),
            unSelectedColor: const Color.fromRGBO(217, 217, 217, 1),
            title: const Text(''),
          ),
          BottomBarItem(
            icon: const Icon(Ionicons.bookmark_outline),
            title: const Text(''),
            selectedColor: const Color.fromRGBO(18, 149, 117, 1),
            unSelectedColor: const Color.fromRGBO(217, 217, 217, 1),
          ),
          BottomBarItem(
            icon: const Icon(Ionicons.notifications_outline),
            title: const Text(''),
            selectedColor: const Color.fromRGBO(18, 149, 117, 1),
            unSelectedColor: const Color.fromRGBO(217, 217, 217, 1),
          ),
          BottomBarItem(
            icon: const Icon(Ionicons.person_outline),
            title: const Text(''),
            selectedColor: const Color.fromRGBO(18, 149, 117, 1),
            unSelectedColor: const Color.fromRGBO(217, 217, 217, 1),
          ),
        ],
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        currentIndex: selected,
        notchStyle: NotchStyle.circle,
        onTap: (index){
          if(index == selected) return;
          pageController.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          final userProvider = Provider.of<UserProvider>(context, listen:false);
          if(userProvider.userDetails?['role'] == "USER"){
            CherryToast.error(
                description:  const Text("Upgrade to Chef Now!", style: TextStyle(color: Colors.black)),

                animationType:  AnimationType.fromTop,

                animationDuration:  const Duration(milliseconds:  2000),

                autoDismiss:  true

            ).show(context);
          }else{
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder:(context)=>const AddRecipe()
                )
            );
          }


        },
        backgroundColor: const Color.fromRGBO(18, 149, 117, 1),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
