import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/RecipeProvider.dart';
import 'package:recipe_app/customerWidgets/RecipeForProfile.dart';
import 'package:recipe_app/models/Recipe.dart';
import 'package:recipe_app/pages/recipeInformation.dart';
import '../Providers/UserProvider.dart';


class ChefProfile extends StatefulWidget {
  const ChefProfile({super.key, required this.id});
  final String? id;

  @override
  State<ChefProfile> createState() => _ChefProfileState();
}

class _ChefProfileState extends State<ChefProfile> {

  Map<String, dynamic>? chefDetails;
  List<RecipeForProfile>? recipes;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
      await userProvider.getChefInfo(widget.id!);
      setState(() {
        chefDetails = userProvider.chefDetails;
      });
      await recipeProvider.fetchRecipesForProfile(widget.id!);
      setState(() {
        print("XXXXX ${widget.id}");
        recipes = recipeProvider.recipesForProfile;
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if(chefDetails == null){
      return const CircularProgressIndicator();
    }

    return Scaffold(
      body: Padding(
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
                  CircleAvatar(
                    radius: screenWidth *0.13,
                    backgroundImage: const AssetImage('assets/images/img.png'),
                  ),
                  Container(width: screenWidth*0.07,),
                  Column(
                    children: [
                      Text(
                          "Recipes",
                        style: TextStyle(
                          color: const Color.fromRGBO(169, 169, 169, 1),
                          fontSize: screenWidth * 0.033,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      Text(
                          "4",
                        style: TextStyle(
                          color: const Color.fromRGBO(18, 18, 18, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: screenWidth*0.045,
                          fontFamily: 'Poppins'
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: screenWidth*0.02,),
                  Column(
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
                          "2.5M",
                        style: TextStyle(
                            color: const Color.fromRGBO(18, 18, 18, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth*0.045,
                            fontFamily: 'Poppins'
                        ),
                      )
                    ],
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
              SizedBox(height: screenHeight*0.03,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${chefDetails?['firstName']} ${chefDetails?['lastName']}",
                    style: const TextStyle(
                      color: Color.fromRGBO(18, 18, 18, 1),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                    ),
                  ),
                  const Text(
                      "Chef",
                    style: TextStyle(
                      color: Color.fromRGBO(169, 169, 169, 1),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    chefDetails?['bio'],
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Color.fromRGBO(80,80, 80, 1),
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: screenHeight*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Years of experience: ",
                        style: TextStyle(
                          color: Color.fromRGBO(169, 169, 169, 1),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth * 0.033,
                        ),
                      ),
                      Text(
                        chefDetails!['years_experience'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Color.fromRGBO(80,80,80,1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.01,),
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
                ],
              ),
              SizedBox(height: screenHeight*0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: screenHeight *0.04,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(18, 149, 117, 1),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Text(
                        "Recipes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color.fromRGBO(255,255,255,1),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: screenWidth*0.04
                        ),

                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight*0.03,),

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
      )
    );
  }
}
