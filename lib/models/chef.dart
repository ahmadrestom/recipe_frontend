import 'Recipe.dart';
import 'Review.dart';
import 'UserManagement/User.dart';

class Chef extends User{
  final String location;
  final String phoneNumber;
  final String bio;
  final List<String> specialities;
  final int yearsOfExperience;

  Chef({
    required String id,
    required String firstName,
    required String lastName,
    required String? email,
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
    password: password.isNotEmpty? password: '',
    imageUrl: imageUrl,
    favorites: favorites?? [],
    reviews: reviews?? [],
    savedSearches: savedSearches??[],
    followers: followers ?? [],
    followings: followings ?? [],
  );

  factory Chef.fromJson(Map<String, dynamic> json) {
    return Chef(
      id: json['chefId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      imageUrl: json['image_url'],
      location: json['location'],
      phoneNumber: json['phone_number'],
      yearsOfExperience: json['years_experience'],
      bio: json['bio'],
      specialities: List<String>.from(json['specialities']),
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
      'image_url': imageUrl,
      'location': location,
      'phone_number': phoneNumber,
      'bio': bio,
      'specialities': specialities,
      'years_experience': yearsOfExperience,
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

class ChefMinimal {
  final String chefId;
  final String firstName;
  final String lastName;
  final String? imageUrl;
  final String location;
  final String phoneNumber;
  final String bio;
  final int yearsExperience;

  ChefMinimal({
    required this.chefId,
    required this.firstName,
    required this.lastName,
    this.imageUrl,
    required this.location,
    required this.phoneNumber,
    required this.bio,
    required this.yearsExperience,
  });

  // Factory constructor to parse JSON
  factory ChefMinimal.fromJson(Map<String, dynamic> json) {
    return ChefMinimal(
      chefId: json['chefId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      imageUrl: json.containsKey('image_url') ? json['image_url'] as String? : null,
      location: json['location'] as String,
      phoneNumber: json['phone_number'] as String,
      bio: json['bio'] as String,
      yearsExperience: json['years_experience'] as int,
    );
  }

  // Convert the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'chefId': chefId,
      'firstName': firstName,
      'lastName': lastName,
      'image_url': imageUrl,
      'location': location,
      'phone_number': phoneNumber,
      'bio': bio,
      'years_experience': yearsExperience,
    };
  }
}

class UpgradeChef{
  final String location;
  final String phoneNumber;
  final int ye;
  final String bio;

  UpgradeChef(
      {required this.location,
        required this.phoneNumber,
        required this.ye,
        required this.bio}
      );

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'phone_number': phoneNumber,
      'years_experience': ye,
      'bio': bio,
    };
  }
}