import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/models/user.dart';

import 'helpingModels/review.dart';

class Chef extends User{
  final String location;
  final String phoneNumber;
  final String bio;
  final List<String> specialities;
  final int yearsOfExperience;

  Chef({
    required int id,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String? imageUrl,
    required this.location,
    required this.phoneNumber,
    required this.bio,
    required this.specialities,
    required this.yearsOfExperience,
    List<Recipe>? favorites,
    List<Review>? reviews,
    List<String>? savedSearches,
    List<User>? followers,
    List<User>? followings,
  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    email: email,
    password: password,
    imageUrl: imageUrl,
    favorites: favorites,
    reviews: reviews,
    savedSearches: savedSearches,
    followers: followers ?? [],
    followings: followings ?? [],
  );

  factory Chef.fromJson(Map<String, dynamic> json) {
    return Chef(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      imageUrl: json['imageUrl'],
      location: json['location'],
      phoneNumber: json['phoneNumber'],
      bio: json['bio'],
      specialities: List<String>.from(json['specialities']),
      yearsOfExperience: json['yearsOfExperience'],
      favorites: _parseRecipes(json['favorites']),
      reviews: _parseReviews(json['reviews']),
      savedSearches: List<String>.from(json['savedSearches']),
      followers: _parseUsers(json['followers']),
      followings: _parseUsers(json['followings']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
      'location': location,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'specialities': specialities,
      'yearsOfExperience': yearsOfExperience,
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