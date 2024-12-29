import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:recipe_app/services/BaseAPI.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/Recipe.dart';

class RecipeService extends BaseAPI{
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<List<Recipe>> fetchRecipes() async{

    try {
      final token = await secureStorage.read(key: 'authToken');
      if (token == null) {
        throw Exception('No token found');
      }
      //print("XXXXXXXXXXXTHE TOKEN IS READDDDDDDDDDDDDXXXXXXXXXXXXXXX $token");
      final headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
    };
      final response = await http.get(
        Uri.parse(super.recipeAPI),
        headers: headers
      );
      print(response.body);
      if (response.statusCode == 200) {
        print("Recipes are loaded successfully");
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Recipe.fromJson(json)).toList();
      } else {
        print("XXX RECIPES NOT FOUND XXX");
        throw Exception('Failed to load recipes');
      }
    }catch(error){
      print("Error fetching recipes: $error");
      rethrow;
    }
    }

  Future<List<Recipe>> fetchRecentRecipes() async {
    try {
      final token = await secureStorage.read(key: 'authToken');
      if (token == null) {
        throw Exception('No token found');
      }
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(
          Uri.parse(super.newRecipesAPI),
          headers: headers
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Recipe.fromJson(json)).toList();
      } else {
        print("TTT ${response.statusCode}");
        print("XXX RECIPES NOT FOUND XXX");
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      throw Exception('Error loading recent recipes');
    }
    }
    Future<Recipe> fetchRecipeById(String id) async{
      try {
        final token = await secureStorage.read(key: 'authToken');
        if (token == null) {
          throw Exception('No token found');
        }
        final headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        };
        final response = await http.get(
            Uri.parse("${super.recipeByIdAPI}/$id"),
            headers: headers
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return Recipe.fromJson(data);
        } else {
          print("TTT ${response.statusCode}");
          print("XXX RECIPES NOT FOUND XXX");
          throw Exception('Failed to load recipes');
        }
      }catch(e){
        print("Error fetching recipe by ID: $e");
        throw Exception("Error cannot fetch recipe by id: $e");
      }

    }
}

  