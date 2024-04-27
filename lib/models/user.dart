import 'package:recipe_app/models/recipe.dart';

import 'helpingModels/review.dart';

class User{

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? imageUrl;
  final List<Recipe>? favorites;
  final List<Review>? reviews;
  final List<String>? savedSearches;
  final List<User>? followers;
  final List<User>? followings;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.imageUrl,
    this.favorites,
    this.reviews,
    this.savedSearches,
    this.followers = const [],
    this.followings = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      imageUrl: json['imageUrl'],
      favorites: _parseRecipes(json['favorites']),
      reviews: _parseReviews(json['reviews']),
      savedSearches: _parseSavedSearches(json['savedSearches']),
      followers: _parseUsers(json['followers']),
      followings: _parseUsers(json['followings']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
      'favorites': _toJsonList(favorites),
      'reviews': _toJsonList(reviews),
      'savedSearches': savedSearches,
      'followers': _toJsonUsersList(followers),
      'followings': _toJsonUsersList(followings),
    };
  }

  static List<Recipe>? _parseRecipes(List<dynamic>? json) {
    if (json == null) return null;
    return json.map((item) => Recipe.fromJson(item)).toList();
  }

  static List<Review>? _parseReviews(List<dynamic>? json) {
    if (json == null) return null;
    return json.map((item) => Review.fromJson(item)).toList();
  }

  static List<String>? _parseSavedSearches(List<dynamic>? json) {
    if (json == null) return null;
    return List<String>.from(json);
  }

  static List<User>? _parseUsers(List<dynamic>? json) {
    if (json == null) return null;
    return json.map((item) => User.fromJson(item)).toList();
  }

  static List _toJsonList(List<dynamic>? items) {
    if (items == null) return [];
    return items.map((item) => item.toJson()).toList();
  }

  static List<Map<String, dynamic>> _toJsonUsersList(List<User>? users) {
    if (users == null) return [];
    return users.map((user) => user.toJson()).toList();
  }
}