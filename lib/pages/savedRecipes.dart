/*import 'package:flutter/material.dart';
import 'package:recipe_app/pages/recipeInformation.dart';

import '../customerWidgets/savedRecipesCard.dart';
import '../models/recipe.dart';
//import 'Data/savedRecipes.dart';

class SavedRecipes extends StatefulWidget {
  const SavedRecipes({super.key});

  @override
  State<SavedRecipes> createState() => _SavedRecipesState();
}

class _SavedRecipesState extends State<SavedRecipes> {

  late List<Recipe> savedRecipes;

  @override
  void initState(){
    super.initState();
    //savedRecipes = getSavedRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(
          children: [
            const Center(
              child: Text(
                "Saved Recipes",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: Color.fromRGBO(18, 18, 18, 1),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: savedRecipes.length,
                itemBuilder: (context, index){
                  bool isFirst = index == 0;
                  bool isLast = index == savedRecipes.length - 1;
                  EdgeInsets itemMargin = EdgeInsets.only(
                      top: isFirst ? 18 : 10, bottom: isLast ? 18 : 10);
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeInformation(recipe: savedRecipes[index]),
                        ),
                      );
                    },
                    child: Container(
                      margin: itemMargin,
                      child: SavedRecipe(
                        recipe: savedRecipes[index],
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
*/