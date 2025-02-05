import 'package:flutter/foundation.dart';
import 'package:recipe_app/models/Recipe.dart';
import 'package:recipe_app/services/Recipe%20Service.dart';
import '../models/category.dart' as model_category;

class RecipeProvider extends ChangeNotifier {
  final RecipeService _recipeService = RecipeService();

  model_category.Category selectedCategory = model_category.Category(categoryId: "RandomID", categoryName: "All");
  List<Recipe>? _recipeDetails;
  List<Recipe>? _filterRecipes;
  List<Recipe>? _newRecipeDetails;
  List<model_category.Category>? _categoryList;
  List<RecipeForProfile>? _recipesForProfile;

  Recipe? _recipeByID;
  final List<String> time = ["All", "New", "Old"];
  final List<String> rating = ["1", "2", "3", "4", "5"];

  List<Recipe>? get recipeDetails => _recipeDetails;
  List<Recipe>? get recentRecipeDetails => _newRecipeDetails;
  Recipe? get recipeByID => _recipeByID;
  List<model_category.Category>? get categoryList => _categoryList;
  List<Recipe>? get filteredRecipes => _filterRecipes;
  List<RecipeForProfile>? get recipesForProfile => _recipesForProfile;

  RecipeProvider() {
    _fetchRecipeDetails();
    _fetchRecentRecipesDetails();
    _getCategories();
  }

  Future<void> _fetchRecipeDetails() async {
    try {
      final fetchedRecipes = await RecipeService().fetchRecipes();
      //remove delay
      await Future.delayed(const Duration(seconds: 2));
      //remove delay
      _recipeDetails = fetchedRecipes;
      _recipeDetails?.forEach((element) {print("RecipeCategoryName: ${element.category.categoryName}");});
    } catch (e) {
      print("Error fetching recipes to home: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> _fetchRecentRecipesDetails()async{
    try {
      _newRecipeDetails = [];
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

  Future<void> _getCategories() async{
    try{
      final categories = await _recipeService.getAllCategories();
      _categoryList = categories;
      _categoryList?.sort((a, b) => a.categoryName.compareTo(b.categoryName));
      _categoryList?.insert(0, model_category.Category(categoryId: "RandomID", categoryName: 'All'));
    }catch(e){
      print("Error in recipe provider: can't fetch categories: $e");
    }finally{
      notifyListeners();
    }
  }

  void updateCategory(model_category.Category category){
    print("Updating category to: ${category.categoryName}");
    selectedCategory = category;
    if(category.categoryName=="All"){
      _filterRecipes=_recipeDetails;
    }else{
      _filterRecipes=_recipeDetails
          ?.where((recipe){
        print("Comparing ${recipe.category.categoryName.trim().toLowerCase()} with ${category.categoryName.trim().toLowerCase()}");
      return recipe.category.categoryName.toLowerCase()==
          category.categoryName.toLowerCase();})
          .toList();
    }
    //print("Recipes: ${_filterRecipes?.length ?? 0}");
    _filterRecipes?.forEach((element) {print("Filtered: ${element.category.categoryName}");});
    notifyListeners();
  }

  Future<void> fetchRecipesForProfile(String chefId) async{
    try{
      _recipesForProfile = [];
      final List<RecipeForProfile> recipes = await _recipeService.getRecipesForProfile(chefId);
      _recipesForProfile = recipes;
    }catch(e){
      print("Error: $e");
      throw Exception("Error fetching recipes for profile: $e");
    }finally{
      notifyListeners();
    }
  }


}