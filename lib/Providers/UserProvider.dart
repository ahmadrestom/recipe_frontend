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
  List<dynamic>? _userFavorites;

  String? get token => _token;

  bool get isAuthenticated => _isAuthenticated;

  Map<String, dynamic>? get userDetails => _userDetails;

  List<dynamic>? get userFavorites => _userFavorites;

  UserProvider() {
    _loadToken();
  }

  Future<void> _loadToken() async {
    _token = await _secureStorage.read(key: 'authToken');
    if (_token != null && !_authService.isTokenExpired(_token!)) {
      _isAuthenticated = true;
      await _fetchUserDetails();
    } else {
      _token = null;
      _isAuthenticated = false;
    }
    notifyListeners();
  }

  Future<void> login(UserAuthentication userAuth) async {
    final response = await _authService.login(userAuth);
    if (response.statusCode == 200) {
      _token = await _secureStorage.read(key: 'authToken');
      print(_token);
      _isAuthenticated = true;
      await _fetchUserDetails();
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _token = null;
    _isAuthenticated = false;
    _userDetails = null;
    _userFavorites = null;
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

  Future<void> _fetchUserDetails() async {
    try {
      if (token != null) {
        final userInfo = await _authService.getUserInfo(_token!);
        _userDetails = userInfo;
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
}