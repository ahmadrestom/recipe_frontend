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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      imageUrl: json['imageUrl'] as String?,
      favorites: (json['favorites'] as List<dynamic>?)
          ?.map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      savedSearches:
      (json['savedSearches'] as List<dynamic>?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
      'favorites': favorites?.map((e) => e.toJson()).toList(),
      'reviews': reviews?.map((e) => e.toJson()).toList(),
      'savedSearches': savedSearches,
    };
  }
}