import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/UserProvider.dart';
import 'package:recipe_app/models/Recipe.dart';
import 'package:recipe_app/services/Recipe%20Service.dart';

class RecipeProvider extends ChangeNotifier {
  final RecipeService _recipeService = RecipeService();
  List<Recipe>? _recipeDetails;
  List<Recipe>? _newRecipeDetails;

  Recipe? _recipeByID;
  final List<String> time = ["All", "New", "Old"];
  final List<String> rating = ["1", "2", "3", "4", "5"];

  List<Recipe>? get recipeDetails => _recipeDetails;

  List<Recipe>? get recentRecipeDetails => _newRecipeDetails;

  Recipe? get recipeByID => _recipeByID;

  RecipeProvider() {
    _fetchRecipeDetails();
    _fetchRecentRecipesDetails();
  }

  Future<void> _fetchRecipeDetails() async {
    try {
      final fetchedRecipes = await RecipeService().fetchRecipes();
      _recipeDetails = fetchedRecipes;
    } catch (e) {
      print("Error fetching recipes to home: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> _fetchRecentRecipesDetails() async {
    try {
      final fetchedRecipes = await RecipeService().fetchRecentRecipes();
      _newRecipeDetails = fetchedRecipes;
    } catch (e) {
      print("Error fetching recent recipes to home: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchRecipeById(String id) async {
    try {
      final fetchRecipe = await _recipeService.fetchRecipeById(id);
      _recipeByID = fetchRecipe;
    } catch (e) {
      print("Error fetching recipe by ID: $e");
    } finally {
      notifyListeners();
    }
  }
}