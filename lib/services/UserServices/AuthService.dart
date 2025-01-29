import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_app/models/UserManagement/userAuthentication.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/services/BaseAPI.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/Recipe.dart';
import '../../models/chef.dart';
class AuthService extends BaseAPI{
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<http.Response> login(UserAuthentication userAuth) async{
    try {
      String? firebaseToken = await FirebaseMessaging.instance.getToken();
      if (firebaseToken == null) {
        throw Exception('Failed to retrieve Firebase token.');
      }
      final Map<String, dynamic> requestBody = userAuth.toJson();
      final response = await http.post(
        Uri.parse(super.authAPI),
        headers: super.headers,
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);
        final token = data['token'];
        await secureStorage.write(key: 'authToken', value: token);
        if(data['id'] != null){
          String uri = "${super.saveFirebaseTokenAPI}/${data['id']}/$firebaseToken";
          print("URI : $uri");
          final r2 = await http.post(
            Uri.parse(uri),
              headers : {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          }
          );
          if(r2.statusCode == 200){
            print("YESSSS: ${r2.statusCode}::::${r2.body}");
          }else{
            print("NOOOOO: ${r2.statusCode}");
          }
        }else{
          print("DATAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa");
        }
        print("Login successful. Auth token: $token");
        return response;
      } else {
        throw Exception('Failed to log in: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      throw Exception('An error occurred during login: $e');
    }
  }


  Future<String?> getToken() async{
    String? token = await secureStorage.read(key: 'authToken');
    if(token != null && isTokenExpired(token)){
      await logout();
      throw Exception('Token expired, please log in again');
    }
    return token;
  }

  bool isTokenExpired(String token){
    try{
      DateTime expiryDate = Jwt.getExpiryDate(token)!;
      return expiryDate.isBefore(DateTime.now());
    }catch(e){
      print('Error checking token expiration: $e');
      return true;
    }
  }

  Future<void> logout() async{
    final token = await getToken();
    if(token == null){
      throw Exception('No valid token available');
    }
    await secureStorage.delete(key: 'authToken');
    String? firebaseToken = await FirebaseMessaging.instance.getToken();
    final response = await http.delete(
        Uri.parse("${super.deleteFirebaseTokenAPI}/$firebaseToken"),
        headers : {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }
    );

    print("RESPONSE CODE: ${response.statusCode}");
  }

  Future<http.Response> get(String url) async{
    final token = await getToken();
    if(token == null){
      throw Exception('No valid token available');
    }
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if(response.statusCode == 401){
      await logout();
      throw Exception('Unauthorized, please log in again');
    }
    return response;
  }

  Future<Map<String, dynamic>> getUserInfo(String token) async {
    try{
      final response = await http.get(
        Uri.parse(super.userInfoAPI),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        }
      );
      if(response.statusCode == 200){
        return jsonDecode(response.body) as Map<String, dynamic>;
      }else{
        throw Exception("Failed to fetch user info: ${response.statusCode}");
      }
    }catch(e){
      print("Error with user info: $e");
      throw Exception('Error fetching user info');
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

  Future<bool> updateImage(String userId, String url) async{
    try{
      final token = await secureStorage.read(key: 'authToken');
      if(token == null){
        return false;
      }
      final response = await http.put(
        Uri.parse("${super.updateProfileImageAPI}/$userId"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        body: '"$url"'
      );
      if(response.statusCode == 200){
        return true;
      }else{
        print(response.body);
        return false;
      }
    }catch(e){
      print("Error: $e");
      return false;
    }
  }

  Future<List<RecipeFavorites>> fetchUserFavorites(String token) async{
    try{
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(
          Uri.parse(super.getUserFavoriteRecipesAPI),
          headers: headers
      );
      print("HMARRRRRRRRRRRRRRRRRRRRRRRRR${response.statusCode}");
      if(response.statusCode == 200){
        print("Favorites: ${response.body}");
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => RecipeFavorites.fromJson(json)).toList();
      }else{
        print("Error code: ${response.statusCode}");
        throw Exception("Error: No favorites with error code: ${response.statusCode}");
      }

    }catch(e){
      print("Can't fetch user favorite recipes: $e");
      throw Exception('Error fetching user favorite recipes: $e');
    }
  }

  Future<bool> addRecipeToFavorites(String recipeId, String token) async{
    try{
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(
          Uri.parse("${super.postUserFavoriteRecipeAPI}/$recipeId"),
          headers: headers
      );

      if(response.statusCode==200 || response.statusCode==201){
        print("Recipe added to user favorites");
        return true;
      }else{
        print("Recipe not added to favorites ${response.statusCode}");
        return false;
      }

    }catch(e){
      print("Not added to favorites. Exception: $e");
      throw Exception("Not added to favorites: $e");
    }
  }

  Future<bool> removeRecipeFromFavorites(String recipeId, String token) async{
    try{
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };
      final response = await http.delete(
          Uri.parse("${super.deleteUserFavoriteRecipeAPI}/$recipeId"),
          headers: headers
      );
      if(response.statusCode == 200){
        print("Deleted successfully from favorites");
        return true;
      }else{
        print("Error deleting from favorites");
        return false;
      }
    }catch(e){
      print("Favorite recipe not deleted. Exception: $e");
      throw Exception("Not delete from favorites: $e");
    }

  }

  Future<Map<String, dynamic>> getChefInfo(String chefId, String token) async{
    try{
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(
          Uri.parse("${super.getChefInfoAPI}/$chefId"),
          headers: headers
      );
      if(response.statusCode == 200){
        print("Got chef info");
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        print(data);
        return data;
      }else{
        print("Error: no data returned, statusCode: ${response.statusCode}");
        throw Exception("No data");
      }

    }catch(e){
      print("Error in the service layer: $e");
      throw Exception("Error getting chef info: $e");
    }
  }

  Future<bool> upgradeToChef(String token,String location, String phone, int ye, String bio) async{
    try{
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };
      UpgradeChef chef = UpgradeChef(
          location: location,
          phoneNumber: phone,
          ye: ye,
          bio: bio
      );

      final jsonBody = jsonEncode(chef.toJson());

      final response = await http.put(
        Uri.parse(super.upgradeToChefAPI),
        headers: headers,
        body: jsonBody
      );
      if(response.statusCode == 200 || response.statusCode ==201){
        print("User is now a chef");
        return true;
      }else{
        print("Error : ${response.statusCode}");
        return false;
      }

    }catch(e){
      print("Error upgrading to chef: $e");
      return false;
    }
  }

}