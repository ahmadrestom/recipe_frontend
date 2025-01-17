import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/pages/savedRecipes.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_app/pages/upgradeToChef.dart';
import '../Providers/UserProvider.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.fetchFavoriteRecipes();
      if(userProvider.userFavorites!.isNotEmpty) {
        setState(() {
        isLoading = false;
        favoritesNumber = userProvider.userFavorites!.length;
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
                        Icon(Icons.share, size: 20,),
                        SizedBox(width: 30,),
                        Text(
                          "Share",
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
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return Center(
                              child: SingleChildScrollView(
                                child: Container(
                                  constraints: BoxConstraints(
                                    minHeight:  MediaQuery.of(context).size.height * 0.38,
                                  ),
                                  child: AlertDialog(
                                    backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                                    title: const Text(
                                      "Recipe Link",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                    ),
                                    content: Column(
                                      children: [
                                        const Text(
                                          "Copy recipe link and share your recipe link with friends and family.",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11,
                                            color: Color.fromRGBO(121, 121, 121, 1),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        CupertinoTextField(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          readOnly: true,
                                          enabled: false,
          
                                          suffix: ElevatedButton(
                                            style: ButtonStyle(
                                              shape: WidgetStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              backgroundColor: WidgetStateProperty.all(
                                                const Color.fromRGBO(18, 149, 117, 1),
                                              ),
          
                                            ),
                                            onPressed: (){
                                              /////////////////////////////////
                                            },
                                            child: const Text(
                                              "Copy Link",
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11,
                                                color: Color.fromRGBO(255, 255, 255, 1),
                                              ),
                                            ),
                                          ),
          
                                        ),
                                      ],
                                    ),
          
          
                                  ),
                                ),
                              ),
                            );
                          }
                      );
                    },
                  ),
                  PopupMenuItem(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: const Row(
                      children: [
                        Icon(Icons.star, size: 20,),
                        SizedBox(width: 30,),
                        Text(
                          "Rate Recipe",
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
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                height: MediaQuery.of(context).size.height * 0.16,
                                width: MediaQuery.of(context).size.width * 0.54,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Rate Recipe",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: Color.fromRGBO(18, 18, 18, 1),
                                      ),
                                    ),
                                    const SizedBox(height: 5.0,),
                                    RatingBar.builder(
                                        itemPadding: const EdgeInsets.only(right: 3),
                                        glowColor: Colors.amberAccent,
                                        unratedColor: const Color.fromRGBO(100,100,100,1),
                                        minRating: 1,
                                        maxRating: 5,
                                        itemSize: 25.0,
                                        allowHalfRating: true,
                                        initialRating: 0,
                                        itemBuilder: (context, index)=>const Icon(
                                          Ionicons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating){
                                          print(rating);
                                        }
                                    ),
                                    const SizedBox(height: 10.0,),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          backgroundColor: WidgetStateProperty.all<Color>(
                                            const Color.fromRGBO(18, 149, 117, 1),
                                          )
                                      ),
                                      onPressed: (){
                                        ///////////////////////////////////////
                                      },
                                      child: const Text(
                                        "Rate",
                                        style: TextStyle(
                                          color: Color.fromRGBO(255, 255, 255, 1),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11,
                                        ),
          
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
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
                    widget.name!,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: screenWidth*0.04,
                    color: const Color.fromRGBO(18, 149, 117, 1),
                    fontStyle: FontStyle.italic
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
                  "259",
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
