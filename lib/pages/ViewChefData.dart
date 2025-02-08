import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/Providers/ChefSpecialityProvider.dart';
import 'package:recipe_app/Providers/FollowingProvider.dart';
import 'package:recipe_app/models/FollowerStats.dart';
import 'package:recipe_app/pages/ViewChefSpecialities.dart';
import 'package:recipe_app/pages/recipeInformation.dart';
import '../Providers/RecipeProvider.dart';
import '../Providers/UserProvider.dart';
import '../customerWidgets/RecipeForProfile.dart';
import '../customerWidgets/curvedDesignScreen.dart';
import '../models/Recipe.dart';
import '../models/chef_speciality.dart';
import 'Followers.dart';

class ViewChefData extends StatefulWidget {
  const ViewChefData({super.key,required this.chefId});
  final String chefId;

  @override
  State<ViewChefData> createState() => _ViewChefDataState();
}

class _ViewChefDataState extends State<ViewChefData> {

  Map<String, dynamic>? chefDetails;
  List<RecipeForProfile>? recipes;
  List<ChefSpeciality>? specialities;
  bool flag = false;
  FollowerStats? followerStats;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
      final chefSpecialityProvider = Provider.of<ChefSpecialityProvider>(context, listen: false);
      final followProvider = Provider.of<FollowingProvider>(context, listen: false);
      await userProvider.getChefInfo(widget.chefId);
      await chefSpecialityProvider.getSpecialitiesForChef(widget.chefId);
      await followProvider.getStats(widget.chefId);
      setState(() {
        followerStats = followProvider.followerStats;
        chefDetails = userProvider.chefDetails;
        specialities = chefSpecialityProvider.specialitiesForChef;
        if(specialities!.isNotEmpty){
          flag = true;
        }
      });
      await recipeProvider.fetchRecipesForProfile(widget.chefId);
      setState(() {
        print("XXXXX ${widget.chefId}");
        recipes = recipeProvider.recipesForProfile;
      });
    });
  }

  @override
  Widget build(BuildContext context){

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if(chefDetails==null){
      return Center(child: Lottie.asset(
          'assets/loader.json'
      ));
    }

    return Scaffold(
      body: Stack(
        children:[
          ///////////////////////
          const CurvedDesignScreen(),
          /////////////////////////
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight *0.03, horizontal: screenWidth*0.05),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 27,
                        color: Color.fromRGBO(41, 45, 50, 1),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the Specialties page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ViewChefSpecialities(chefId: widget.chefId, name: chefDetails?['firstName'])),
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF14B89B), Color(0xFF6DFFBB)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              offset: Offset(4, 4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star, // You can change the icon based on your design
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "View Specialties",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight*0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: screenWidth*0.001),
                    SizedBox(
                      width: screenWidth * 0.5,
                      height: screenWidth * 0.5,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer glowing effect
                          Container(
                            width: screenWidth * 0.55,
                            height: screenWidth * 0.55,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.blue.withOpacity(0.3),
                                  Colors.purple.withOpacity(0.5),
                                ],
                                stops: const [0.7, 0.9, 1.0],
                              ),
                            ),
                          ),
                          // Rotating gradient border
                          Container(
                            width: screenWidth * 0.5,
                            height: screenWidth * 0.5,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: SweepGradient(
                                colors: [
                                  Colors.red,
                                  Colors.orange,
                                  Colors.yellow,
                                  Colors.green,
                                  Colors.cyan,
                                  Colors.blue,
                                  Colors.purple,
                                  Colors.red,
                                ],
                                stops: [0.0, 0.14, 0.28, 0.42, 0.57, 0.71, 0.85, 1.0],
                                transform: GradientRotation(0.0), // Static, but can be animated
                              ),
                            ),
                          ),
                          // White inner border
                          Container(
                            width: screenWidth * 0.47,
                            height: screenWidth * 0.47,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white, // Inner frame
                            ),
                          ),
                          // Avatar image
                          GestureDetector(
                            child: Container(
                              width: screenWidth * 0.45,
                              height: screenWidth * 0.45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: chefDetails?['image_url'] == null
                                      ? const AssetImage("assets/icons/defaultProfile.png") as ImageProvider
                                      : NetworkImage(chefDetails!['image_url']) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              _showFullSizeImageDialog(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(width: screenWidth*0.001),


                  ],
                ),
                SizedBox(height: screenHeight*0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: screenWidth*0.01,),
                    Container(
                      width: screenWidth*0.88,
                      child: Text(
                          "${chefDetails?['firstName']} ${chefDetails?['lastName']}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.anton(
                          textStyle: TextStyle(color: const Color.fromRGBO(18, 149, 117, 1), fontSize: screenWidth*0.1),
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          letterSpacing: screenWidth*0.009,
                          fontSize: screenWidth*0.09
                        ),
                      ),
                    ),
                    Container(width: screenWidth*0.01,),
                  ],
                ),
                SizedBox(height: screenHeight*0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: Column(
                        children: [
                          Text(
                            "Followers",
                            style: TextStyle(
                                color: const Color.fromRGBO(169, 169, 169, 1),
                                fontSize: screenWidth * 0.033,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          Text(
                            followerStats!.followerCount.toString(),
                            style: TextStyle(
                                color: const Color.fromRGBO(18, 18, 18, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth*0.045,
                                fontFamily: 'Poppins'
                            ),
                          )
                        ],
                      ),
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context)=>Followers(chefId: chefDetails?['chefId'], name: "${chefDetails?['firstName']} ${chefDetails?['lastName']}", follower: true,)));
                      },
                    ),
                    SizedBox(width: screenWidth*0.02,),
                    GestureDetector(
                      child: Column(
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
                            followerStats!.followingCount.toString(),
                            style: TextStyle(
                                color: const Color.fromRGBO(18, 18, 18, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth*0.045,
                                fontFamily: 'Poppins'
                            ),
                          ),
                        ],
                      ),
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context)=>Followers(chefId: chefDetails?['chefId'], name: "${chefDetails?['firstName']} ${chefDetails?['lastName']}", follower: false,)));
                      },
                    ),
                  ],
                ),
                SizedBox(height: screenHeight*0.02,),
                Text(
                  chefDetails?['bio'],
                  style: GoogleFonts.aleo(
                      textStyle: TextStyle(color: const Color.fromRGBO(
                          11, 117, 89, 1.0), fontSize: screenWidth*0.042),
                      fontStyle: FontStyle.normal,
                      letterSpacing: screenWidth*0.005
                  ),
                ),
          SizedBox(height: screenHeight*0.02,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on,
                color: Color.fromRGBO(18, 149, 117, 1),
              ),
              Text(
                chefDetails?['location'],
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.italic
                ),
              ),
            ],
          ),
                SizedBox(height: screenHeight*0.02,),
                Expanded(
                  child: (recipes==null || recipes!.isEmpty)?
                  const Center(child: Text("No Recipes"),)
                      :ListView.builder(
                    itemCount: recipes!.length,
                    itemBuilder: (context, index){
                      bool isFirst = index == 0;
                      bool isLast = index == recipes!.length - 1;
                      EdgeInsets itemMargin = EdgeInsets.only(
                          top: isFirst ? 2 : 10, bottom: isLast ? 0 : 10);
                      return GestureDetector(
                        onTap: () {
                          final ide = recipes![index].recipeId;
                          print("Recipe ID: $ide");
                          final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
                          recipeProvider.fetchRecipeById(ide).then((_) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeInformation(
                                  recipe: recipeProvider.recipeByID!,
                                ),
                              ),
                            );
                          });
                        },
                        child: Container(
                          margin: itemMargin,
                          child: Recipeforprofile(
                            recipe: recipes![index],
                          ),
                        ),
                      );
                    },
                  ),
                ),


              ],
            ),
        ),
    ]
      ),
    );
  }
  void _showFullSizeImageDialog(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Transparent background for the dialog
          child: Container(
            width: screenWidth*0.4,
            height: screenHeight*0.4,
            decoration: BoxDecoration(
              color: Colors.transparent, // Keep the container background transparent
              borderRadius: BorderRadius.circular(20), // Rounded corners for the dialog
            ),
            child: Stack(
              children: [
                // Apply blur to the background
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                        color: Colors.transparent
                    ),
                  ),
                ),
                Center(
                  child: ClipOval(
                    child: userProvider.chefDetails?['image_url'] == null
                        ? const Image(
                      image: AssetImage('assets/images/img.png'),
                      fit: BoxFit.cover,
                    )
                        : Image.network(
                      userProvider.chefDetails?['image_url'] ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
