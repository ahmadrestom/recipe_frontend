import 'package:flutter/cupertino.dart';
import 'package:recipe_app/services/Recipe%20Service.dart';

import '../models/Review.dart';

class ReviewProvider extends ChangeNotifier {
  final RecipeService _recipeService = RecipeService();

  Set<Review>? _reviews;


  Set<Review>? get reviews => _reviews;

  Future<void> fetchRecipeReviews(String recipeId) async{
    try{
      _reviews = null;
      final fetchedReviews = await _recipeService.getRecipeReviews(recipeId);
      _reviews = fetchedReviews;
      _reviews?.forEach((e){print("XX $e");});
      notifyListeners();
    }catch(e){
      print("Error in provider: $e");
    }
  }

  int? getNbOfReviews(String recipeId){
    return _reviews?.length;
  }

  Future<bool> addReview(String text, String recipeId) async{
    try{
      bool success = await _recipeService.addReview(text, recipeId);
      if(success){
        notifyListeners();
        fetchRecipeReviews(recipeId);
      }
      return success;
    }catch(e){
      print("Error adding review: $e");
      return false;
    }
  }










}