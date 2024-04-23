import 'package:recipe_app/models/helpingModels/nutritional_information.dart';
import 'helpingModels/review.dart';

class Recipe {
  final int id;
  final String name;
  final String description;
  final DateTime timeUploaded;
  final List<String> ingredients;
  final List<String> instructions;
  final Duration preparationTime;
  final Duration cookingTime;
  final DifficultyLevel difficultyLevel;
  final Category category;
  final NutritionalInformation? nutritionalInformation;
  final String imageUrl;
  List<Review>? reviews;

  Recipe({
      required this.id,
      required this.name,
      required this.description,
      required this.timeUploaded,
      required this.ingredients,
      required this.instructions,
      required this.preparationTime,
      required this.cookingTime,
      required this.difficultyLevel,
      required this.category,
      this.nutritionalInformation,
      required this.imageUrl,
      this.reviews
      });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      timeUploaded: DateTime.parse(json['timeUploaded'] as String),
      ingredients: (json['ingredients'] as List<dynamic>).cast<String>(),
      instructions: (json['instructions'] as List<dynamic>).cast<String>(),
      preparationTime: Duration(minutes: json['preparationTime'] as int),
      cookingTime: Duration(minutes: json['cookingTime'] as int),
      difficultyLevel: DifficultyLevel.values
          .firstWhere((e) => e.toString().split('.').last == json['difficultyLevel'] as String),
      category: Category.values
          .firstWhere((e) => e.toString().split('.').last == json['category'] as String),
      nutritionalInformation:
      NutritionalInformation.fromJson(json['nutritionalInformation'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String,
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'timeUploaded': timeUploaded.toIso8601String(),
      'ingredients': ingredients,
      'instructions': instructions,
      'preparationTime': preparationTime.inMinutes,
      'cookingTime': cookingTime.inMinutes,
      'difficultyLevel': difficultyLevel.toString().split('.').last,
      'category': category.toString().split('.').last,
      'nutritionalInformation': nutritionalInformation?.toJson(),
      'imageUrl': imageUrl,
      'reviews': reviews?.map((e) => e.toJson()).toList(),
    };
  }


}

enum DifficultyLevel {
  easy,
  moderate,
  difficult, medium,
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