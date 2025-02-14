import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipe_app/models/UserManagement/userAuthentication.dart';
import 'package:recipe_app/services/Recipe%20Service.dart';
import '../models/Recipe.dart';
import '../models/UserManagement/userRegistration.dart';
import '../services/UserServices/AuthService.dart';
import '../services/UserServices/Registration.dart';

class UserProvider extends ChangeNotifier {

  final AuthService _authService = AuthService();
  final RegistrationService _registrationService = RegistrationService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final RecipeService _recipeService = RecipeService();

  String? _token;
  bool _isAuthenticated = false;
  Map<String, dynamic>? _userDetails;
  Map<String, dynamic>? _chefDetails;
  List<dynamic>? _userFavorites;
  String? _userId;
  String? _imageUrl;

  String? get token => _token;

  bool get isAuthenticated => _isAuthenticated;

  Map<String, dynamic>? get userDetails => _userDetails;

  Map<String, dynamic>? get chefDetails => _chefDetails;

  List<dynamic>? get userFavorites => _userFavorites;

  String? get userId => _userId;

  String? get imageUrl => _imageUrl;

  UserProvider(){
    _loadToken();
  }

  void updateProfileImage(String? newUrl) {
    _imageUrl = newUrl;
    notifyListeners();
  }

  Future<void> _loadToken() async {
    _token = await _secureStorage.read(key: 'authToken');
    if (_token != null && !_authService.isTokenExpired(_token!)){
      _isAuthenticated = true;
      await fetchUserDetails();
    } else {
      _token = null;
      _isAuthenticated = false;
    }
    notifyListeners();
  }

  Future<bool> login(UserAuthentication userAuth) async {
    final response = await _authService.login(userAuth);
    if (response) {
      _token = await _secureStorage.read(key: 'authToken');
      _isAuthenticated = true;
      await fetchUserDetails();
      _userId = _userDetails?['id'];
      notifyListeners();
      return true; // Success
    } else {
      return false; // Invalid credentials
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _token = null;
    _isAuthenticated = false;
    _userDetails = null;
    _userFavorites = null;
    _secureStorage.delete(key: 'authToken');
    _userId = null;
    notifyListeners();
  }

  Future<bool> signUp(UserRegistration userRegistration,
      BuildContext context) async {
    try {
      final response = await _registrationService.register(
          userRegistration.firstName,
          userRegistration.lastName,
          userRegistration.email,
          userRegistration.password
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print("Registered successfully");
        return true;
      } else if (response.statusCode == 409) {
        _isAuthenticated = false;
        print('Email already exists');
        return false;
      } else {
        _isAuthenticated = false;
        return false;
      }
    } catch (e) {
      _isAuthenticated = false;
      print("Error during sign up : $e");
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateImage(String userId, String? url) async{
    final res = await _authService.updateImage(userId, url);
    chefDetails?['image_url'] = url;
    notifyListeners();
  }

  Future<void> deleteImage(String userId)async{
    final res = await _authService.deleteImage(userId);
    chefDetails?['image_url'] = null;
    notifyListeners();
  }

  Future<String?> uploadImage(File imageFile, String bucketName, String path) async{
    final url = await _authService.uploadImage(imageFile, bucketName, path);
    return url;
  }

  Future<void> fetchUserDetails() async {
    try {
      _imageUrl = null;
      if (token != null) {
        final userInfo = await _authService.getUserInfo(_token!);
        _userDetails = userInfo;
        _imageUrl = _userDetails?['image_url'];
        print("User details fetched: $_userDetails");
      }
    } catch (e) {
      print("Error fetching user details: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchFavoriteRecipes() async {
    try {
      if (token != null) {
        final userFavs = await _authService.fetchUserFavorites(_token!);
        _userFavorites = userFavs;
        print(userFavs);
        print("User's favorties fetched successfully");
        notifyListeners();
      }
    } catch (e) {
      print("Can't fetch favorites");
    }
  }

    Future<void> addFavoriteRecipe(String recipeId) async {
      try {
        if (token != null) {
          _userFavorites ??= []; //initialize if null
          final Recipe recipe = await _recipeService.fetchRecipeById(recipeId);
          final RecipeFavorites fav = RecipeFavorites.convertFromRecipe(recipe);
          bool isFavorite = _userFavorites?.any((fav) =>
          fav.recipeId == recipeId) ?? false;

          if (isFavorite) {
            final bool removed = await _authService.removeRecipeFromFavorites(
                recipeId, _token!);
            if (removed) {
              _userFavorites?.removeWhere((fav) => fav.recipeId == recipeId);
              print("Recipe removed from favorites");
            } else {
              print("Failed to remove recipe from favorites");
            }
          }
          else {
            final bool added = await _authService.addRecipeToFavorites(
                recipeId, _token!);
            if (added) {
              final recipe = await _recipeService.fetchRecipeById(recipeId);
              _userFavorites?.add(fav);
              print("Recipe added to favorites");
            } else {
              print("Failed to add recipe to favorites");
            }
          }
        }else{
          throw Exception("Token not found");
        }
      } catch (e) {
        print("ERROR adding favorites");
        throw Exception("Error adding favs: $e");
      } finally {
        notifyListeners();
      }
    }

    Future<void> removeFromFavorites(RecipeFavorites recipe) async{
      try{
        if(token!=null) {
          final bool removed = await _authService.removeRecipeFromFavorites(
              recipe.recipeId, _token!);
          _userFavorites?.remove(recipe);
          if(removed) {
            print("Removed from favorites successfully");
            notifyListeners();
          } else {
            print("Not removed from favorites");
          }
        }else{
          print("Token is null");
          throw Exception("Token is null");
        }
      }catch(e){
        print("Error removing favorite recipe: $e");
        throw Exception("Exception: $e");
      }
    }

  Future<void> getChefInfo(String chefId) async{
    try{
      _chefDetails = {};
      if(token!=null){
        final data = await _authService.getChefInfo(chefId, _token!);
        _chefDetails = data;
        _imageUrl = _chefDetails?['image_url']??"";
        notifyListeners();
      }
    }catch(e){
      print("Error: level provider, $e");
      throw Exception("Error getting chef info");
    }
  }

  Future<bool> upGradeToChef(String location, String phone, int ye, String bio) async{
    try{
      if(token!=null){
        final success = await _authService.upgradeToChef(_token!,location,phone,ye,bio);
        if(success){
          print("success");
          return true;
        }else{
          print("failure");
          return false;
        }
      }else{
        return false;
      }
    }catch(e){
      print("Error in provider: $e");
      return false;
    }finally{
      notifyListeners();
    }
  }
}