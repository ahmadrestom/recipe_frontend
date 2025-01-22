import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/Review.dart';
import 'package:recipe_app/services/BaseAPI.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/Recipe.dart';
import '../models/category.dart' as category;

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

    Future<List<category.Category>?> getAllCategories() async{
      try{
        final token = await secureStorage.read(key: 'authToken');
        if (token == null) {
          throw Exception('No token found');
        }
        final response = await http.get(
          Uri.parse(super.getCategoriesAPI),
          headers: BaseAPI().headers
        );
        print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ${response.body}");
        if(response.statusCode==200){
          final List<dynamic> data = jsonDecode(response.body);
          return data.map((json) => category.Category.fromJson(json)).toList();
        }else{
          print("Error: No categories where fetched: StatusCode: ${response.statusCode}");
          throw Exception("No categories");
        }
      }catch(e){
        print("Error fetching categories");
        throw Exception("Error: $e");
      }
    }

    Future<String?> uploadImage(File imageFile, String bucketName, String path) async {
    final supabase = Supabase.instance.client;
    try {
      print("Starting upload for $path");

      // Perform the upload
      final response = await supabase.storage.from(bucketName).upload(path, imageFile);
      print("Upload Response: $response");

      // Check if the response indicates an error (Supabase might throw exceptions on failure)
      if (response.isEmpty) {
        throw Exception("Upload failed: Empty response");
      }

      // If no error, get the public URL
      final publicUrl = supabase.storage.from(bucketName).getPublicUrl(path);
      print("Public URL: $publicUrl");

      return publicUrl;
    } catch (e) {
      print("Error uploading image: $e");
      throw Exception("Error uploading image: $e");
    }
  }

    Future<bool> uploadRecipe(RecipePost recipe) async{
      try{
        final token = await secureStorage.read(key: 'authToken');
        if(token == null){
          throw Exception('No token found');
        }
        final response = await http.post(
          Uri.parse(super.addRecipeAPI),
          headers : {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        },
          body: jsonEncode(recipe.toJson()),
        );
        if(response.statusCode==200 || response.statusCode==201){
          print("Recipe uploaded successfully");
          return true;
        }else{
          print("Failed to upload recipe: ${response.statusCode}");
          print("Response body: ${response.body}");
          print("Response headers: ${response.headers}");
          return false;
        }
      }catch(e){
        print("Cannot add recipe in service: $e");
        throw Exception("Recipe not added in service");
      }

    }

    Future<bool> addReview(String text,String recipeId) async{
      try{
        final token = await secureStorage.read(key: 'authToken');
        if(token==null){
          print("No token to add review");
          throw Exception("No token found");
        }
        final response = await http.post(
          Uri.parse("${super.addReviewAPI}/$recipeId"),
          headers : {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: text
        );
        if(response.statusCode == 200 || response.statusCode==201){
          print("Review added to recipe with id: $recipeId");
          return true;
        }else{
          print("Error adding review to recipe with id: $recipeId");
          print("XXXXXXXXXXXXXXX ${response.statusCode}");
          print(response.body);
          return false;
        }
      }catch(e){
        print("Error adding review: $e");
        throw Exception("Error adding review::$e");
      }
    }
    
    Future<Set<Review>> getRecipeReviews(String recipeId) async{
      try{
        final token = await secureStorage.read(key: 'authToken');
        if(token==null){
          print("No token available to get reviews");
          throw Exception("No token");
        }
        final response = await http.get(
          Uri.parse("${super.getReviewsAPI}/$recipeId"),
          headers : {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );
        if(response.statusCode == 200){
          List<dynamic> responseData = jsonDecode(response.body);
          Set<Review> reviews = responseData
              .map((reviewJson) => Review.fromJson(reviewJson))
              .toSet();
          return reviews;
        }else {
          print("Failed to fetch reviews. Status code: ${response.statusCode}");
          throw Exception("Failed to fetch reviews");
        }
      }catch(e){
        print("Error getting reviews: $e");
        throw Exception("Error getting reviews: $e");
      }
    }

    Future<List<RecipeForProfile>> getRecipesForProfile(String chefId) async{
      try{
        final token = await secureStorage.read(key: 'authToken');
        if(token == null){
          print("No token");
          throw Exception("No token available");
        }
        final response = await http.get(
          Uri.parse("${super.getRecipesByChefIdAPI}/$chefId"),
          headers : {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );
        print(response.body);
        if(response.statusCode == 200){
          final List<dynamic> data = jsonDecode(response.body);
          List<RecipeForProfile> recipes = data.map((item){
            return RecipeForProfile.fromJson(item);
          }).toList();
          return recipes;
        }else{
          print("XX ${response.statusCode}");
          throw Exception("Failed to load recipes: ${response.statusCode}");
        }
      }catch(e){
        print("Error getting recipes for chef with id: $chefId");
        throw Exception("Error getting recipes for chef with id: $chefId");
      }
    }
}