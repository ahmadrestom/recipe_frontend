import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/pages/savedRecipes.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_app/pages/upgradeToChef.dart';
import '../Providers/FollowingProvider.dart';
import '../Providers/UserProvider.dart';
import '../models/FollowerStats.dart';
import 'landing.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({super.key, this.id, this.email, this.name});
  final String? id;
  final String? email;
  final String? name;

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {

  int favoritesNumber = 0;
  bool isLoading = true;
  FollowerStats? followerStats;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      final followProvider = Provider.of<FollowingProvider>(context, listen: false);
      await followProvider.getStats(widget.id!);
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.fetchFavoriteRecipes();
      if(userProvider.userFavorites != null && userProvider.userFavorites!.isNotEmpty && followProvider.followerStats!=null) {
        setState((){
          isLoading = false;
          favoritesNumber = userProvider.userFavorites!.length;
          followerStats = followProvider.followerStats;
        });
      }else{
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if(isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
          padding: EdgeInsets.fromLTRB(screenWidth*0.03, screenHeight*0.03, screenWidth*0.03, 0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(width: screenWidth*0.1,),
            const Text(
              "Profile",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Color.fromRGBO(18, 18, 18, 1),
              ),
            ),
            PopupMenuButton(
                elevation: 10,
                offset: const Offset(0,40),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                ),
                color: const Color.fromRGBO(255, 255, 255, 1),
                icon: const Icon(
                  Icons.more_horiz,
                  size: 27,
                ),
                onSelected: (String value){
          
                },
                itemBuilder: (BuildContext context)=> <PopupMenuEntry<String>>[
                  PopupMenuItem(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: const Row(
                      children: [
                        Icon(Icons.logout, size: 20),
                        SizedBox(width: 30),
                        Text(
                          "Sign out",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            color: Color.fromRGBO(18, 18, 18, 1),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Future.delayed(
                        const Duration(milliseconds: 100), // Delay to ensure menu dismisses
                            () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                title: const Text(
                                  "Log Out",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Color.fromRGBO(18, 18, 18, 1),
                                  ),
                                ),
                                content: const Text(
                                  "Are you sure you want to log out?",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color.fromRGBO(100, 100, 100, 1),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color.fromRGBO(100, 100, 100, 1),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(18, 149, 117, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () async {
                                      final userProvider = Provider.of<UserProvider>(context, listen: false);
                                      await userProvider.logout();
                                      if(mounted){
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const LandingPage(),
                                          ),
                                              (route) => false,
                                        );
                                      }


                                    },
                                    child: const Text(
                                      "Log Out",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
          
                ]
            ),
          
          ],
          
                ),
                SizedBox(height: screenHeight*0.02,),
                Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: screenWidth *0.13,
                  backgroundImage: const AssetImage("assets/icons/defaultProfile.png"),
                ),
                SizedBox(height: screenHeight*0.02,),
                widget.name != null?
                Text(
                    widget.name!.replaceFirst(widget.name![0], widget.name![0].toUpperCase()),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: screenWidth*0.04,
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                  ),
                )
                    : Text(""),
              ],
            ),
            Container(width: screenWidth*0.07,),
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder:
                        (context)=> const SavedRecipes()));
              },
              child: Column(
                children: [
                  Text(
                    "Saved Recipes",
                    style: TextStyle(
                        color: const Color.fromRGBO(169, 169, 169, 1),
                        fontSize: screenWidth * 0.033,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  Text(
                    favoritesNumber.toString(),
                    style: TextStyle(
                        color: const Color.fromRGBO(18, 18, 18, 1),
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth*0.045,
                        fontFamily: 'Poppins'
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: screenWidth*0.02,),
          
            Column(
              children: [
                Text(
                  "Following",
                  style: TextStyle(
                      color: const Color.fromRGBO(169, 169, 169, 1),
                      fontSize: screenWidth * 0.033,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  followerStats?.followingCount.toString() ?? "0",
                  style: TextStyle(
                      color: const Color.fromRGBO(18, 18, 18, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth*0.045,
                      fontFamily: 'Poppins'
                  ),
                ),
              ],
            ),
          ],
                ),
                SizedBox(height: screenHeight*0.06,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: screenWidth*0.01,),
                    Container(
                      constraints: BoxConstraints(
                        minHeight: screenHeight*0.07,
                      ),

                      child: DefaultTextStyle(
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: const Color.fromRGBO(18, 149, 117, 1),
                          fontSize: screenWidth*0.05,
                          fontFamily: 'Poppins',
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                                'UPGRADE TO CHEF?',
                            ),
                            TypewriterAnimatedText(
                                'CLICK ME',
                            ),
                            TypewriterAnimatedText(
                                'Start your culinary journey!'.toUpperCase(),
                            ),
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth*0.01,),


                  ],
                ),
                SizedBox(width: screenWidth*0.02,),
                GestureDetector(
                  child: Lottie.asset(
                      'assets/chef.json',
                    repeat: false
                  ),
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context)=> Upgradetochef(email: widget.email,)));
                  },
                ),
                //UserProfilePage(email: widget.email),
          
          
          
              ]
              ),
              ),
        ),
    );
  }
}
