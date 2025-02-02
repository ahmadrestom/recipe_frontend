import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/RecipeProvider.dart';
import 'package:recipe_app/Providers/UserProvider.dart';
import 'package:recipe_app/customerWidgets/CategoryItem.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/pages/SearchRecipes.dart';
import 'package:recipe_app/pages/recipeInformation.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import '../models/category.dart' as category;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  int? currentSelection = 0;

  /*late List<Recipe> recipes = [];
  late List<Recipe> newRecipes = [];
  final List<String> time = ["All", "New", "Old"];
  final List<String> rating = ["1","2","3","4","5"];*/

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchFavoriteRecipes();

  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userDetails = userProvider.userDetails;
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: true);
    final recipeDetails = recipeProvider.filteredRecipes?? recipeProvider.recipeDetails;
    final categories = recipeProvider.categoryList??[];
    //categories.forEach((element) {print(element.categoryName);});
    category.Category selectedCategory = recipeProvider.selectedCategory;
    final recentRecipeDetails = recipeProvider.recentRecipeDetails;
    if(recipeDetails == null || recentRecipeDetails==null){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(
                    top: screenHeight*0.05, left: screenWidth*0.08, right: screenWidth*0.08
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello ${userDetails?['firstName']} ${userDetails?['lastName']}',
                          style:  TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth*0.05,
                            color: const Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        const SizedBox(height: 6,),
                         Text(
                          'What are you cooking today?',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: screenWidth*0.035,
                            color: const Color.fromRGBO(169, 169, 169, 1),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: screenWidth * 0.12,
                      height: screenWidth * 0.12,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.amber
                      ),
                      child: Image.asset('assets/images/avatar.png'),
                      //child: userDetails?['imageUrl'] == null? Image.asset('assets/icons/profile.png'):Image.network(userDetails?['imageUrl']),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.85,
                      height: screenHeight * 0.05,
                      child: CupertinoTextField(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context)=>SearchRecipes(recipes: recipeDetails)));
                        },
                        placeholder: "Search",
                        readOnly: true,
                        prefix: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          child: Image.asset('assets/icons/search.png'),

                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)
                        ),

                      ),
                    ),
                    /*GestureDetector(
                      child: Image.asset(
                        'assets/icons/filter.png',
                        width: screenWidth * 0.12,
                        height: screenWidth * 0.12,
                      ),
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context)=>const RecentSearches()));
                      },
                    )*/
                  ],
                ),
              ),

              const SizedBox(height: 25,),

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,

                      child:  ListView.builder(
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                            bool isFirst = index == 0;
                            bool isLast = index == recipeDetails.length - 1;
                            EdgeInsets itemMargin = EdgeInsets.only(
                                left: isFirst ? screenWidth * 0.05 : screenWidth * 0.02,
                                right: isLast ? screenWidth * 0.05 : screenWidth * 0.02);
                            return Container(

                              margin: itemMargin,
                              child: CategoryItem(
                                category: categories[index],
                                selectedCategory: recipeProvider.selectedCategory,
                                onCategorySelected: (category){
                                  recipeProvider.updateCategory(category);
                                },
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                ],
              ),
              recipeDetails.isEmpty?
              const Center(
                child: CircularProgressIndicator(),
              )
                  :Container(
                margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                height: 231,
                child: ListView.builder(
                    itemCount: recipeDetails.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final recipe = recipeDetails[index];
                      final isFavorite = userProvider.userFavorites?.any((fav) => fav.recipeId == recipe.recipeId) ?? false;
                      bool isFirst = index == 0;
                      bool isLast = index == recipeDetails.length - 1;
                      EdgeInsets itemMargin = EdgeInsets.only(
                          left: isFirst ? screenWidth * 0.08 : 10,
                          right: isLast ? screenWidth * 0.08 : 10);
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeInformation(recipe: recipeDetails[index]),
                            ),
                          );
                        },
                        child: Container(
                          margin: itemMargin,
                          width: screenWidth * 0.4,
                          child: Stack(
                            children: [
                              Positioned(
                                top: screenHeight * 0.07,
                                child: Container(
                                  width: screenWidth * 0.4,
                                  height: screenHeight * 0.22,
                                  decoration: BoxDecoration(
                                    //color: const Color.fromRGBO(217, 217, 217, 0.5),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(217, 217, 217, 1),
                                          spreadRadius: 2,
                                          blurRadius: 1,
                                          offset: Offset(0,3),
                                        )
                                      ]
                                  ),
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.03),
                                      child: Text(
                                        recipeDetails[index].recipeName,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.04,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            color: const Color.fromRGBO(48, 48, 48, 1)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: screenWidth*0.07,
                                top: screenHeight * 0.02,
                                child: ClipOval(
                                  child: Image.network(
                                    recipeDetails[index].plateImageUrl,
                                    width: screenWidth * 0.25,
                                    height: screenWidth * 0.25,
                                    fit: BoxFit.cover, // Ensures the image covers the circular area
                                  ),
                                ),
                              ),

                              Positioned(
                                top: screenHeight * 0.05,
                                right: screenWidth * 0.03,
                                child: Container(
                                  width: screenWidth * 0.12,
                                  height: screenHeight * 0.03,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 225, 179, 1),
                                    borderRadius: BorderRadius.circular(20),

                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Color.fromRGBO(255, 173, 48, 1),
                                        size: 18,
                                      ),
                                      Text(
                                        (recipeDetails[index].rating).toString(),
                                        style:  TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: screenWidth * 0.03,
                                          fontWeight: FontWeight.w400,
                                          color: const Color.fromRGBO(0, 0, 0, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                             Text(
                                              "Time",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: screenWidth * 0.03,
                                                  color: const Color.fromRGBO(18, 149, 117, 1)
                                              ),
                                            ),
                                            Text(
                                              '${recipeDetails[index].preparationTime.inMinutes.toString()} Mins',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                fontSize: screenWidth * 0.03,
                                                color: const Color.fromRGBO(50, 50, 50, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: screenWidth * 0.08,
                                          height: screenHeight * 0.04,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(40),
                                              color: const Color.fromRGBO(255, 255, 255, 1)
                                          ),
                                          child: GestureDetector(
                                            child:  Icon(
                                              isFavorite
                                                  ? Ionicons.bookmark
                                                  : Ionicons.bookmark_outline,
                                              color: isFavorite
                                                  ? const Color.fromRGBO(18, 149, 117, 1)
                                                  : const Color.fromRGBO(18, 149, 117, 1),
                                              size: screenWidth * 0.063,
                                            ),
                                            onTap: (){
                                              userProvider.addFavoriteRecipe(recipe.recipeId);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),
               SizedBox(height: screenHeight*0.05,),
              Container(
                padding: EdgeInsets.only(left: screenWidth * 0.08),
                child:  Text(
                  "New Recipes",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w900,
                    fontSize: screenWidth * 0.05,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
              ),
              ///////////////////////////////////////////////////////////
              SizedBox(
                height: screenHeight * 0.25,

                child: ListView.builder(
                    itemCount: recentRecipeDetails.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      bool isFirst = index == 0;
                      bool isLast = index == recentRecipeDetails.length - 1;
                      EdgeInsets itemMargin = EdgeInsets.only(
                          left: isFirst ? screenWidth * 0.08 : 10,
                          right: isLast ? screenWidth * 0.08 : 10);
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeInformation(recipe: recentRecipeDetails[index]),
                            ),
                          );
                        },
                        child: Container(
                          margin: itemMargin,
                          width: screenWidth * 0.6,
                          child: Stack(
                            children: [
                              Positioned(
                                top: screenHeight * 0.05,
                                child: Container(
                                  width: screenWidth * 0.6,
                                  height: screenHeight * 0.15,

                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.2),
                                          spreadRadius: 0,
                                          blurRadius: 20,
                                          offset: Offset(0,3),
                                        )
                                      ]
                                  ),
                                  child: Container(
                                    //margin: const EdgeInsets.only(left: 7, top: 10, right: 0),
                                    padding: EdgeInsets.only(
                                      left: screenWidth * 0.02,
                                      top: screenHeight * 0.01,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.4,
                                          child: Text(
                                            recentRecipeDetails[index].recipeName,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w900,
                                              fontSize: screenWidth * 0.035,
                                              color: const Color.fromRGBO(72, 72, 72, 1),
                                            ),
                                          ),
                                        ),

                                        Container(
                                          margin: EdgeInsets.only(top: screenHeight* 0.01),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              RatingStars(
                                                editable: false,
                                                rating: recentRecipeDetails[index].rating,
                                                color: Colors.amber,
                                                iconSize: screenWidth * 0.04,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.03),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "By Chef ${recentRecipeDetails[index].chef.firstName} ${recentRecipeDetails[index].chef.lastName}",
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.03,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(right: screenWidth*0.06),
                                              child: Row(
                                                children: [
                                                   Icon(
                                                    Icons.timer_outlined, color: const Color.fromRGBO(145, 145, 145, 1),
                                                    size: screenWidth * 0.045,

                                                  ),
                                                  SizedBox(width: screenWidth * 0.01),
                                                  Text(
                                                    "${(recentRecipeDetails[index].preparationTime.inMinutes.toString())} Mins",
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: screenWidth * 0.03,
                                                      color: const Color.fromRGBO(145, 145, 145, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),

                                        /*Transform.scale(
                                          alignment: Alignment.topLeft,
                                          scale: 0.45,
                                          child: RatingBar.builder(
                                            initialRating: newRecipes[index].rating,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemBuilder: (context, _) => const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ), onRatingUpdate: (double value) {  },
                                          ),
                                        )*/
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              /*Align(
                                heightFactor: 2,
                                alignment: Alignment.topRight,
                                child: ClipOval(

                                  child: Image.network(
                                      width: screenWidth * 0.17,
                                      height: screenWidth * 0.17,
                                    recipeDetails[index].plateImageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}