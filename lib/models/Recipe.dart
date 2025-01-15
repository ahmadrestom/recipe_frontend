import 'NutritionalInformation.dart';
import 'Review.dart';
import 'category.dart';
import 'chef.dart';
import 'ingredients.dart';
import 'instruction.dart';

class RecipeBase{
  final String recipeId;
  final String recipeName;
  final String description;
  final DateTime timeUploaded;
  final Duration preparationTime;
  final Duration cookingTime;
  final DifficultyLevel difficultyLevel;
  double rating;
  final String imageUrl;

  RecipeBase({
  required this.recipeId,
  required this.recipeName,
  required this.description,
  required this.timeUploaded,
  required this.preparationTime,
  required this.cookingTime,
  required this.difficultyLevel,
  required this.rating,
  required this.imageUrl,
  });

}

class Recipe extends RecipeBase{
  final Set<Ingredients> ingredients;
  List<Instruction> instructions;
  final Category category;
  final ChefMinimal chef;
  final NutritionalInformation? nutritionalInformation;
  final String plateImageUrl;
  Set<Review>? reviews;

  Recipe({
    required String recipeId,
    required this.ingredients,
    required this.instructions,
    required this.category,
    required this.chef,
    this.nutritionalInformation,
    required this.plateImageUrl,
    required this.reviews,
    required double rating,
    required String recipeName,
    required String description,
    required DateTime timeUploaded,
    required Duration preparationTime,
    required Duration cookingTime,
    required DifficultyLevel difficultyLevel,
    required String imageUrl
  }):super(
    recipeId: recipeId,
    recipeName: recipeName,
    description: description,
    timeUploaded: timeUploaded,
    preparationTime: preparationTime,
    cookingTime: cookingTime,
    difficultyLevel: difficultyLevel,
    imageUrl: imageUrl,
    rating: rating,
  );

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      recipeId: json['recipeId'] as String,
      recipeName: json['recipeName'] as String,
      description: json['description'] as String,
      timeUploaded: DateTime.parse(json['timeUploaded'] as String),
      ingredients: Set<Ingredients>.from(
          (json['ingredients'] as List<dynamic>).map((x) => Ingredients.fromJson(x))
      ),
      instructions: (json['instructions'] as List<dynamic>)
          .map((instructionJson) => Instruction.fromJson(instructionJson))
          .toList(),
      preparationTime: Duration(minutes: json['preparationTime'] as int),
      cookingTime: Duration(minutes: json['cookingTime'] as int),
      difficultyLevel: DifficultyLevel.values
          .firstWhere((e) => e.toString().split('.').last == json['difficultyLevel'] as String),
      category: Category.fromJson(json['category']),
      nutritionalInformation:
      NutritionalInformation.fromJson(json['ni'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'],
      chef: ChefMinimal.fromJson(json['chef'] as Map<String, dynamic>),
      rating: (json['rating'] as num).toDouble(),
      plateImageUrl: json['plateImageUrl'] as String,
      reviews: json['reviews'] != null
          ? Set<Review>.from(json['reviews'].map((e) => Review.fromJson(e)))
          : <Review>{},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipeId': recipeId,
      'recipeName': recipeName,
      'description': description,
      'timeUploaded': timeUploaded.toIso8601String(),
      'ingredients': ingredients.map((ingredient) => ingredient.toJson()).toSet(),
      'instructions': instructions,
      'preparationTime': preparationTime.inMinutes,
      'cookingTime': cookingTime.inMinutes,
      'difficultyLevel': difficultyLevel.toString().split('.').last,
      'category': category.toJson(),
      'ni': nutritionalInformation?.toJson(),
      'imageUrl': imageUrl,
      'chef': chef.toJson(),
      'rating': rating,
      'plateImageUrl': plateImageUrl,
      'reviews': reviews?.map((e) => e.toJson()).toSet(),
    };
  }

  double getRating(){
    return rating;
  }

  void setRating(double value){
    rating = (value < 1) ? 1 : (value > 5) ? 5 : value.toDouble();
  }

  int getNumberOfReviews(){
    if (reviews == null || reviews!.isEmpty) {
      return 0;
    }
    return reviews!.length;
  }
}

enum DifficultyLevel {
  Easy, Medium, Hard
}

class RecipeFavorites extends RecipeBase{

  final String categoryName;
  final String chefName;
  final String? chefPictureUrl;

  RecipeFavorites({
  required this.categoryName,
  required this.chefName,
  required this.chefPictureUrl,
  required String recipeId,
  required String recipeName,
  required String description,
  required DateTime timeUploaded,
  required Duration preparationTime,
  required Duration cookingTime,
  required DifficultyLevel difficultyLevel,
  required double rating,
  required String imageUrl
  }):super(
      recipeId: recipeId,
      recipeName: recipeName,
      description: description,
      timeUploaded: timeUploaded,
      preparationTime: preparationTime,
      cookingTime: cookingTime,
      difficultyLevel: difficultyLevel,
      imageUrl: imageUrl,
      rating: rating,
  );

  factory RecipeFavorites.fromJson(Map<String, dynamic> json){
    return RecipeFavorites(
        recipeId: json['recipeId'] as String,
        recipeName: json['recipeName'] as String,
        description: json['description'] as String,
        timeUploaded: DateTime.parse(json['timeUploaded'] as String),
        preparationTime: Duration(minutes: json['preparationTime'] as int),
        cookingTime: Duration(minutes: json['cookingTime'] as int),
        difficultyLevel: DifficultyLevel.values
            .firstWhere((e) => e.toString().split('.').last == json['difficultyLevel'] as String),
        rating: (json['rating'] as num).toDouble(),
        imageUrl: json['imageUrl'],
        categoryName: json['categoryName'],
        chefName: json['chefName'],
        chefPictureUrl: json['chefPictureUrl']
    );
  }

  static RecipeFavorites convertFromRecipe(Recipe recipe) {
    return RecipeFavorites(
      recipeId: recipe.recipeId,
      recipeName: recipe.recipeName,
      description: recipe.description,
      timeUploaded: recipe.timeUploaded,
      preparationTime: recipe.preparationTime,
      cookingTime: recipe.cookingTime,
      difficultyLevel: recipe.difficultyLevel,
      rating: recipe.rating,
      imageUrl: recipe.imageUrl,
      categoryName: recipe.category.categoryName, // Get category name from recipe
      chefName: "${recipe.chef.firstName} ${recipe.chef.firstName}",
      chefPictureUrl: recipe.chef.imageUrl, // Optional chef picture
    );
  }
}

class RecipePost{
  final String recipeName;
  final String description;
  final int preparationTime;
  final int cookingTime;
  final String difficultyLevel;
  final double rating;
  final String imageUrl;
  final String plateUrl;
  final String categoryId;
  final String chefId;
  final NutritionalInformation ni;
  final Set<Ingredients> ingredients;
  List<Instruction> instructions;

  RecipePost.name(
      this.recipeName,
      this.description,
      this.preparationTime,
      this.cookingTime,
      this.difficultyLevel,
      this.rating,
      this.imageUrl,
      this.plateUrl,
      this.categoryId,
      this.chefId,
      this.ni,
      this.ingredients,
      this.instructions
      );

  Map<String, dynamic> toJson() {
    return {
      'recipeName': recipeName,
      'description': description,
      'preparationTime': preparationTime,
      'cookingTime': cookingTime,
      'difficultyLevel': difficultyLevel,
      'rating': rating,
      'imageUrl': imageUrl,
      'plateImageUrl': plateUrl,
      'categoryId': categoryId,
      'chefId': chefId,
      'ni': ni.toJson(), // Assuming NutritionalInformation has a toJson() method
      'ingredients': ingredients.map((e) => e.toJson()).toList(), // Assuming Ingredients has a toJson() method
      'instructions': instructions.map((e) => e.toJson()).toList(), // Assuming Instruction has a toJson() method
    };
  }

  // Convert JSON to RecipePost
  factory RecipePost.fromJson(Map<String, dynamic> json) {
    return RecipePost.name(
      json['recipeName'],
      json['description'],
      json['preparationTime'],
      json['cookingTime'],
      json['difficultyLevel'],
      json['rating'],
      json['imageUrl'],
      json['plateImageUrl'],
      json['categoryId'],
      json['chefId'],
      NutritionalInformation.fromJson(json['ni']), // Assuming NutritionalInformation has a fromJson() method
      Set<Ingredients>.from(json['ingredients'].map((x) => Ingredients.fromJson(x))), // Assuming Ingredients has a fromJson() method
      List<Instruction>.from(json['instructions'].map((x) => Instruction.fromJson(x))), // Assuming Instruction has a fromJson() method
    );
  }
}

class RecipeForProfile{

  final String recipeId;
  final String recipeName;
  final Duration preparationTime;
  final double rating;
  final String imageUrl;

  RecipeForProfile(this.recipeId, this.recipeName, this.preparationTime,
      this.rating, this.imageUrl);

  Map<String, dynamic> toJson() {
    return {
      'recipeId': recipeId,
      'recipeName': recipeName,
      'preparationTime': preparationTime.inMinutes,
      'rating': rating,
      'imageUrl': imageUrl,
    };
  }

  factory RecipeForProfile.fromJson(Map<String, dynamic> json) {
    return RecipeForProfile(
      json['recipeId'] as String,
      json['recipeName'] as String,
      Duration(minutes: json['preparationTime'] as int),
      (json['rating'] as num).toDouble(),
      json['imageUrl'] as String,
    );
  }
}