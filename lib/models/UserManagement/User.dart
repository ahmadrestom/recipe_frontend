import '../Recipe.dart';
import '../Review.dart';

class User{
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final String? password;
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
    this.email,
    this.password,
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

class UserDTO{
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  final String role;

  UserDTO(
      {required this.userId,
       required this.firstName,
       required this.lastName,
       required this.email,
       required this.imageUrl,
       required this.role}
         );

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      userId: json['userId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      imageUrl: json['imageUrl'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'imageUrl': imageUrl,
      'role': role,
    };
  }


}