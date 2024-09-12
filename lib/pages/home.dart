/*
import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:recipe_app/customerWidgets/CategoryItem.dart';
import 'package:flutter/material.dart';
//import 'package:recipe_app/pages/Data/newRecipes.dart';
import 'package:recipe_app/pages/recentSearches.dart';
import 'package:recipe_app/pages/recipeInformation.dart';
import '../models/recipe.dart' as recipe;
import '../models/recipe.dart';
//import '../pages/Data/recipes.dart';
import 'package:rate_in_stars/rate_in_stars.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  int? currentSelection = 0;

  late List<Recipe> recipes;
  late List<Recipe> newRecipes;
  final List<String> time = ["All", "New", "Old"];
  final List<String> rating = ["1","2","3","4","5"];

  String selectedCategory = '';

  final List<String> categories = recipe.Category.values
      .map((e) => e.toString().split('.').last)
      .map((category) => category.substring(0, 1).toUpperCase() + category.substring(1))
      .toList();

  @override
  void initState(){
    super.initState();
    //recipes = getRecipes();
    //newRecipes = getNewRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello Ahmad',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        SizedBox(height: 6,),
                        Text(
                          'What are you cooking today?',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Color.fromRGBO(169, 169, 169, 1),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.amber
                      ),
                      child: Image.asset('assets/images/avatar.png'),
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
                      width: 255,
                      height: 40,
                      child: CupertinoTextField(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context)=>const RecentSearches()));
                        },
                        placeholder: "Search",
                        readOnly: true,
                        prefix: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/icons/search.png'),

                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)
                        ),

                      ),
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'assets/icons/filter.png',
                        width: 45,
                        height: 45,
                      ),
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context)=>const RecentSearches()));
                      },
                    )
                  ],
                ),
              ),

              const SizedBox(height: 25,),

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                            bool isFirst = index == 0;
                            bool isLast = index == recipes.length - 1;
                            EdgeInsets itemMargin = EdgeInsets.only(
                                left: isFirst ? 30 : 3, right: isLast ? 30 : 3);
                            return Container(
                              margin: itemMargin,
                              child: CategoryItem(
                                categoryName: categories[index],
                                selectedCategory: selectedCategory,
                                onCategorySelected: (category){
                                  setState(() {
                                    selectedCategory = category;
                                  });
                                },
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                ],

              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                height: 231,
                child: ListView.builder(
                    itemCount: recipes.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      bool isFirst = index == 0;
                      bool isLast = index == recipes.length - 1;
                      EdgeInsets itemMargin = EdgeInsets.only(
                          left: isFirst ? 30 : 10, right: isLast ? 30 : 10);
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeInformation(recipe: recipes[index]),
                            ),
                          );
                        },
                        child: Container(
                          margin: itemMargin,
                          width: 150,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 50,
                                child: Container(
                                  width: 150,
                                  height: 176,
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
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        recipes[index].name,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(48, 48, 48, 1)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Image.asset(
                                'assets/images/ClassicGreekSalad.png',
                              ),
                              Positioned(
                                top: 27,
                                right: 10,
                                child: Container(
                                  width: 48,
                                  height: 23,
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
                                        (recipes[index].rating).toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(0, 0, 0, 1),
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
                                            const Text(
                                              "Time",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 11,
                                                  color: Color.fromRGBO(18, 149, 117, 1)
                                              ),
                                            ),
                                            Text(
                                              '${recipes[index].preparationTime.inMinutes.toString()} Mins',
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11,
                                                color: Color.fromRGBO(50, 50, 50, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(40),
                                            color: const Color.fromRGBO(255, 255, 255, 1)
                                          ),
                                          child: GestureDetector(
                                            child: const Icon(
                                              Ionicons.bookmark_outline,
                                                color: Color.fromRGBO(18, 149, 117, 1),
                                              size: 26,
                                            ),
                                            onTap: (){
                                              ////////////////////////////////////
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
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.only(left: 30),
                child: const Text(
                  "New Recipes",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w900,
                    fontSize: 19,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
              ),
              ///////////////////////////////////////////////////////////
              SizedBox(
                height: 150,
                child: ListView.builder(
                    itemCount: newRecipes.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      bool isFirst = index == 0;
                      bool isLast = index == newRecipes.length - 1;
                      EdgeInsets itemMargin = EdgeInsets.only(
                          left: isFirst ? 30 : 10, right: isLast ? 30 : 10);
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeInformation(recipe: newRecipes[index]),
                            ),
                          );
                        },
                        child: Container(
                          margin: itemMargin,
                          width: 251,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 40,
                                child: Container(
                                  width: 251,
                                  height: 100,
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
                                    margin: const EdgeInsets.only(left: 10, top: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 125,
                                          child: Text(
                                            newRecipes[index].name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w900,
                                              fontSize: 13,
                                              color: Color.fromRGBO(72, 72, 72, 1),
                                            ),
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            RatingStars(
                                              editable: false,
                                              rating: newRecipes[index].rating,
                                              color: Colors.amber,
                                              iconSize: 16,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "By Chef ${newRecipes[index].chef.firstName} ${newRecipes[index].chef.lastName}",
                                              style: const TextStyle(

                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(right: 15),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.timer_outlined, color: Color.fromRGBO(145, 145, 145, 1),
                                                    size: 19,
                                                  ),
                                                  const SizedBox(width: 6,),
                                                  Text(
                                                    "${(newRecipes[index].preparationTime.inMinutes.toString())} Mins",
                                                    style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Color.fromRGBO(145, 145, 145, 1),
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
                              Align(
                                alignment: Alignment.topRight,
                                child: SizedBox(
                                  width: 130,
                                  height: 130,
                                  child: Image.asset(
                                    'assets/images/CrunchyNutColeslaw.png',

                                  ),
                                ),
                              ),
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
}*/