import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/customerWidgets/RecipeCard.dart';
import 'package:recipe_app/pages/home.dart';
import '../models/recipe.dart';
import '../pages/Data/recipes.dart';

class RecentSearches extends StatefulWidget {
  const RecentSearches({super.key});

  @override
  State<RecentSearches> createState() => _RecentSearchesState();
}

class _RecentSearchesState extends State<RecentSearches> {

  late List<Recipe> recipes;

  @override
  void initState(){
    super.initState();
    recipes = getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        //////////////////////////////
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
                  return RecipeCard(recipe: recipes[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
