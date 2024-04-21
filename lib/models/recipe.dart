import 'package:recipe_app/models/helpingModels/nutritional_information.dart';

import 'helpingModels/review.dart';

class Recipe {
  final int id;
  final String name;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final Duration preparationTime;
  final Duration cookingTime;
  final DifficultyLevel difficultyLevel;
  final Category category;
  final NutritionalInformation nutritionalInformation;
  final String imageUrl;
  List<Review> reviews;

  Recipe({
      required this.id,
      required this.name,
      required this.description,
      required this.ingredients,
      required this.instructions,
      required this.preparationTime,
      required this.cookingTime,
      required this.difficultyLevel,
      required this.category,
      required this.nutritionalInformation,
      required this.imageUrl,
      required this.reviews
      });
}

enum DifficultyLevel {
  easy,
  moderate,
  difficult,
}

enum Category{
  all,
  indian,
  asian,
  chinese,
  pizza,
  pasta,
  burgers,
  vegan,
  sandwiches,
  desserts,
  lebanese,
  seaFood,
  grilledDishes
}