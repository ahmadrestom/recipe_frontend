import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:radio_grouped_buttons/custom_buttons/custom_radio_buttons_group.dart';
import 'package:recipe_app/Providers/FollowingProvider.dart';
import 'package:recipe_app/Providers/UserProvider.dart';
import '../customerWidgets/RecipeInformationCard.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/Recipe.dart';
import 'ViewChefData.dart';

class RecipeInformation extends StatefulWidget {
  const RecipeInformation({super.key, required this.recipe});
  final Recipe recipe;

  @override
  State<RecipeInformation> createState() => _RecipeInformationState();
}

class _RecipeInformationState extends State<RecipeInformation> {

  @override
  void initState() {
    super.initState();
  }


  String selectedOption = "Ingredients";
  //late TextEditingController _controller;
  bool clicked = false;
  String? userId;

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userId = userProvider.userId;
    final followProvider = Provider.of<FollowingProvider>(context, listen: false);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        margin:  EdgeInsets.fromLTRB(
            screenWidth*0.06,
            screenHeight*0.015,
            screenWidth*0.06,
            screenHeight*0.05
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          enabled: true,
                                          controller: TextEditingController(text: "https://recipeApp/${widget.recipe.recipeId}"),
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
                                              print("XXXXXXXXXXXXXXXXx");
                                              CherryToast.success(
                                                title:  const Text("Link copied to clipboard", style: TextStyle(color: Colors.black)),
                                                animationType:  AnimationType.fromBottom,
                                                animationDuration:  const Duration(milliseconds:  500),
                                                autoDismiss:  true,
                                                toastPosition: Position.bottom,
                                              ).show(context);
                                              Navigator.pop(context);
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
                                            CherryToast.success(
                                                title:  const Text("Thanks for rating!", style: TextStyle(color: Colors.black)),
                                                animationType:  AnimationType.fromBottom,
                                                animationDuration:  const Duration(milliseconds:  500),
                                                autoDismiss:  true,
                                              toastPosition: Position.bottom,
                                            ).show(context);
                                            Navigator.pop(context);
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
                    PopupMenuItem(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: const Row(
                        children: [
                          Icon(Icons.rate_review_sharp, size: 20,),
                          SizedBox(width: 30,),
                          Text(
                            "Review",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              color: Color.fromRGBO(18, 18, 18, 1),

                            ),
                          ),
                        ],
                      ),
                      onTap: (){
                        Navigator.pushNamed(
                          context,
                          '/reviews',
                          arguments: widget.recipe.recipeId,
                        );
                      },
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: const Row(
                        children: [
                          Icon(Icons.view_headline_outlined, size: 20,),
                          SizedBox(width: 30,),
                          Text(
                            "Nutrition Facts",
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
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            backgroundColor: Colors.white,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 5,
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Text(
                                      "Nutrition Facts",
                                      style: GoogleFonts.akshar(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 22,
                                        color: const Color.fromRGBO(18, 149, 117, 1),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: MediaQuery.of(context).size.height * 0.6,
                                      ),
                                      child: SingleChildScrollView(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          elevation: 3,
                                          color: Colors.grey[100],
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Column(
                                              children: [
                                                const Divider(),
                                                _buildNutritionItem("Calories", widget.recipe.nutritionalInformation!.calories.toString()),
                                                const Divider(),
                                                _buildNutritionItem("Total Fat", widget.recipe.nutritionalInformation!.totalFat.toString()),
                                                const Divider(),
                                                _buildNutritionItem("Cholesterol", widget.recipe.nutritionalInformation!.cholesterol.toString()),
                                                const Divider(),
                                                _buildNutritionItem("Carbohydrates", widget.recipe.nutritionalInformation!.carbohydrates.toString()),
                                                const Divider(),
                                                _buildNutritionItem("Protein", widget.recipe.nutritionalInformation!.protein.toString()),
                                                const Divider(),
                                                _buildNutritionItem("Sugar", widget.recipe.nutritionalInformation!.sugar.toString()),
                                                const Divider(),
                                                _buildNutritionItem("Sodium", widget.recipe.nutritionalInformation!.sodium.toString()),
                                                const Divider(),
                                                _buildNutritionItem("Fiber", widget.recipe.nutritionalInformation!.fiber.toString()),
                                                const Divider(),
                                                _buildNutritionItem("Zinc", widget.recipe.nutritionalInformation!.zinc.toString()),
                                                const Divider(),
                                                _buildNutritionItem("Magnesium", widget.recipe.nutritionalInformation!.magnesium.toString()),
                                                const Divider(),
                                                _buildNutritionItem("Potassium", widget.recipe.nutritionalInformation!.potassium.toString()),
                                                const Divider(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(18, 149, 117, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                        child: Text(
                                          "Close",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                    ),
                  ]
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  RecipeInformationCard(recipe:widget.recipe),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          //overflow: TextOverflow.ellipsis,
                          widget.recipe.recipeName,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ),
                      Text(
                        "(${widget.recipe.getNumberOfReviews()} Reviews)",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(140, 140, 140, 1)
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewChefData(chefId:widget.recipe.chef.chefId)),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.transparent),
                        ),
                  
                        child:widget.recipe.chef.imageUrl ==null?
                        Image.asset(
                          "assets/icons/defaultProfile.png",
                        )
                        :Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(widget.recipe.chef.imageUrl!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                        /*child: widget.recipe.chef.imageUrl == null?
                        Image.asset(
                          "assets/icons/defaultProfile.png",
                        ):
                        Image.network(
                  
                        ),*/
                      ),
                      const SizedBox(width: 8.0,),
                      Column(
                        children: [
                          Text(
                            "${widget.recipe.chef.firstName} ${widget.recipe.chef.lastName}",
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(18, 18, 18, 1),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Color.fromRGBO(113, 177, 161, 1),
                              ),
                              Text(
                                widget.recipe.chef.location,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Color.fromRGBO(140, 140, 140, 1)
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  
                  ),
                ),
      FutureBuilder<bool>(
        future: followProvider.isFollowing(userId!, widget.recipe.chef.chefId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Container();
            // return Lottie.asset(
            //     'assets/loader.json',
            //   width: screenWidth*0.1,
            // );
          }

          if (userId! == widget.recipe.chef.chefId) {
            return Container(); // Hide the button if the user is the chef
          }

          if (snapshot.hasData) {
            bool isFollowing = snapshot.data!;

            return StatefulBuilder(
              builder: (context, setState) {
                return ElevatedButton(
                  onPressed: () async {
                    if (isFollowing) {
                      await followProvider.unfollowChef(widget.recipe.chef.chefId);
                      setState(() {
                        isFollowing = false;
                      });
                    } else {
                      await followProvider.followChef(widget.recipe.chef.chefId);
                      setState(() {
                        isFollowing = true;
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                      // Determine button color based on following state
                      return isFollowing
                          ? Colors.white // White if following
                          : const Color.fromRGBO(18, 149, 117, 1); // Green if not following
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                      // Determine text color
                      return isFollowing
                          ? const Color.fromRGBO(18, 149, 117, 1) // Green text if following
                          : Colors.white; // White text if not following
                    }),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                    isFollowing ? "Following" : "Follow",
                    style: TextStyle(
                      color: isFollowing
                          ? const Color.fromRGBO(18, 149, 117, 1) // Green text if following
                          : Colors.white, // White text if not following
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Text("Error"); // Handle errors
          }
        },
      )

      ],
            ),
            const SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRadioButton(
                  buttonLables: const ["Ingredients", "Procedure"],
                  buttonValues: const ["Ingredients", "Procedure"],
                  radioButtonValue: (value,index){
                    setState(() {
                      selectedOption = value;
                    });
                  },
                  horizontal: true,
                  buttonWidth: MediaQuery.of(context).size.width * 0.38,
                  enableShape: false,
                  buttonSpace: 5,
                  elevation: 5,
                  buttonColor: const Color.fromRGBO(255, 255, 255, 1),
                  selectedColor: const Color.fromRGBO(18, 149, 117, 1),
                  selectedTextColor: const Color.fromRGBO(255, 255, 255, 1),
                  textColor: const Color.fromRGBO(113, 177, 161, 1),
                ),
              ],
            ),

            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.ramen_dining_sharp,
                      color: Color.fromRGBO(169, 169, 169, 1),
                    ),
                    Text(
                      "1 serving",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color.fromRGBO(169, 169, 169, 1),
                      ),
                    )
                  ],
                ),
                if(selectedOption == "Ingredients")
                  Text(
                    "${widget.recipe.ingredients.length} Items",
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color.fromRGBO(169, 169, 169, 1),
                    ),

                  ),
                if(selectedOption == "Procedure")
                  Text(
                    "${widget.recipe.instructions.length} Steps",
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color.fromRGBO(169, 169, 169, 1),
                    ),
                  ),
              ],
            ),
            
            if(selectedOption == "Ingredients")
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(13, 7, 13, 0),
                  child: ListView.builder(
                    itemCount: widget.recipe.ingredients.length,
                    itemBuilder: (context, index){
                      final ingredient = widget.recipe.ingredients.elementAt(index);
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(217, 217, 217, 1),
                        ),
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 75,
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                              Text(
                                ingredient.name,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Color.fromRGBO(18, 18, 18, 1),
                                ),
                              ),
                              Text(
                                "${ingredient.grams} g",
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color.fromRGBO(155, 155, 155, 1),
                                ),
                              ),
                            ],
                      ),
                      );
                    },
                  ),
                ),
              ),
            if(selectedOption == "Procedure")
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(13, 7, 13, 0),
                  child: ListView.builder(
                    itemCount: widget.recipe.instructions.length,
                    itemBuilder: (context, index){
                      return Container(
                        constraints: const BoxConstraints(minHeight: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(217, 217, 217, 1),
                        ),
                        margin: const EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Step ${widget.recipe.instructions[index].instructionOrder} ",
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Color.fromRGBO(18, 18, 18, 1),
                              ),
                            ),
                            Text(
                              widget.recipe.instructions[index].instruction,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color.fromRGBO(169, 169, 169, 1),
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      )
    );
  }
}

Widget _buildNutritionItem(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.akshar(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: const Color.fromRGBO(18, 149, 117, 1),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}
