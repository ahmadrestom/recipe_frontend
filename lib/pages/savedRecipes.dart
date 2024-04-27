import 'package:flutter/material.dart';

import '../customerWidgets/savedRecipesCard.dart';
import '../models/recipe.dart';
import 'Data/savedRecipes.dart';

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
    savedRecipes = getSavedRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red)
        ),
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(
          children: [
            const Center(
              child: Text(
                "Saved Recipes",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Color.fromRGBO(18, 18, 18, 1),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: savedRecipes.length,
                itemBuilder: (context, index){
                  return Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SavedRecipe(
                      recipe: savedRecipes[index],
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
