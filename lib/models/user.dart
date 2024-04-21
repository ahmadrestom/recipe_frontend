import 'package:recipe_app/models/recipe.dart';

import 'helpingModels/review.dart';

class User{

  final int id;
  final String name;
  final String email;
  final String password;
  final String? imageUrl;
  final List<Recipe>? favorites;
  final List<Review>? reviews;
  final List<String>? savedSearches;

  User({required this.id, required this.name, required this.email, required this.password, this.imageUrl,
      this.favorites, this.reviews, this.savedSearches});
}