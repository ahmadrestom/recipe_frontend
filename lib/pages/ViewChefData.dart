import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/pages/recipeInformation.dart';
import '../Providers/RecipeProvider.dart';
import '../Providers/UserProvider.dart';
import '../customerWidgets/RecipeForProfile.dart';
import '../customerWidgets/curvedDesignScreen.dart';
import '../models/Recipe.dart';

class ViewChefData extends StatefulWidget {
  const ViewChefData({super.key, this.chefId});
  final String? chefId;

  @override
  State<ViewChefData> createState() => _ViewChefDataState();
}

class _ViewChefDataState extends State<ViewChefData> {

  Map<String, dynamic>? chefDetails;
  List<RecipeForProfile>? recipes;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
      await userProvider.getChefInfo(widget.chefId!);
      setState(() {
        chefDetails = userProvider.chefDetails;
      });
      await recipeProvider.fetchRecipesForProfile(widget.chefId!);
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
      return const CircularProgressIndicator();
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 27,
                        color: Color.fromRGBO(41, 45, 50, 1),
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
                          Container(
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
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
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
                    Text(
                        "${chefDetails?['firstName']} ${chefDetails?['lastName']}",
                      style: GoogleFonts.anton(
                        textStyle: TextStyle(color: const Color.fromRGBO(18, 149, 117, 1), fontSize: screenWidth*0.1),
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        letterSpacing: screenWidth*0.011
                      ),
                    ),
                    Container(width: screenWidth*0.01,),
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
}
