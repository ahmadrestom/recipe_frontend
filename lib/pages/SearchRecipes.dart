import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/pages/recipeInformation.dart';

import '../models/Recipe.dart';

class SearchRecipes extends StatefulWidget {
  final List<Recipe> recipes; // List of Recipe objects
  const SearchRecipes({Key? key, required this.recipes}) : super(key: key);

  @override
  _SearchRecipesState createState() => _SearchRecipesState();
}

class _SearchRecipesState extends State<SearchRecipes> {
  final TextEditingController _searchController = TextEditingController();
  List<Recipe> _filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _filteredRecipes = widget.recipes; // Initialize with all recipes
  }

  void _filterRecipes(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredRecipes = widget.recipes;
      });
    } else {
      setState(() {
        _filteredRecipes = widget.recipes
            .where((recipe) =>
            recipe.recipeName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(screenWidth*0.05, screenHeight *0.03,screenWidth*0.05, screenHeight*0.001),
            child: Row(
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
                Text(
                    "Search for your recipe",
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth*0.05,
                    fontWeight: FontWeight.w600
                  ),

                ),
                Container(width: screenWidth*0.07,)
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.05,
                  child: CupertinoTextField(
                    controller: _searchController,
                    placeholder: "Search",
                    prefix: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      child: Image.asset('assets/icons/search.png'),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onChanged: _filterRecipes, // Update the filtered list
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight*0.02,),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = _filteredRecipes[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        recipe.recipeName,
                        style: GoogleFonts.aleo(
                          fontSize: screenWidth*0.05,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      subtitle: Text(
                          recipe.description,
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth*0.03,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(18, 149, 117, 1),
                        ),

                      ),
                      onTap: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context)
                        => RecipeInformation(recipe: recipe)));
                        print("Selected recipe: ${recipe.recipeName}");
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(recipe.plateImageUrl),
                        radius: screenWidth*0.05,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.01,),


                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
