import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/RecipeProvider.dart';
import 'package:recipe_app/Providers/UserProvider.dart';
import 'package:recipe_app/pages/recipeInformation.dart';
import '../customerWidgets/savedRecipesCard.dart';
import '../models/Recipe.dart';

class SavedRecipes extends StatefulWidget {
  const SavedRecipes({super.key});

  @override
  State<SavedRecipes> createState() => _SavedRecipesState();
}

class _SavedRecipesState extends State<SavedRecipes> {

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.isAuthenticated) {
      userProvider.fetchFavoriteRecipes();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userFavs = userProvider.userFavorites;

    final recipeProvider = Provider.of<RecipeProvider>(context);

    if(userFavs == null || userFavs.isEmpty){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
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
                itemCount: userFavs.length,
                itemBuilder: (context, index){
                  bool isFirst = index == 0;
                  bool isLast = index == userFavs.length - 1;
                  EdgeInsets itemMargin = EdgeInsets.only(
                      top: isFirst ? 18 : 10, bottom: isLast ? 18 : 10);
                  return GestureDetector(
                    onTap: (){
                      final id = userFavs[index].recipeId;
                      print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX $id");
                      final Recipe r = recipeProvider.fetchRecipeById(id) as Recipe;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeInformation(recipe: r),
                        ),
                      );
                    },
                    child: Container(
                      margin: itemMargin,
                      child: SavedRecipe(
                        recipe: userFavs[index],
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
