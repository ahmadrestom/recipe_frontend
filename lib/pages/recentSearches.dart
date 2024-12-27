import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/customerWidgets/RecipeCard.dart';
import 'package:recipe_app/pages/home.dart';
import 'package:recipe_app/pages/recipeInformation.dart';
//import '../pages/Data/recipes.dart';
import 'package:radio_grouped_buttons/radio_grouped_buttons.dart';
import '../models/Recipe.dart' as recipe;
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../models/Recipe.dart';

class RecentSearches extends StatefulWidget {
  const RecentSearches({super.key});

  @override
  State<RecentSearches> createState() => _RecentSearchesState();
}

class _RecentSearchesState extends State<RecentSearches> {

  final List<String> time = ["All", "New", "Old"];
  final List<String> rating = ["1","2","3","4","5"];

  /*final List<String> categories = recipe.Category.values
      .map((e) => e.toString().split('.').last)
      .map((category) => category.substring(0, 1).toUpperCase() + category.substring(1))
      .toList();*/

  final List<String> categories = [
    "all",
    "indian",
    "asian",
    "chinese",
    "pizza",
    "pasta",
    "burgers",
    "vegan",
    "sandwiches",
    "desserts",
    "lebanese",
    "seaFood",
    "grilledDishes"
  ];

  late List<Recipe> recipes;

  @override
  void initState(){
    super.initState();
    //recipes = getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [GestureType.onTap, GestureType.onPanUpdateAnyDirection],
      child: Scaffold(
        extendBody: true,
        body: Container(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 1),
          child: Column(
            children: [
              Row(
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
                  const Spacer(),
                  const Text(
                    "Search Recipes",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color.fromRGBO(24, 24, 24, 1),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 6,
                    child: SizedBox(
                      width: 255,
                      height: 40,
                      child: CupertinoTextField(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context)=>const HomePage()));
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
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      child: GestureDetector(
                        child: Image.asset(
                          'assets/icons/filter.png',
                          width: 45,
                          height: 45,
                        ),
                        onTap: (){
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => SingleChildScrollView(
                              child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Filter Search",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Color.fromRGBO(0, 0, 0, 1)
                                      ),
                                    ),
                                    const SizedBox(height: 25,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Time",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Color.fromRGBO(0, 0, 0, 1)

                                          ),
                                        ),
                                        const SizedBox(height: 10,),

                                        CustomRadioButton(
                                          buttonLables: time,
                                          buttonValues: time,
                                          radioButtonValue: (value,index){

                                          },
                                          horizontal: true,
                                          enableShape: false,
                                          buttonSpace: 5,
                                          elevation: 5,
                                          buttonColor: const Color.fromRGBO(255, 255, 255, 1),
                                          selectedColor: const Color.fromRGBO(18, 149, 117, 1),
                                          selectedTextColor: const Color.fromRGBO(255, 255, 255, 1),
                                          textColor: const Color.fromRGBO(113, 177, 161, 1),
                                        ),
                                        const SizedBox(height: 10,),
                                        const Text(
                                          "Rate",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Color.fromRGBO(0, 0, 0, 1)

                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        CustomRadioButton(
                                          initialSelection: 0,
                                          buttonLables: rating,
                                          buttonValues: rating,
                                          radioButtonValue: (value,index){

                                          },
                                          horizontal: true,
                                          buttonWidth: 40,
                                          enableShape: false,
                                          buttonSpace: 5,
                                          elevation: 5,
                                          buttonColor: const Color.fromRGBO(255, 255, 255, 1),
                                          selectedColor: const Color.fromRGBO(18, 149, 117, 1),
                                          selectedTextColor: const Color.fromRGBO(255, 255, 255, 1),
                                          textColor: const Color.fromRGBO(113, 177, 161, 1),
                                        ),
                                        const SizedBox(height: 10,),
                                        const Text(
                                          "Category",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Color.fromRGBO(0, 0, 0, 1)
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        CustomRadioButton(
                                          buttonLables: categories,
                                          buttonValues: categories,
                                          radioButtonValue: (value,index){

                                          },
                                          horizontal: true,
                                          enableShape: false,
                                          buttonSpace: 5,
                                          elevation: 5,
                                          buttonColor: const Color.fromRGBO(255, 255, 255, 1),
                                          selectedColor: const Color.fromRGBO(18, 149, 117, 1),
                                          selectedTextColor: const Color.fromRGBO(255, 255, 255, 1),
                                          textColor: const Color.fromRGBO(113, 177, 161, 1),
                                        ),
                                        const SizedBox(height: 18,),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(
                                              const Color.fromRGBO(18, 149, 117, 1),
                                            ),
                                          ),
                                          onPressed: (){

                                          },
                                          child: const Center(
                                            child: Text(
                                              "Filter",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                                color: Color.fromRGBO(255, 255, 255, 1),
                                              ),
                                            ),
                                          ),

                                        ),




                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ),
                  ),
                ],

              ),
              const SizedBox(height: 18.0,),
              const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Recent Searches',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: recipes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in the grid
                    crossAxisSpacing: 14.0, // Spacing between each column
                    mainAxisSpacing: 24.0, // Spacing between each row
                    childAspectRatio: 1, // Aspect ratio of each grid item
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeInformation(recipe: recipes[index]),
                            ),
                          );
                        },
                      child: RecipeCard(recipe: recipes[index]));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
